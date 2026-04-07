import 'package:flutter/foundation.dart';

@immutable
class Conversation {
  const Conversation({
    required this.id,
    required this.salonName,
    required this.lastMessage,
    required this.lastMessageAt,
    this.salonAvatarUrl,
    this.barberName,
    this.unreadCount = 0,
    this.isOnline = false,
  });

  final String id;
  final String salonName;
  final String? salonAvatarUrl;
  final String? barberName;
  final String lastMessage;
  final DateTime lastMessageAt;
  final int unreadCount;
  final bool isOnline;
}
