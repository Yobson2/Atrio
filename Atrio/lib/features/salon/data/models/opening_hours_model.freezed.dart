// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'opening_hours_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OpeningHoursModel {
  String get day;
  @JsonKey(name: 'open_time')
  String get openTime;
  @JsonKey(name: 'close_time')
  String get closeTime;
  @JsonKey(name: 'is_closed')
  bool get isClosed;

  /// Create a copy of OpeningHoursModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OpeningHoursModelCopyWith<OpeningHoursModel> get copyWith =>
      _$OpeningHoursModelCopyWithImpl<OpeningHoursModel>(
          this as OpeningHoursModel, _$identity);

  /// Serializes this OpeningHoursModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OpeningHoursModel &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.openTime, openTime) ||
                other.openTime == openTime) &&
            (identical(other.closeTime, closeTime) ||
                other.closeTime == closeTime) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, day, openTime, closeTime, isClosed);

  @override
  String toString() {
    return 'OpeningHoursModel(day: $day, openTime: $openTime, closeTime: $closeTime, isClosed: $isClosed)';
  }
}

/// @nodoc
abstract mixin class $OpeningHoursModelCopyWith<$Res> {
  factory $OpeningHoursModelCopyWith(
          OpeningHoursModel value, $Res Function(OpeningHoursModel) _then) =
      _$OpeningHoursModelCopyWithImpl;
  @useResult
  $Res call(
      {String day,
      @JsonKey(name: 'open_time') String openTime,
      @JsonKey(name: 'close_time') String closeTime,
      @JsonKey(name: 'is_closed') bool isClosed});
}

/// @nodoc
class _$OpeningHoursModelCopyWithImpl<$Res>
    implements $OpeningHoursModelCopyWith<$Res> {
  _$OpeningHoursModelCopyWithImpl(this._self, this._then);

  final OpeningHoursModel _self;
  final $Res Function(OpeningHoursModel) _then;

  /// Create a copy of OpeningHoursModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? openTime = null,
    Object? closeTime = null,
    Object? isClosed = null,
  }) {
    return _then(_self.copyWith(
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      openTime: null == openTime
          ? _self.openTime
          : openTime // ignore: cast_nullable_to_non_nullable
              as String,
      closeTime: null == closeTime
          ? _self.closeTime
          : closeTime // ignore: cast_nullable_to_non_nullable
              as String,
      isClosed: null == isClosed
          ? _self.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _OpeningHoursModel extends OpeningHoursModel {
  const _OpeningHoursModel(
      {required this.day,
      @JsonKey(name: 'open_time') required this.openTime,
      @JsonKey(name: 'close_time') required this.closeTime,
      @JsonKey(name: 'is_closed') this.isClosed = false})
      : super._();
  factory _OpeningHoursModel.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursModelFromJson(json);

  @override
  final String day;
  @override
  @JsonKey(name: 'open_time')
  final String openTime;
  @override
  @JsonKey(name: 'close_time')
  final String closeTime;
  @override
  @JsonKey(name: 'is_closed')
  final bool isClosed;

  /// Create a copy of OpeningHoursModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OpeningHoursModelCopyWith<_OpeningHoursModel> get copyWith =>
      __$OpeningHoursModelCopyWithImpl<_OpeningHoursModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$OpeningHoursModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OpeningHoursModel &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.openTime, openTime) ||
                other.openTime == openTime) &&
            (identical(other.closeTime, closeTime) ||
                other.closeTime == closeTime) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, day, openTime, closeTime, isClosed);

  @override
  String toString() {
    return 'OpeningHoursModel(day: $day, openTime: $openTime, closeTime: $closeTime, isClosed: $isClosed)';
  }
}

/// @nodoc
abstract mixin class _$OpeningHoursModelCopyWith<$Res>
    implements $OpeningHoursModelCopyWith<$Res> {
  factory _$OpeningHoursModelCopyWith(
          _OpeningHoursModel value, $Res Function(_OpeningHoursModel) _then) =
      __$OpeningHoursModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String day,
      @JsonKey(name: 'open_time') String openTime,
      @JsonKey(name: 'close_time') String closeTime,
      @JsonKey(name: 'is_closed') bool isClosed});
}

/// @nodoc
class __$OpeningHoursModelCopyWithImpl<$Res>
    implements _$OpeningHoursModelCopyWith<$Res> {
  __$OpeningHoursModelCopyWithImpl(this._self, this._then);

  final _OpeningHoursModel _self;
  final $Res Function(_OpeningHoursModel) _then;

  /// Create a copy of OpeningHoursModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? day = null,
    Object? openTime = null,
    Object? closeTime = null,
    Object? isClosed = null,
  }) {
    return _then(_OpeningHoursModel(
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      openTime: null == openTime
          ? _self.openTime
          : openTime // ignore: cast_nullable_to_non_nullable
              as String,
      closeTime: null == closeTime
          ? _self.closeTime
          : closeTime // ignore: cast_nullable_to_non_nullable
              as String,
      isClosed: null == isClosed
          ? _self.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
