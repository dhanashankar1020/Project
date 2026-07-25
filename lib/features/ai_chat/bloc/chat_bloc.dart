import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart'
    show Content, TextPart;
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_event.dart';
import 'chat_state.dart';
import '../models/chat_message.dart';
import '../services/ai_prompt_service.dart';
import '../services/connectivity_service.dart';
import '../services/gemini_service.dart';
import '../services/offline_ai_service.dart';
import '../services/recommendation_scoring_service.dart';
import '../../safe_places/models/safe_place_model.dart';

/// ChatBloc — the single source of truth for the AI Chat feature.
///
/// Replaces the ad-hoc setState() calls scattered throughout SafePlacesScreen
/// with a deterministic event → state machine. The UI only calls [add] and
/// reads [state]; all async work happens here.
class ChatBloc {
  // ── Dependencies ──────────────────────────────────────────────────────────
  final ConnectivityService _connectivity = ConnectivityService.instance;
  final GeminiService _gemini = GeminiService.instance;
  final OfflineAIService _offline = OfflineAIService.instance;
  final AIPromptService _promptService = AIPromptService.instance;
  final RecommendationScoringService _scoring =
      RecommendationScoringService.instance;

  // ── State stream ──────────────────────────────────────────────────────────
  final StreamController<ChatState> _stateController =
      StreamController<ChatState>.broadcast();

  Stream<ChatState> get stream => _stateController.stream;

  ChatState _state = const ChatInitial();
  ChatState get state => _state;

  // ── Internal ──────────────────────────────────────────────────────────────
  StreamSubscription<bool>? _connectivitySub;
  String _apiKey = '';

  // ── Init / Dispose ────────────────────────────────────────────────────────

  ChatBloc() {
    _connectivitySub = _connectivity.onConnectivityChanged.listen((isOnline) {
      add(ChatConnectivityChangedEvent(isConnected: isOnline));
    });
    _connectivity.startMonitoring();
  }

  void dispose() {
    _connectivitySub?.cancel();
    _connectivity.stopMonitoring();
    _stateController.close();
  }

  // ── Public entry point ────────────────────────────────────────────────────

  void add(ChatEvent event) {
    _handleEvent(event);
  }

  // ── Event router ──────────────────────────────────────────────────────────

  Future<void> _handleEvent(ChatEvent event) async {
    if (event is ChatInitializeEvent) {
      await _onInitialize();
    } else if (event is ChatSendMessageEvent) {
      await _onSendMessage(event.text);
    } else if (event is ChatSendSuggestionEvent) {
      await _onSendMessage(event.text);
    } else if (event is ChatToggleModeEvent) {
      await _onToggleMode();
    } else if (event is ChatSaveApiKeyEvent) {
      await _onSaveApiKey(event.apiKey);
    } else if (event is ChatClearHistoryEvent) {
      _onClearHistory();
    } else if (event is ChatConnectivityChangedEvent) {
      _onConnectivityChanged(event.isConnected);
    }
  }

  // ── Handlers ──────────────────────────────────────────────────────────────

  Future<void> _onInitialize() async {
    _emit(const ChatSettingsLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      _apiKey = await _gemini.getApiKey() ?? '';
      final savedOnline = prefs.getBool('ai_online_mode') ?? false;
      final isOnline = savedOnline && _apiKey.isNotEmpty;

      _emit(
        ChatLoaded(
          messages: const [],
          mode: isOnline ? AIMode.online : AIMode.offline,
        ),
      );
    } catch (e) {
      _emit(ChatError('Failed to load settings: $e'));
    }
  }

  Future<void> _onSendMessage(String text) async {
    final currentState = _state;
    if (currentState is! ChatLoaded) return;
    if (text.trim().isEmpty) return;

    // 1. Optimistically add user message and show typing indicator.
    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );

    _emit(
      currentState.copyWith(
        messages: [...currentState.messages, userMsg],
        isTyping: true,
        clearError: true,
      ),
    );

    // 2. Detect intent locally (always — even online).
    final intent = _promptService.detectIntent(text);

    // 3. Generate response.
    String replyText = '';
    List<SafePlaceModel>? recommendedPlaces;
    String? errorMsg;

