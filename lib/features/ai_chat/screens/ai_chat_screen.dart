import 'package:flutter/material.dart';

import '../../safe_places/screens/safe_place_detail_screen.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../models/chat_message.dart';
import '../widgets/ai_welcome_card.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/message_input.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/suggestion_chip.dart' as chips;
import '../widgets/typing_indicator.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen>
    with SingleTickerProviderStateMixin {
  late final ChatBloc _bloc;
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc = ChatBloc();
    _bloc.add(const ChatInitializeEvent());
    _bloc.stream.listen((state) {
      if (state is ChatLoaded) {
        _scrollToBottom();
      }
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ── Actions ────────────────────────────────────────────────────────────────

  void _sendMessage() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    _inputController.clear();
    _bloc.add(ChatSendMessageEvent(text));
  }

  void _sendSuggestion(String text) {
    _bloc.add(ChatSendSuggestionEvent(text));
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showSettingsDialog(BuildContext ctx) {
    final state = _bloc.state;
    final currentKey = state is ChatLoaded ? '' : '';
    final keyController = TextEditingController(text: currentKey);

    showDialog(
      context: ctx,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.vpn_key_rounded, color: Colors.indigo),
            SizedBox(width: 10),
            Text('AI Settings'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gemini API Key',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: keyController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your Gemini API key',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The key is stored only on this device and used to call the Gemini API directly.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              _bloc.add(ChatSaveApiKeyEvent(keyController.text.trim()));
              Navigator.pop(dialogCtx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatState>(
      stream: _bloc.stream,
      initialData: _bloc.state,
      builder: (context, snapshot) {
        final state = snapshot.data ?? _bloc.state;
        return _buildScaffold(context, state);
      },
    );
  }

  Widget _buildScaffold(BuildContext context, ChatState state) {
    final theme = Theme.of(context);
    final isLoaded = state is ChatLoaded;
    final isOnline = isLoaded && state.isOnline;
    final isTyping = isLoaded && state.isTyping;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: theme.colorScheme.surface,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SafePlace AI',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              isOnline ? '🟢 Online · Gemini' : '⚫ Offline · Local Engine',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isOnline ? Colors.green.shade600 : Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          // Online/Offline toggle
          if (isLoaded)
            Tooltip(
              message: isOnline ? 'Switch to Offline' : 'Switch to Online',
              child: IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isOnline ? Icons.cloud_done_rounded : Icons.cloud_off_rounded,
                    key: ValueKey(isOnline),
                    color: isOnline
                        ? Colors.green.shade600
                        : theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                onPressed: () => _bloc.add(const ChatToggleModeEvent()),
              ),
            ),

          // Clear history
          if (isLoaded && state.messages.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_rounded),
              tooltip: 'Clear conversation',
              onPressed: () {
                _bloc.add(const ChatClearHistoryEvent());
              },
            ),

          // Settings
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            tooltip: 'AI Settings',
            onPressed: () => _showSettingsDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Inline error / info banner ──────────────────────────────────
          if (isLoaded && state.inlineError != null)
            _InlineBanner(message: state.inlineError!),

          // ── Main content area ───────────────────────────────────────────
          Expanded(
            child: state is ChatSettingsLoading
                ? const Center(child: CircularProgressIndicator())
                : state is ChatError
                    ? _ErrorBody(message: state.message)
                    : isLoaded
                        ? _buildChatBody(context, state)
                        : const Center(child: CircularProgressIndicator()),
          ),

          // ── Input bar ───────────────────────────────────────────────────
          if (isLoaded)
            MessageInput(
              controller: _inputController,
              onSend: _sendMessage,
              isLoading: isTyping,
            ),
        ],
      ),
    );
  }

  Widget _buildChatBody(BuildContext context, ChatLoaded state) {
    if (state.messages.isEmpty) {
      return _buildWelcomeView(context, state);
    }
    return _buildConversationView(context, state);
  }

  // ── Welcome / Idle View ───────────────────────────────────────────────────

  Widget _buildWelcomeView(BuildContext context, ChatLoaded state) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AIWelcomeCard(),

          const SizedBox(height: 28),

          Text(
            'Quick Actions',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.15,
            children: [
              QuickActionCard(
                title: 'Find Hospital',
                subtitle: 'Locate nearby hospitals',
                icon: Icons.local_hospital_rounded,
                color: Colors.red,
                onTap: () => _sendSuggestion('Find nearest hospital'),
              ),
              QuickActionCard(
                title: 'Find Shelter',
                subtitle: 'Emergency shelters nearby',
                icon: Icons.home_work_rounded,
                color: Colors.blue,
                onTap: () => _sendSuggestion('Find nearby shelter'),
              ),
              QuickActionCard(
                title: 'Earthquake Safety',
                subtitle: 'What to do during a quake',
                icon: Icons.public_rounded,
                color: Colors.deepPurple,
                onTap: () => _sendSuggestion('Earthquake safety tips'),
              ),
              QuickActionCard(
                title: 'Emergency Guide',
                subtitle: 'Flood preparedness advice',
                icon: Icons.health_and_safety_rounded,
                color: Colors.orange,
                onTap: () => _sendSuggestion('Flood safety tips'),
              ),
            ],
          ),

          const SizedBox(height: 30),

          Text(
            'Suggested Questions',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                chips.SuggestionChip(
                  title: 'CPR Instructions',
                  icon: Icons.favorite_rounded,
                  onTap: () => _sendSuggestion('How to do CPR?'),
                ),
                chips.SuggestionChip(
                  title: 'Nearest Hospital',
                  icon: Icons.local_hospital_rounded,
                  onTap: () => _sendSuggestion('Show hospitals'),
                ),
                chips.SuggestionChip(
                  title: 'Cyclone Shelter',
                  icon: Icons.cyclone_rounded,
                  onTap: () => _sendSuggestion('Cyclone shelter'),
                ),
                chips.SuggestionChip(
                  title: 'Police Station',
                  icon: Icons.local_police_rounded,
                  onTap: () => _sendSuggestion('Find police station'),
                ),
                chips.SuggestionChip(
                  title: 'Fire Station',
                  icon: Icons.local_fire_department_rounded,
                  onTap: () => _sendSuggestion('Find fire station'),
                ),
                chips.SuggestionChip(
                  title: 'Snake Bite',
                  icon: Icons.emergency_rounded,
                  onTap: () => _sendSuggestion('First aid for snake bite'),
                ),
                chips.SuggestionChip(
                  title: 'Flood Safety',
                  icon: Icons.flood_rounded,
                  onTap: () => _sendSuggestion('Flood safety advice'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // Prompt placeholder
          Center(
            child: Opacity(
              opacity: 0.55,
              child: Column(
                children: [
                  Icon(
                    Icons.smart_toy_rounded,
                    size: 52,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Start a conversation',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Ask about first aid, disaster safety, or find safe places near you.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Conversation View ─────────────────────────────────────────────────────

  Widget _buildConversationView(BuildContext context, ChatLoaded state) {
    final itemCount = state.messages.length + (state.isTyping ? 1 : 0);

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: itemCount,
      itemBuilder: (ctx, index) {
        if (index == state.messages.length) {
          return const TypingIndicator();
        }
        return _buildMessageItem(ctx, state.messages[index]);
      },
    );
  }

  Widget _buildMessageItem(BuildContext context, ChatMessage message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChatBubble(
          message: message.text,
          isUser: message.isUser,
          timestamp: message.timestamp,
        ),

        // Recommended places carousel
        if (!message.isUser &&
            message.recommendedPlaces != null &&
            message.recommendedPlaces!.isNotEmpty)
          _RecommendedPlacesCarousel(places: message.recommendedPlaces!),
      ],
    );
  }
}

// ── Sub-widgets ──────────────────────────────────────────────────────────────

class _InlineBanner extends StatelessWidget {
  final String message;

  const _InlineBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      color: Colors.orange.shade50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              size: 18, color: Colors.orange),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  final String message;

  const _ErrorBody({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecommendedPlacesCarousel extends StatelessWidget {
  final List places;

  const _RecommendedPlacesCarousel({required this.places});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 54, right: 16, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Row(
              children: [
                Icon(Icons.location_on_rounded,
                    size: 15, color: theme.colorScheme.primary),
                const SizedBox(width: 4),
                Text(
                  'Recommended Safe Places',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: places.length,
              itemBuilder: (ctx, i) {
                final place = places[i];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: 220,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => Navigator.push(
                          ctx,
                          MaterialPageRoute(
                            builder: (_) => SafePlaceDetailScreen(place: place),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _placeIcon(place.category),
                                    size: 16,
                                    color: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      place.name,
                                      style: theme.textTheme.labelLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                place.address,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primaryContainer,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      place.category,
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                            color: theme.colorScheme
                                                .onPrimaryContainer,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    place.isOpen24Hours ? '24 Hrs' : 'Limited',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: place.isOpen24Hours
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _placeIcon(String category) {
    switch (category) {
      case 'Hospital':
        return Icons.local_hospital_rounded;
      case 'Shelter':
        return Icons.home_work_rounded;
      case 'Police':
        return Icons.local_police_rounded;
      case 'Fire Station':
        return Icons.local_fire_department_rounded;
      case 'Relief Center':
        return Icons.volunteer_activism_rounded;
      default:
        return Icons.location_on_rounded;
    }
  }
}
