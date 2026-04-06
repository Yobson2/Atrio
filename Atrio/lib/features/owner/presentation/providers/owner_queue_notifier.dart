import 'package:flutter_templates/features/booking/domain/entities/booking_status.dart';
import 'package:flutter_templates/features/owner/domain/usecases/advance_queue_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/skip_queue_entry_usecase.dart';
import 'package:flutter_templates/features/owner/domain/usecases/update_booking_status_usecase.dart';
import 'package:flutter_templates/features/owner/presentation/providers/owner_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'owner_queue_notifier.g.dart';

/// State for queue operations: idle, loading, success, or error.
enum OwnerQueueActionState {
  /// No action in progress.
  idle,

  /// An action is in progress.
  loading,

  /// Action completed successfully.
  success,

  /// Action failed.
  error,
}

/// Manages queue operations for the owner.
@riverpod
class OwnerQueueNotifier extends _$OwnerQueueNotifier {
  String _lastError = '';

  /// The last error message.
  String get lastError => _lastError;

  @override
  OwnerQueueActionState build() {
    return OwnerQueueActionState.idle;
  }

  /// Advances the queue for the given salon.
  Future<bool> advanceQueue(String salonId) async {
    state = OwnerQueueActionState.loading;
    final result = await ref
        .read(advanceQueueUseCaseProvider)
        .call(AdvanceQueueParams(salonId: salonId));
    return result.fold(
      (failure) {
        _lastError = failure.message;
        state = OwnerQueueActionState.error;
        return false;
      },
      (_) {
        state = OwnerQueueActionState.success;
        return true;
      },
    );
  }

  /// Skips a queue entry.
  Future<bool> skipEntry(String entryId) async {
    state = OwnerQueueActionState.loading;
    final result = await ref
        .read(skipQueueEntryUseCaseProvider)
        .call(SkipQueueEntryParams(entryId: entryId));
    return result.fold(
      (failure) {
        _lastError = failure.message;
        state = OwnerQueueActionState.error;
        return false;
      },
      (_) {
        state = OwnerQueueActionState.success;
        return true;
      },
    );
  }

  /// Updates a booking's status.
  Future<bool> updateBookingStatus(
    String bookingId,
    BookingStatus status,
  ) async {
    state = OwnerQueueActionState.loading;
    final result = await ref
        .read(updateBookingStatusUseCaseProvider)
        .call(UpdateBookingStatusParams(
          bookingId: bookingId,
          status: status,
        ));
    return result.fold(
      (failure) {
        _lastError = failure.message;
        state = OwnerQueueActionState.error;
        return false;
      },
      (_) {
        state = OwnerQueueActionState.success;
        return true;
      },
    );
  }

  /// Resets the state back to idle.
  void reset() {
    _lastError = '';
    state = OwnerQueueActionState.idle;
  }
}
