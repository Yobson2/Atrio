// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salon_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SalonStatsModel {
  @JsonKey(name: 'today_bookings')
  int get todayBookings;
  @JsonKey(name: 'today_completed')
  int get todayCompleted;
  @JsonKey(name: 'today_revenue')
  double get todayRevenue;
  @JsonKey(name: 'week_bookings')
  int get weekBookings;
  @JsonKey(name: 'week_revenue')
  double get weekRevenue;
  @JsonKey(name: 'average_rating')
  double get averageRating;
  @JsonKey(name: 'total_reviews')
  int get totalReviews;
  @JsonKey(name: 'average_wait_minutes')
  double get averageWaitMinutes;

  /// Create a copy of SalonStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SalonStatsModelCopyWith<SalonStatsModel> get copyWith =>
      _$SalonStatsModelCopyWithImpl<SalonStatsModel>(
          this as SalonStatsModel, _$identity);

  /// Serializes this SalonStatsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SalonStatsModel &&
            (identical(other.todayBookings, todayBookings) ||
                other.todayBookings == todayBookings) &&
            (identical(other.todayCompleted, todayCompleted) ||
                other.todayCompleted == todayCompleted) &&
            (identical(other.todayRevenue, todayRevenue) ||
                other.todayRevenue == todayRevenue) &&
            (identical(other.weekBookings, weekBookings) ||
                other.weekBookings == weekBookings) &&
            (identical(other.weekRevenue, weekRevenue) ||
                other.weekRevenue == weekRevenue) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalReviews, totalReviews) ||
                other.totalReviews == totalReviews) &&
            (identical(other.averageWaitMinutes, averageWaitMinutes) ||
                other.averageWaitMinutes == averageWaitMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      todayBookings,
      todayCompleted,
      todayRevenue,
      weekBookings,
      weekRevenue,
      averageRating,
      totalReviews,
      averageWaitMinutes);

  @override
  String toString() {
    return 'SalonStatsModel(todayBookings: $todayBookings, todayCompleted: $todayCompleted, todayRevenue: $todayRevenue, weekBookings: $weekBookings, weekRevenue: $weekRevenue, averageRating: $averageRating, totalReviews: $totalReviews, averageWaitMinutes: $averageWaitMinutes)';
  }
}

/// @nodoc
abstract mixin class $SalonStatsModelCopyWith<$Res> {
  factory $SalonStatsModelCopyWith(
          SalonStatsModel value, $Res Function(SalonStatsModel) _then) =
      _$SalonStatsModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'today_bookings') int todayBookings,
      @JsonKey(name: 'today_completed') int todayCompleted,
      @JsonKey(name: 'today_revenue') double todayRevenue,
      @JsonKey(name: 'week_bookings') int weekBookings,
      @JsonKey(name: 'week_revenue') double weekRevenue,
      @JsonKey(name: 'average_rating') double averageRating,
      @JsonKey(name: 'total_reviews') int totalReviews,
      @JsonKey(name: 'average_wait_minutes') double averageWaitMinutes});
}

