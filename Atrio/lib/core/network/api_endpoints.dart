/// Static API endpoint path constants.
///
/// Centralizes all API routes in one place to avoid
/// hardcoded strings throughout the data layer.
class ApiEndpoints {
  const ApiEndpoints._();

  // -- Auth --
  /// POST: Login with email and password.
  static const String login = '/auth/login';

  /// POST: Register a new user.
  static const String register = '/auth/register';

  /// POST: Request password reset email.
  static const String forgotPassword = '/auth/forgot-password';

  /// POST: Verify OTP code.
  static const String verifyOtp = '/auth/verify-otp';

  /// POST: Refresh the access token.
  static const String refreshToken = '/auth/refresh-token';

  /// POST: Logout and invalidate tokens.
  static const String logout = '/auth/logout';

  /// GET: Fetch the current user profile.
  static const String me = '/auth/me';

  // -- Notes --
  /// CRUD: Notes resource.
  static const String notes = '/notes';

  // -- Salons --
  /// GET: Search nearby salons with lat/lng/radius query params.
  static const String nearbySalons = '/salons/nearby';

  /// CRUD: Salons resource.
  static const String salons = '/salons';

  /// GET: Salon services. Append salonId: `/salons/{id}/services`.
  static String salonServices(String salonId) => '/salons/$salonId/services';

  /// GET: Salon barbers. Append salonId: `/salons/{id}/barbers`.
  static String salonBarbers(String salonId) => '/salons/$salonId/barbers';

  /// GET/POST: Salon reviews. Append salonId: `/salons/{id}/reviews`.
  static String salonReviews(String salonId) => '/salons/$salonId/reviews';

  /// GET: Single salon detail.
  static String salonDetail(String salonId) => '/salons/$salonId';

  // -- Bookings --
  /// GET (my list) + POST (create): Bookings resource.
  static const String bookings = '/bookings';

  /// GET: Single booking detail.
  static String bookingDetail(String bookingId) => '/bookings/$bookingId';

  /// POST: Cancel a booking.
  static String bookingCancel(String bookingId) =>
      '/bookings/$bookingId/cancel';

  /// GET: Available time slots.
  static const String availableSlots = '/bookings/available-slots';

  // -- Queue --
  /// GET: Queue status for a salon.
  static String queueStatus(String salonId) => '/queue/$salonId';

  /// POST: Join the queue.
  static const String queueJoin = '/queue/join';

  /// POST: Leave the queue.
  static String queueLeave(String entryId) => '/queue/$entryId/leave';

  /// GET: My position in a salon's queue.
  static String queueMyPosition(String salonId) =>
      '/queue/$salonId/my-position';

  /// WebSocket path for live queue updates.
  static String queueWebSocket(String salonId) => '/ws/queue/$salonId';

  // -- Owner --
  /// GET/PUT: Owner's salon.
  static const String mySalon = '/owner/salon';

  /// GET/POST: Owner's services.
  static const String ownerServices = '/owner/services';

  /// PUT/DELETE: Single service.
  static String ownerServiceDetail(String serviceId) =>
      '/owner/services/$serviceId';

  /// GET/POST: Owner's barbers.
  static const String ownerBarbers = '/owner/barbers';

  /// PUT/DELETE: Single barber.
  static String ownerBarberDetail(String barberId) =>
      '/owner/barbers/$barberId';

  /// GET: Owner statistics.
  static const String ownerStats = '/owner/stats';

  /// GET: Today's bookings for owner.
  static const String ownerTodayBookings = '/owner/bookings/today';

  /// POST: Advance the queue (serve next).
  static const String ownerAdvanceQueue = '/owner/queue/advance';

  /// POST: Skip a queue entry.
  static String ownerSkipQueue(String entryId) => '/owner/queue/$entryId/skip';

  /// PUT: Update a booking's status.
  static String ownerUpdateBooking(String bookingId) =>
      '/owner/bookings/$bookingId/status';

  // -- Notifications --
  /// GET: User notifications.
  static const String notifications = '/notifications';

  /// PUT: Mark a notification as read.
  static String notificationRead(String notificationId) =>
      '/notifications/$notificationId/read';

  /// PUT: Mark all notifications as read.
  static const String notificationsReadAll = '/notifications/read-all';

  /// POST: Register device for push notifications.
  static const String registerDevice = '/notifications/register-device';
}
