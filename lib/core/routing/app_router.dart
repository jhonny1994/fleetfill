import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/app_bootstrap.dart';
import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/core/permissions/permissions.dart';
import 'package:fleetfill/core/routing/routing.dart';
import 'package:fleetfill/features/features.dart';
import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (ref) => GlobalKey<NavigatorState>(),
);
final shipperShellNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (ref) => GlobalKey<NavigatorState>(),
);
final carrierShellNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (ref) => GlobalKey<NavigatorState>(),
);
final adminShellNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (ref) => GlobalKey<NavigatorState>(),
);

final appRouterProvider = Provider<GoRouter>((ref) {
  final rootNavigatorKey = ref.watch(rootNavigatorKeyProvider);
  final shipperNavigatorKey = ref.watch(shipperShellNavigatorKeyProvider);
  final carrierNavigatorKey = ref.watch(carrierShellNavigatorKeyProvider);
  final adminNavigatorKey = ref.watch(adminShellNavigatorKeyProvider);
  final bootstrapState = ref.watch(appBootstrapControllerProvider);
  ref.watch(authSessionControllerProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutePath.splash,
    redirect: (context, state) {
      final resolvedBootstrap = bootstrapState.asData?.value;
      final resolvedAuth = ref
          .read(authSessionControllerProvider)
          .asData
          ?.value;
      if (resolvedBootstrap == null) {
        return state.matchedLocation == AppRoutePath.splash
            ? null
            : AppRoutePath.splash;
      }

      if (resolvedAuth == null) {
        return state.matchedLocation == AppRoutePath.splash
            ? null
            : AppRoutePath.splash;
      }

      final decision = ref.read(
        routeGuardDecisionProvider(state.matchedLocation),
      );
      final redirectLocation = AppRouteGuards.redirectLocation(
        decision,
        auth: resolvedAuth,
      );
      if (redirectLocation == null ||
          redirectLocation == state.matchedLocation) {
        return null;
      }

      if (state.matchedLocation == AppRoutePath.splash &&
          redirectLocation == AppRoutePath.splash) {
        return null;
      }

      return redirectLocation;
    },
    errorBuilder: (context, state) {
      final bootstrap = bootstrapState.asData?.value;
      final authSnapshot = ref
          .watch(authSessionControllerProvider)
          .asData
          ?.value;
      final decision = bootstrap == null
          ? const RouteGuardDecision.none()
          : ref.read(routeGuardDecisionProvider(state.matchedLocation));

      if (decision.target == AppRedirectTarget.forbidden) {
        if (decision.reason == 'suspended') {
          return const AppSuspendedAccountState();
        }

        if (decision.reason == 'admin_step_up_required') {
          return AppForbiddenState(
            message: S.of(context).forbiddenAdminStepUpMessage,
          );
        }

        return const AppForbiddenState();
      }

      if (decision.target == AppRedirectTarget.sessionExpired ||
          authSnapshot?.isSessionExpired == true) {
        return const SignInScreen();
      }

      return const AppNotFoundState();
    },
    routes: [
      GoRoute(
        path: AppRoutePath.splash,
        name: AppRouteName.splash.name,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutePath.maintenance,
        name: AppRouteName.maintenance.name,
        builder: (context, state) => const MaintenanceModeScreen(),
      ),
      GoRoute(
        path: AppRoutePath.updateRequired,
        name: AppRouteName.updateRequired.name,
        builder: (context, state) => const ForceUpdateScreen(),
      ),
      GoRoute(
        path: AppRoutePath.signIn,
        name: AppRouteName.signIn.name,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutePath.signUp,
        name: AppRouteName.signUp.name,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutePath.forgotPassword,
        name: AppRouteName.forgotPassword.name,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutePath.resetPassword,
        name: AppRouteName.resetPassword.name,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutePath.roleSelection,
        name: AppRouteName.roleSelection.name,
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutePath.languageSelection,
        name: AppRouteName.languageSelection.name,
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: AppRoutePath.profileSetup,
        name: AppRouteName.profileSetup.name,
        builder: (context, state) => const ProfileSetupScreen(),
      ),
      GoRoute(
        path: AppRoutePath.phoneCompletion,
        name: AppRouteName.phoneCompletion.name,
        builder: (context, state) => const PhoneCompletionScreen(),
      ),
      GoRoute(
        path: AppRoutePath.notificationsHelp,
        name: AppRouteName.notificationsHelp.name,
        builder: (context, state) => const NotificationsPermissionHelpScreen(),
      ),
      GoRoute(
        path: AppRoutePath.mediaUploadHelp,
        name: AppRouteName.mediaUploadHelp.name,
        builder: (context, state) => const MediaUploadPermissionHelpScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ShipperShellScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: shipperNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutePath.shipperHome,
                name: AppRouteName.shipperHome.name,
                builder: (context, state) => const ShipperHomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePath.shipperShipments,
                name: AppRouteName.shipperShipments.name,
                builder: (context, state) => const MyShipmentsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePath.shipperSearch,
                name: AppRouteName.shipperSearch.name,
                builder: (context, state) => const SearchTripsScreen(),
                routes: [
                  GoRoute(
                    path: 'booking-review',
                    name: AppRouteName.shipperBookingReview.name,
                    builder: (context, state) => BookingReviewScreen(
                      selection: state.extra as BookingReviewSelection?,
                    ),
                  ),
                  GoRoute(
                    path: 'payment-flow',
                    name: AppRouteName.shipperPaymentFlow.name,
                    builder: (context, state) => PaymentFlowScreen(
                      bookingId: state.extra as String?,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePath.shipperProfile,
                name: AppRouteName.shipperProfile.name,
                builder: (context, state) => const ShipperProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) =>
                        const EditShipperProfileScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            CarrierShellScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: carrierNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoutePath.carrierHome,
                name: AppRouteName.carrierHome.name,
                builder: (context, state) => const CarrierHomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePath.carrierRoutes,
                name: AppRouteName.carrierRoutes.name,
                builder: (context, state) => const MyRoutesScreen(),
                routes: [
                  GoRoute(
                    path: 'new-route',
                    name: AppRouteName.carrierRouteCreate.name,
                    builder: (context, state) => const RouteEditorScreen(),
                  ),
                  GoRoute(
                    path: 'route/:routeId',
                    name: AppRouteName.carrierRouteDetail.name,
                    builder: (context, state) => CarrierRouteDetailScreen(
                      routeId: state.pathParameters['routeId']!,
                    ),
                    routes: [
                      GoRoute(
                        path: 'edit',
                        name: AppRouteName.carrierRouteEdit.name,
                        builder: (context, state) => RouteEditorScreen(
                          routeId: state.pathParameters['routeId'],
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'new-trip',
                    name: AppRouteName.carrierOneOffTripCreate.name,
                    builder: (context, state) => const OneOffTripEditorScreen(),
                  ),
                  GoRoute(
                    path: 'trip/:tripId',
                    name: AppRouteName.carrierOneOffTripDetail.name,
                    builder: (context, state) => CarrierOneOffTripDetailScreen(
                      tripId: state.pathParameters['tripId']!,
                    ),
                    routes: [
                      GoRoute(
                        path: 'edit',
                        name: AppRouteName.carrierOneOffTripEdit.name,
                        builder: (context, state) => OneOffTripEditorScreen(
                          tripId: state.pathParameters['tripId'],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePath.carrierBookings,
                name: AppRouteName.carrierBookings.name,
                builder: (context, state) => const CarrierBookingsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePath.carrierProfile,
                name: AppRouteName.carrierProfile.name,
                builder: (context, state) => const CarrierProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) =>
                        const EditCarrierProfileScreen(),
                  ),
                  GoRoute(
                    path: 'vehicles',
                    builder: (context, state) => const MyVehiclesScreen(),
                    routes: [
                      GoRoute(
                        path: 'new',
                        name: AppRouteName.carrierVehicleCreate.name,
                        builder: (context, state) =>
                            const VehicleEditorScreen(),
                      ),
                      GoRoute(
                        path: ':vehicleId',
                        name: AppRouteName.carrierVehicleDetail.name,
                        builder: (context, state) => VehicleDetailScreen(
                          vehicleId: state.pathParameters['vehicleId']!,
                        ),
                        routes: [
                          GoRoute(
                            path: 'edit',
                            name: AppRouteName.carrierVehicleEdit.name,
                            builder: (context, state) => VehicleEditorScreen(
                              vehicleId: state.pathParameters['vehicleId'],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'verification',
                    name: AppRouteName.carrierVerification.name,
                    builder: (context, state) =>
                        const CarrierVerificationCenterScreen(),
                  ),
                  GoRoute(
                    path: 'payout-accounts',
                    builder: (context, state) => const PayoutAccountsScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: adminNavigatorKey,
        builder: (context, state, child) => AdminShellScreen(
          selectedIndex: _adminIndex(state.matchedLocation),
          child: child,
        ),
        routes: [
          GoRoute(
            path: AppRoutePath.adminDashboard,
            name: AppRouteName.adminDashboard.name,
            builder: (context, state) => const AdminDashboardScreen(),
          ),
          GoRoute(
            path: AppRoutePath.adminQueues,
            name: AppRouteName.adminQueues.name,
            builder: (context, state) => const AdminQueuesScreen(),
            routes: [
              GoRoute(
                path: 'verification/:carrierId',
                name: AppRouteName.adminVerificationPacket.name,
                builder: (context, state) => AdminVerificationPacketScreen(
                  carrierId: state.pathParameters['carrierId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutePath.adminUsers,
            name: AppRouteName.adminUsers.name,
            builder: (context, state) => const UsersScreen(),
            routes: [
              GoRoute(
                path: ':userId',
                name: AppRouteName.adminUserDetail.name,
                builder: (context, state) => UserDetailScreen(
                  userId: state.pathParameters['userId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutePath.adminSettings,
            name: AppRouteName.adminSettings.name,
            builder: (context, state) => const AdminSettingsScreen(),
            routes: [
              GoRoute(
                path: 'audit-log',
                name: AppRouteName.adminAuditLog.name,
                builder: (context, state) => const AdminAuditLogScreen(),
              ),
            ],
          ),
        ],
      ),
      ..._sharedRoutes(rootNavigatorKey),
    ],
  );
});

List<RouteBase> _sharedRoutes(GlobalKey<NavigatorState> rootNavigatorKey) {
  return [
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedNotifications,
      name: AppRouteName.sharedNotifications.name,
      builder: (context, state) => const NotificationsCenterScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedNotificationDetail,
      name: AppRouteName.sharedNotificationDetail.name,
      builder: (context, state) => NotificationDetailScreen(
        notificationId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedSettings,
      name: AppRouteName.sharedSettings.name,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedSupport,
      name: AppRouteName.sharedSupport.name,
      builder: (context, state) => const SupportHomeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedPolicies,
      name: AppRouteName.sharedPolicies.name,
      builder: (context, state) => const LegalPoliciesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedShipmentDetail,
      name: AppRouteName.sharedShipmentDetail.name,
      builder: (context, state) => ShipmentDetailScreen(
        shipmentId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedBookingDetail,
      name: AppRouteName.sharedBookingDetail.name,
      builder: (context, state) => BookingDetailScreen(
        bookingId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedTrackingDetail,
      name: AppRouteName.sharedTrackingDetail.name,
      builder: (context, state) => BookingTrackingScreen(
        bookingId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedCarrierProfile,
      name: AppRouteName.sharedCarrierProfile.name,
      builder: (context, state) => CarrierPublicProfileScreen(
        carrierId: state.pathParameters['carrierId']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedRouteDetail,
      name: AppRouteName.sharedRouteDetail.name,
      builder: (context, state) => RouteDetailScreen(
        routeId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedOneOffTripDetail,
      name: AppRouteName.sharedOneOffTripDetail.name,
      builder: (context, state) => OneOffTripDetailScreen(
        tripId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedProofViewer,
      name: AppRouteName.sharedProofViewer.name,
      builder: (context, state) => ProofViewerScreen(
        proofId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedDisputeEvidenceViewer,
      name: AppRouteName.sharedDisputeEvidenceViewer.name,
      builder: (context, state) => DisputeEvidenceViewerScreen(
        evidenceId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedDocumentViewer,
      name: AppRouteName.sharedDocumentViewer.name,
      builder: (context, state) => DocumentViewerScreen(
        documentId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: AppRoutePath.sharedGeneratedDocumentViewer,
      name: AppRouteName.sharedGeneratedDocumentViewer.name,
      builder: (context, state) => GeneratedDocumentViewerScreen(
        documentId: state.pathParameters['id']!,
      ),
    ),
  ];
}

int _adminIndex(String location) {
  if (location.startsWith(AppRoutePath.adminQueues)) {
    return 1;
  }
  if (location.startsWith(AppRoutePath.adminUsers)) {
    return 2;
  }
  if (location.startsWith(AppRoutePath.adminSettings)) {
    return 3;
  }
  return 0;
}
