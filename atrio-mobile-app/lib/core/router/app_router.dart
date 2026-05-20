import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/providers/analytics_provider.dart';
import 'package:flutter_templates/core/providers/storage_providers.dart';
import 'package:flutter_templates/core/router/analytics_observer.dart';
import 'package:flutter_templates/core/router/page_transitions.dart';
import 'package:flutter_templates/core/router/route_names.dart';
import 'package:flutter_templates/features/auth/presentation/pages/choose_role_page.dart';
import 'package:flutter_templates/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:flutter_templates/features/auth/presentation/pages/phone_entry_page.dart';
import 'package:flutter_templates/features/auth/presentation/pages/profile_setup_page.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_state.dart';
import 'package:flutter_templates/features/booking/presentation/pages/booking_confirmation_page.dart';
import 'package:flutter_templates/features/booking/presentation/pages/booking_detail_page.dart';
import 'package:flutter_templates/features/booking/presentation/pages/confirm_booking_page.dart';
import 'package:flutter_templates/features/booking/presentation/pages/my_bookings_page.dart';
import 'package:flutter_templates/features/booking/presentation/pages/select_barber_page.dart';
import 'package:flutter_templates/features/booking/presentation/pages/select_service_page.dart';
import 'package:flutter_templates/features/booking/presentation/pages/select_time_page.dart';
import 'package:flutter_templates/features/chat/presentation/pages/chat_detail_page.dart';
import 'package:flutter_templates/features/chat/presentation/pages/conversations_page.dart';
import 'package:flutter_templates/features/favorites/presentation/pages/favorites_page.dart';
import 'package:flutter_templates/features/home/presentation/pages/client_shell.dart';
import 'package:flutter_templates/features/home/presentation/pages/owner_shell.dart';
import 'package:flutter_templates/features/loyalty/presentation/pages/available_rewards_page.dart';
import 'package:flutter_templates/features/loyalty/presentation/pages/loyalty_dashboard_page.dart';
import 'package:flutter_templates/features/loyalty/presentation/pages/points_history_page.dart';
import 'package:flutter_templates/features/loyalty/presentation/pages/referral_page.dart';
import 'package:flutter_templates/features/notification/presentation/pages/notifications_page.dart';
import 'package:flutter_templates/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/barber_form_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/manage_barbers_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/manage_services_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/owner_all_bookings_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/owner_dashboard_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/owner_settings_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/salon_settings_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/service_form_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/statistics_page.dart';
import 'package:flutter_templates/features/profile/presentation/pages/add_payment_method_page.dart';
import 'package:flutter_templates/features/profile/presentation/pages/change_password_page.dart';
import 'package:flutter_templates/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:flutter_templates/features/profile/presentation/pages/help_support_page.dart';
import 'package:flutter_templates/features/profile/presentation/pages/my_profile_page.dart';
import 'package:flutter_templates/features/profile/presentation/pages/payment_methods_page.dart';
import 'package:flutter_templates/features/queue/presentation/pages/live_queue_page.dart';
import 'package:flutter_templates/features/queue/presentation/pages/queue_management_page.dart';
import 'package:flutter_templates/features/salon/presentation/pages/salon_detail_page.dart';
import 'package:flutter_templates/features/salon/presentation/pages/salon_discovery_page.dart';
import 'package:flutter_templates/features/salon/presentation/pages/salon_reviews_page.dart';
import 'package:flutter_templates/features/salon/presentation/pages/write_review_page.dart';
import 'package:flutter_templates/features/splash/presentation/pages/splash_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

// Client shell keys
final _discoverNavigatorKey = GlobalKey<NavigatorState>();
final _bookingsNavigatorKey = GlobalKey<NavigatorState>();
final _queueNavigatorKey = GlobalKey<NavigatorState>();
final _clientSettingsNavigatorKey = GlobalKey<NavigatorState>();

