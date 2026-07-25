import '../models/chat_message.dart';

/// Connectivity and AI mode status
enum AIMode { online, offline }

/// Base state class for the Chat feature.
abstract class ChatState {
  const ChatState();
}

/// Initial state before anything loads.
class ChatInitial extends ChatState {
  const ChatInitial();
}

/// State while the initial settings (API key, mode) are being loaded.
class ChatSettingsLoading extends ChatState {
  const ChatSettingsLoading();
}

/// The primary loaded state of the chat.
class ChatLoaded extends ChatState {
  /// All messages in the conversation (user + AI).
  final List<ChatMessage> messages;

  /// Whether we are in Online (Gemini) or Offline mode.
  final AIMode mode;

  /// Whether the AI is currently generating a response.
  final bool isTyping;

  /// Non-null when a recoverable error occurred (e.g. Gemini timeout).
  final String? inlineError;

  const ChatLoaded({
    required this.messages,
    required this.mode,
    this.isTyping = false,
    this.inlineError,
  });

  bool get isOnline => mode == AIMode.online;

  ChatLoaded copyWith({
    List<ChatMessage>? messages,
    AIMode? mode,
    bool? isTyping,
    String? inlineError,
    bool clearError = false,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      mode: mode ?? this.mode,
      isTyping: isTyping ?? this.isTyping,
      inlineError: clearError ? null : inlineError ?? this.inlineError,
    );
  }
}

/// Fatal error state (e.g., unrecoverable init failure).
class ChatError extends ChatState {
  final String message;
  const ChatError(this.message);
}
