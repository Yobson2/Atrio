// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueueStatusModel {
  @JsonKey(name: 'salon_id')
  String get salonId;
  @JsonKey(name: 'total_waiting')
  int get totalWaiting;
  @JsonKey(name: 'estimated_wait_minutes')
  int get estimatedWaitMinutes;
  @JsonKey(name: 'currently_serving')
  int get currentlyServing;
  List<QueueEntryModel> get entries;
  @JsonKey(name: 'last_updated_at')
  DateTime get lastUpdatedAt;

  /// Create a copy of QueueStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QueueStatusModelCopyWith<QueueStatusModel> get copyWith =>
      _$QueueStatusModelCopyWithImpl<QueueStatusModel>(
          this as QueueStatusModel, _$identity);

  /// Serializes this QueueStatusModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QueueStatusModel &&
            (identical(other.salonId, salonId) || other.salonId == salonId) &&
            (identical(other.totalWaiting, totalWaiting) ||
                other.totalWaiting == totalWaiting) &&
            (identical(other.estimatedWaitMinutes, estimatedWaitMinutes) ||
                other.estimatedWaitMinutes == estimatedWaitMinutes) &&
            (identical(other.currentlyServing, currentlyServing) ||
                other.currentlyServing == currentlyServing) &&
            const DeepCollectionEquality().equals(other.entries, entries) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      salonId,
      totalWaiting,
      estimatedWaitMinutes,
      currentlyServing,
      const DeepCollectionEquality().hash(entries),
      lastUpdatedAt);

  @override
  String toString() {
    return 'QueueStatusModel(salonId: $salonId, totalWaiting: $totalWaiting, estimatedWaitMinutes: $estimatedWaitMinutes, currentlyServing: $currentlyServing, entries: $entries, lastUpdatedAt: $lastUpdatedAt)';
  }
}

/// @nodoc
abstract mixin class $QueueStatusModelCopyWith<$Res> {
  factory $QueueStatusModelCopyWith(
          QueueStatusModel value, $Res Function(QueueStatusModel) _then) =
      _$QueueStatusModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'salon_id') String salonId,
      @JsonKey(name: 'total_waiting') int totalWaiting,
      @JsonKey(name: 'estimated_wait_minutes') int estimatedWaitMinutes,
      @JsonKey(name: 'currently_serving') int currentlyServing,
      List<QueueEntryModel> entries,
      @JsonKey(name: 'last_updated_at') DateTime lastUpdatedAt});
}

