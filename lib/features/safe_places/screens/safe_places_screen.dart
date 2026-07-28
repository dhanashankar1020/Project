import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:google_generative_ai/google_generative_ai.dart'
    show Content, TextPart;
import '../models/safe_place_model.dart';
import '../screens/safe_place_detail_screen.dart';
import '../services/safe_places_service.dart';
import '../widgets/safe_place_card.dart';
import '../widgets/place_search_bar.dart';
import '../widgets/category_chip.dart';
import '../widgets/safe_places_map_view.dart';
import '../../../services/location_service.dart';

// AI Assistant imports
import '../../ai_chat/models/chat_message.dart';
import '../../ai_chat/widgets/chat_bubble.dart';
import '../../ai_chat/widgets/typing_indicator.dart';
import '../../ai_chat/widgets/ai_welcome_card.dart';
import '../../ai_chat/services/ai_prompt_service.dart';
import '../../ai_chat/services/offline_ai_service.dart';
import '../../ai_chat/services/gemini_service.dart';
import '../../ai_chat/models/user_intent.dart';

class SafePlacesScreen extends StatefulWidget {
  const SafePlacesScreen({super.key});

  @override
  State<SafePlacesScreen> createState() => _SafePlacesScreenState();
}

class _SafePlacesScreenState extends State<SafePlacesScreen> {
  final SafePlacesService service = SafePlacesService.instance;
  final TextEditingController searchController = TextEditingController();

  late List<SafePlaceModel> places;
  String selectedCategory = "All";

  // AI Assistant state variables
  final List<ChatMessage> _chatMessages = [];
  bool _isAiLoading = false;
  bool _isOnlineMode = false;
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _apiKeyValue = '';

  // Voice input state
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _speechAvailable = false;

  // Real-time network safe places state
  bool _isFetchingRealTime = false;
  String? _locationStatusMessage;

