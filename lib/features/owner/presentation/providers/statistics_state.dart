import 'package:flutter_templates/features/owner/domain/entities/revenue_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistics_state.freezed.dart';

/// State for the statistics page.
@freezed
sealed class StatisticsState with _$StatisticsState {
  const factory StatisticsState.initial() = StatisticsInitial;
  const factory StatisticsState.loading() = StatisticsLoading;
  const factory StatisticsState.loaded(PerformanceStats stats) =
      StatisticsLoaded;
  const factory StatisticsState.error(String message) = StatisticsError;
}
