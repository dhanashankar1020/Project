import 'package:flutter/material.dart';

import '../models/chat_message.dart';

class ChatProvider extends ChangeNotifier {

  final List<ChatMessage> _messages = [];

  bool _isTyping = false;

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  bool get isTyping => _isTyping;

  /// Add a user message
  void addUserMessage(String text) {

    _messages.add(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  /// Add AI message
  void addAIMessage(String text) {

    _messages.add(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  /// Show / Hide typing animation
  void setTyping(bool value) {

    _isTyping = value;

    notifyListeners();
  }

  /// Clear chat
  void clearChat() {

    _messages.clear();

    notifyListeners();
  }
}