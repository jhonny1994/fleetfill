import { requireServerAdminSession } from "@/lib/auth/require-server-admin-session";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import type {
  AdminBookingListItem,
  AdminShipmentListItem,
  BookingWorkspaceDetail,
  PaginatedListResult,
  ShipmentWorkspaceDetail,
} from "@/lib/queries/admin-types";

type BookingRow = {
  id: string;
  shipment_id: string;
  shipper_id: string;
  carrier_id: string;
  vehicle_id: string;
  tracking_number: string;
  payment_reference: string;
  booking_status: string;
  payment_status: string;
  shipper_total_dzd: number;
  carrier_payout_dzd: number;
  created_at: string | null;
};

type ShipmentRow = {
  id: string;
  shipper_id: string;
  origin_commune_id: number;
  destination_commune_id: number;
  total_weight_kg: number;
  total_volume_m3: number | null;
  description: string | null;
  status: string;
  created_at: string | null;
};

type CommuneRow = {
  id: number;
  name: string;
};

type TrackingEventRow = {
  id: string;
  event_type: string;
  note: string | null;
  recorded_at: string;
};

type PayoutRequestContextRow = {
  blocked_reason: string | null;
  is_eligible: boolean | null;
  request_status: string | null;
  requested_at: string | null;
  payout_processed_at: string | null;
};

export const bookingIndexStatuses = [
  "pending",
  "pending_payment",
  "payment_under_review",
  "confirmed",
  "picked_up",
  "in_transit",
  "delivered_pending_review",
  "completed",
  "canceled",
  "cancelled",
  "disputed",
] as const;

export const shipmentIndexStatuses = ["draft", "booked", "canceled", "cancelled"] as const;

type ProfileRow = {
  id: string;
  full_name: string | null;
  email: string;
  company_name: string | null;
};

type BookingIndexRow = {
  id: string;
  shipment_id: string;
  shipper_id: string;
  carrier_id: string | null;
  tracking_number: string;
  payment_reference: string;
  booking_status: string;
  payment_status: string;
  shipper_total_dzd: number;
  carrier_payout_dzd: number;
  created_at: string | null;
};

type ShipmentIndexRow = {
  id: string;
  shipper_id: string;
  origin_commune_id: number;
  destination_commune_id: number;
  total_weight_kg: number;
  total_volume_m3: number | null;
  description: string | null;
  status: string;
  created_at: string | null;
};

type BookingShipmentRow = {
  id: string;
  description: string | null;
  status: string;
  origin_commune_id: number;
  destination_commune_id: number;
};

type ShipmentBookingRow = {
  id: string;
  shipment_id: string;
  tracking_number: string;
  booking_status: string;
  payment_status: string;
  created_at: string | null;
};

function isBookingIndexStatus(value: string): value is (typeof bookingIndexStatuses)[number] {
  return bookingIndexStatuses.includes(value as (typeof bookingIndexStatuses)[number]);
}

function isShipmentIndexStatus(value: string): value is (typeof shipmentIndexStatuses)[number] {
  return shipmentIndexStatuses.includes(value as (typeof shipmentIndexStatuses)[number]);
}

function escapeLikeQuery(value: string) {
  return value.replace(/\\/g, "\\\\").replace(/%/g, "\\%").replace(/_/g, "\\_");
}

function isUuidLike(value: string) {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(value.trim());
}

function buildBookingSearchFilter(query: string) {
  const trimmed = escapeLikeQuery(query.trim());
  const filters = [
    `tracking_number.ilike.%${trimmed}%`,
    `payment_reference.ilike.%${trimmed}%`,
    `id.ilike.%${trimmed}%`,
    `shipment_id.ilike.%${trimmed}%`,
    `shipper_id.ilike.%${trimmed}%`,
    `carrier_id.ilike.%${trimmed}%`,
  ];

  if (isUuidLike(query)) {
    const normalized = query.trim();
    filters.push(`id.eq.${normalized}`);
    filters.push(`shipment_id.eq.${normalized}`);
    filters.push(`shipper_id.eq.${normalized}`);
    filters.push(`carrier_id.eq.${normalized}`);
  }

  return filters.join(",");
}

function buildShipmentSearchFilter(query: string) {
  const trimmed = escapeLikeQuery(query.trim());
  const filters = [
    `id.ilike.%${trimmed}%`,
    `description.ilike.%${trimmed}%`,
    `shipper_id.ilike.%${trimmed}%`,
    `status.ilike.%${trimmed}%`,
  ];

  if (isUuidLike(query)) {
    const normalized = query.trim();
    filters.push(`id.eq.${normalized}`);
    filters.push(`shipper_id.eq.${normalized}`);
  }

  return filters.join(",");
}

