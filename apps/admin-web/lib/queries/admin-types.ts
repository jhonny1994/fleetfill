import type { AppLocale } from "@/lib/i18n/config";

export type AdminOperationalSummary = {
  verificationPackets: number;
  pendingVerificationDocuments: number;
  paymentProofs: number;
  disputes: number;
  eligiblePayouts: number;
  supportNeedsReply: number;
  emailBacklog: number;
  emailDeadLetter: number;
  auditEventsLast24h: number;
  overdueDeliveryReviews: number;
  overduePaymentResubmissions: number;
};

export type PaginatedListResult<T> = {
  items: T[];
  total: number;
  page: number;
  pageSize: number;
  totalPages: number;
};

export type PaymentQueueItem = {
  proofId: string;
  bookingId: string;
  trackingNumber: string;
  paymentReference: string;
  paymentRail: string;
  status: string;
  submittedReference: string | null;
  submittedAmountDzd: number;
  shipperTotalDzd: number;
  carrierPayoutDzd: number;
  submittedAt: string;
  ageHours: number;
};

export type VerificationVehicleSummary = {
  id: string;
  label: string;
  pendingDocuments: number;
  missingDocuments: string[];
};

export type VerificationQueueItem = {
  carrierId: string;
  displayName: string;
  companyName: string | null;
  status: string;
  carrierPendingDocuments: number;
  carrierMissingDocuments: string[];
  vehicleCount: number;
  pendingDocumentCount: number;
  latestRelevantUpdateAt: string | null;
  vehicles: VerificationVehicleSummary[];
};

export type DisputeQueueItem = {
  id: string;
  bookingId: string;
  trackingNumber: string | null;
  reason: string;
  status: string;
  evidenceCount: number;
  createdAt: string | null;
  updatedAt: string | null;
  ageHours: number;
};

export type EligiblePayoutQueueItem = {
  bookingId: string;
  trackingNumber: string;
  carrierId: string;
  carrierName: string;
  carrierPayoutDzd: number;
  payoutRequestStatus: string | null;
  payoutRequestedAt: string | null;
  updatedAt: string | null;
  ageHours: number;
};

export type ReleasedPayoutItem = {
  id: string;
  bookingId: string;
  carrierId: string;
  amountDzd: number;
  status: string;
  externalReference: string | null;
  processedAt: string | null;
};

export type SupportQueueItem = {
  id: string;
  subject: string;
  status: string;
  priority: string;
  bookingId: string | null;
  disputeId: string | null;
  paymentProofId: string | null;
  assignedAdminId: string | null;
  lastMessageSenderType: string;
  lastMessageAt: string;
  hasUnreadForAdmin: boolean;
};

export type AdminUserListItem = {
  profileId: string;
  displayName: string;
  role: string;
  email: string;
  phoneNumber: string | null;
  companyName: string | null;
  isActive: boolean;
  verificationStatus: string | null;
  vehicleCount: number;
  shipmentCount: number;
  bookingCount: number;
  updatedAt: string | null;
};

export type AdminUserRoleFilter = "all" | "shipper" | "carrier";

export type AdminUserActivityFilter = "all" | "active" | "inactive";

export type AdminUserVerificationFilter = "all" | "pending" | "rejected" | "verified";

export type AdminUserRegistryFilters = {
  q?: string;
  role?: AdminUserRoleFilter;
  activity?: AdminUserActivityFilter;
  verification?: AdminUserVerificationFilter;
  page?: number;
  pageSize?: number;
};

export type AdminUserRegistrySnapshot = {
  users: AdminUserListItem[];
  page: number;
  pageSize: number;
  totalUsers: number;
  filters: {
    q: string;
    role: AdminUserRoleFilter;
    activity: AdminUserActivityFilter;
    verification: AdminUserVerificationFilter;
  };
};

export type AdminVehicleSummary = {
  id: string;
  label: string;
  verificationStatus: string;
  updatedAt: string | null;
};

export type AdminShipmentSummary = {
  id: string;
  status: string;
  description: string | null;
  originLabel: string;
  destinationLabel: string;
  totalWeightKg: number;
  createdAt: string | null;
};

export type AdminShipmentListItem = AdminShipmentSummary & {
  shipperId: string;
  shipperDisplayName: string;
  shipperName: string;
  bookingId: string | null;
  bookingTrackingNumber: string | null;
  bookingStatus: string | null;
  paymentStatus: string | null;
  totalVolumeM3: number | null;
};

