import 'package:flutter/material.dart';
import 'package:flutter_templates/core/theme/app_spacing.dart';
import 'package:flutter_templates/core/widgets/layout/app_pull_to_refresh.dart';
import 'package:flutter_templates/core/widgets/loading/app_shimmer_list.dart';
import 'package:flutter_templates/core/widgets/states/app_empty_state.dart';
import 'package:flutter_templates/core/widgets/states/app_error_state.dart';

/// Page template for list screens with search, filter, and state handling.
///
/// Handles loading, empty, error, and content states automatically.
class ListPageTemplate extends StatelessWidget {
  /// Creates a [ListPageTemplate].
  const ListPageTemplate({
    required this.body,
    super.key,
    this.appBar,
    this.searchBar,
    this.isLoading = false,
    this.isEmpty = false,
    this.errorMessage,
    this.onRefresh,
    this.onRetry,
    this.emptyTitle,
    this.emptySubtitle,
    this.emptyIcon,
    this.emptyActionText,
    this.onEmptyAction,
    this.floatingActionButton,
    this.padding,
  });

  /// The main list content.
  final Widget body;

  /// Optional app bar.
  final PreferredSizeWidget? appBar;

  /// Optional search bar widget above the list.
  final Widget? searchBar;

  /// Whether data is loading.
  final bool isLoading;

  /// Whether the list is empty (after loading).
  final bool isEmpty;

  /// Error message to display. Overrides other states.
  final String? errorMessage;

  /// Pull-to-refresh callback.
  final Future<void> Function()? onRefresh;

  /// Retry callback for error state.
  final VoidCallback? onRetry;

  /// Empty state title.
  final String? emptyTitle;

  /// Empty state subtitle.
  final String? emptySubtitle;

  /// Empty state icon.
  final IconData? emptyIcon;

  /// Empty state action button text.
  final String? emptyActionText;

  /// Empty state action callback.
  final VoidCallback? onEmptyAction;

  /// Optional FAB.
  final Widget? floatingActionButton;

  /// Padding around the body content.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: Column(
        children: [
          if (searchBar != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: searchBar,
            ),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (errorMessage != null) {
      return Center(
        child: AppErrorState(
          message: errorMessage!,
          onRetry: onRetry,
        ),
      );
    }

    if (isLoading) {
      return const AppShimmerList();
    }

    if (isEmpty) {
      return Center(
        child: AppEmptyState(
          title: emptyTitle ?? 'Nothing here yet',
          subtitle: emptySubtitle,
          icon: emptyIcon ?? Icons.inbox_outlined,
          actionText: emptyActionText,
          onAction: onEmptyAction,
        ),
      );
    }

    final content = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: body,
    );

    if (onRefresh != null) {
      return AppPullToRefresh(
        onRefresh: onRefresh!,
        child: content,
      );
    }

    return content;
  }
}
