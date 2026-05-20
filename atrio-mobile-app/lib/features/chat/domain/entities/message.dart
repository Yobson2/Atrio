import 'package:flutter/foundation.dart';

enum MessageType { text, image, bookingLink }

@immutable
class Message {
  const Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.sentAt,
    this.isRead = false,
    this.type = MessageType.text,
    this.isMe = false,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final DateTime sentAt;
  final bool isRead;
  final MessageType type;
  final bool isMe;
}
