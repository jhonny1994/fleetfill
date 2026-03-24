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

export type PaymentQueueItem = {
  proofId: string;
  bookingId: string;
  trackingNumber: string;
  paymentReference: string;
  paymentRail: string;
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
  profilePendingDocuments: number;
  profileMissingDocuments: string[];
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
