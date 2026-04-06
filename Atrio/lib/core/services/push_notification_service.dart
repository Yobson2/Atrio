/// Abstract interface for push notification services.
///
/// Override with a real implementation (e.g. Firebase) in production.
abstract class PushNotificationService {
  /// Initializes the push notification service.
  Future<void> init();

  /// Returns the device token for push notifications.
  Future<String?> getToken();

  /// Called when a new notification is received while the app is in foreground.
  void onForegroundMessage(
    void Function(String title, String body, Map<String, dynamic> data) handler,
  );

  /// Called when the user taps a notification.
  void onNotificationTap(
    void Function(Map<String, dynamic> data) handler,
  );
}

/// Dev implementation that logs instead of sending real notifications.
class DevPushNotificationService implements PushNotificationService {
  @override
  Future<void> init() async {}

  @override
  Future<String?> getToken() async => 'dev-fcm-token';

  @override
  void onForegroundMessage(
    void Function(String title, String body, Map<String, dynamic> data) handler,
  ) {}

  @override
  void onNotificationTap(void Function(Map<String, dynamic> data) handler) {}
}