// Owner shell keys
final _dashboardNavigatorKey = GlobalKey<NavigatorState>();
final _ownerBookingsNavigatorKey = GlobalKey<NavigatorState>();
final _statsNavigatorKey = GlobalKey<NavigatorState>();
final _ownerSettingsNavigatorKey = GlobalKey<NavigatorState>();

/// Public routes that don't require authentication.
const _publicPaths = [
  RouteNames.splash,
  RouteNames.onboarding,
  RouteNames.login,
  RouteNames.otpVerification,
  RouteNames.chooseRole,
  RouteNames.profileSetup,
];

/// Provides the application [GoRouter] instance.
///
/// Supports dual-role navigation: clients get Discover/Bookings/Queue/Settings,
/// owners get Dashboard/Bookings/Statistics/Settings.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final authState = ValueNotifier<AuthState>(const AuthInitial());

  ref
    ..listen(authNotifierProvider, (_, next) {
      authState.value = next;
    })
    ..onDispose(authState.dispose);

  final analytics = ref.read(analyticsServiceProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.splash,
    refreshListenable: authState,
    observers: [AnalyticsObserver(analytics)],
    redirect: (context, state) {
      final currentPath = state.matchedLocation;
      final auth = authState.value;

      // Never redirect away from splash.
      if (currentPath == RouteNames.splash) return null;

      // Don't redirect while auth state is still initializing.
      if (auth is AuthInitial || auth is AuthLoading) return null;

      final isPublicRoute = _publicPaths.contains(currentPath);

      final localStorage = ref.read(localStorageProvider);

      // Redirect authenticated users away from auth pages.
      if (auth is AuthAuthenticated && isPublicRoute) {
        // New user hasn't completed profile setup → let them through
        if (!localStorage.hasCompletedProfileSetup) {
          // Allow profile-setup and choose-role for new users
          if (currentPath == RouteNames.profileSetup ||
              currentPath == RouteNames.chooseRole) {
            return null;
          }
          return RouteNames.profileSetup;
        }
        // Returning user → route to the correct shell based on role
        return auth.user.isOwner
            ? RouteNames.ownerDashboard
            : RouteNames.discover;
      }

      // Redirect unauthenticated users to login for protected routes.
      if (auth is AuthUnauthenticated && !isPublicRoute) {
        return RouteNames.login;
      }

      // Check onboarding completion for the login route.
      if (auth is AuthUnauthenticated && currentPath == RouteNames.login) {
        if (!localStorage.isOnboardingComplete && localStorage.isFirstLaunch) {
          return RouteNames.onboarding;
        }
      }

      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.matchedLocation}'),
      ),
    ),
    routes: [
      // ── Public Routes ────────────────────────────────────────────

      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splashName,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboardingName,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.loginName,
        pageBuilder: (context, state) => AppPageTransitions.fade(
          key: state.pageKey,
          child: const PhoneEntryPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.otpVerification,
        name: RouteNames.otpVerificationName,
        builder: (context, state) {
          final phone = state.extra as String? ?? '';
          return OtpVerificationPage(phone: phone);
        },
      ),
      GoRoute(
        path: RouteNames.chooseRole,
        name: RouteNames.chooseRoleName,
        builder: (context, state) => const ChooseRolePage(),
      ),
      GoRoute(
        path: RouteNames.profileSetup,
        name: RouteNames.profileSetupName,
        builder: (context, state) => const ProfileSetupPage(),
      ),

      // ── Booking Flow (full-screen, outside shell) ────────────────

      GoRoute(
        path: RouteNames.bookSelectService,
        name: RouteNames.bookSelectServiceName,
        builder: (context, state) => const SelectServicePage(),
      ),
      GoRoute(
        path: RouteNames.bookSelectBarber,
        name: RouteNames.bookSelectBarberName,
        builder: (context, state) => const SelectBarberPage(),
      ),
      GoRoute(
        path: RouteNames.bookSelectTime,
        name: RouteNames.bookSelectTimeName,
        builder: (context, state) => const SelectTimePage(),
      ),
      GoRoute(
        path: RouteNames.bookConfirm,
        name: RouteNames.bookConfirmName,
        builder: (context, state) => const ConfirmBookingPage(),
      ),
      GoRoute(
        path: RouteNames.bookingConfirmation,
        name: RouteNames.bookingConfirmationName,
        builder: (context, state) => const BookingConfirmationPage(),
      ),

      // ── Write Review & Chat (full-screen) ────────────────────────

      GoRoute(
        path: RouteNames.writeReview,
        name: RouteNames.writeReviewName,
        builder: (context, state) => const WriteReviewPage(),
      ),
      GoRoute(
        path: RouteNames.chatDetail,
        name: RouteNames.chatDetailName,
        builder: (context, state) {
          final conversationId =
              state.pathParameters['conversationId'] ?? '';
          return ChatDetailPage(conversationId: conversationId);
        },
      ),

      // ── Owner Management (full-screen) ───────────────────────────

      GoRoute(
        path: RouteNames.manageBarbers,
        name: RouteNames.manageBarbersName,
        builder: (context, state) => const ManageBarbersPage(),
      ),
      GoRoute(
        path: RouteNames.barberForm,
        name: RouteNames.barberFormName,
        builder: (context, state) => const BarberFormPage(),
      ),
      GoRoute(
        path: RouteNames.manageServices,
        name: RouteNames.manageServicesName,
        builder: (context, state) => const ManageServicesPage(),
      ),
      GoRoute(
        path: RouteNames.serviceForm,
        name: RouteNames.serviceFormName,
        builder: (context, state) => const ServiceFormPage(),
      ),
      GoRoute(
        path: RouteNames.queueManagement,
        name: RouteNames.queueManagementName,
        builder: (context, state) => const QueueManagementPage(),
      ),

      // ── Client Shell (4 tabs) ───────────────────────────────────

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ClientShell(navigationShell: navigationShell),
        branches: [
          // Tab 1: Discover
          StatefulShellBranch(
            navigatorKey: _discoverNavigatorKey,
            routes: [
              GoRoute(
                path: RouteNames.discover,
                name: RouteNames.discoverName,
                builder: (context, state) => const SalonDiscoveryPage(),
                routes: [
                  GoRoute(
                    path: RouteNames.salonDetail,
                    name: RouteNames.salonDetailName,
                    builder: (context, state) {
                      final salonId = state.pathParameters['salonId'] ?? '';
                      return SalonDetailPage(salonId: salonId);
                    },
                    routes: [
                      GoRoute(
                        path: RouteNames.salonReviews,
                        name: RouteNames.salonReviewsName,
                        builder: (context, state) =>
                            const SalonReviewsPage(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Tab 2: My Bookings
          StatefulShellBranch(
            navigatorKey: _bookingsNavigatorKey,
            routes: [
              GoRoute(
                path: RouteNames.myBookings,
                name: RouteNames.myBookingsName,
                builder: (context, state) => const MyBookingsPage(),
                routes: [
                  GoRoute(
                    path: RouteNames.bookingDetail,
                    name: RouteNames.bookingDetailName,
                    builder: (context, state) {
                      final bookingId =
                          state.pathParameters['bookingId'] ?? '';
                      return BookingDetailPage(bookingId: bookingId);
                    },
                  ),
                ],
              ),
            ],
          ),
          // Tab 3: Queue
          StatefulShellBranch(
            navigatorKey: _queueNavigatorKey,
            routes: [
              GoRoute(
                path: RouteNames.liveQueue,
                name: RouteNames.liveQueueName,
                builder: (context, state) => const LiveQueuePage(),
              ),
            ],
          ),
          // Tab 4: Settings / Profile
          StatefulShellBranch(
            navigatorKey: _clientSettingsNavigatorKey,
            routes: [
              GoRoute(
                path: RouteNames.clientSettings,
                name: RouteNames.clientSettingsName,
                builder: (context, state) => const MyProfilePage(),
                routes: [
                  GoRoute(
                    path: RouteNames.notifications,
                    name: RouteNames.notificationsName,
                    builder: (context, state) =>
                        const NotificationsPage(),
                  ),
                  GoRoute(
                    path: RouteNames.editProfile,
                    name: RouteNames.editProfileName,
                    builder: (context, state) =>
                        const EditProfilePage(),
                  ),
                  GoRoute(
                    path: RouteNames.changePassword,
                    name: RouteNames.changePasswordName,
                    builder: (context, state) =>
                        const ChangePasswordPage(),
                  ),
                  GoRoute(
                    path: RouteNames.helpSupport,
                    name: RouteNames.helpSupportName,
                    builder: (context, state) =>
                        const HelpSupportPage(),
                  ),
                  GoRoute(
                    path: RouteNames.paymentMethods,
                    name: RouteNames.paymentMethodsName,
                    builder: (context, state) =>
                        const PaymentMethodsPage(),
                    routes: [
                      GoRoute(
                        path: RouteNames.addPaymentMethod,
                        name: RouteNames.addPaymentMethodName,
                        builder: (context, state) =>
                            const AddPaymentMethodPage(),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: RouteNames.favorites,
                    name: RouteNames.favoritesName,
                    builder: (context, state) =>
                        const FavoritesPage(),
                  ),
                  GoRoute(
                    path: RouteNames.conversations,
                    name: RouteNames.conversationsName,
                    builder: (context, state) =>
                        const ConversationsPage(),
                  ),
                  GoRoute(
                    path: RouteNames.loyalty,
                    name: RouteNames.loyaltyName,
                    builder: (context, state) =>
                        const LoyaltyDashboardPage(),
                    routes: [
                      GoRoute(
                        path: RouteNames.pointsHistory,
                        name: RouteNames.pointsHistoryName,
                        builder: (context, state) =>
                            const PointsHistoryPage(),
                      ),
                      GoRoute(
                        path: RouteNames.rewards,
                        name: RouteNames.rewardsName,
                        builder: (context, state) =>
                            const AvailableRewardsPage(),
                      ),
                      GoRoute(
                        path: RouteNames.referral,
                        name: RouteNames.referralName,
                        builder: (context, state) =>
                            const ReferralPage(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // ── Owner Shell (4 tabs) ────────────────────────────────────

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            OwnerShell(navigationShell: navigationShell),
        branches: [
          // Tab 1: Dashboard
          StatefulShellBranch(
            navigatorKey: _dashboardNavigatorKey,
            routes: [
              GoRoute(
                path: RouteNames.ownerDashboard,
                name: RouteNames.ownerDashboardName,
                builder: (context, state) =>
                    const OwnerDashboardPage(),
              ),
            ],
          ),
          // Tab 2: All Bookings (Owner)
          StatefulShellBranch(
            navigatorKey: _ownerBookingsNavigatorKey,
            routes: [
              GoRoute(
                path: RouteNames.ownerBookings,
                name: RouteNames.ownerBookingsName,
                builder: (context, state) =>
                    const OwnerAllBookingsPage(),
              ),
            ],
          ),
          // Tab 3: Statistics
          StatefulShellBranch(
            navigatorKey: _statsNavigatorKey,
            routes: [
              GoRoute(
                path: RouteNames.statistics,
                name: RouteNames.statisticsName,
                builder: (context, state) => const StatisticsPage(),
              ),
            ],
          ),
          // Tab 4: Owner Settings
          StatefulShellBranch(
            navigatorKey: _ownerSettingsNavigatorKey,
            routes: [
              GoRoute(
                path: RouteNames.ownerSettings,
                name: RouteNames.ownerSettingsName,
                builder: (context, state) => const OwnerSettingsPage(),
                routes: [
                  GoRoute(
                    path: RouteNames.salonSettings,
                    name: RouteNames.salonSettingsName,
                    builder: (context, state) =>
                        const SalonSettingsPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
