import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_radius.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/app_avatar.dart';
import 'package:flutter_templates/core/widgets/data_display/message_bubble.dart';
import 'package:flutter_templates/features/chat/domain/entities/message.dart';
import 'package:go_router/go_router.dart';

/// Chat detail view showing messages for a single conversation.
class ChatDetailPage extends StatefulWidget {
  /// Creates a [ChatDetailPage].
  const ChatDetailPage({
    required this.conversationId,
    super.key,
  });

  /// The conversation identifier.
  final String conversationId;

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final _controller = TextEditingController();

  static final List<Message> _mockMessages = [
    Message(
      id: '1',
      conversationId: '1',
      senderId: 'salon',
      content: 'Welcome to The Artisan Studio! How can we help you today?',
      sentAt: DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
    ),
    Message(
      id: '2',
      conversationId: '1',
      senderId: 'me',
      content: "Hi! I'd like to book a haircut for tomorrow afternoon.",
      sentAt: DateTime.now().subtract(const Duration(hours: 2, minutes: 25)),
      isMe: true,
      isRead: true,
    ),
    Message(
      id: '3',
      conversationId: '1',
      senderId: 'salon',
      content:
          'Of course! We have availability at 2 PM and 3:30 PM with Marcus. '
          'Which works best for you?',
      sentAt: DateTime.now().subtract(const Duration(hours: 2, minutes: 20)),
    ),
    Message(
      id: '4',
      conversationId: '1',
      senderId: 'me',
      content: '2 PM would be perfect. Can I also add a beard trim?',
      sentAt: DateTime.now().subtract(const Duration(hours: 2, minutes: 15)),
      isMe: true,
      isRead: true,
    ),
    Message(
      id: '5',
      conversationId: '1',
      senderId: 'salon',
      content:
          'Absolutely! Haircut + beard trim with Marcus at 2 PM. '
          'The total will be \$45.',
      sentAt: DateTime.now().subtract(const Duration(hours: 2, minutes: 10)),
    ),
    Message(
      id: '6',
      conversationId: '1',
      senderId: 'me',
      content: 'Sounds great, please confirm the booking.',
      sentAt: DateTime.now().subtract(const Duration(hours: 2)),
      isMe: true,
      isRead: true,
    ),
    Message(
      id: '7',
      conversationId: '1',
      senderId: 'salon',
      content:
          'Your appointment is confirmed for tomorrow at 2 PM. '
          "We'll send you a reminder an hour before.",
      sentAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
    ),
    Message(
      id: '8',
      conversationId: '1',
      senderId: 'me',
      content: 'Thank you! See you tomorrow.',
      sentAt: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
      isMe: true,
      isRead: true,
    ),
    Message(
      id: '9',
      conversationId: '1',
      senderId: 'salon',
      content:
          "You're welcome! Feel free to reach out if you need to reschedule. "
          'Have a great day!',
      sentAt: DateTime.now().subtract(const Duration(minutes: 12)),
    ),
    Message(
      id: '10',
      conversationId: '1',
      senderId: 'salon',
      content: 'Your appointment is confirmed for tomorrow at 2 PM.',
      sentAt: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
  ];

  // Mock contact info
  static const _contactName = 'The Artisan Studio';
  static const _isOnline = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Row(
          children: [
            const AppAvatar(
              radius: 16,
              name: _contactName,
            ),
            AppSpacing.horizontalSm,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _contactName,
                  style: theme.textTheme.titleSmall,
                ),
                Text(
                  _isOnline
                      ? context.l10n.chatDetailOnline
                      : context.l10n.chatDetailOffline,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: _isOnline
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: AppSpacing.paddingLg,
              itemCount: _mockMessages.length,
              itemBuilder: (context, index) {
                final message =
                    _mockMessages[_mockMessages.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: MessageBubble(
                    content: message.content,
                    time: _formatTime(message.sentAt),
                    isMe: message.isMe,
                    isRead: message.isRead,
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              border: Border(
                top: BorderSide(
                  color: theme.colorScheme.outlineVariant,
                  width: 0.5,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: context.l10n.chatDetailSendHint,
                          border: OutlineInputBorder(
                            borderRadius: AppRadius.borderRadiusFull,
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: theme.colorScheme.surfaceContainerLowest,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.md,
                          ),
                        ),
                      ),
                    ),
                    AppSpacing.horizontalSm,
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                          color: theme.colorScheme.onPrimary,
                        ),
                        onPressed: () {
                          // Send message
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
