import 'package:flutter_templates/features/notification/domain/entities/app_notification.dart';
import 'package:flutter_templates/features/notification/domain/entities/notification_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification_model.freezed.dart';
part 'app_notification_model.g.dart';

/// Data model for [AppNotification] with JSON serialization.
///
/// Maps between API JSON responses and the domain [AppNotification] entity.
@freezed
abstract class AppNotificationModel with _$AppNotificationModel {
  /// Creates an [AppNotificationModel].
  const AppNotificationModel._();

  const factory AppNotificationModel({
    required String id,
    required String title,
    required String body,
    required String type,
    @Default(<String, dynamic>{}) Map<String, dynamic> data,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
  }) = _AppNotificationModel;

  /// Creates an [AppNotificationModel] from JSON.
  factory AppNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationModelFromJson(json);

  /// Converts this model to a domain [AppNotification] entity.
  AppNotification toEntity() => AppNotification(
        id: id,
        title: title,
        body: body,
        type: NotificationType.fromJson(type),
        data: data,
        createdAt: createdAt,
        isRead: isRead,
      );

  /// Creates an [AppNotificationModel] from a domain [AppNotification] entity.
  factory AppNotificationModel.fromEntity(AppNotification entity) =>
      AppNotificationModel(
        id: entity.id,
        title: entity.title,
        body: entity.body,
        type: entity.type.toJson(),
        data: entity.data,
        createdAt: entity.createdAt,
        isRead: entity.isRead,
      );
}