function resolveDisplayName(profile: ProfileRow | null | undefined) {
  if (!profile) {
    return "Unknown";
  }

  return profile.company_name?.trim() || profile.full_name?.trim() || profile.email.trim() || profile.id;
}

function paginate(total: number, requestedPage: number, pageSize: number) {
  const totalPages = Math.max(1, Math.ceil(total / pageSize));
  const page = Math.min(Math.max(requestedPage, 1), totalPages);
  return { page, totalPages };
}

export async function fetchBookingWorkspaceDetail(bookingId: string): Promise<BookingWorkspaceDetail | null> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const { data: booking, error: bookingError } = await supabase
    .from("bookings")
    .select("id, shipment_id, shipper_id, carrier_id, vehicle_id, tracking_number, payment_reference, booking_status, payment_status, shipper_total_dzd, carrier_payout_dzd, created_at")
    .eq("id", bookingId)
    .maybeSingle();

  if (bookingError) throw bookingError;
  if (!booking) return null;

  const [shipmentResult, proofsResult, disputeResult, payoutResult, trackingResult] = await Promise.all([
    supabase
      .from("shipments")
      .select("id, shipper_id, origin_commune_id, destination_commune_id, total_weight_kg, total_volume_m3, description, status, created_at")
      .eq("id", (booking as BookingRow).shipment_id)
      .maybeSingle(),
    supabase.from("payment_proofs").select("id", { count: "exact", head: true }).eq("booking_id", bookingId),
    supabase.from("disputes").select("status").eq("booking_id", bookingId).maybeSingle(),
    supabase.from("payouts").select("status").eq("booking_id", bookingId).maybeSingle(),
    supabase
      .from("tracking_events")
      .select("id, event_type, note, recorded_at")
      .eq("booking_id", bookingId)
      .order("recorded_at", { ascending: false })
      .limit(12),
  ]);

  if (shipmentResult.error) throw shipmentResult.error;
  if (proofsResult.error) throw proofsResult.error;
  if (disputeResult.error) throw disputeResult.error;
  if (payoutResult.error) throw payoutResult.error;
  if (trackingResult.error) throw trackingResult.error;
  const { data: payoutRequestContext, error: payoutRequestContextError } = await supabase.rpc(
    "get_booking_payout_request_context",
    { p_booking_id: bookingId },
  );
  if (payoutRequestContextError) throw payoutRequestContextError;

  const shipment = shipmentResult.data as ShipmentRow | null;
  let shipmentContext: BookingWorkspaceDetail["shipment"] = null;

  if (shipment) {
    const communeIds = [shipment.origin_commune_id, shipment.destination_commune_id];
    const { data: communes, error: communesError } = await supabase.from("communes").select("id, name").in("id", communeIds);
    if (communesError) throw communesError;
    const communeMap = new Map<number, string>(((communes ?? []) as CommuneRow[]).map((row) => [row.id, row.name]));
    shipmentContext = {
      id: shipment.id,
      status: shipment.status,
      description: shipment.description,
      originLabel: communeMap.get(shipment.origin_commune_id) ?? `Commune #${shipment.origin_commune_id}`,
      destinationLabel: communeMap.get(shipment.destination_commune_id) ?? `Commune #${shipment.destination_commune_id}`,
    };
  }

  return {
    booking: {
      id: (booking as BookingRow).id,
      trackingNumber: (booking as BookingRow).tracking_number,
      paymentReference: (booking as BookingRow).payment_reference,
      bookingStatus: (booking as BookingRow).booking_status,
      paymentStatus: (booking as BookingRow).payment_status,
      shipperTotalDzd: Number((booking as BookingRow).shipper_total_dzd),
      carrierPayoutDzd: Number((booking as BookingRow).carrier_payout_dzd),
      createdAt: (booking as BookingRow).created_at,
      shipmentId: (booking as BookingRow).shipment_id,
      shipperId: (booking as BookingRow).shipper_id,
      carrierId: (booking as BookingRow).carrier_id,
      vehicleId: (booking as BookingRow).vehicle_id,
    },
    shipment: shipmentContext,
    paymentProofCount: proofsResult.count ?? 0,
    disputeStatus: (disputeResult.data as { status: string } | null)?.status ?? null,
    payoutStatus: (payoutResult.data as { status: string } | null)?.status ?? null,
    payoutRequestContext: payoutRequestContext
      ? {
          blockedReason: (payoutRequestContext as PayoutRequestContextRow).blocked_reason,
          isEligible: (payoutRequestContext as PayoutRequestContextRow).is_eligible ?? false,
          requestStatus: (payoutRequestContext as PayoutRequestContextRow).request_status,
          requestedAt: (payoutRequestContext as PayoutRequestContextRow).requested_at,
          payoutProcessedAt: (payoutRequestContext as PayoutRequestContextRow).payout_processed_at,
        }
      : null,
    trackingEvents: ((trackingResult.data ?? []) as TrackingEventRow[]).map((row) => ({
      id: row.id,
      eventType: row.event_type,
      note: row.note,
      recordedAt: row.recorded_at,
    })),
  };
}

