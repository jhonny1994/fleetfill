import { requireServerAdminSession } from "@/lib/auth/require-server-admin-session";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import type {
  DisputeQueueItem,
  PaymentQueueItem,
  SupportQueueItem,
  VerificationQueueItem,
} from "@/lib/queries/admin-types";
import {
  diffHoursFromNow,
} from "@/lib/formatting/formatters";

const PROFILE_REQUIRED_DOCUMENTS = ["driver_identity_or_license"] as const;
const VEHICLE_REQUIRED_DOCUMENTS = [
  "truck_registration",
  "truck_insurance",
  "truck_technical_inspection",
] as const;

type PaymentProofRow = {
  id: string;
  booking_id: string;
  payment_rail: string;
  submitted_reference: string | null;
  submitted_amount_dzd: number;
  submitted_at: string;
};

type BookingRow = {
  id: string;
  tracking_number: string;
  payment_reference: string;
  shipper_total_dzd: number;
  carrier_payout_dzd: number;
};

export async function fetchPaymentQueue({
  query,
  limit = 50,
}: {
  query?: string;
  limit?: number;
} = {}): Promise<PaymentQueueItem[]> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const { data: proofs, error: proofError } = await supabase
    .from("payment_proofs")
    .select("id, booking_id, payment_rail, submitted_reference, submitted_amount_dzd, submitted_at")
    .eq("status", "pending")
    .order("submitted_at", { ascending: true })
    .limit(limit * 2);

  if (proofError) {
    throw proofError;
  }

  const proofRows = ((proofs ?? []) as PaymentProofRow[]);
  if (proofRows.length === 0) {
    return [];
  }

  const bookingIds = [...new Set(proofRows.map((proof) => proof.booking_id))];
  const { data: bookings, error: bookingError } = await supabase
    .from("bookings")
    .select("id, tracking_number, payment_reference, shipper_total_dzd, carrier_payout_dzd")
    .in("id", bookingIds);

  if (bookingError) {
    throw bookingError;
  }

  const bookingMap = new Map<string, BookingRow>(
    ((bookings ?? []) as BookingRow[]).map((booking) => [booking.id, booking]),
  );

  const normalized = query?.trim().toLowerCase();
  const results = proofRows
    .map((proof) => {
      const booking = bookingMap.get(proof.booking_id);
      if (!booking) {
        return null;
      }

      return {
        proofId: proof.id,
        bookingId: booking.id,
        trackingNumber: booking.tracking_number,
        paymentReference: booking.payment_reference,
        paymentRail: proof.payment_rail,
        submittedReference: proof.submitted_reference,
        submittedAmountDzd: Number(proof.submitted_amount_dzd),
        shipperTotalDzd: Number(booking.shipper_total_dzd),
        carrierPayoutDzd: Number(booking.carrier_payout_dzd),
        submittedAt: proof.submitted_at,
        ageHours: diffHoursFromNow(proof.submitted_at),
      } satisfies PaymentQueueItem;
    })
    .filter((item): item is PaymentQueueItem => item !== null);

  if (!normalized) {
    return results.slice(0, limit);
  }

  return results
    .filter((item) => {
      const haystack = [
        item.trackingNumber,
        item.paymentReference,
        item.submittedReference ?? "",
        item.bookingId,
        item.proofId,
        item.paymentRail,
      ]
        .join(" ")
        .toLowerCase();
      return haystack.includes(normalized);
    })
    .slice(0, limit);
}

type ProfileRow = {
  id: string;
  email: string;
  full_name: string | null;
  company_name: string | null;
  updated_at: string | null;
};

type CarrierVerificationPacketRow = {
  carrier_id: string;
  status: string;
  rejection_reason: string | null;
  updated_at: string | null;
};

type VehicleRow = {
  id: string;
  carrier_id: string;
  plate_number: string;
  vehicle_type: string;
  updated_at: string | null;
};