  Future<void> _fetchRealTimeNearbyPlaces() async {
    setState(() {
      _isFetchingRealTime = true;
    });

    final position = await LocationService.getCurrentLocation();

    if (!context.mounted) return;

    if (position == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not access GPS location. Please enable location permissions.'),
          backgroundColor: Colors.orange,
        ),
      );
      setState(() {
        _isFetchingRealTime = false;
      });
      return;
    }

    final realTimePlaces = await service.fetchRealTimeNearbyPlaces(
      lat: position.latitude,
      lng: position.longitude,
      category: selectedCategory,
    );

    if (!context.mounted) return;

    setState(() {
      places = realTimePlaces;
      _isFetchingRealTime = false;
      _locationStatusMessage =
          'Loaded ${realTimePlaces.length} real-time places near (${position.latitude.toStringAsFixed(2)}, ${position.longitude.toStringAsFixed(2)})';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_locationStatusMessage!),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    places = service.getAllPlaces();
    _loadSettings();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    try {
      _speechAvailable = await _speech.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('Speech initialization failed: $e');
      _speechAvailable = false;
    }
  }

  final List<Map<String, dynamic>> _suggestions = [
    {"title": "Nearest Shelter", "icon": Icons.home_work},
    {"title": "Find Hospitals", "icon": Icons.local_hospital},
    {"title": "CPR Instructions", "icon": Icons.health_and_safety},
    {"title": "Earthquake Safety", "icon": Icons.public},
    {"title": "Flood Preparedness", "icon": Icons.flood},
  ];



  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await GeminiService.instance.getApiKey() ?? '';
    final isOnline = prefs.getBool('ai_online_mode') ?? false;
    setState(() {
      _isOnlineMode = isOnline && key.isNotEmpty;
      _apiKeyValue = key;
    });
  }

  void search(String query) {
    setState(() {
      places = service.searchPlaces(query);
    });
  }

  Future<void> _handleSendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _chatMessages.add(userMsg);
      _isAiLoading = true;
    });
    _chatController.clear();
    _scrollToBottom();

    // 1. Detect Intent locally (works online & offline)
    final intent = AIPromptService.instance.detectIntent(text);

    String replyText = '';
    List<SafePlaceModel>? recommendedPlaces;

    try {
      if (_isOnlineMode) {
        // 2. Online: Use Gemini Service
        final List<Content> geminiHistory = [];
        // Map history to Content types
        for (final msg
            in _chatMessages.sublist(0, _chatMessages.length - 1).take(10)) {
          if (msg.isUser) {
            geminiHistory.add(Content.text(msg.text));
          } else {
            geminiHistory.add(Content.model([TextPart(msg.text)]));
          }
        }

        replyText = await GeminiService.instance.generateResponse(
          text,
          history: geminiHistory,
        );

        // Enrich Gemini response with recommended places if user asked for safe places
        if (intent.isSafePlace) {
          final category = _getCategoryFromIntent(intent.safePlaceType);
          final pos = await LocationService.getCurrentLocation();
          if (pos != null) {
            recommendedPlaces = await service.fetchRealTimeNearbyPlaces(
              lat: pos.latitude,
              lng: pos.longitude,
              category: category,
            );
          } else {
            recommendedPlaces = service.getPlacesByCategory(category);
          }
        }
      } else {
        // 3. Offline: Use Offline AI Service
        final offlineResponse = OfflineAIService.instance.generateResponse(
          text,
          intent,
        );
        replyText = offlineResponse.text;
        if (intent.isSafePlace) {
          final category = _getCategoryFromIntent(intent.safePlaceType);
          final pos = await LocationService.getCurrentLocation();
          if (pos != null) {
            recommendedPlaces = await service.fetchRealTimeNearbyPlaces(
              lat: pos.latitude,
              lng: pos.longitude,
              category: category,
            );
          } else {
            recommendedPlaces = offlineResponse.recommendedPlaces ?? service.getPlacesByCategory(category);
          }
        } else {
          recommendedPlaces = offlineResponse.recommendedPlaces;
        }
      }
    } catch (e) {
      debugPrint("Gemini call failed, falling back to offline: $e");
      final offlineResponse = OfflineAIService.instance.generateResponse(
        text,
        intent,
      );
      replyText =
          "⚠️ *(Gemini failed. Using offline backup)*\n\n${offlineResponse.text}";
      if (intent.isSafePlace) {
        final category = _getCategoryFromIntent(intent.safePlaceType);
        final pos = await LocationService.getCurrentLocation();
        if (pos != null) {
          recommendedPlaces = await service.fetchRealTimeNearbyPlaces(
            lat: pos.latitude,
            lng: pos.longitude,
            category: category,
          );
        } else {
          recommendedPlaces = offlineResponse.recommendedPlaces ?? service.getPlacesByCategory(category);
        }
      } else {
        recommendedPlaces = offlineResponse.recommendedPlaces;
      }
    } finally {
      final aiMsg = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: replyText,
        isUser: false,
        timestamp: DateTime.now(),
        recommendedPlaces: recommendedPlaces,
      );

      if (mounted) {
        setState(() {
          _chatMessages.add(aiMsg);
          _isAiLoading = false;
        });
        _scrollToBottom();
      }
    }
  }

  String _getCategoryFromIntent(SafePlaceType type) {
    switch (type) {
      case SafePlaceType.hospital:
        return "Hospital";
      case SafePlaceType.shelter:
        return "Shelter";
      case SafePlaceType.policeStation:
        return "Police";
      case SafePlaceType.fireStation:
        return "Fire Station";
      case SafePlaceType.reliefCamp:
        return "Relief Center";
      case SafePlaceType.pharmacy:
        return "Pharmacy";
      default:
        return "";
    }
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

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final keyController = TextEditingController(text: _apiKeyValue);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: const [
              Icon(Icons.settings, color: Colors.indigo),
              SizedBox(width: 10),
              Text("AI Assistant Settings"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Gemini API Key:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: keyController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter Gemini API Key",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.vpn_key),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Note: The API key is stored locally and used to query Google's Gemini API directly.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                final newKey = keyController.text.trim();
                await GeminiService.instance.saveApiKey(newKey);
                final prefs = await SharedPreferences.getInstance();
                if (newKey.isEmpty) {
                  await prefs.setBool('ai_online_mode', false);
                }
                setState(() {
                  _apiKeyValue = newKey;
                  if (newKey.isEmpty) {
                    _isOnlineMode = false;
                  }
                });
                if (mounted) Navigator.pop(context);
              },
              child: const Text("Save Key"),
            ),
          ],
        );
      },
    );
  }

  void _startListening() async {
    if (!_speechAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Speech recognition not available on this device.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      setState(() {
        _isListening = true;
      });

      await _speech.listen(
        onResult: (result) {
          setState(() {
            _chatController.text = result.recognizedWords;
          });
          // Auto-send when final result is ready and text is non-empty
          if (result.finalResult &&
              result.recognizedWords.trim().isNotEmpty) {
            _handleSendMessage(result.recognizedWords);
          }
        },
        listenFor: const Duration(seconds: 30),
        partialResults: true,
        cancelOnError: true,
        localeId: 'en_IN',
      );
    } catch (e) {
      debugPrint('Speech listening error: $e');
      setState(() {
        _isListening = false;
      });
    }
  }

  void _stopListening() async {
    try {
      await _speech.stop();
    } catch (_) {}
    setState(() {
      _isListening = false;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _chatController.dispose();
    _scrollController.dispose();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          title: const Text("Safe Places"),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.chat_bubble), text: "AI Assistant"),
              Tab(icon: Icon(Icons.list), text: "Safe Places List"),
              Tab(icon: Icon(Icons.map), text: "Map View"),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(_isOnlineMode ? Icons.cloud : Icons.cloud_off),
              color: _isOnlineMode ? Colors.greenAccent : Colors.white70,
              tooltip: _isOnlineMode ? "Online Mode (Gemini)" : "Offline Mode",
              onPressed: () async {
                if (_apiKeyValue.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please configure a Gemini API key in settings to enable Online Mode.",
                      ),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  _showSettingsDialog();
                  return;
                }
                final nextMode = !_isOnlineMode;
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('ai_online_mode', nextMode);
                setState(() {
                  _isOnlineMode = nextMode;
                });
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        nextMode
                            ? "Online Mode Enabled (Gemini)"
                            : "Offline Mode Enabled",
                      ),
                      backgroundColor: nextMode ? Colors.green : Colors.indigo,
                    ),
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: _showSettingsDialog,
              tooltip: "Settings",
            ),
          ],
        ),
        body: TabBarView(
          children: [_buildAssistantTab(), _buildDirectoryTab(), _buildMapTab()],
        ),
      ),
    );
  }

  Widget _buildAssistantTab() {
    return Column(
      children: [
        Expanded(
          child: _chatMessages.isEmpty
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const AIWelcomeCard(),
                      const SizedBox(height: 24),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Suggested Emergency Queries",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _suggestions.length,
                          itemBuilder: (context, index) {
                            final sug = _suggestions[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ActionChip(
                                elevation: 1,
                                backgroundColor: Colors.white,
                                avatar: Icon(
                                  sug["icon"],
                                  size: 16,
                                  color: Colors.indigo,
                                ),
                                label: Text(sug["title"]),
                                onPressed: () =>
                                    _handleSendMessage(sug["title"]),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Opacity(
                        opacity: 0.6,
                        child: Column(
                          children: const [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 48,
                              color: Colors.indigo,
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Start a conversation with SafePlace AI",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Ask first aid questions, disaster safety tips, or safe places",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: _chatMessages.length + (_isAiLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _chatMessages.length) {
                      return const TypingIndicator();
                    }
                    return _buildMessageItem(_chatMessages[index]);
                  },
                ),
        ),

        // Chat Input Panel
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    minLines: 1,
                    maxLines: 4,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (val) {
                      if (!_isAiLoading && val.trim().isNotEmpty) {
                        _handleSendMessage(val);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: _isOnlineMode
                          ? "Ask SafePlace AI (Online mode)..."
                          : "Ask SafePlace AI (Offline mode)...",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                // Voice Input Button
                if (_speechAvailable && !_isAiLoading)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: FloatingActionButton.small(
                      elevation: 2,
                      backgroundColor:
                          _isListening ? Colors.red : Colors.indigo.shade100,
                      foregroundColor:
                          _isListening ? Colors.white : Colors.indigo,
                      onPressed:
                          _isListening ? _stopListening : _startListening,
                      tooltip: _isListening ? 'Stop listening' : 'Voice input',
                      child: _isListening
                          ? const Icon(Icons.mic, size: 18)
                          : const Icon(Icons.keyboard_voice, size: 18),
                    ),
                  ),
                const SizedBox(width: 8),
                FloatingActionButton.small(
                  elevation: 2,
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  onPressed: _isAiLoading
                      ? null
                      : () {
                          if (_chatController.text.trim().isNotEmpty) {
                            _handleSendMessage(_chatController.text);
                          }
                        },
                  child: _isAiLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChatBubble(
          message: message.text,
          isUser: message.isUser,
          timestamp: message.timestamp,
        ),
        if (!message.isUser &&
            message.recommendedPlaces != null &&
            message.recommendedPlaces!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 54, right: 16, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.indigo),
                      SizedBox(width: 4),
                      Text(
                        "Recommended Safe Places:",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 185,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: message.recommendedPlaces!.length,
                    itemBuilder: (context, index) {
                      final place = message.recommendedPlaces![index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: 260,
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        SafePlaceDetailScreen(place: place),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          _getPlaceIcon(place.category),
                                          color: Colors.indigo,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            place.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      place.description,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 12,
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
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.indigo.shade50,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            place.category,
                                            style: const TextStyle(
                                              color: Colors.indigo,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          place.isOpen24Hours
                                              ? "24 Hrs"
                                              : "Limited",
                                          style: TextStyle(
                                            color: place.isOpen24Hours
                                                ? Colors.green
                                                : Colors.orange,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
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
          ),
      ],
    );
  }

  IconData _getPlaceIcon(String category) {
    switch (category) {
      case "Hospital":
        return Icons.local_hospital;
      case "Shelter":
        return Icons.home_work;
      case "Police":
        return Icons.local_police;
      case "Fire Station":
        return Icons.local_fire_department;
      case "Relief Center":
        return Icons.volunteer_activism;
      default:
        return Icons.location_on;
    }
  }

  Widget _buildMapTab() {
    return SafePlacesMapView(service: service);
  }

  Widget _buildDirectoryTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: PlaceSearchBar(
              controller: searchController,
              onChanged: search,
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                CategoryChip(
                  title: "All",
                  icon: Icons.apps,
                  color: Colors.indigo,
                  isSelected: selectedCategory == "All",
                  onTap: () {
                    setState(() {
                      selectedCategory = "All";
                      places = service.getAllPlaces();
                    });
                  },
                ),
                CategoryChip(
                  title: "Hospital",
                  icon: Icons.local_hospital,
                  color: Colors.red,
                  isSelected: selectedCategory == "Hospital",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Hospital";
                      places = service.getPlacesByCategory("Hospital");
                    });
                  },
                ),
                CategoryChip(
                  title: "Shelter",
                  icon: Icons.home_work,
                  color: Colors.blue,
                  isSelected: selectedCategory == "Shelter",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Shelter";
                      places = service.getPlacesByCategory("Shelter");
                    });
                  },
                ),
                CategoryChip(
                  title: "Police",
                  icon: Icons.local_police,
                  color: Colors.indigo,
                  isSelected: selectedCategory == "Police",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Police";
                      places = service.getPlacesByCategory("Police");
                    });
                  },
                ),
                CategoryChip(
                  title: "Fire",
                  icon: Icons.local_fire_department,
                  color: Colors.orange,
                  isSelected: selectedCategory == "Fire",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Fire";
                      places = service.getPlacesByCategory("Fire Station");
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.indigo),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${places.length} Safe Places",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _isFetchingRealTime ? null : _fetchRealTimeNearbyPlaces,
                    icon: _isFetchingRealTime
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.my_location, size: 16),
                    label: Text(
                      _isFetchingRealTime ? "Fetching..." : "Live Nearby (GPS)",
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (places.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(Icons.location_off, size: 48, color: Colors.grey),
                  const SizedBox(height: 12),
                  const Text(
                    'No safe places found.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Try switching categories or tap “Live Nearby (GPS)” to refresh.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SafePlaceCard(
                    place: place,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SafePlaceDetailScreen(place: place),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
