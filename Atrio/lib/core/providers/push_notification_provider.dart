import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/services/push_notification_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_notification_provider.g.dart';

/// Provides the [PushNotificationService].
///
/// Override at bootstrap with a real implementation for production.
@Riverpod(keepAlive: true)
PushNotificationService pushNotificationService(Ref ref) {
  return DevPushNotificationService();
}
