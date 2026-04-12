import { requireServerAdminSession } from "@/lib/auth/require-server-admin-session";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { createSignedFileUrl } from "@/lib/queries/signed-files";

type BookingDetail = {
  id: string;
  tracking_number: string;
  payment_reference: string;
  shipper_total_dzd: number;
  carrier_payout_dzd: number;
  payment_status: string;
  booking_status: string;
  carrier_id: string;
};

type PaymentProofDetail = {
  id: string;
  booking_id: string;
  storage_path: string;
  content_type: string | null;
  payment_rail: string;
  submitted_reference: string | null;
  submitted_amount_dzd: number;
  verified_amount_dzd: number | null;
  verified_reference: string | null;
  status: string;
  rejection_reason: string | null;
  submitted_at: string;
  reviewed_at: string | null;
  decision_note: string | null;
  version: number;
};

type AuditLog = {
  id: string;
  action: string;
  target_type: string;
  target_id: string | null;
  outcome: string;
  reason: string | null;
  metadata: Record<string, unknown>;
  created_at: string | null;
};

type AdminPaymentDetail = {
  booking: BookingDetail;
  latestProof: PaymentProofDetail | null;
  proofHistory: PaymentProofDetail[];
  signedUrl: string | null;
  auditLogs: AuditLog[];
};

export async function fetchPaymentDetail(bookingId: string): Promise<AdminPaymentDetail | null> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const { data: booking, error: bookingError } = await supabase
    .from("bookings")
    .select("id, tracking_number, payment_reference, shipper_total_dzd, carrier_payout_dzd, payment_status, booking_status, carrier_id")
    .eq("id", bookingId)
    .maybeSingle();

  if (bookingError) {
    throw bookingError;
  }
  if (!booking) {
    return null;
  }

  const { data: proofs, error: proofError } = await supabase
    .from("payment_proofs")
    .select(
      "id, booking_id, storage_path, content_type, payment_rail, submitted_reference, submitted_amount_dzd, verified_amount_dzd, verified_reference, status, rejection_reason, submitted_at, reviewed_at, decision_note, version",
    )
    .eq("booking_id", bookingId)
    .order("version", { ascending: false });

  if (proofError) {
    throw proofError;
  }

  const proofHistory = (proofs ?? []) as PaymentProofDetail[];
  const latestProof = proofHistory[0] ?? null;
  const signedUrl = latestProof ? await createSignedFileUrl("payment-proofs", latestProof.storage_path) : null;

  const { data: auditLogs, error: auditError } = await supabase
    .from("admin_audit_logs")
    .select("id, action, target_type, target_id, outcome, reason, metadata, created_at")
    .eq("target_id", latestProof?.id ?? bookingId)
    .order("created_at", { ascending: false })
    .limit(20);

  if (auditError) {
    throw auditError;
  }

  return {
    booking: booking as BookingDetail,
    latestProof,
    proofHistory,
    signedUrl,
    auditLogs: (auditLogs ?? []) as AuditLog[],
  };
}