export type AdminBookingSummary = {
  id: string;
  shipmentId: string;
  trackingNumber: string;
  bookingStatus: string;
  paymentStatus: string;
  createdAt: string | null;
};

export type AdminBookingListItem = AdminBookingSummary & {
  shipperId: string;
  carrierId: string | null;
  shipperDisplayName: string;
  carrierDisplayName: string | null;
  shipperName: string;
  carrierName: string | null;
  paymentReference: string;
  shipmentDescription: string | null;
  originLabel: string;
  destinationLabel: string;
  shipperTotalDzd: number;
  carrierPayoutDzd: number;
  paymentProofCount: number;
  disputeStatus: string | null;
};

export type AdminSupportSummary = {
  id: string;
  subject: string;
  status: string;
  lastMessageAt: string;
};

export type AdminDocumentSummary = {
  id: string;
  documentType: string;
  entityType: "profile" | "vehicle";
  status: string;
  updatedAt: string | null;
};

export type AdminPayoutAccountSummary = {
  id: string;
  accountType: string;
  identifier: string;
  institutionName: string | null;
  isVerified: boolean;
  isActive: boolean;
  updatedAt: string | null;
};

export type AdminAuditLogItem = {
  id: string;
  action: string;
  targetType: string;
  targetId: string | null;
  outcome: string;
  reason: string | null;
  metadata: Record<string, unknown>;
  createdAt: string | null;
};

export type AdminUserDetail = {
  profile: {
    id: string;
    role: string;
    email: string;
    fullName: string | null;
    phoneNumber: string | null;
    companyName: string | null;
    preferredLocale: string;
    isActive: boolean;
    verificationStatus: string | null;
    verificationRejectionReason: string | null;
    ratingAverage: number | null;
    ratingCount: number;
    createdAt: string | null;
    updatedAt: string | null;
  };
  vehicles: AdminVehicleSummary[];
  shipments: AdminShipmentSummary[];
  bookings: AdminBookingSummary[];
  supportRequests: AdminSupportSummary[];
  documents: AdminDocumentSummary[];
  payoutAccounts: AdminPayoutAccountSummary[];
  auditLogs: AdminAuditLogItem[];
};

export type AdminAccountListItem = {
  profileId: string;
  displayName: string;
  email: string;
  adminRole: "super_admin" | "ops_admin";
  isActive: boolean;
  invitedByName: string | null;
  activatedAt: string | null;
  deactivatedAt: string | null;
  updatedAt: string | null;
};

export type AdminInvitationListItem = {
  id: string;
  email: string;
  role: "super_admin" | "ops_admin";
  status: string;
  expiresAt: string;
  invitedByName: string | null;
  acceptedByName: string | null;
  createdAt: string | null;
  updatedAt: string | null;
};

export type AdminAccountDetail = {
  account: AdminAccountListItem;
  invitations: AdminInvitationListItem[];
  auditLogs: AdminAuditLogItem[];
};

export type GlobalSearchItem = {
  id: string;
  title: string;
  subtitle: string;
  meta: string;
  href: string;
};

export type PlatformSettingsSnapshot = {
  appRuntime: {
    maintenanceMode: boolean;
    forceUpdateRequired: boolean;
    minimumSupportedAndroidVersion: number;
    minimumSupportedIosVersion: number;
  };
  bookingPricing: {
    platformFeeRate: number;
    carrierFeeRate: number;
    insuranceRate: number;
    insuranceMinFeeDzd: number;
    taxRate: number;
    paymentResubmissionDeadlineHours: number;
  };
  deliveryReview: {
    graceWindowHours: number;
  };
  featureFlags: {
    adminEmailResendEnabled: boolean;
  };
  localization: {
    fallbackLocale: AppLocale;
    enabledLocales: AppLocale[];
  };
  updatedAtByKey: Partial<
    Record<"app_runtime" | "booking_pricing" | "delivery_review" | "feature_flags" | "localization", string | null>
  >;
};

export type EmailDeliveryHealthItem = {
  id: string;
  bookingId: string | null;
  recipientEmail: string;
  templateKey: string;
  status: string;
  provider: string;
  errorCode: string | null;
  errorMessage: string | null;
  createdAt: string | null;
  lastAttemptAt: string | null;
};

export type EmailDeadLetterItem = {
  id: string;
  bookingId: string | null;
  recipientEmail: string;
  templateKey: string;
  status: string;
  attemptCount: number;
  maxAttempts: number;
  lastErrorCode: string | null;
  lastErrorMessage: string | null;
  createdAt: string | null;
  updatedAt: string | null;
};