type VerificationDocumentRow = {
  id: string;
  entity_type: "profile" | "vehicle";
  entity_id: string;
  document_type: string;
  status: string;
  created_at: string | null;
  updated_at: string | null;
};

export async function fetchVerificationQueue({
  query,
  limit = 20,
}: {
  query?: string;
  limit?: number;
} = {}): Promise<VerificationQueueItem[]> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const { data: packets, error: packetError } = await supabase
    .from("carrier_verification_packets")
    .select("carrier_id, status, rejection_reason, updated_at")
    .in("status", ["pending", "rejected"])
    .order("updated_at", { ascending: true })
    .limit(limit * 3);

  if (packetError) {
    throw packetError;
  }

  const packetRows = (packets ?? []) as CarrierVerificationPacketRow[];
  if (packetRows.length === 0) {
    return [];
  }

  const packetMap = new Map<string, CarrierVerificationPacketRow>(
    packetRows.map((packet) => [packet.carrier_id, packet]),
  );
  const carrierIds = packetRows.map((packet) => packet.carrier_id);

  const { data: profiles, error: profileError } = await supabase
    .from("profiles")
    .select("id, email, full_name, company_name, updated_at")
    .eq("role", "carrier")
    .in("id", carrierIds);

  if (profileError) {
    throw profileError;
  }

  const profileRows = (profiles ?? []) as ProfileRow[];
  if (profileRows.length === 0) {
    return [];
  }
  const { data: vehicles, error: vehicleError } = await supabase
    .from("vehicles")
    .select("id, carrier_id, plate_number, vehicle_type, updated_at")
    .in("carrier_id", carrierIds)
    .order("updated_at", { ascending: true });

  if (vehicleError) {
    throw vehicleError;
  }

  const vehicleRows = (vehicles ?? []) as VehicleRow[];
  const vehicleIds = vehicleRows.map((vehicle) => vehicle.id);
  const documentFilters = [
    `and(entity_type.eq.profile,entity_id.in.(${carrierIds.map((id) => `"${id}"`).join(",")}))`,
    vehicleIds.length > 0
      ? `and(entity_type.eq.vehicle,entity_id.in.(${vehicleIds.map((id) => `"${id}"`).join(",")}))`
      : null,
  ].filter(Boolean);

  const { data: documents, error: documentError } = await supabase
    .from("verification_documents")
    .select("id, entity_type, entity_id, document_type, status, created_at, updated_at")
    .or(documentFilters.join(","))
    .order("created_at", { ascending: false });

  if (documentError) {
    throw documentError;
  }

  const latestByEntityType = new Map<string, VerificationDocumentRow>();
  for (const row of (documents ?? []) as VerificationDocumentRow[]) {
    const key = `${row.entity_type}:${row.entity_id}:${row.document_type}`;
    if (!latestByEntityType.has(key)) {
      latestByEntityType.set(key, row);
    }
  }

  const vehiclesByCarrier = new Map<string, VehicleRow[]>();
  for (const vehicle of vehicleRows) {
    const existing = vehiclesByCarrier.get(vehicle.carrier_id) ?? [];
    existing.push(vehicle);
    vehiclesByCarrier.set(vehicle.carrier_id, existing);
  }

  const normalized = query?.trim().toLowerCase();
  const results: VerificationQueueItem[] = [];
  for (const profile of profileRows) {
      const packet = packetMap.get(profile.id);
      if (!packet) {
        continue;
      }
      const carrierVehicles = vehiclesByCarrier.get(profile.id) ?? [];
      const carrierDocuments = PROFILE_REQUIRED_DOCUMENTS.map((documentType) =>
        latestByEntityType.get(`profile:${profile.id}:${documentType}`),
      ).filter(Boolean) as VerificationDocumentRow[];
      const carrierMissingDocuments = PROFILE_REQUIRED_DOCUMENTS.filter(
        (documentType) =>
          !carrierDocuments.some(
            (document) => document.document_type === documentType && document.status === "verified",
          ),
      );

      const vehicles = carrierVehicles.map((vehicle) => {
        const documents = VEHICLE_REQUIRED_DOCUMENTS.map((documentType) =>
          latestByEntityType.get(`vehicle:${vehicle.id}:${documentType}`),
        ).filter(Boolean) as VerificationDocumentRow[];
        const missingDocuments = VEHICLE_REQUIRED_DOCUMENTS.filter(
          (documentType) =>
            !documents.some(
              (document) => document.document_type === documentType && document.status === "verified",
            ),
        );

        return {
          id: vehicle.id,
          label: `${vehicle.vehicle_type.toUpperCase()} • ${vehicle.plate_number}`,
          pendingDocuments: documents.filter((document) => document.status === "pending").length,
          missingDocuments,
        };
      });

      const pendingDocumentCount =
        carrierDocuments.filter((document) => document.status === "pending").length +
        vehicles.reduce((sum, vehicle) => sum + vehicle.pendingDocuments, 0);
      const latestRelevantUpdateAt = [profile.updated_at, ...carrierVehicles.map((vehicle) => vehicle.updated_at)]
        .filter(Boolean)
        .sort()
        .at(-1) ?? null;

      const item: VerificationQueueItem = {
        carrierId: profile.id,
        displayName: profile.company_name?.trim() || profile.full_name?.trim() || profile.email,
        companyName: profile.company_name,
        carrierPendingDocuments: carrierDocuments.filter((document) => document.status === "pending").length,
        carrierMissingDocuments,
        vehicleCount: carrierVehicles.length,
        pendingDocumentCount,
        latestRelevantUpdateAt,
        vehicles,
      };

      if (item.pendingDocumentCount > 0 || item.carrierMissingDocuments.length > 0) {
        results.push(item);
      }
    }

  const filtered = !normalized
    ? results
    : results.filter((item) => {
        const haystack = [
          item.displayName,
          item.companyName ?? "",
          item.carrierId,
          ...item.vehicles.map((vehicle) => vehicle.label),
        ]
          .join(" ")
          .toLowerCase();
        return haystack.includes(normalized);
      });

  return filtered
    .sort((left, right) => {
      if (right.pendingDocumentCount !== left.pendingDocumentCount) {
        return right.pendingDocumentCount - left.pendingDocumentCount;
      }
      return (left.latestRelevantUpdateAt ?? "").localeCompare(right.latestRelevantUpdateAt ?? "");
    })
    .slice(0, limit);
}