/// @nodoc
class _$QueueStatusModelCopyWithImpl<$Res>
    implements $QueueStatusModelCopyWith<$Res> {
  _$QueueStatusModelCopyWithImpl(this._self, this._then);

  final QueueStatusModel _self;
  final $Res Function(QueueStatusModel) _then;

  /// Create a copy of QueueStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? salonId = null,
    Object? totalWaiting = null,
    Object? estimatedWaitMinutes = null,
    Object? currentlyServing = null,
    Object? entries = null,
    Object? lastUpdatedAt = null,
  }) {
    return _then(_self.copyWith(
      salonId: null == salonId
          ? _self.salonId
          : salonId // ignore: cast_nullable_to_non_nullable
              as String,
      totalWaiting: null == totalWaiting
          ? _self.totalWaiting
          : totalWaiting // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedWaitMinutes: null == estimatedWaitMinutes
          ? _self.estimatedWaitMinutes
          : estimatedWaitMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      currentlyServing: null == currentlyServing
          ? _self.currentlyServing
          : currentlyServing // ignore: cast_nullable_to_non_nullable
              as int,
      entries: null == entries
          ? _self.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<QueueEntryModel>,
      lastUpdatedAt: null == lastUpdatedAt
          ? _self.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _QueueStatusModel extends QueueStatusModel {
  const _QueueStatusModel(
      {@JsonKey(name: 'salon_id') required this.salonId,
      @JsonKey(name: 'total_waiting') this.totalWaiting = 0,
      @JsonKey(name: 'estimated_wait_minutes') this.estimatedWaitMinutes = 0,
      @JsonKey(name: 'currently_serving') this.currentlyServing = 0,
      final List<QueueEntryModel> entries = const [],
      @JsonKey(name: 'last_updated_at') required this.lastUpdatedAt})
      : _entries = entries,
        super._();
  factory _QueueStatusModel.fromJson(Map<String, dynamic> json) =>
      _$QueueStatusModelFromJson(json);

  @override
  @JsonKey(name: 'salon_id')
  final String salonId;
  @override
  @JsonKey(name: 'total_waiting')
  final int totalWaiting;
  @override
  @JsonKey(name: 'estimated_wait_minutes')
  final int estimatedWaitMinutes;
  @override
  @JsonKey(name: 'currently_serving')
  final int currentlyServing;
  final List<QueueEntryModel> _entries;
  @override
  @JsonKey()
  List<QueueEntryModel> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  @JsonKey(name: 'last_updated_at')
  final DateTime lastUpdatedAt;

  /// Create a copy of QueueStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QueueStatusModelCopyWith<_QueueStatusModel> get copyWith =>
      __$QueueStatusModelCopyWithImpl<_QueueStatusModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QueueStatusModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QueueStatusModel &&
            (identical(other.salonId, salonId) || other.salonId == salonId) &&
            (identical(other.totalWaiting, totalWaiting) ||
                other.totalWaiting == totalWaiting) &&
            (identical(other.estimatedWaitMinutes, estimatedWaitMinutes) ||
                other.estimatedWaitMinutes == estimatedWaitMinutes) &&
            (identical(other.currentlyServing, currentlyServing) ||
                other.currentlyServing == currentlyServing) &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      salonId,
      totalWaiting,
      estimatedWaitMinutes,
      currentlyServing,
      const DeepCollectionEquality().hash(_entries),
      lastUpdatedAt);

  @override
  String toString() {
    return 'QueueStatusModel(salonId: $salonId, totalWaiting: $totalWaiting, estimatedWaitMinutes: $estimatedWaitMinutes, currentlyServing: $currentlyServing, entries: $entries, lastUpdatedAt: $lastUpdatedAt)';
  }
}

/// @nodoc
abstract mixin class _$QueueStatusModelCopyWith<$Res>
    implements $QueueStatusModelCopyWith<$Res> {
  factory _$QueueStatusModelCopyWith(
          _QueueStatusModel value, $Res Function(_QueueStatusModel) _then) =
      __$QueueStatusModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'salon_id') String salonId,
      @JsonKey(name: 'total_waiting') int totalWaiting,
      @JsonKey(name: 'estimated_wait_minutes') int estimatedWaitMinutes,
      @JsonKey(name: 'currently_serving') int currentlyServing,
      List<QueueEntryModel> entries,
      @JsonKey(name: 'last_updated_at') DateTime lastUpdatedAt});
}

/// @nodoc
class __$QueueStatusModelCopyWithImpl<$Res>
    implements _$QueueStatusModelCopyWith<$Res> {
  __$QueueStatusModelCopyWithImpl(this._self, this._then);

  final _QueueStatusModel _self;
  final $Res Function(_QueueStatusModel) _then;

  /// Create a copy of QueueStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? salonId = null,
    Object? totalWaiting = null,
    Object? estimatedWaitMinutes = null,
    Object? currentlyServing = null,
    Object? entries = null,
    Object? lastUpdatedAt = null,
  }) {
    return _then(_QueueStatusModel(
      salonId: null == salonId
          ? _self.salonId
          : salonId // ignore: cast_nullable_to_non_nullable
              as String,
      totalWaiting: null == totalWaiting
          ? _self.totalWaiting
          : totalWaiting // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedWaitMinutes: null == estimatedWaitMinutes
          ? _self.estimatedWaitMinutes
          : estimatedWaitMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      currentlyServing: null == currentlyServing
          ? _self.currentlyServing
          : currentlyServing // ignore: cast_nullable_to_non_nullable
              as int,
      entries: null == entries
          ? _self._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<QueueEntryModel>,
      lastUpdatedAt: null == lastUpdatedAt
          ? _self.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
