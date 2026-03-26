import { diffHoursFromNow } from "@/lib/formatting/formatters";
import { requireServerAdminSession } from "@/lib/auth/require-server-admin-session";
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

type PayoutAccountRow = {
  id: string;
  carrier_id: string;
  account_type: string;
  account_holder_name: string;
  account_identifier: string;
  bank_or_ccp_name: string | null;
  is_verified: boolean;
};

type PayoutRequestRow = {
  booking_id: string;
  status: string;
  requested_at: string | null;
};

type PayoutRequestContextRow = {
  blocked_reason: string | null;
  is_eligible: boolean | null;
  request_status: string | null;
  requested_at: string | null;
};

export async function fetchEligiblePayoutQueue({
  limit = 50,
}: {
  limit?: number;
} = {}): Promise<EligiblePayoutQueueItem[]> {
  await requireServerAdminSession();
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
  const [disputesResult, payoutsResult, carriersResult, payoutRequestsResult] = await Promise.all([
    supabase.from("disputes").select("booking_id").eq("status", "open").in("booking_id", bookingIds),
    supabase.from("payouts").select("booking_id").in("booking_id", bookingIds),
    supabase
      .from("profiles")
      .select("id, email, full_name, company_name")
      .in("id", [...new Set(bookingRows.map((booking) => booking.carrier_id))]),
    supabase
      .from("payout_requests")
      .select("booking_id, status, requested_at")
      .in("booking_id", bookingIds),
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
  const payoutRequestMap = new Map(
    (((payoutRequestsResult.data ?? []) as unknown[]) as PayoutRequestRow[]).map((request) => [
      request.booking_id,
      request,
    ]),
  );

  return bookingRows
    .filter((booking) => !blockedIds.has(booking.id))
    .sort((left, right) => {
      const leftRequested = payoutRequestMap.get(left.id)?.status === "requested" ? 1 : 0;
      const rightRequested = payoutRequestMap.get(right.id)?.status === "requested" ? 1 : 0;
      return rightRequested - leftRequested;
    })
    .slice(0, limit)
    .map((booking) => ({
      bookingId: booking.id,
      trackingNumber: booking.tracking_number,
      carrierId: booking.carrier_id,
      carrierName: resolveProfileDisplayName(carrierMap.get(booking.carrier_id)),
      carrierPayoutDzd: Number(booking.carrier_payout_dzd),
      payoutRequestStatus: payoutRequestMap.get(booking.id)?.status ?? null,
      payoutRequestedAt: payoutRequestMap.get(booking.id)?.requested_at ?? null,
      updatedAt: booking.updated_at,
      ageHours: diffHoursFromNow(booking.updated_at),
    }));
}

export async function fetchRecentReleasedPayouts({
  limit = 20,
}: {
  limit?: number;
} = {}): Promise<ReleasedPayoutItem[]> {
  await requireServerAdminSession();
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

export type AdminPayoutDetail = {
  booking: BookingRow;
  carrierName: string;
  activePayoutAccount: PayoutAccountRow | null;
  existingPayout: PayoutRow | null;
  payoutRequestContext: {
    blockedReason: string | null;
    isEligible: boolean;
    requestStatus: string | null;
    requestedAt: string | null;
  } | null;
};

export async function fetchPayoutDetail(bookingId: string): Promise<AdminPayoutDetail | null> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const { data: booking, error: bookingError } = await supabase
    .from("bookings")
    .select("id, carrier_id, tracking_number, carrier_payout_dzd, updated_at")
    .eq("id", bookingId)
    .maybeSingle();

  if (bookingError) {
    throw bookingError;
  }
  if (!booking) {
    return null;
  }

  const [{ data: carrier }, { data: payoutAccount }, { data: payouts }, { data: payoutRequestContext, error: payoutRequestContextError }] = await Promise.all([
    supabase
      .from("profiles")
      .select("id, email, full_name, company_name")
      .eq("id", (booking as BookingRow).carrier_id)
      .maybeSingle(),
    supabase
      .from("payout_accounts")
      .select("id, carrier_id, account_type, account_holder_name, account_identifier, bank_or_ccp_name, is_verified")
      .eq("carrier_id", (booking as BookingRow).carrier_id)
      .eq("is_active", true)
      .limit(1)
      .maybeSingle(),
    supabase
      .from("payouts")
      .select("id, booking_id, carrier_id, amount_dzd, status, external_reference, processed_at, created_at")
      .eq("booking_id", bookingId)
      .order("created_at", { ascending: false })
      .limit(1),
    supabase.rpc("get_booking_payout_request_context", { p_booking_id: bookingId }),
  ]);

  if (payoutRequestContextError) {
    throw payoutRequestContextError;
  }

  return {
    booking: booking as BookingRow,
    carrierName: resolveProfileDisplayName(carrier as ProfileRow | null),
    activePayoutAccount: (payoutAccount as PayoutAccountRow | null) ?? null,
    existingPayout: ((payouts ?? []) as PayoutRow[])[0] ?? null,
    payoutRequestContext: payoutRequestContext
      ? {
          blockedReason: (payoutRequestContext as PayoutRequestContextRow).blocked_reason,
          isEligible: (payoutRequestContext as PayoutRequestContextRow).is_eligible ?? false,
          requestStatus: (payoutRequestContext as PayoutRequestContextRow).request_status,
          requestedAt: (payoutRequestContext as PayoutRequestContextRow).requested_at,
        }
      : null,
  };
}