export type PushDeadLetterItem = {
  id: string;
  profileId: string;
  eventKey: string;
  title: string;
  status: string;
  attemptCount: number;
  maxAttempts: number;
  lastErrorCode: string | null;
  lastErrorMessage: string | null;
  createdAt: string | null;
  updatedAt: string | null;
};

export type AuditAndHealthSnapshot = {
  auditLogs: AdminAuditLogItem[];
  emailDeliveries: EmailDeliveryHealthItem[];
  deadLetterEmails: EmailDeadLetterItem[];
  deadLetterPushes: PushDeadLetterItem[];
  totals: {
    auditLogs: number;
    emailDeliveries: number;
    deadLetterEmails: number;
    deadLetterPushes: number;
  };
};

export type BookingWorkspaceDetail = {
  booking: {
    id: string;
    trackingNumber: string;
    paymentReference: string;
    bookingStatus: string;
    paymentStatus: string;
    shipperTotalDzd: number;
    carrierPayoutDzd: number;
    createdAt: string | null;
    shipmentId: string;
    shipperId: string;
    carrierId: string;
    vehicleId: string;
  };
  shipment: {
    id: string;
    status: string;
    description: string | null;
    originLabel: string;
    destinationLabel: string;
  } | null;
  paymentProofCount: number;
  disputeStatus: string | null;
  payoutStatus: string | null;
  payoutRequestContext: {
    blockedReason: string | null;
    isEligible: boolean;
    requestStatus: string | null;
    requestedAt: string | null;
    payoutProcessedAt: string | null;
  } | null;
  trackingEvents: Array<{
    id: string;
    eventType: string;
    note: string | null;
    recordedAt: string;
  }>;
};

export type ShipmentWorkspaceDetail = {
  shipment: {
    id: string;
    status: string;
    description: string | null;
    totalWeightKg: number;
    totalVolumeM3: number | null;
    originLabel: string;
    destinationLabel: string;
    shipperId: string;
    createdAt: string | null;
  };
  booking: {
    id: string;
    trackingNumber: string;
    bookingStatus: string;
    paymentStatus: string;
  } | null;
};

export type GlobalSearchKind =
  | "booking"
  | "shipment"
  | "user"
  | "admin"
  | "payment"
  | "verification"
  | "dispute"
  | "payout"
  | "support";

export type GlobalSearchKindFilter = GlobalSearchKind | "all";

export type GlobalSearchGroup = {
  kind: GlobalSearchKind;
  label: string;
  total: number;
  items: GlobalSearchItem[];
};

export type GlobalSearchSummary = Record<GlobalSearchKind, number>;

export type GlobalSearchSnapshot = {
  query: string;
  kind: GlobalSearchKindFilter;
  page: number;
  pageSize: number;
  totalResults: number;
  summary: GlobalSearchSummary;
  groups: GlobalSearchGroup[];
  selectedGroup: GlobalSearchGroup | null;
};

export type AdminAccountRoleFilter = "all" | "super_admin" | "ops_admin";

export type AdminAccountStateFilter = "all" | "active" | "inactive";

export type AdminRegistryFilters = {
  q?: string;
  role?: AdminAccountRoleFilter;
  state?: AdminAccountStateFilter;
  page?: number;
  pageSize?: number;
};

export type AdminRegistrySummary = {
  totalAccounts: number;
  activeAccounts: number;
  inactiveAccounts: number;
  superAdmins: number;
  opsAdmins: number;
  totalInvitations: number;
  pendingInvitations: number;
};

export type AdminRegistrySnapshot = {
  accounts: AdminAccountListItem[];
  invitations: AdminInvitationListItem[];
  page: number;
  pageSize: number;
  totalAccounts: number;
  totalInvitations: number;
  summary: AdminRegistrySummary;
  filters: {
    q: string;
    role: AdminAccountRoleFilter;
    state: AdminAccountStateFilter;
  };
};

type ProfileMap = {
  id: string;
  email: string;
  full_name: string | null;
  company_name: string | null;
};

export function resolveProfileDisplayName(profile: ProfileMap | null | undefined) {
  if (!profile) {
    return "Unknown";
  }

  return (
    profile.company_name?.trim() ||
    profile.full_name?.trim() ||
    profile.email?.trim() ||
    profile.id
  );
}
