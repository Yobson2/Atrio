/// Static route name and path constants.
abstract final class RouteNames {
  // -- Splash --
  static const String splash = '/';
  static const String splashName = 'splash';

  // -- Onboarding --
  static const String onboarding = '/onboarding';
  static const String onboardingName = 'onboarding';

  // -- Auth --
  static const String login = '/login';
  static const String loginName = 'login';

  static const String register = '/register';
  static const String registerName = 'register';

  static const String forgotPassword = '/forgot-password';
  static const String forgotPasswordName = 'forgotPassword';

  static const String otpVerification = '/otp-verification';
  static const String otpVerificationName = 'otpVerification';

  static const String chooseRole = '/choose-role';
  static const String chooseRoleName = 'chooseRole';

  static const String profileSetup = '/profile-setup';
  static const String profileSetupName = 'profileSetup';

  // -- Client Shell --
  // Tab 1: Discover
  static const String discover = '/discover';
  static const String discoverName = 'discover';

  static const String salonDetail = 'salon/:salonId';
  static const String salonDetailName = 'salonDetail';

  static const String salonReviews = 'reviews';
  static const String salonReviewsName = 'salonReviews';

  // Tab 2: Bookings
  static const String myBookings = '/bookings';
  static const String myBookingsName = 'myBookings';

  static const String bookingDetail = 'detail/:bookingId';
  static const String bookingDetailName = 'bookingDetail';

  // Tab 3: Queue
  static const String liveQueue = '/queue';
  static const String liveQueueName = 'liveQueue';

  // Tab 4: Client Settings / Profile
  static const String clientSettings = '/client-settings';
  static const String clientSettingsName = 'clientSettings';

  static const String notifications = 'notifications';
  static const String notificationsName = 'notifications';

  static const String editProfile = 'edit-profile';
  static const String editProfileName = 'editProfile';

  static const String changePassword = 'change-password';
  static const String changePasswordName = 'changePassword';

  static const String helpSupport = 'help-support';
  static const String helpSupportName = 'helpSupport';

  static const String paymentMethods = 'payment-methods';
  static const String paymentMethodsName = 'paymentMethods';

  static const String addPaymentMethod = 'add-payment';
  static const String addPaymentMethodName = 'addPaymentMethod';

  static const String favorites = 'favorites';
  static const String favoritesName = 'favorites';

  static const String conversations = 'conversations';
  static const String conversationsName = 'conversations';

  static const String loyalty = 'loyalty';
  static const String loyaltyName = 'loyalty';

  static const String pointsHistory = 'points-history';
  static const String pointsHistoryName = 'pointsHistory';

  static const String rewards = 'rewards';
  static const String rewardsName = 'rewards';

  static const String referral = 'referral';
  static const String referralName = 'referral';

  // -- Full-screen routes (outside shell) --
  static const String writeReview = '/write-review';
  static const String writeReviewName = 'writeReview';

  static const String chatDetail = '/chat/:conversationId';
  static const String chatDetailName = 'chatDetail';

  // -- Booking Flow (full-screen, outside shell) --
  static const String bookSelectService = '/book/service';
  static const String bookSelectServiceName = 'bookSelectService';

  static const String bookSelectBarber = '/book/barber';
  static const String bookSelectBarberName = 'bookSelectBarber';

  static const String bookSelectTime = '/book/time';
  static const String bookSelectTimeName = 'bookSelectTime';

  static const String bookConfirm = '/book/confirm';
  static const String bookConfirmName = 'bookConfirm';

  static const String bookingConfirmation = '/book/confirmed';
  static const String bookingConfirmationName = 'bookingConfirmation';

  // -- Owner Shell --
  // Tab 1: Dashboard
  static const String ownerDashboard = '/dashboard';
  static const String ownerDashboardName = 'ownerDashboard';

  // Tab 2: All Bookings (Owner)
  static const String ownerBookings = '/owner-bookings';
  static const String ownerBookingsName = 'ownerBookings';

  // Tab 3: Statistics
  static const String statistics = '/statistics';
  static const String statisticsName = 'statistics';

  // Tab 4: Owner Settings
  static const String ownerSettings = '/owner-settings';
  static const String ownerSettingsName = 'ownerSettings';

  static const String salonSettings = 'salon-settings';
  static const String salonSettingsName = 'salonSettings';

  // -- Owner Management (nested under dashboard or settings) --
  static const String manageBarbers = '/manage-barbers';
  static const String manageBarbersName = 'manageBarbers';

  static const String barberForm = '/barber-form';
  static const String barberFormName = 'barberForm';

  static const String manageServices = '/manage-services';
  static const String manageServicesName = 'manageServices';

  static const String serviceForm = '/service-form';
  static const String serviceFormName = 'serviceForm';

  static const String queueManagement = '/queue-management';
  static const String queueManagementName = 'queueManagement';

  // -- Legacy (kept for compatibility) --
  static const String home = '/home';
  static const String homeName = 'home';

  static const String profile = '/profile';
  static const String profileName = 'profile';

  static const String settings = '/settings';
  static const String settingsName = 'settings';

  static const String notes = '/home/notes';
  static const String notesName = 'notes';

  static const String noteDetail = '/home/notes/detail';
  static const String noteDetailName = 'noteDetail';
}
