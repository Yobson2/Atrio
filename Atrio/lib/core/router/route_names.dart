/// Static route name and path constants.
abstract final class RouteNames {
  // -- Splash --
  /// Splash screen path.
  static const String splash = '/';

  /// Splash screen name.
  static const String splashName = 'splash';

  // -- Onboarding --
  /// Onboarding path.
  static const String onboarding = '/onboarding';

  /// Onboarding name.
  static const String onboardingName = 'onboarding';

  // -- Auth --
  /// Login path.
  static const String login = '/login';

  /// Login name.
  static const String loginName = 'login';

  /// Register path.
  static const String register = '/register';

  /// Register name.
  static const String registerName = 'register';

  /// Forgot password path.
  static const String forgotPassword = '/forgot-password';

  /// Forgot password name.
  static const String forgotPasswordName = 'forgotPassword';

  /// OTP verification path.
  static const String otpVerification = '/otp-verification';

  /// OTP verification name.
  static const String otpVerificationName = 'otpVerification';

  /// Choose role path.
  static const String chooseRole = '/choose-role';

  /// Choose role name.
  static const String chooseRoleName = 'chooseRole';

  /// Profile setup path.
  static const String profileSetup = '/profile-setup';

  /// Profile setup name.
  static const String profileSetupName = 'profileSetup';

  // -- Client Home Shell --
  /// Discover (client home) path.
  static const String discover = '/discover';

  /// Discover name.
  static const String discoverName = 'discover';

  /// My bookings tab path.
  static const String myBookings = '/bookings';

  /// My bookings tab name.
  static const String myBookingsName = 'myBookings';

  /// Profile path.
  static const String profile = '/profile';

  /// Profile name.
  static const String profileName = 'profile';

  /// Settings path.
  static const String settings = '/settings';

  /// Settings name.
  static const String settingsName = 'settings';

  // -- Salon Discovery --
  /// Salon detail path (nested under discover).
  static const String salonDetail = 'salon';

  /// Salon detail name.
  static const String salonDetailName = 'salonDetail';

  /// Salon reviews path (nested under salon detail).
  static const String salonReviews = 'reviews';

  /// Salon reviews name.
  static const String salonReviewsName = 'salonReviews';

  /// Salon map path (nested under discover).
  static const String salonMap = 'map';

  /// Salon map name.
  static const String salonMapName = 'salonMap';

  // -- Booking --
  /// Booking flow path.
  static const String bookingFlow = '/booking';

  /// Booking flow name.
  static const String bookingFlowName = 'bookingFlow';

  /// Booking confirmation path.
  static const String bookingConfirmation = '/booking/confirmation';

  /// Booking confirmation name.
  static const String bookingConfirmationName = 'bookingConfirmation';

  /// Booking detail path (nested under myBookings).
  static const String bookingDetail = 'detail';

  /// Booking detail name.
  static const String bookingDetailName = 'bookingDetail';

  // -- Queue --
  /// Queue status path.
  static const String queueStatus = '/queue';

  /// Queue status name.
  static const String queueStatusName = 'queueStatus';

  // -- Notifications --
  /// Notifications path.
  static const String notifications = '/notifications';

  /// Notifications name.
  static const String notificationsName = 'notifications';

  // -- Owner Home Shell --
  /// Owner dashboard path.
  static const String ownerDashboard = '/owner';

  /// Owner dashboard name.
  static const String ownerDashboardName = 'ownerDashboard';

  /// Owner queue management path.
  static const String ownerQueue = '/owner-queue';

  /// Owner queue name.
  static const String ownerQueueName = 'ownerQueue';

  /// Owner services management path (nested under owner dashboard).
  static const String ownerServices = 'services';

  /// Owner services name.
  static const String ownerServicesName = 'ownerServices';

  /// Owner service form path (nested under services).
  static const String ownerServiceForm = 'form';

  /// Owner service form name.
  static const String ownerServiceFormName = 'ownerServiceForm';

  /// Owner barbers management path (nested under owner dashboard).
  static const String ownerBarbers = 'barbers';

  /// Owner barbers name.
  static const String ownerBarbersName = 'ownerBarbers';

  /// Owner barber form path (nested under barbers).
  static const String ownerBarberForm = 'form';

  /// Owner barber form name.
  static const String ownerBarberFormName = 'ownerBarberForm';

  /// Owner stats path (nested under owner dashboard).
  static const String ownerStats = 'stats';

  /// Owner stats name.
  static const String ownerStatsName = 'ownerStats';

  /// Owner bookings path (nested under owner dashboard).
  static const String ownerBookings = 'bookings';

  /// Owner bookings name.
  static const String ownerBookingsName = 'ownerBookings';

  /// Salon settings path (nested under owner dashboard).
  static const String salonSettings = 'salon-settings';

  /// Salon settings name.
  static const String salonSettingsName = 'salonSettings';

  // -- Legacy (kept for backward compatibility) --
  /// Home path (redirects based on role).
  static const String home = '/home';

  /// Home name.
  static const String homeName = 'home';

  /// Notes path.
  static const String notes = '/home/notes';

  /// Notes name.
  static const String notesName = 'notes';

  /// Note detail path.
  static const String noteDetail = '/home/notes/detail';

  /// Note detail name.
  static const String noteDetailName = 'noteDetail';
}