/// @nodoc
class _$SalonStatsModelCopyWithImpl<$Res>
    implements $SalonStatsModelCopyWith<$Res> {
  _$SalonStatsModelCopyWithImpl(this._self, this._then);

  final SalonStatsModel _self;
  final $Res Function(SalonStatsModel) _then;

  /// Create a copy of SalonStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todayBookings = null,
    Object? todayCompleted = null,
    Object? todayRevenue = null,
    Object? weekBookings = null,
    Object? weekRevenue = null,
    Object? averageRating = null,
    Object? totalReviews = null,
    Object? averageWaitMinutes = null,
  }) {
    return _then(_self.copyWith(
      todayBookings: null == todayBookings
          ? _self.todayBookings
          : todayBookings // ignore: cast_nullable_to_non_nullable
              as int,
      todayCompleted: null == todayCompleted
          ? _self.todayCompleted
          : todayCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      todayRevenue: null == todayRevenue
          ? _self.todayRevenue
          : todayRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      weekBookings: null == weekBookings
          ? _self.weekBookings
          : weekBookings // ignore: cast_nullable_to_non_nullable
              as int,
      weekRevenue: null == weekRevenue
          ? _self.weekRevenue
          : weekRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      averageRating: null == averageRating
          ? _self.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _self.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      averageWaitMinutes: null == averageWaitMinutes
          ? _self.averageWaitMinutes
          : averageWaitMinutes // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SalonStatsModel extends SalonStatsModel {
  const _SalonStatsModel(
      {@JsonKey(name: 'today_bookings') this.todayBookings = 0,
      @JsonKey(name: 'today_completed') this.todayCompleted = 0,
      @JsonKey(name: 'today_revenue') this.todayRevenue = 0.0,
      @JsonKey(name: 'week_bookings') this.weekBookings = 0,
      @JsonKey(name: 'week_revenue') this.weekRevenue = 0.0,
      @JsonKey(name: 'average_rating') this.averageRating = 0.0,
      @JsonKey(name: 'total_reviews') this.totalReviews = 0,
      @JsonKey(name: 'average_wait_minutes') this.averageWaitMinutes = 0.0})
      : super._();
  factory _SalonStatsModel.fromJson(Map<String, dynamic> json) =>
      _$SalonStatsModelFromJson(json);

  @override
  @JsonKey(name: 'today_bookings')
  final int todayBookings;
  @override
  @JsonKey(name: 'today_completed')
  final int todayCompleted;
  @override
  @JsonKey(name: 'today_revenue')
  final double todayRevenue;
  @override
  @JsonKey(name: 'week_bookings')
  final int weekBookings;
  @override
  @JsonKey(name: 'week_revenue')
  final double weekRevenue;
  @override
  @JsonKey(name: 'average_rating')
  final double averageRating;
  @override
  @JsonKey(name: 'total_reviews')
  final int totalReviews;
  @override
  @JsonKey(name: 'average_wait_minutes')
  final double averageWaitMinutes;

  /// Create a copy of SalonStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SalonStatsModelCopyWith<_SalonStatsModel> get copyWith =>
      __$SalonStatsModelCopyWithImpl<_SalonStatsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SalonStatsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SalonStatsModel &&
            (identical(other.todayBookings, todayBookings) ||
                other.todayBookings == todayBookings) &&
            (identical(other.todayCompleted, todayCompleted) ||
                other.todayCompleted == todayCompleted) &&
            (identical(other.todayRevenue, todayRevenue) ||
                other.todayRevenue == todayRevenue) &&
            (identical(other.weekBookings, weekBookings) ||
                other.weekBookings == weekBookings) &&
            (identical(other.weekRevenue, weekRevenue) ||
                other.weekRevenue == weekRevenue) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalReviews, totalReviews) ||
                other.totalReviews == totalReviews) &&
            (identical(other.averageWaitMinutes, averageWaitMinutes) ||
                other.averageWaitMinutes == averageWaitMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      todayBookings,
      todayCompleted,
      todayRevenue,
      weekBookings,
      weekRevenue,
      averageRating,
      totalReviews,
      averageWaitMinutes);

  @override
  String toString() {
    return 'SalonStatsModel(todayBookings: $todayBookings, todayCompleted: $todayCompleted, todayRevenue: $todayRevenue, weekBookings: $weekBookings, weekRevenue: $weekRevenue, averageRating: $averageRating, totalReviews: $totalReviews, averageWaitMinutes: $averageWaitMinutes)';
  }
}

/// @nodoc
abstract mixin class _$SalonStatsModelCopyWith<$Res>
    implements $SalonStatsModelCopyWith<$Res> {
  factory _$SalonStatsModelCopyWith(
          _SalonStatsModel value, $Res Function(_SalonStatsModel) _then) =
      __$SalonStatsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'today_bookings') int todayBookings,
      @JsonKey(name: 'today_completed') int todayCompleted,
      @JsonKey(name: 'today_revenue') double todayRevenue,
      @JsonKey(name: 'week_bookings') int weekBookings,
      @JsonKey(name: 'week_revenue') double weekRevenue,
      @JsonKey(name: 'average_rating') double averageRating,
      @JsonKey(name: 'total_reviews') int totalReviews,
      @JsonKey(name: 'average_wait_minutes') double averageWaitMinutes});
}

/// @nodoc
class __$SalonStatsModelCopyWithImpl<$Res>
    implements _$SalonStatsModelCopyWith<$Res> {
  __$SalonStatsModelCopyWithImpl(this._self, this._then);

  final _SalonStatsModel _self;
  final $Res Function(_SalonStatsModel) _then;

  /// Create a copy of SalonStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? todayBookings = null,
    Object? todayCompleted = null,
    Object? todayRevenue = null,
    Object? weekBookings = null,
    Object? weekRevenue = null,
    Object? averageRating = null,
    Object? totalReviews = null,
    Object? averageWaitMinutes = null,
  }) {
    return _then(_SalonStatsModel(
      todayBookings: null == todayBookings
          ? _self.todayBookings
          : todayBookings // ignore: cast_nullable_to_non_nullable
              as int,
      todayCompleted: null == todayCompleted
          ? _self.todayCompleted
          : todayCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      todayRevenue: null == todayRevenue
          ? _self.todayRevenue
          : todayRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      weekBookings: null == weekBookings
          ? _self.weekBookings
          : weekBookings // ignore: cast_nullable_to_non_nullable
              as int,
      weekRevenue: null == weekRevenue
          ? _self.weekRevenue
          : weekRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      averageRating: null == averageRating
          ? _self.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _self.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      averageWaitMinutes: null == averageWaitMinutes
          ? _self.averageWaitMinutes
          : averageWaitMinutes // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