export async function fetchShipmentWorkspaceDetail(shipmentId: string): Promise<ShipmentWorkspaceDetail | null> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const { data: shipment, error: shipmentError } = await supabase
    .from("shipments")
    .select("id, shipper_id, origin_commune_id, destination_commune_id, total_weight_kg, total_volume_m3, description, status, created_at")
    .eq("id", shipmentId)
    .maybeSingle();

  if (shipmentError) throw shipmentError;
  if (!shipment) return null;

  const [bookingResult, communesResult] = await Promise.all([
    supabase.from("bookings").select("id, tracking_number, booking_status, payment_status").eq("shipment_id", shipmentId).maybeSingle(),
    supabase
      .from("communes")
      .select("id, name")
      .in("id", [(shipment as ShipmentRow).origin_commune_id, (shipment as ShipmentRow).destination_commune_id]),
  ]);

  if (bookingResult.error) throw bookingResult.error;
  if (communesResult.error) throw communesResult.error;

  const communeMap = new Map<number, string>(((communesResult.data ?? []) as CommuneRow[]).map((row) => [row.id, row.name]));

  return {
    shipment: {
      id: (shipment as ShipmentRow).id,
      status: (shipment as ShipmentRow).status,
      description: (shipment as ShipmentRow).description,
      totalWeightKg: Number((shipment as ShipmentRow).total_weight_kg),
      totalVolumeM3: (shipment as ShipmentRow).total_volume_m3 == null ? null : Number((shipment as ShipmentRow).total_volume_m3),
      originLabel: communeMap.get((shipment as ShipmentRow).origin_commune_id) ?? `Commune #${(shipment as ShipmentRow).origin_commune_id}`,
      destinationLabel: communeMap.get((shipment as ShipmentRow).destination_commune_id) ?? `Commune #${(shipment as ShipmentRow).destination_commune_id}`,
      shipperId: (shipment as ShipmentRow).shipper_id,
      createdAt: (shipment as ShipmentRow).created_at,
    },
    booking: bookingResult.data
      ? {
          id: bookingResult.data.id,
          trackingNumber: bookingResult.data.tracking_number,
          bookingStatus: bookingResult.data.booking_status,
          paymentStatus: bookingResult.data.payment_status,
        }
    : null,
  };
}

function applyBookingIndexFilters<
  T extends {
    eq: (column: string, value: string) => T;
    or: (filter: string) => T;
  },
>(request: T, query?: string, status?: string) {
  const trimmedQuery = query?.trim();
  const normalizedStatus = status?.trim();

  if (normalizedStatus && isBookingIndexStatus(normalizedStatus)) {
    request = request.eq("booking_status", normalizedStatus);
  }

  if (trimmedQuery) {
    request = request.or(buildBookingSearchFilter(trimmedQuery));
  }

  return request;
}

function applyShipmentIndexFilters<
  T extends {
    eq: (column: string, value: string) => T;
    or: (filter: string) => T;
  },
>(request: T, query?: string, status?: string) {
  const trimmedQuery = query?.trim();
  const normalizedStatus = status?.trim();

  if (normalizedStatus && isShipmentIndexStatus(normalizedStatus)) {
    request = request.eq("status", normalizedStatus);
  }

  if (trimmedQuery) {
    request = request.or(buildShipmentSearchFilter(trimmedQuery));
  }

  return request;
}