type DisputeRow = {
  id: string;
  booking_id: string;
  reason: string;
  status: string;
  created_at: string | null;
  updated_at: string | null;
};

export async function fetchDisputeQueue({
  query,
  limit = 50,
}: {
  query?: string;
  limit?: number;
} = {}): Promise<DisputeQueueItem[]> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const { data, error } = await supabase
    .from("disputes")
    .select("id, booking_id, reason, status, created_at, updated_at")
    .eq("status", "open")
    .order("created_at", { ascending: true })
    .limit(limit);

  if (error) {
    throw error;
  }

  const disputeRows = (data ?? []) as DisputeRow[];
  const bookingIds = [...new Set(disputeRows.map((dispute) => dispute.booking_id))];
  const [bookingsResult, evidenceResult] = await Promise.all([
    bookingIds.length
      ? supabase.from("bookings").select("id, tracking_number").in("id", bookingIds)
      : Promise.resolve({ data: [], error: null }),
    disputeRows.length
      ? supabase.from("dispute_evidence").select("id, dispute_id").in("dispute_id", disputeRows.map((row) => row.id))
      : Promise.resolve({ data: [], error: null }),
  ]);
  if (bookingsResult.error) throw bookingsResult.error;
  if (evidenceResult.error) throw evidenceResult.error;
  const trackingMap = new Map(
    ((bookingsResult.data ?? []) as Array<{ id: string; tracking_number: string }>).map((booking) => [
      booking.id,
      booking.tracking_number,
    ]),
  );
  const evidenceCountByDispute = new Map<string, number>();
  for (const row of (evidenceResult.data ?? []) as Array<{ dispute_id: string }>) {
    evidenceCountByDispute.set(row.dispute_id, (evidenceCountByDispute.get(row.dispute_id) ?? 0) + 1);
  }

  const normalized = query?.trim().toLowerCase();
  const results = disputeRows.map((dispute) => ({
    id: dispute.id,
    bookingId: dispute.booking_id,
    trackingNumber: trackingMap.get(dispute.booking_id) ?? null,
    reason: dispute.reason,
    status: dispute.status,
    evidenceCount: evidenceCountByDispute.get(dispute.id) ?? 0,
    createdAt: dispute.created_at,
    updatedAt: dispute.updated_at,
    ageHours: diffHoursFromNow(dispute.created_at),
  }));

  if (!normalized) {
    return results;
  }

  return results.filter((item) =>
    [item.bookingId, item.id, item.reason, item.trackingNumber ?? ""].join(" ").toLowerCase().includes(normalized),
  );
}

