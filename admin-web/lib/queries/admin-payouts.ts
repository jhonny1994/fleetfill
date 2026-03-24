import { diffHoursFromNow } from "@/lib/formatting/formatters";
import type { EligiblePayoutQueueItem, ReleasedPayoutItem } from "@/lib/queries/admin-types";
import { resolveProfileDisplayName } from "@/lib/queries/admin-types";
import { createSupabaseServerClient } from "@/lib/supabase/server";

type BookingRow = {
  id: string;
  carrier_id: string;
  tracking_number: string;
  carrier_payout_dzd: number;
  updated_at: string | null;
};

type ProfileRow = {
  id: string;
  email: string;
  full_name: string | null;
  company_name: string | null;
};

type PayoutRow = {
  id: string;
  booking_id: string;
  carrier_id: string;
  amount_dzd: number;
  status: string;
  external_reference: string | null;
  processed_at: string | null;
  created_at: string | null;
};

export async function fetchEligiblePayoutQueue({
  limit = 50,
}: {
  limit?: number;
} = {}): Promise<EligiblePayoutQueueItem[]> {
  const supabase = await createSupabaseServerClient();
  const { data: bookings, error } = await supabase
    .from("bookings")
    .select("id, carrier_id, tracking_number, carrier_payout_dzd, updated_at")
    .eq("booking_status", "completed")
    .eq("payment_status", "secured")
    .order("updated_at", { ascending: false })
    .limit(limit * 2);

  if (error) {
    throw error;
  }

  const bookingRows = (bookings ?? []) as BookingRow[];
  if (bookingRows.length === 0) {
    return [];
  }

  const bookingIds = bookingRows.map((booking) => booking.id);
  const [disputesResult, payoutsResult, carriersResult] = await Promise.all([
    supabase.from("disputes").select("booking_id").eq("status", "open").in("booking_id", bookingIds),
    supabase.from("payouts").select("booking_id").in("booking_id", bookingIds),
    supabase
      .from("profiles")
      .select("id, email, full_name, company_name")
      .in("id", [...new Set(bookingRows.map((booking) => booking.carrier_id))]),
  ]);

  const blockedIds = new Set<string>();
  for (const row of ((disputesResult.data ?? []) as Array<{ booking_id: string }>)) {
    blockedIds.add(row.booking_id);
  }
  for (const row of ((payoutsResult.data ?? []) as Array<{ booking_id: string }>)) {
    blockedIds.add(row.booking_id);
  }

  const carrierMap = new Map(
    ((carriersResult.data ?? []) as ProfileRow[]).map((profile) => [profile.id, profile]),
  );

  return bookingRows
    .filter((booking) => !blockedIds.has(booking.id))
    .slice(0, limit)
    .map((booking) => ({
      bookingId: booking.id,
      trackingNumber: booking.tracking_number,
      carrierId: booking.carrier_id,
      carrierName: resolveProfileDisplayName(carrierMap.get(booking.carrier_id)),
      carrierPayoutDzd: Number(booking.carrier_payout_dzd),
      updatedAt: booking.updated_at,
      ageHours: diffHoursFromNow(booking.updated_at),
    }));
}

export async function fetchRecentReleasedPayouts({
  limit = 20,
}: {
  limit?: number;
} = {}): Promise<ReleasedPayoutItem[]> {
  const supabase = await createSupabaseServerClient();
  const { data, error } = await supabase
    .from("payouts")
    .select("id, booking_id, carrier_id, amount_dzd, status, external_reference, processed_at, created_at")
    .order("created_at", { ascending: false })
    .limit(limit);

  if (error) {
    throw error;
  }

  return ((data ?? []) as PayoutRow[]).map((payout) => ({
    id: payout.id,
    bookingId: payout.booking_id,
    carrierId: payout.carrier_id,
    amountDzd: Number(payout.amount_dzd),
    status: payout.status,
    externalReference: payout.external_reference,
    processedAt: payout.processed_at ?? payout.created_at,
  }));
}
