import { requireServerAdminSession } from "@/lib/auth/require-server-admin-session";
import { pageRange, totalPages } from "@/lib/pagination";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import type {
  AdminAuditLogItem,
  AdminBookingSummary,
  AdminDocumentSummary,
  AdminPayoutAccountSummary,
  AdminShipmentSummary,
  AdminSupportSummary,
  AdminUserDetail,
  AdminUserRegistryFilters,
  AdminUserRegistrySnapshot,
  AdminVehicleSummary,
} from "@/lib/queries/admin-types";

function isUuidLike(value: string) {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(value.trim());
}

const userRoles = ["shipper", "carrier", "admin"] as const;

function isUserRole(value: string): value is (typeof userRoles)[number] {
  return userRoles.includes(value as (typeof userRoles)[number]);
}

function buildProfileSearchFilter(query: string) {
  const trimmed = query.trim();
  const filters = [
    `full_name.ilike.%${trimmed}%`,
    `company_name.ilike.%${trimmed}%`,
    `email.ilike.%${trimmed}%`,
    `phone_number.ilike.%${trimmed}%`,
  ];

  if (isUuidLike(trimmed)) {
    filters.push(`id.eq.${trimmed}`);
  }

  return filters.join(",");
}

function normalizeQuery(value?: string) {
  return value?.trim() ?? "";
}

function clampPage(page: number | undefined) {
  return Number.isFinite(page) && (page ?? 1) > 0 ? Math.floor(page as number) : 1;
}

function clampPageSize(pageSize: number | undefined) {
  const normalized = Number.isFinite(pageSize) ? Math.floor(pageSize as number) : 25;
  return Math.min(50, Math.max(10, normalized || 25));
}

type ProfileRow = {
  id: string;
  role: string;
  full_name: string | null;
  phone_number: string | null;
  email: string;
  company_name: string | null;
  preferred_locale: string;
  is_active: boolean;
  rating_average: number | null;
  rating_count: number;
  created_at: string | null;
  updated_at: string | null;
};

type CarrierVerificationPacketRow = {
  carrier_id: string;
  status: string;
  rejection_reason: string | null;
};

type VehicleRow = {
  id: string;
  carrier_id: string;
  plate_number: string;
  vehicle_type: string;
  verification_status: string;
  updated_at: string | null;
};

type BookingRow = {
  id: string;
  shipment_id: string;
  shipper_id: string;
  carrier_id: string;
  tracking_number: string;
  booking_status: string;
  payment_status: string;
  created_at: string | null;
};

type ShipmentRow = {
  id: string;
  shipper_id: string;
  origin_commune_id: number;
  destination_commune_id: number;
  total_weight_kg: number;
  description: string | null;
  status: string;
  created_at: string | null;
};

type CommuneRow = {
  id: number;
  name: string;
};

type SupportRequestRow = {
  id: string;
  created_by: string;
  subject: string;
  status: string;
  last_message_at: string;
};

type VerificationDocumentRow = {
  id: string;
  owner_profile_id: string;
  document_type: string;
  entity_type: "profile" | "vehicle";
  status: string;
  updated_at: string | null;
};

type PayoutAccountRow = {
  id: string;
  carrier_id: string;
  account_type: string;
  account_identifier: string;
  bank_or_ccp_name: string | null;
  is_verified: boolean;
  is_active: boolean;
  updated_at: string | null;
};

type AuditRow = {
  id: string;
  action: string;
  target_type: string;
  target_id: string | null;
  outcome: string;
  reason: string | null;
  metadata: Record<string, unknown> | null;
  created_at: string | null;
};

function resolveDisplayName(profile: Pick<ProfileRow, "company_name" | "full_name" | "email">) {
  return profile.company_name?.trim() || profile.full_name?.trim() || profile.email;
}

function mapAuditLogs(rows: AuditRow[]): AdminAuditLogItem[] {
  return rows.map((row) => ({
    id: row.id,
    action: row.action,
    targetType: row.target_type,
    targetId: row.target_id,
    outcome: row.outcome,
    reason: row.reason,
    metadata: row.metadata ?? {},
    createdAt: row.created_at,
  }));
}

function normalizeUserFilters(filters: AdminUserRegistryFilters) {
  return {
    q: normalizeQuery(filters.q),
    role: filters.role ?? "all",
    activity: filters.activity ?? "all",
    verification: filters.verification ?? "all",
    page: clampPage(filters.page),
    pageSize: clampPageSize(filters.pageSize),
  } as const;
}

