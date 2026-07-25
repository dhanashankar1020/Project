/// Base event class for the Chat feature.
abstract class ChatEvent {
  const ChatEvent();
}

/// Fired once on screen mount to load stored API key and mode preference.
class ChatInitializeEvent extends ChatEvent {
  const ChatInitializeEvent();
}

/// Fired when the user submits a text message.
class ChatSendMessageEvent extends ChatEvent {
  final String text;
  const ChatSendMessageEvent(this.text);
}

/// Fired when the user taps a suggestion chip or quick-action card.
class ChatSendSuggestionEvent extends ChatEvent {
  final String text;
  const ChatSendSuggestionEvent(this.text);
}

/// Fired when the user toggles the Online/Offline mode switch.
class ChatToggleModeEvent extends ChatEvent {
  const ChatToggleModeEvent();
}

/// Fired when the user saves a new API key from the settings dialog.
class ChatSaveApiKeyEvent extends ChatEvent {
  final String apiKey;
  const ChatSaveApiKeyEvent(this.apiKey);
}

/// Fired when the user requests to clear the conversation.
class ChatClearHistoryEvent extends ChatEvent {
  const ChatClearHistoryEvent();
}

/// Fired by an internal network-change listener.
class ChatConnectivityChangedEvent extends ChatEvent {
  final bool isConnected;
  const ChatConnectivityChangedEvent({required this.isConnected});
}
