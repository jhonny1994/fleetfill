enum AppRouteName {
  splash,
  maintenance,
  updateRequired,
  signIn,
  signUp,
  forgotPassword,
  resetPassword,
  roleSelection,
  languageSelection,
  profileSetup,
  phoneCompletion,
  notificationsHelp,
  mediaUploadHelp,
  sharedNotifications,
  sharedNotificationDetail,
  sharedSettings,
  sharedSupport,
  sharedShipmentDetail,
  sharedBookingDetail,
  sharedTrackingDetail,
  sharedCarrierProfile,
  sharedRouteDetail,
  sharedOneOffTripDetail,
  sharedProofViewer,
  sharedDocumentViewer,
  sharedGeneratedDocumentViewer,
  shipperHome,
  shipperShipments,
  shipperSearch,
  shipperProfile,
  shipperBookingReview,
  shipperPaymentFlow,
  carrierHome,
  carrierRoutes,
  carrierBookings,
  carrierProfile,
  carrierVerification,
  carrierRouteCreate,
  carrierRouteDetail,
  carrierRouteEdit,
  carrierOneOffTripCreate,
  carrierOneOffTripDetail,
  carrierOneOffTripEdit,
  carrierVehicleCreate,
  carrierVehicleDetail,
  carrierVehicleEdit,
  adminDashboard,
  adminQueues,
  adminVerificationPacket,
  adminUsers,
  adminUserDetail,
  adminSettings,
  adminAuditLog,
}

abstract final class AppRoutePath {
  static const splash = '/';
  static const maintenance = '/maintenance';
  static const updateRequired = '/update-required';

  static const signIn = '/auth/sign-in';
  static const signUp = '/auth/sign-up';
  static const forgotPassword = '/auth/forgot-password';
  static const resetPassword = '/auth/reset-password';

  static const roleSelection = '/onboarding/role-selection';
  static const languageSelection = '/onboarding/language-selection';
  static const profileSetup = '/onboarding/profile-setup';
  static const phoneCompletion = '/onboarding/phone-completion';

  static const notificationsHelp = '/permissions/notifications-help';
  static const mediaUploadHelp = '/permissions/media-upload-help';

  static const sharedNotifications = '/shared/notifications';
  static const sharedNotificationDetail = '/shared/notification/:id';
  static const sharedSettings = '/shared/settings';
  static const sharedSupport = '/shared/support';
  static const sharedShipmentDetail = '/shared/shipment/:id';
  static const sharedBookingDetail = '/shared/booking/:id';
  static const sharedTrackingDetail = '/shared/tracking/:id';
  static const sharedCarrierProfile = '/shared/carrier/:carrierId';
  static const sharedRouteDetail = '/shared/route/:id';
  static const sharedOneOffTripDetail = '/shared/oneoff-trip/:id';
  static const sharedProofViewer = '/shared/proof/:id';
  static const sharedDocumentViewer = '/shared/document/:id';
  static const sharedGeneratedDocumentViewer = '/shared/generated-document/:id';

  static const shipperHome = '/shipper/home';
  static const shipperShipments = '/shipper/shipments';
  static const shipperSearch = '/shipper/search';
  static const shipperProfile = '/shipper/profile';
  static const shipperBookingReview = '/shipper/search/booking-review';
  static const shipperPaymentFlow = '/shipper/search/payment-flow';
  static String shipperProfileEdit() => '$shipperProfile/edit';

  static const carrierHome = '/carrier/home';
  static const carrierRoutes = '/carrier/routes';
  static const carrierBookings = '/carrier/bookings';
  static const carrierProfile = '/carrier/profile';
  static const carrierVerification = '/carrier/profile/verification';
  static String carrierRouteCreate() => '$carrierRoutes/new-route';
  static String carrierRouteDetail(String routeId) => '$carrierRoutes/route/$routeId';
  static String carrierRouteEdit(String routeId) =>
      '${carrierRouteDetail(routeId)}/edit';
  static String carrierOneOffTripCreate() => '$carrierRoutes/new-trip';
  static String carrierOneOffTripDetail(String tripId) =>
      '$carrierRoutes/trip/$tripId';
  static String carrierOneOffTripEdit(String tripId) =>
      '${carrierOneOffTripDetail(tripId)}/edit';
  static String carrierProfileEdit() => '$carrierProfile/edit';
  static String carrierVehicles() => '$carrierProfile/vehicles';
  static String carrierVehicleCreate() => '${carrierVehicles()}/new';
  static String carrierVehicleDetail(String vehicleId) =>
      '${carrierVehicles()}/$vehicleId';
  static String carrierVehicleEdit(String vehicleId) =>
      '${carrierVehicleDetail(vehicleId)}/edit';
  static String carrierPayoutAccounts() => '$carrierProfile/payout-accounts';

  static const adminDashboard = '/admin/dashboard';
  static const adminQueues = '/admin/queues';
  static String adminQueuesVerification(String carrierId) =>
      '/admin/queues/verification/$carrierId';
  static const adminUsers = '/admin/users';
  static String adminUserDetail(String userId) => '/admin/users/$userId';
  static const adminSettings = '/admin/settings';
  static const adminAuditLog = '/admin/settings/audit-log';
}
