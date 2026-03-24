import { requireServerAdminSession } from "@/lib/auth/require-server-admin-session";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import { createSignedFileUrl } from "@/lib/queries/signed-files";

type BookingRow = {
  id: string;
  tracking_number: string;
  payment_reference: string;
  carrier_payout_dzd: number;
  shipper_total_dzd: number;
};

type DisputeRow = {
  id: string;
  booking_id: string;
  reason: string;
  description: string | null;
  status: string;
  resolution: string | null;
  resolution_note: string | null;
  created_at: string | null;
};

type DisputeEvidenceRow = {
  id: string;
  storage_path: string;
  note: string | null;
  content_type: string | null;
  created_at: string | null;
};

export type AdminDisputeDetail = {
  dispute: DisputeRow;
  booking: BookingRow;
  evidence: Array<DisputeEvidenceRow & { signedUrl: string | null }>;
  refunds: Array<{
    id: string;
    amount_dzd: number;
    status: string;
    reason: string;
    processed_at: string | null;
  }>;
};

export async function fetchDisputeDetail(bookingId: string): Promise<AdminDisputeDetail | null> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const { data: dispute, error: disputeError } = await supabase
    .from("disputes")
    .select("id, booking_id, reason, description, status, resolution, resolution_note, created_at")
    .eq("booking_id", bookingId)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  if (disputeError) {
    throw disputeError;
  }
  if (!dispute) {
    return null;
  }

  const [{ data: booking, error: bookingError }, { data: evidence, error: evidenceError }, { data: refunds }] =
    await Promise.all([
      supabase
        .from("bookings")
        .select("id, tracking_number, payment_reference, carrier_payout_dzd, shipper_total_dzd")
        .eq("id", bookingId)
        .maybeSingle(),
      supabase
        .from("dispute_evidence")
        .select("id, storage_path, note, content_type, created_at")
        .eq("dispute_id", dispute.id)
        .order("created_at", { ascending: false }),
      supabase
        .from("refunds")
        .select("id, amount_dzd, status, reason, processed_at")
        .eq("dispute_id", dispute.id)
        .order("created_at", { ascending: false }),
    ]);

  if (bookingError) {
    throw bookingError;
  }
  if (evidenceError) {
    throw evidenceError;
  }
  if (!booking) {
    return null;
  }

  const evidenceRows = (evidence ?? []) as DisputeEvidenceRow[];
  const signedUrls = await Promise.all(
    evidenceRows.map((item) => createSignedFileUrl("dispute-evidence", item.storage_path)),
  );

  return {
    dispute: {
      ...(dispute as DisputeRow),
      description: dispute.description,
    },
    booking: booking as BookingRow,
    evidence: evidenceRows.map((item, index) => ({ ...item, signedUrl: signedUrls[index] })),
    refunds: (refunds ?? []) as Array<{
      id: string;
      amount_dzd: number;
      status: string;
      reason: string;
      processed_at: string | null;
    }>,
  };
}
