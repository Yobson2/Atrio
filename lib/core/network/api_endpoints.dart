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

  /// POST: Send OTP to phone number.
  static const String sendOtp = '/auth/send-otp';

  /// POST: Verify phone OTP and authenticate.
  static const String verifyPhoneOtp = '/auth/verify-phone-otp';

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
  /// GET: List all salons.
  static const String salons = '/salons';

  /// GET: Salon details by ID. Append `/$id`.
  static const String salonDetail = '/salons';

  /// GET: Services for a salon. Append `/$salonId/services`.
  static const String salonServices = '/salons';

  /// GET: Barbers for a salon. Append `/$salonId/barbers`.
  static const String salonBarbers = '/salons';

  /// GET: Reviews for a salon. Append `/$salonId/reviews`.
  static const String salonReviews = '/salons';

  // -- Bookings --
  /// CRUD: Bookings resource.
  static const String bookings = '/bookings';

  /// GET: Available time slots. Query params: salon_id, barber_id, date.
  static const String timeSlots = '/time-slots';

  // -- Queue --
  /// GET/POST: Queue for a salon. Append `/$salonId`.
  static const String queue = '/queue';

  // -- Notifications --
  /// GET: User notifications.
  static const String notifications = '/notifications';

  // -- Owner --
  /// GET: Owner dashboard stats.
  static const String ownerDashboard = '/owner/dashboard';

  /// GET: Owner statistics.
  static const String ownerStats = '/owner/stats';
}
