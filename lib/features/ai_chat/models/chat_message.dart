import 'package:flutter/foundation.dart';
import '../../safe_places/models/safe_place_model.dart';

/// Represents one chat message in SafePlace AI.
@immutable
class ChatMessage {
  /// Unique message ID
  final String id;

  final String text;

  /// true = User
  /// false = AI
  final bool isUser;

  /// Time the message was created
  final DateTime timestamp;

  /// Sending state
  final MessageStatus status;

  /// List of safe places recommended for this message
  final List<SafePlaceModel>? recommendedPlaces;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.recommendedPlaces,
  });

  ChatMessage copyWith({
    String? id,
    String? text,
    bool? isUser,
    DateTime? timestamp,
    MessageStatus? status,
    List<SafePlaceModel>? recommendedPlaces,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      recommendedPlaces: recommendedPlaces ?? this.recommendedPlaces,
    );
  }
}

enum MessageStatus { sending, sent, failed }