    try {
      if (currentState.isOnline) {
        // ── Online: Gemini ──────────────────────────────────────────────────
        final history = _buildGeminiHistory(currentState.messages);
        replyText = await _gemini.generateResponse(text, history: history);

        // Enrich with scored place recommendations when intent detected.
        if (intent.isSafePlace) {
          final category = _categoryFromSafePlaceType(intent.safePlaceType);
          recommendedPlaces = _scoring.getScoredPlaces(category: category);
        }
      } else {
        // ── Offline: Rule-based engine ──────────────────────────────────────
        final offlineResp = _offline.generateResponse(text, intent);
        replyText = offlineResp.text;
        recommendedPlaces = offlineResp.recommendedPlaces;
      }
    } catch (e) {
      debugPrint('[ChatBloc] AI call failed — falling back to offline: $e');
      errorMsg =
          '⚠️ *Gemini is unreachable. Showing offline response.*';
      try {
        final offlineResp = _offline.generateResponse(text, intent);
        replyText =
            '$errorMsg\n\n${offlineResp.text}';
        recommendedPlaces = offlineResp.recommendedPlaces;
      } catch (fallbackErr) {
        replyText =
            '⚠️ Unable to generate a response right now. Please try again.';
      }
    }

    // 4. Append AI message.
    final aiMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: replyText,
      isUser: false,
      timestamp: DateTime.now(),
      recommendedPlaces: recommendedPlaces,
    );

    final latestLoaded = _state;
    if (latestLoaded is ChatLoaded) {
      _emit(
        latestLoaded.copyWith(
          messages: [...latestLoaded.messages, aiMsg],
          isTyping: false,
          inlineError: errorMsg,
        ),
      );
    }
  }

  Future<void> _onToggleMode() async {
    final currentState = _state;
    if (currentState is! ChatLoaded) return;

    if (_apiKey.isEmpty && !currentState.isOnline) {
      // Can't go online without a key — surface inline error.
      _emit(
        currentState.copyWith(
          inlineError:
              'Please configure a Gemini API key in settings first.',
        ),
      );
      return;
    }

    final newMode = currentState.isOnline ? AIMode.offline : AIMode.online;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ai_online_mode', newMode == AIMode.online);
    _emit(currentState.copyWith(mode: newMode, clearError: true));
  }

  Future<void> _onSaveApiKey(String apiKey) async {
    await _gemini.saveApiKey(apiKey);
    _apiKey = apiKey.trim();

    final prefs = await SharedPreferences.getInstance();
    if (_apiKey.isEmpty) {
      await prefs.setBool('ai_online_mode', false);
    }

    final currentState = _state;
    if (currentState is ChatLoaded) {
      _emit(
        currentState.copyWith(
          mode: _apiKey.isNotEmpty ? currentState.mode : AIMode.offline,
          clearError: true,
        ),
      );
    }
  }

  void _onClearHistory() {
    final currentState = _state;
    if (currentState is ChatLoaded) {
      _emit(currentState.copyWith(messages: [], clearError: true));
    }
  }

  void _onConnectivityChanged(bool isConnected) {
    final currentState = _state;
    if (currentState is! ChatLoaded) return;

    // Automatically drop to offline when network is lost.
    if (!isConnected && currentState.isOnline) {
      _emit(
        currentState.copyWith(
          mode: AIMode.offline,
          inlineError: '📡 Network lost — switched to Offline mode.',
        ),
      );
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  void _emit(ChatState newState) {
    _state = newState;
    if (!_stateController.isClosed) {
      _stateController.add(newState);
    }
  }

  List<Content> _buildGeminiHistory(List<ChatMessage> messages) {
    // Use last 10 messages (excluding the latest user message which is sent separately)
    final history = messages.length > 1
        ? messages.sublist(0, messages.length - 1).take(10)
        : <ChatMessage>[];

    return history.map((msg) {
      if (msg.isUser) {
        return Content.text(msg.text);
      } else {
        return Content.model([TextPart(msg.text)]);
      }
    }).toList();
  }

  String _categoryFromSafePlaceType(SafePlaceType type) {
    switch (type) {
      case SafePlaceType.hospital:
        return 'Hospital';
      case SafePlaceType.shelter:
        return 'Shelter';
      case SafePlaceType.police:
        return 'Police';
      case SafePlaceType.fireStation:
        return 'Fire Station';
      case SafePlaceType.reliefCenter:
        return 'Relief Center';
      default:
        return '';
    }
  }
}