export async function fetchUsers(filters: AdminUserRegistryFilters = {}): Promise<AdminUserRegistrySnapshot> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const normalized = normalizeUserFilters(filters);

  let countRequest = supabase.from("profiles").select("id", { count: "exact", head: true }).neq("role", "admin");
  let pageRequest = supabase
    .from("profiles")
    .select(
      "id, role, full_name, phone_number, email, company_name, preferred_locale, is_active, rating_average, rating_count, created_at, updated_at",
    )
    .neq("role", "admin")
    .order("updated_at", { ascending: false });

  if (normalized.role !== "all" && isUserRole(normalized.role)) {
    countRequest = countRequest.eq("role", normalized.role);
    pageRequest = pageRequest.eq("role", normalized.role);
  }

  if (normalized.activity === "active") {
    countRequest = countRequest.eq("is_active", true);
    pageRequest = pageRequest.eq("is_active", true);
  } else if (normalized.activity === "inactive") {
    countRequest = countRequest.eq("is_active", false);
    pageRequest = pageRequest.eq("is_active", false);
  }

  if (normalized.q) {
    const searchFilter = buildProfileSearchFilter(normalized.q);
    countRequest = countRequest.or(searchFilter);
    pageRequest = pageRequest.or(searchFilter);
  }

  if (normalized.verification !== "all") {
    if (normalized.role !== "all" && normalized.role !== "carrier") {
      return {
        users: [],
        page: 1,
        pageSize: normalized.pageSize,
        totalUsers: 0,
        filters: normalized,
      };
    }

    countRequest = countRequest.eq("role", "carrier");
    pageRequest = pageRequest.eq("role", "carrier");

    const { data: matchingPackets, error: matchingPacketsError } = await supabase
      .from("carrier_verification_packets")
      .select("carrier_id")
      .eq("status", normalized.verification);

    if (matchingPacketsError) throw matchingPacketsError;

    const carrierIds = [...new Set(((matchingPackets ?? []) as Array<{ carrier_id: string }>).map((row) => row.carrier_id))];
    if (carrierIds.length === 0) {
      return {
        users: [],
        page: 1,
        pageSize: normalized.pageSize,
        totalUsers: 0,
        filters: normalized,
      };
    }

    countRequest = countRequest.in("id", carrierIds);
    pageRequest = pageRequest.in("id", carrierIds);
  }

  const countResult = await countRequest;
  if (countResult.error) throw countResult.error;

  const safePage = Math.min(normalized.page, totalPages(countResult.count ?? 0, normalized.pageSize));
  const { from, to } = pageRange(safePage, normalized.pageSize);
  const pageResult = await pageRequest.range(from, to);
  if (pageResult.error) throw pageResult.error;

  const profiles = (pageResult.data ?? []) as ProfileRow[];
  if (profiles.length === 0) {
    return {
      users: [],
      page: safePage,
      pageSize: normalized.pageSize,
      totalUsers: countResult.count ?? 0,
      filters: normalized,
    };
  }

  const profileIds = profiles.map((profile) => profile.id);
  const carrierIds = profiles.filter((profile) => profile.role === "carrier").map((profile) => profile.id);
  const shipperIds = profiles.filter((profile) => profile.role === "shipper").map((profile) => profile.id);

  const [vehiclesResult, bookingsAsShipperResult, bookingsAsCarrierResult, shipmentsResult] = await Promise.all([
    profileIds.length
      ? supabase.from("vehicles").select("id, carrier_id").in("carrier_id", profileIds)
      : Promise.resolve({ data: [], error: null }),
    shipperIds.length
      ? supabase.from("bookings").select("id, shipper_id").in("shipper_id", shipperIds)
      : Promise.resolve({ data: [], error: null }),
    carrierIds.length
      ? supabase.from("bookings").select("id, carrier_id").in("carrier_id", carrierIds)
      : Promise.resolve({ data: [], error: null }),
    shipperIds.length
      ? supabase.from("shipments").select("id, shipper_id").in("shipper_id", shipperIds)
      : Promise.resolve({ data: [], error: null }),
  ]);

  if (vehiclesResult.error) throw vehiclesResult.error;
  if (bookingsAsShipperResult.error) throw bookingsAsShipperResult.error;
  if (bookingsAsCarrierResult.error) throw bookingsAsCarrierResult.error;
  if (shipmentsResult.error) throw shipmentsResult.error;

  const { data: packets, error: packetError } = carrierIds.length
    ? await supabase
        .from("carrier_verification_packets")
        .select("carrier_id, status, rejection_reason")
        .in("carrier_id", carrierIds)
    : { data: [], error: null };

  if (packetError) throw packetError;

  const packetMap = new Map<string, CarrierVerificationPacketRow>(
    ((packets ?? []) as CarrierVerificationPacketRow[]).map((packet) => [packet.carrier_id, packet]),
  );

  const vehicleCounts = new Map<string, number>();
  for (const vehicle of ((vehiclesResult.data ?? []) as Array<{ carrier_id: string }>)) {
    vehicleCounts.set(vehicle.carrier_id, (vehicleCounts.get(vehicle.carrier_id) ?? 0) + 1);
  }

  const shipperBookingCounts = new Map<string, number>();
  for (const booking of ((bookingsAsShipperResult.data ?? []) as Array<{ shipper_id: string }>)) {
    shipperBookingCounts.set(booking.shipper_id, (shipperBookingCounts.get(booking.shipper_id) ?? 0) + 1);
  }

  const carrierBookingCounts = new Map<string, number>();
  for (const booking of ((bookingsAsCarrierResult.data ?? []) as Array<{ carrier_id: string }>)) {
    carrierBookingCounts.set(booking.carrier_id, (carrierBookingCounts.get(booking.carrier_id) ?? 0) + 1);
  }

  const shipmentCounts = new Map<string, number>();
  for (const shipment of ((shipmentsResult.data ?? []) as Array<{ shipper_id: string }>)) {
    shipmentCounts.set(shipment.shipper_id, (shipmentCounts.get(shipment.shipper_id) ?? 0) + 1);
  }

  return {
    users: profiles.map((profile) => ({
      profileId: profile.id,
      displayName: resolveDisplayName(profile),
      role: profile.role,
      email: profile.email,
      phoneNumber: profile.phone_number,
      companyName: profile.company_name,
      isActive: profile.is_active,
      verificationStatus: profile.role === "carrier" ? (packetMap.get(profile.id)?.status ?? "pending") : null,
      vehicleCount: vehicleCounts.get(profile.id) ?? 0,
      shipmentCount: shipmentCounts.get(profile.id) ?? 0,
      bookingCount:
        profile.role === "carrier"
          ? (carrierBookingCounts.get(profile.id) ?? 0)
          : (shipperBookingCounts.get(profile.id) ?? 0),
      updatedAt: profile.updated_at,
    })),
    page: safePage,
    pageSize: normalized.pageSize,
    totalUsers: countResult.count ?? 0,
    filters: normalized,
  };
}

