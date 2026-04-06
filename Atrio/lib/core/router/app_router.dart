import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_templates/core/providers/analytics_provider.dart';
import 'package:flutter_templates/core/providers/storage_providers.dart';
import 'package:flutter_templates/core/router/analytics_observer.dart';
import 'package:flutter_templates/core/router/page_transitions.dart';
import 'package:flutter_templates/core/router/route_names.dart';
import 'package:flutter_templates/features/auth/domain/entities/user_role.dart';
import 'package:flutter_templates/features/salon/domain/entities/barber.dart';
import 'package:flutter_templates/features/salon/domain/entities/salon_service.dart';
import 'package:flutter_templates/features/auth/presentation/pages/choose_role_page.dart';
import 'package:flutter_templates/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:flutter_templates/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_templates/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:flutter_templates/features/auth/presentation/pages/profile_setup_page.dart';
import 'package:flutter_templates/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_notifier.dart';
import 'package:flutter_templates/features/auth/presentation/providers/auth_state.dart';
import 'package:flutter_templates/features/booking/presentation/pages/booking_confirmation_page.dart';
import 'package:flutter_templates/features/booking/presentation/pages/booking_detail_page.dart';
import 'package:flutter_templates/features/booking/presentation/pages/booking_flow_page.dart';
import 'package:flutter_templates/features/booking/presentation/pages/my_bookings_page.dart';
import 'package:flutter_templates/features/home/presentation/pages/home_shell.dart';
import 'package:flutter_templates/features/home/presentation/pages/profile_page.dart';
import 'package:flutter_templates/features/home/presentation/pages/settings_page.dart';
import 'package:flutter_templates/features/notification/presentation/pages/notifications_page.dart';
import 'package:flutter_templates/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/barber_form_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/barber_management_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/owner_bookings_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/owner_dashboard_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/owner_queue_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/owner_stats_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/salon_settings_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/service_form_page.dart';
import 'package:flutter_templates/features/owner/presentation/pages/service_management_page.dart';
import 'package:flutter_templates/features/queue/presentation/pages/queue_status_page.dart';
import 'package:flutter_templates/features/salon/presentation/pages/salon_detail_page.dart';
import 'package:flutter_templates/features/salon/presentation/pages/salon_discovery_page.dart';
import 'package:flutter_templates/features/salon/presentation/pages/salon_map_page.dart';
import 'package:flutter_templates/features/salon/presentation/pages/salon_reviews_page.dart';
import 'package:flutter_templates/features/splash/presentation/pages/splash_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

// Navigator keys for shell branches.
final _rootNavigatorKey = GlobalKey<NavigatorState>();

// Client shell keys.
final _clientDiscoverKey = GlobalKey<NavigatorState>();
final _clientBookingsKey = GlobalKey<NavigatorState>();
final _clientProfileKey = GlobalKey<NavigatorState>();
final _clientSettingsKey = GlobalKey<NavigatorState>();

// Owner shell keys.
final _ownerDashboardKey = GlobalKey<NavigatorState>();
final _ownerQueueKey = GlobalKey<NavigatorState>();
final _ownerProfileKey = GlobalKey<NavigatorState>();
final _ownerSettingsKey = GlobalKey<NavigatorState>();

/// Public routes that don't require authentication.
const _publicPaths = [
  RouteNames.splash,
  RouteNames.onboarding,
  RouteNames.login,
  RouteNames.register,
  RouteNames.forgotPassword,
  RouteNames.otpVerification,
  RouteNames.chooseRole,
  RouteNames.profileSetup,
];