export async function fetchBookingIndexPage({
  query,
  status,
  page = 1,
  pageSize = 20,
}: {
  query?: string;
  status?: string;
  page?: number;
  pageSize?: number;
} = {}): Promise<PaginatedListResult<AdminBookingListItem>> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();

  const countRequest = applyBookingIndexFilters(
    supabase.from("bookings").select("id", { count: "exact", head: true }),
    query,
    status,
  );
  const { count, error: countError } = await countRequest;
  if (countError) {
    throw countError;
  }

  const total = count ?? 0;
  const { page: normalizedPage, totalPages } = paginate(total, page, pageSize);
  const offset = (normalizedPage - 1) * pageSize;

  const dataRequest = applyBookingIndexFilters(
    supabase
      .from("bookings")
      .select(
        "id, shipment_id, shipper_id, carrier_id, tracking_number, payment_reference, booking_status, payment_status, shipper_total_dzd, carrier_payout_dzd, created_at",
      )
      .order("created_at", { ascending: false })
      .range(offset, offset + pageSize - 1),
    query,
    status,
  );
  const { data: bookingRows, error: bookingError } = await dataRequest;
  if (bookingError) {
    throw bookingError;
  }

  const rows = (bookingRows ?? []) as BookingIndexRow[];
  const shipmentIds = [...new Set(rows.map((row) => row.shipment_id))];
  const shipperIds = [...new Set(rows.map((row) => row.shipper_id))];
  const carrierIds = [...new Set(rows.map((row) => row.carrier_id).filter((value): value is string => Boolean(value)))];

  const [shipmentsResult, profilesResult] = await Promise.all([
    shipmentIds.length
      ? supabase
          .from("shipments")
          .select("id, description, status, origin_commune_id, destination_commune_id")
          .in("id", shipmentIds)
      : Promise.resolve({ data: [], error: null }),
    [...new Set([...shipperIds, ...carrierIds])].length
      ? supabase.from("profiles").select("id, full_name, email, company_name").in("id", [...new Set([...shipperIds, ...carrierIds])])
      : Promise.resolve({ data: [], error: null }),
  ]);

  if (shipmentsResult.error) {
    throw shipmentsResult.error;
  }
  if (profilesResult.error) {
    throw profilesResult.error;
  }

  const shipmentRows = (shipmentsResult.data ?? []) as BookingShipmentRow[];
  const shipmentMap = new Map<string, BookingShipmentRow>(shipmentRows.map((row) => [row.id, row]));
  const communeIds = [...new Set(shipmentRows.flatMap((row) => [row.origin_commune_id, row.destination_commune_id]))];
  const { data: communes, error: communesError } = communeIds.length
    ? await supabase.from("communes").select("id, name").in("id", communeIds)
    : { data: [], error: null };

  if (communesError) {
    throw communesError;
  }

  const communeMap = new Map<number, string>(((communes ?? []) as CommuneRow[]).map((row) => [row.id, row.name]));
  const profileMap = new Map<string, ProfileRow>((profilesResult.data ?? []).map((row) => [row.id, row as ProfileRow]));

  const paymentProofCounts = rows.length
    ? await supabase.from("payment_proofs").select("id, booking_id", { count: "exact" }).in(
        "booking_id",
        rows.map((row) => row.id),
      )
    : { data: [], count: 0, error: null };

  if (paymentProofCounts.error) {
    throw paymentProofCounts.error;
  }

  const disputeResult = rows.length
    ? await supabase.from("disputes").select("booking_id, status").in(
        "booking_id",
        rows.map((row) => row.id),
      )
    : { data: [], error: null };

  if (disputeResult.error) {
    throw disputeResult.error;
  }

  const disputeMap = new Map<string, string>(
    ((disputeResult.data ?? []) as Array<{ booking_id: string; status: string }>).map((row) => [row.booking_id, row.status]),
  );
  const paymentProofMap = new Map<string, number>();
  for (const proof of ((paymentProofCounts.data ?? []) as Array<{ booking_id: string }>)) {
    paymentProofMap.set(proof.booking_id, (paymentProofMap.get(proof.booking_id) ?? 0) + 1);
  }

  return {
    items: rows.map((row) => {
      const shipment = shipmentMap.get(row.shipment_id);
      const shipper = profileMap.get(row.shipper_id);
      const carrier = row.carrier_id ? profileMap.get(row.carrier_id) : null;

      return {
        id: row.id,
        shipmentId: row.shipment_id,
        shipperId: row.shipper_id,
        carrierId: row.carrier_id,
        trackingNumber: row.tracking_number,
        paymentReference: row.payment_reference,
        bookingStatus: row.booking_status,
        paymentStatus: row.payment_status,
        shipperDisplayName: resolveDisplayName(shipper),
        carrierDisplayName: resolveDisplayName(carrier ?? undefined),
        shipperName: resolveDisplayName(shipper),
        carrierName: resolveDisplayName(carrier ?? undefined),
        originLabel: shipment ? communeMap.get(shipment.origin_commune_id) ?? `Commune #${shipment.origin_commune_id}` : `Shipment #${row.shipment_id}`,
        destinationLabel: shipment
          ? communeMap.get(shipment.destination_commune_id) ?? `Commune #${shipment.destination_commune_id}`
          : `Shipment #${row.shipment_id}`,
        shipmentDescription: shipment?.description ?? null,
        shipperTotalDzd: Number(row.shipper_total_dzd),
        carrierPayoutDzd: Number(row.carrier_payout_dzd),
        paymentProofCount: paymentProofMap.get(row.id) ?? 0,
        disputeStatus: disputeMap.get(row.id) ?? null,
        createdAt: row.created_at,
      };
    }),
    total,
    page: normalizedPage,
    pageSize,
    totalPages,
  };
}

