import { requireServerAdminSession } from "@/lib/auth/require-server-admin-session";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import type { BookingWorkspaceDetail, ShipmentWorkspaceDetail } from "@/lib/queries/admin-types";

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
