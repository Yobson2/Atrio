import 'package:flutter/material.dart';
import 'package:flutter_templates/core/extensions/context_extensions.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/data_display/conversation_tile.dart';
import 'package:flutter_templates/core/widgets/inputs/app_search_field.dart';
import 'package:flutter_templates/core/widgets/states/app_empty_state.dart';
import 'package:flutter_templates/features/chat/domain/entities/conversation.dart';
import 'package:go_router/go_router.dart';

/// Page displaying a list of chat conversations.
class ConversationsPage extends StatelessWidget {
  const ConversationsPage({super.key});

  static final List<Conversation> _mockConversations = [
    Conversation(
      id: '1',
      salonName: 'The Artisan Studio',
      barberName: 'Marcus Williams',
      lastMessage: 'Your appointment is confirmed for tomorrow at 2 PM.',
      lastMessageAt: DateTime.now().subtract(const Duration(minutes: 12)),
      unreadCount: 2,
      isOnline: true,
    ),
    Conversation(
      id: '2',
      salonName: 'Crown & Blade',
      barberName: 'David Chen',
      lastMessage: 'Sure, we can fit you in on Saturday morning.',
      lastMessageAt: DateTime.now().subtract(const Duration(hours: 3)),
      isOnline: true,
    ),
    Conversation(
      id: '3',
      salonName: 'Prestige Cuts',
      barberName: 'James Okafor',
      lastMessage: 'Thanks for visiting! Hope you enjoyed the fade.',
      lastMessageAt: DateTime.now().subtract(const Duration(days: 1)),
      unreadCount: 1,
    ),
    Conversation(
      id: '4',
      salonName: 'Urban Edge Barbershop',
      barberName: 'Carlos Rivera',
      lastMessage: 'We have a promotion this week, 20% off all services!',
      lastMessageAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  String _timeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: Text(context.l10n.conversationsTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.xl,
              right: AppSpacing.xl,
              top: AppSpacing.lg,
            ),
            child: AppSearchField(
              hint: context.l10n.conversationsSearchHint,
            ),
          ),
          AppSpacing.verticalMd,
          Expanded(
            child: _mockConversations.isEmpty
                ? AppEmptyState(
                    icon: Icons.chat_outlined,
                    title: context.l10n.conversationsEmpty,
                    subtitle: context.l10n.conversationsEmptyDesc,
                  )
                : ListView.builder(
                    itemCount: _mockConversations.length,
                    itemBuilder: (context, index) {
                      final conv = _mockConversations[index];
                      return ConversationTile(
                        name: conv.salonName,
                        avatarUrl: conv.salonAvatarUrl,
                        lastMessage: conv.lastMessage,
                        timeAgo: _timeAgo(conv.lastMessageAt),
                        unreadCount: conv.unreadCount,
                        isOnline: conv.isOnline,
                        onTap: () => context.push('/chat/${conv.id}'),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