export async function fetchShipmentIndexPage({
  query,
  status,
  page = 1,
  pageSize = 20,
}: {
  query?: string;
  status?: string;
  page?: number;
  pageSize?: number;
} = {}): Promise<PaginatedListResult<AdminShipmentListItem>> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();

  const countRequest = applyShipmentIndexFilters(
    supabase.from("shipments").select("id", { count: "exact", head: true }),
    query,
    status,
  );
  const { count, error: countError } = await countRequest;
  if (countError) {
    throw countError;
  }

  const total = count ?? 0;
  const { page: normalizedPage, totalPages } = paginate(total, page, pageSize);
  const offset = (normalizedPage - 1) * pageSize;

  const dataRequest = applyShipmentIndexFilters(
    supabase
      .from("shipments")
      .select("id, shipper_id, origin_commune_id, destination_commune_id, total_weight_kg, total_volume_m3, description, status, created_at")
      .order("created_at", { ascending: false })
      .range(offset, offset + pageSize - 1),
    query,
    status,
  );
  const { data: shipmentRows, error: shipmentError } = await dataRequest;
  if (shipmentError) {
    throw shipmentError;
  }

  const rows = (shipmentRows ?? []) as ShipmentIndexRow[];
  const shipperIds = [...new Set(rows.map((row) => row.shipper_id))];
  const communeIds = [...new Set(rows.flatMap((row) => [row.origin_commune_id, row.destination_commune_id]))];
  const shipmentIds = rows.map((row) => row.id);

  const [profilesResult, communesResult, bookingsResult] = await Promise.all([
    shipperIds.length
      ? supabase.from("profiles").select("id, full_name, email, company_name").in("id", shipperIds)
      : Promise.resolve({ data: [], error: null }),
    communeIds.length
      ? supabase.from("communes").select("id, name").in("id", communeIds)
      : Promise.resolve({ data: [], error: null }),
    shipmentIds.length
      ? supabase
          .from("bookings")
          .select("id, shipment_id, tracking_number, booking_status, payment_status, created_at")
          .in("shipment_id", shipmentIds)
          .order("created_at", { ascending: false })
      : Promise.resolve({ data: [], error: null }),
  ]);

  if (profilesResult.error) {
    throw profilesResult.error;
  }
  if (communesResult.error) {
    throw communesResult.error;
  }
  if (bookingsResult.error) {
    throw bookingsResult.error;
  }

  const profileMap = new Map<string, ProfileRow>((profilesResult.data ?? []).map((row) => [row.id, row as ProfileRow]));
  const communeMap = new Map<number, string>(((communesResult.data ?? []) as CommuneRow[]).map((row) => [row.id, row.name]));
  const bookingRows = (bookingsResult.data ?? []) as ShipmentBookingRow[];
  const bookingMap = new Map<string, ShipmentBookingRow>();
  for (const row of bookingRows) {
    if (!bookingMap.has(row.shipment_id)) {
      bookingMap.set(row.shipment_id, row);
    }
  }

  return {
    items: rows.map((row) => {
      const booking = bookingMap.get(row.id);
      return {
        id: row.id,
        description: row.description,
        status: row.status,
        shipperId: row.shipper_id,
        shipperDisplayName: resolveDisplayName(profileMap.get(row.shipper_id)),
        shipperName: resolveDisplayName(profileMap.get(row.shipper_id)),
        originLabel: communeMap.get(row.origin_commune_id) ?? `Commune #${row.origin_commune_id}`,
        destinationLabel: communeMap.get(row.destination_commune_id) ?? `Commune #${row.destination_commune_id}`,
        totalWeightKg: Number(row.total_weight_kg),
        totalVolumeM3: row.total_volume_m3 == null ? null : Number(row.total_volume_m3),
        bookingId: booking?.id ?? null,
        bookingTrackingNumber: booking?.tracking_number ?? null,
        bookingStatus: booking?.booking_status ?? null,
        paymentStatus: booking?.payment_status ?? null,
        createdAt: row.created_at,
      };
    }),
    total,
    page: normalizedPage,
    pageSize,
    totalPages,
  };
}