type SupportRow = {
  id: string;
  subject: string;
  status: string;
  priority: string;
  booking_id: string | null;
  dispute_id: string | null;
  payment_proof_id: string | null;
  assigned_admin_id: string | null;
  last_message_sender_type: string;
  last_message_at: string;
  admin_last_read_at: string | null;
};

const supportStatuses = ["open", "in_progress", "waiting_for_user", "resolved", "closed"] as const;
function isSupportStatus(value: string): value is (typeof supportStatuses)[number] {
  return supportStatuses.includes(value as (typeof supportStatuses)[number]);
}

function isUuidLike(value: string) {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(
    value.trim(),
  );
}

function buildSupportSearchFilter(query: string) {
  const trimmed = query.trim();
  const filters = [`subject.ilike.%${trimmed}%`];
  if (isUuidLike(trimmed)) {
    filters.push(
      `created_by.eq.${trimmed}`,
      `booking_id.eq.${trimmed}`,
      `shipment_id.eq.${trimmed}`,
      `payment_proof_id.eq.${trimmed}`,
      `dispute_id.eq.${trimmed}`,
    );
  }
  return filters.join(",");
}

export async function fetchSupportQueue({
  query,
  status,
  limit = 50,
}: {
  query?: string;
  status?: string;
  limit?: number;
} = {}): Promise<SupportQueueItem[]> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  let request = supabase
    .from("support_requests")
    .select(
      "id, subject, status, priority, booking_id, dispute_id, payment_proof_id, assigned_admin_id, last_message_sender_type, last_message_at, admin_last_read_at",
    );

  const normalizedStatus = status?.trim();
  if (normalizedStatus && isSupportStatus(normalizedStatus)) {
    request = request.eq("status", normalizedStatus);
  }

  const normalizedQuery = query?.trim();
  if (normalizedQuery) {
    request = request.or(buildSupportSearchFilter(normalizedQuery));
  }

  const { data, error } = await request.order("last_message_at", { ascending: false }).limit(limit);
  if (error) {
    throw error;
  }

  return ((data ?? []) as SupportRow[]).map((row) => ({
    id: row.id,
    subject: row.subject,
    status: row.status,
    priority: row.priority,
    bookingId: row.booking_id,
    disputeId: row.dispute_id,
    paymentProofId: row.payment_proof_id,
    assignedAdminId: row.assigned_admin_id,
    lastMessageSenderType: row.last_message_sender_type,
    lastMessageAt: row.last_message_at,
    hasUnreadForAdmin:
      row.last_message_sender_type === "user" &&
      (!row.admin_last_read_at || new Date(row.last_message_at) > new Date(row.admin_last_read_at)),
  }));
}
