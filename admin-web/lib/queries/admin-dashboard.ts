import { createSupabaseServerClient } from "@/lib/supabase/server";
import type {
  AdminOperationalSummary,
  DisputeQueueItem,
  EligiblePayoutQueueItem,
  PaymentQueueItem,
  SupportQueueItem,
  VerificationQueueItem,
} from "@/lib/queries/admin-types";
import {
  fetchDisputeQueue,
  fetchPaymentQueue,
  fetchSupportQueue,
  fetchVerificationQueue,
} from "@/lib/queries/admin-queues";
import { fetchEligiblePayoutQueue } from "@/lib/queries/admin-payouts";

function mapSummary(payload: Record<string, unknown> | null): AdminOperationalSummary {
  return {
    verificationPackets: Number(payload?.verification_packets ?? 0),
    pendingVerificationDocuments: Number(payload?.pending_verification_documents ?? 0),
    paymentProofs: Number(payload?.payment_proofs ?? 0),
    disputes: Number(payload?.disputes ?? 0),
    eligiblePayouts: Number(payload?.eligible_payouts ?? 0),
    supportNeedsReply: Number(payload?.support_needs_reply ?? 0),
    emailBacklog: Number(payload?.email_backlog ?? 0),
    emailDeadLetter: Number(payload?.email_dead_letter ?? 0),
    auditEventsLast24h: Number(payload?.audit_events_last_24h ?? 0),
    overdueDeliveryReviews: Number(payload?.overdue_delivery_reviews ?? 0),
    overduePaymentResubmissions: Number(payload?.overdue_payment_resubmissions ?? 0),
  };
}

export async function fetchAdminOperationalSummary() {
  const supabase = await createSupabaseServerClient();
  const { data, error } = await supabase.rpc("admin_get_operational_summary");

  if (error) {
    throw error;
  }

  return mapSummary((data ?? null) as Record<string, unknown> | null);
}

export type DashboardQueuePreviews = {
  payments: PaymentQueueItem[];
  verification: VerificationQueueItem[];
  disputes: DisputeQueueItem[];
  payouts: EligiblePayoutQueueItem[];
  support: SupportQueueItem[];
};

export async function fetchDashboardQueuePreviews(): Promise<DashboardQueuePreviews> {
  const [payments, verification, disputes, payouts, support] = await Promise.all([
    fetchPaymentQueue({ limit: 5 }),
    fetchVerificationQueue({ limit: 5 }),
    fetchDisputeQueue({ limit: 5 }),
    fetchEligiblePayoutQueue({ limit: 5 }),
    fetchSupportQueue({ limit: 5 }),
  ]);

  return { payments, verification, disputes, payouts, support };
}

export type DashboardAlert = {
  id: string;
  tone: "danger" | "warning";
  title: string;
  body: string;
};

export function buildDashboardAlerts(summary: AdminOperationalSummary): DashboardAlert[] {
  const alerts: DashboardAlert[] = [];

  if (summary.overdueDeliveryReviews > 0) {
    alerts.push({
      id: "delivery-review-overdue",
      tone: "danger",
      title: "Delivered bookings are waiting on review.",
      body: `${summary.overdueDeliveryReviews} bookings have stayed in delivered-pending-review beyond the configured grace window.`,
    });
  }

  if (summary.overduePaymentResubmissions > 0) {
    alerts.push({
      id: "payment-resubmission-overdue",
      tone: "warning",
      title: "Rejected payments have gone stale.",
      body: `${summary.overduePaymentResubmissions} bookings still need a payment-proof resubmission.`,
    });
  }

  if (summary.emailDeadLetter > 0) {
    alerts.push({
      id: "email-dead-letter",
      tone: "warning",
      title: "Delivery failures need operator attention.",
      body: `${summary.emailDeadLetter} email jobs are in dead-letter state.`,
    });
  }

  if (summary.supportNeedsReply > 0) {
    alerts.push({
      id: "support-needs-reply",
      tone: "warning",
      title: "Support queue has user messages waiting.",
      body: `${summary.supportNeedsReply} support requests have unread user follow-ups for admins.`,
    });
  }

  return alerts;
}