export async function fetchUserDetail(userId: string): Promise<AdminUserDetail | null> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const { data: profile, error: profileError } = await supabase
    .from("profiles")
    .select(
      "id, role, email, full_name, phone_number, company_name, preferred_locale, is_active, rating_average, rating_count, created_at, updated_at",
    )
    .eq("id", userId)
    .neq("role", "admin")
    .maybeSingle();

  if (profileError) throw profileError;
  if (!profile) return null;

  const { data: packet, error: packetError } =
    profile.role === "carrier"
      ? await supabase
          .from("carrier_verification_packets")
          .select("carrier_id, status, rejection_reason")
          .eq("carrier_id", userId)
          .maybeSingle()
      : { data: null, error: null };

  if (packetError) throw packetError;

  const [vehiclesResult, shipmentsResult, bookingsAsShipperResult, bookingsAsCarrierResult, supportResult, documentsResult, payoutAccountsResult, auditLogsResult] =
    await Promise.all([
      supabase
        .from("vehicles")
        .select("id, carrier_id, plate_number, vehicle_type, verification_status, updated_at")
        .eq("carrier_id", userId)
        .order("updated_at", { ascending: false })
        .limit(8),
      supabase
        .from("shipments")
        .select("id, shipper_id, origin_commune_id, destination_commune_id, total_weight_kg, description, status, created_at")
        .eq("shipper_id", userId)
        .order("created_at", { ascending: false })
        .limit(8),
      supabase
        .from("bookings")
        .select("id, shipment_id, shipper_id, carrier_id, tracking_number, booking_status, payment_status, created_at")
        .eq("shipper_id", userId)
        .order("created_at", { ascending: false })
        .limit(6),
      supabase
        .from("bookings")
        .select("id, shipment_id, shipper_id, carrier_id, tracking_number, booking_status, payment_status, created_at")
        .eq("carrier_id", userId)
        .order("created_at", { ascending: false })
        .limit(6),
      supabase
        .from("support_requests")
        .select("id, created_by, subject, status, last_message_at")
        .eq("created_by", userId)
        .order("last_message_at", { ascending: false })
        .limit(6),
      supabase
        .from("verification_documents")
        .select("id, owner_profile_id, document_type, entity_type, status, updated_at")
        .eq("owner_profile_id", userId)
        .order("updated_at", { ascending: false })
        .limit(10),
      supabase
        .from("payout_accounts")
        .select("id, carrier_id, account_type, account_identifier, bank_or_ccp_name, is_verified, is_active, updated_at")
        .eq("carrier_id", userId)
        .order("updated_at", { ascending: false })
        .limit(4),
      supabase
        .from("admin_audit_logs")
        .select("id, action, target_type, target_id, outcome, reason, metadata, created_at")
        .eq("target_id", userId)
        .order("created_at", { ascending: false })
        .limit(15),
    ]);

  if (vehiclesResult.error) throw vehiclesResult.error;
  if (shipmentsResult.error) throw shipmentsResult.error;
  if (bookingsAsShipperResult.error) throw bookingsAsShipperResult.error;
  if (bookingsAsCarrierResult.error) throw bookingsAsCarrierResult.error;
  if (supportResult.error) throw supportResult.error;
  if (documentsResult.error) throw documentsResult.error;
  if (payoutAccountsResult.error) throw payoutAccountsResult.error;
  if (auditLogsResult.error) throw auditLogsResult.error;

  const shipmentRows = (shipmentsResult.data ?? []) as ShipmentRow[];
  const communeIds = [...new Set(shipmentRows.flatMap((shipment) => [shipment.origin_commune_id, shipment.destination_commune_id]))];
  const { data: communes, error: communeError } = communeIds.length
    ? await supabase.from("communes").select("id, name").in("id", communeIds)
    : { data: [], error: null };

  if (communeError) throw communeError;

  const communeMap = new Map<number, string>(((communes ?? []) as CommuneRow[]).map((commune) => [commune.id, commune.name]));
  const bookings = [
    ...((bookingsAsShipperResult.data ?? []) as BookingRow[]),
    ...((bookingsAsCarrierResult.data ?? []) as BookingRow[]),
  ]
    .filter((booking, index, all) => all.findIndex((candidate) => candidate.id === booking.id) === index)
    .sort((left, right) => (right.created_at ?? "").localeCompare(left.created_at ?? ""))
    .slice(0, 8);

  return {
    profile: {
      id: profile.id,
      role: profile.role,
      email: profile.email,
      fullName: profile.full_name,
      phoneNumber: profile.phone_number,
      companyName: profile.company_name,
      preferredLocale: profile.preferred_locale,
      isActive: profile.is_active,
      verificationStatus: profile.role === "carrier" ? packet?.status ?? "pending" : null,
      verificationRejectionReason: profile.role === "carrier" ? packet?.rejection_reason ?? null : null,
      ratingAverage: profile.rating_average,
      ratingCount: profile.rating_count,
      createdAt: profile.created_at,
      updatedAt: profile.updated_at,
    },
    vehicles: ((vehiclesResult.data ?? []) as VehicleRow[]).map<AdminVehicleSummary>((vehicle) => ({
      id: vehicle.id,
      label: `${vehicle.vehicle_type.toUpperCase()} • ${vehicle.plate_number}`,
      verificationStatus: vehicle.verification_status,
      updatedAt: vehicle.updated_at,
    })),
    shipments: shipmentRows.map<AdminShipmentSummary>((shipment) => ({
      id: shipment.id,
      status: shipment.status,
      description: shipment.description,
      originLabel: communeMap.get(shipment.origin_commune_id) ?? `Commune #${shipment.origin_commune_id}`,
      destinationLabel: communeMap.get(shipment.destination_commune_id) ?? `Commune #${shipment.destination_commune_id}`,
      totalWeightKg: Number(shipment.total_weight_kg),
      createdAt: shipment.created_at,
    })),
    bookings: bookings.map<AdminBookingSummary>((booking) => ({
      id: booking.id,
      shipmentId: booking.shipment_id,
      trackingNumber: booking.tracking_number,
      bookingStatus: booking.booking_status,
      paymentStatus: booking.payment_status,
      createdAt: booking.created_at,
    })),
    supportRequests: ((supportResult.data ?? []) as SupportRequestRow[]).map<AdminSupportSummary>((request) => ({
      id: request.id,
      subject: request.subject,
      status: request.status,
      lastMessageAt: request.last_message_at,
    })),
    documents: ((documentsResult.data ?? []) as VerificationDocumentRow[]).map<AdminDocumentSummary>((document) => ({
      id: document.id,
      documentType: document.document_type,
      entityType: document.entity_type,
      status: document.status,
      updatedAt: document.updated_at,
    })),
    payoutAccounts: ((payoutAccountsResult.data ?? []) as PayoutAccountRow[]).map<AdminPayoutAccountSummary>((account) => ({
      id: account.id,
      accountType: account.account_type,
      identifier: account.account_identifier,
      institutionName: account.bank_or_ccp_name,
      isVerified: account.is_verified,
      isActive: account.is_active,
      updatedAt: account.updated_at,
    })),
    auditLogs: mapAuditLogs((auditLogsResult.data ?? []) as AuditRow[]),
  };
}