/// Provides the application [GoRouter] instance.
///
/// Listens to [authNotifierProvider] for authentication state changes
/// and redirects accordingly. Routes are role-aware: clients see the
/// discover/bookings shell, owners see the dashboard/queue shell.
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

      // Never redirect away from splash — it handles its own navigation.
      if (currentPath == RouteNames.splash) return null;

      // Don't redirect while auth state is still initializing.
      if (auth is AuthInitial || auth is AuthLoading) return null;

      final isPublicRoute = _publicPaths.contains(currentPath);

      // Redirect authenticated users away from auth pages.
      if (auth is AuthAuthenticated && isPublicRoute) {
        return auth.user.role == UserRole.owner
            ? RouteNames.ownerDashboard
            : RouteNames.discover;
      }

      // Redirect unauthenticated users to login for protected routes.
      if (auth is AuthUnauthenticated && !isPublicRoute) {
        return RouteNames.login;
      }

      // Check onboarding completion for the login route.
      if (auth is AuthUnauthenticated && currentPath == RouteNames.login) {
        final localStorage = ref.read(localStorageProvider);
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
      // Splash
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splashName,
        builder: (context, state) => const SplashPage(),
      ),

      // Onboarding
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboardingName,
        builder: (context, state) => const OnboardingPage(),
      ),

      // Auth routes
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.loginName,
        pageBuilder: (context, state) => AppPageTransitions.fade(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.register,
        name: RouteNames.registerName,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        name: RouteNames.forgotPasswordName,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: RouteNames.otpVerification,
        name: RouteNames.otpVerificationName,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return OtpVerificationPage(email: email);
        },
      ),

      // Choose role
      GoRoute(
        path: RouteNames.chooseRole,
        name: RouteNames.chooseRoleName,
        builder: (context, state) => const ChooseRolePage(),
      ),

      // Profile setup
      GoRoute(
        path: RouteNames.profileSetup,
        name: RouteNames.profileSetupName,
        builder: (context, state) {
          final role = state.extra as UserRole? ?? UserRole.client;
          return ProfileSetupPage(role: role);
        },
      ),

      // Global routes (accessible from any shell)
      GoRoute(
        path: RouteNames.bookingFlow,
        name: RouteNames.bookingFlowName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return BookingFlowPage(
            salonId: extra['salonId'] as String? ?? '',
            salonName: extra['salonName'] as String? ?? '',
          );
        },
      ),
      GoRoute(
        path: RouteNames.bookingConfirmation,
        name: RouteNames.bookingConfirmationName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final bookingId = state.extra as String? ?? '';
          return BookingConfirmationPage(bookingId: bookingId);
        },
      ),
      GoRoute(
        path: RouteNames.queueStatus,
        name: RouteNames.queueStatusName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return QueueStatusPage(
            salonId: extra['salonId'] as String? ?? '',
            salonName: extra['salonName'] as String? ?? '',
          );
        },
      ),
      GoRoute(
        path: RouteNames.notifications,
        name: RouteNames.notificationsName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const NotificationsPage(),
      ),

      // ── Client Shell (4 tabs) ──────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeShell(navigationShell: navigationShell),
        branches: [
          // Tab 1: Discover
          StatefulShellBranch(
            navigatorKey: _clientDiscoverKey,
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
                      final salonId = state.extra as String? ?? '';
                      return SalonDetailPage(salonId: salonId);
                    },
                    routes: [
                      GoRoute(
                        path: RouteNames.salonReviews,
                        name: RouteNames.salonReviewsName,
                        builder: (context, state) {
                          final salonId = state.extra as String? ?? '';
                          return SalonReviewsPage(salonId: salonId);
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: RouteNames.salonMap,
                    name: RouteNames.salonMapName,
                    builder: (context, state) => const SalonMapPage(),
                  ),
                ],
              ),
            ],
          ),

          // Tab 2: My Bookings
          StatefulShellBranch(
            navigatorKey: _clientBookingsKey,
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
                      final bookingId = state.extra as String? ?? '';
                      return BookingDetailPage(bookingId: bookingId);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Tab 3: Profile
          StatefulShellBranch(
            navigatorKey: _clientProfileKey,
            routes: [
              GoRoute(
                path: RouteNames.profile,
                name: RouteNames.profileName,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),

          // Tab 4: Settings
          StatefulShellBranch(
            navigatorKey: _clientSettingsKey,
            routes: [
              GoRoute(
                path: RouteNames.settings,
                name: RouteNames.settingsName,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),

      // ── Owner Shell (4 tabs) ───────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            HomeShell(navigationShell: navigationShell),
        branches: [
          // Tab 1: Dashboard
          StatefulShellBranch(
            navigatorKey: _ownerDashboardKey,
            routes: [
              GoRoute(
                path: RouteNames.ownerDashboard,
                name: RouteNames.ownerDashboardName,
                builder: (context, state) => const OwnerDashboardPage(),
                routes: [
                  GoRoute(
                    path: RouteNames.ownerServices,
                    name: RouteNames.ownerServicesName,
                    builder: (context, state) => const ServiceManagementPage(),
                    routes: [
                      GoRoute(
                        path: RouteNames.ownerServiceForm,
                        name: RouteNames.ownerServiceFormName,
                        builder: (context, state) {
                          final service = state.extra as SalonService?;
                          return ServiceFormPage(service: service);
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: RouteNames.ownerBarbers,
                    name: RouteNames.ownerBarbersName,
                    builder: (context, state) => const BarberManagementPage(),
                    routes: [
                      GoRoute(
                        path: RouteNames.ownerBarberForm,
                        name: RouteNames.ownerBarberFormName,
                        builder: (context, state) {
                          final barber = state.extra as Barber?;
                          return BarberFormPage(barber: barber);
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: RouteNames.ownerStats,
                    name: RouteNames.ownerStatsName,
                    builder: (context, state) => const OwnerStatsPage(),
                  ),
                  GoRoute(
                    path: RouteNames.ownerBookings,
                    name: RouteNames.ownerBookingsName,
                    builder: (context, state) => const OwnerBookingsPage(),
                  ),
                  GoRoute(
                    path: RouteNames.salonSettings,
                    name: RouteNames.salonSettingsName,
                    builder: (context, state) => const SalonSettingsPage(),
                  ),
                ],
              ),
            ],
          ),

          // Tab 2: Queue Management
          StatefulShellBranch(
            navigatorKey: _ownerQueueKey,
            routes: [
              GoRoute(
                path: RouteNames.ownerQueue,
                name: RouteNames.ownerQueueName,
                builder: (context, state) => const OwnerQueuePage(),
              ),
            ],
          ),

          // Tab 3: Profile (reused)
          StatefulShellBranch(
            navigatorKey: _ownerProfileKey,
            routes: [
              GoRoute(
                path: '/owner-profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),

          // Tab 4: Settings (reused)
          StatefulShellBranch(
            navigatorKey: _ownerSettingsKey,
            routes: [
              GoRoute(
                path: '/owner-settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
