import { buildAdminRoute } from "@/lib/admin-routes";
import { requireServerAdminSession } from "@/lib/auth/require-server-admin-session";
import { getEnumLabel, getUserVerificationLabel } from "@/lib/i18n/admin-ui";
import type { AppLocale } from "@/lib/i18n/config";
import type {
  GlobalSearchGroup,
  GlobalSearchKind,
  GlobalSearchKindFilter,
  GlobalSearchSnapshot,
  GlobalSearchSummary,
} from "@/lib/queries/admin-types";
import { createSupabaseServerClient } from "@/lib/supabase/server";

function isUuidLike(value: string) {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(value.trim());
}

function maybeUuid(value: string) {
  return isUuidLike(value) ? value : "00000000-0000-0000-0000-000000000000";
}

function withUuidFilter(query: string, filters: string[]) {
  if (isUuidLike(query)) {
    filters.push(`id.eq.${query}`);
  }

  return filters.join(",");
}

function clampPage(page: number | undefined) {
  return Number.isFinite(page) && (page ?? 1) > 0 ? Math.floor(page as number) : 1;
}

function pageRange(page: number, pageSize: number) {
  const from = (page - 1) * pageSize;
  return { from, to: from + pageSize - 1 };
}

function toCount(count: number | null | undefined, dataLength: number) {
  return count ?? dataLength;
}

function emptySummary(): GlobalSearchSummary {
  return {
    booking: 0,
    shipment: 0,
    user: 0,
    admin: 0,
    payment: 0,
    verification: 0,
    dispute: 0,
    payout: 0,
    support: 0,
  };
}

function totalFromSummary(summary: GlobalSearchSummary) {
  return Object.values(summary).reduce((total, value) => total + value, 0);
}

function searchLabel(kind: GlobalSearchKind) {
  switch (kind) {
    case "booking":
      return "Bookings";
    case "shipment":
      return "Shipments";
    case "user":
      return "Users";
    case "admin":
      return "Admins";
    case "payment":
      return "Payment proofs";
    case "verification":
      return "Verification packets";
    case "dispute":
      return "Disputes";
    case "payout":
      return "Payouts";
    case "support":
      return "Support";
  }
}

async function fetchBookingPreview(supabase: Awaited<ReturnType<typeof createSupabaseServerClient>>, query: string) {
  return supabase
    .from("bookings")
    .select("id, tracking_number, payment_reference, booking_status, payment_status", { count: "exact" })
    .or(withUuidFilter(query, [`tracking_number.ilike.%${query}%`, `payment_reference.ilike.%${query}%`]))
    .limit(5);
}

async function fetchShipmentPreview(supabase: Awaited<ReturnType<typeof createSupabaseServerClient>>, query: string) {
  return supabase
    .from("shipments")
    .select("id, description, status", { count: "exact" })
    .or(withUuidFilter(query, [`description.ilike.%${query}%`]))
    .limit(5);
}

async function fetchUserPreview(supabase: Awaited<ReturnType<typeof createSupabaseServerClient>>, query: string) {
  return supabase
    .from("profiles")
    .select("id, email, full_name, company_name, role", { count: "exact" })
    .neq("role", "admin")
    .or(
      withUuidFilter(query, [
        `full_name.ilike.%${query}%`,
        `company_name.ilike.%${query}%`,
        `email.ilike.%${query}%`,
        `phone_number.ilike.%${query}%`,
      ]),
    )
    .limit(5);
}

async function fetchPaymentPreview(supabase: Awaited<ReturnType<typeof createSupabaseServerClient>>, query: string) {
  return supabase
    .from("payment_proofs")
    .select("id, booking_id, submitted_reference, status", { count: "exact" })
    .or(withUuidFilter(query, [`submitted_reference.ilike.%${query}%`, `booking_id.eq.${maybeUuid(query)}`]))
    .limit(5);
}

async function fetchVerificationPreview(supabase: Awaited<ReturnType<typeof createSupabaseServerClient>>, query: string) {
  return supabase
    .from("profiles")
    .select("id, email, full_name, company_name", { count: "exact" })
    .eq("role", "carrier")
    .or(withUuidFilter(query, [`full_name.ilike.%${query}%`, `company_name.ilike.%${query}%`, `email.ilike.%${query}%`]))
    .limit(5);
}

async function fetchDisputePreview(supabase: Awaited<ReturnType<typeof createSupabaseServerClient>>, query: string) {
  return supabase
    .from("disputes")
    .select("id, booking_id, reason, status", { count: "exact" })
    .or(withUuidFilter(query, [`reason.ilike.%${query}%`, `booking_id.eq.${maybeUuid(query)}`]))
    .limit(5);
}

async function fetchPayoutPreview(supabase: Awaited<ReturnType<typeof createSupabaseServerClient>>, query: string) {
  return supabase
    .from("payouts")
    .select("id, booking_id, amount_dzd, status, external_reference", { count: "exact" })
    .or(withUuidFilter(query, [`external_reference.ilike.%${query}%`, `booking_id.eq.${maybeUuid(query)}`]))
    .limit(5);
}

async function fetchSupportPreview(supabase: Awaited<ReturnType<typeof createSupabaseServerClient>>, query: string) {
  return supabase
    .from("support_requests")
    .select("id, subject, status, booking_id", { count: "exact" })
    .or(withUuidFilter(query, [`subject.ilike.%${query}%`, `booking_id.eq.${maybeUuid(query)}`]))
    .limit(5);
}

async function fetchAdminPreview(supabase: Awaited<ReturnType<typeof createSupabaseServerClient>>) {
  return supabase
    .from("admin_accounts")
    .select("profile_id, admin_role, profiles:profiles!admin_accounts_profile_id_fkey(full_name,email)", { count: "exact" })
    .limit(10);
}

export async function fetchGlobalSearchPage({
  locale,
  query,
  includeAdmins,
  kind = "all",
  page = 1,
  pageSize = 10,
}: {
  locale: AppLocale | string;
  query?: string;
  includeAdmins?: boolean;
  kind?: GlobalSearchKindFilter;
  page?: number;
  pageSize?: number;
}): Promise<GlobalSearchSnapshot> {
  const trimmed = query?.trim() ?? "";
  const currentPage = clampPage(page);
  if (!trimmed) {
    return {
      query: "",
      kind,
      page: currentPage,
      pageSize,
      totalResults: 0,
      summary: emptySummary(),
      groups: [],
      selectedGroup: null,
    };
  }

  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const shouldIncludeAdmins = includeAdmins ?? false;

  const [
    bookingsResult,
    shipmentsResult,
    usersResult,
    paymentsResult,
    carrierProfilesResult,
    disputesResult,
    payoutsResult,
    supportResult,
    adminsResult,
    selectedResult,
  ] = await Promise.all([
    fetchBookingPreview(supabase, trimmed),
    fetchShipmentPreview(supabase, trimmed),
    fetchUserPreview(supabase, trimmed),
    fetchPaymentPreview(supabase, trimmed),
    fetchVerificationPreview(supabase, trimmed),
    fetchDisputePreview(supabase, trimmed),
    fetchPayoutPreview(supabase, trimmed),
    fetchSupportPreview(supabase, trimmed),
    shouldIncludeAdmins ? fetchAdminPreview(supabase) : Promise.resolve({ data: [], error: null, count: 0 }),
    kind !== "all"
      ? fetchSelectedSearchPage(supabase, kind, trimmed, currentPage, pageSize, locale, shouldIncludeAdmins)
      : Promise.resolve(null),
  ]);

  if (bookingsResult.error) throw bookingsResult.error;
  if (shipmentsResult.error) throw shipmentsResult.error;
  if (usersResult.error) throw usersResult.error;
  if (paymentsResult.error) throw paymentsResult.error;
  if (carrierProfilesResult.error) throw carrierProfilesResult.error;
  if (disputesResult.error) throw disputesResult.error;
  if (payoutsResult.error) throw payoutsResult.error;
  if (supportResult.error) throw supportResult.error;
  if (adminsResult.error) throw adminsResult.error;
  const userCarrierIds = ((usersResult.data ?? []) as Array<{ id: string; role: string }>)
    .filter((profile) => profile.role === "carrier")
    .map((profile) => profile.id);
  const verificationCarrierIds = ((carrierProfilesResult.data ?? []) as Array<{ id: string }>).map((profile) => profile.id);
  const carrierPacketIds = [...new Set([...userCarrierIds, ...verificationCarrierIds])];
  const { data: carrierPackets, error: carrierPacketsError } = carrierPacketIds.length
    ? await supabase
        .from("carrier_verification_packets")
        .select("carrier_id, status")
        .in("carrier_id", carrierPacketIds)
    : { data: [], error: null };

  if (carrierPacketsError) throw carrierPacketsError;

  const carrierPacketMap = new Map<string, string>(
    ((carrierPackets ?? []) as Array<{ carrier_id: string; status: string }>).map((packet) => [packet.carrier_id, packet.status]),
  );

  const summary = emptySummary();
  summary.booking = toCount(bookingsResult.count, bookingsResult.data?.length ?? 0);
  summary.shipment = toCount(shipmentsResult.count, shipmentsResult.data?.length ?? 0);
  summary.user = toCount(usersResult.count, usersResult.data?.length ?? 0);
  summary.payment = toCount(paymentsResult.count, paymentsResult.data?.length ?? 0);
  summary.verification = toCount(carrierProfilesResult.count, carrierProfilesResult.data?.length ?? 0);
  summary.dispute = toCount(disputesResult.count, disputesResult.data?.length ?? 0);
  summary.payout = toCount(payoutsResult.count, payoutsResult.data?.length ?? 0);
  summary.support = toCount(supportResult.count, supportResult.data?.length ?? 0);
  summary.admin = shouldIncludeAdmins ? toCount(adminsResult.count, adminsResult.data?.length ?? 0) : 0;

  const groups: GlobalSearchGroup[] = [];

  const bookingItems = (bookingsResult.data ?? []).map((booking) => ({
    id: booking.id,
    title: booking.tracking_number,
    subtitle: booking.payment_reference,
    meta: `${getEnumLabel(locale, "booking", booking.booking_status)} • ${getEnumLabel(locale, "payment", booking.payment_status)}`,
    href: buildAdminRoute(locale, "booking", booking.id),
  }));
  if (bookingItems.length) groups.push({ kind: "booking", label: searchLabel("booking"), total: summary.booking, items: bookingItems });

  const shipmentItems = (shipmentsResult.data ?? []).map((shipment) => ({
    id: shipment.id,
    title: shipment.description?.trim() || `Shipment ${shipment.id.slice(0, 8)}`,
    subtitle: shipment.id,
    meta: getEnumLabel(locale, "shipment", shipment.status),
    href: buildAdminRoute(locale, "shipment", shipment.id),
  }));
  if (shipmentItems.length) groups.push({ kind: "shipment", label: searchLabel("shipment"), total: summary.shipment, items: shipmentItems });

  const userItems = (usersResult.data ?? []).map((profile) => ({
    id: profile.id,
    title: profile.company_name?.trim() || profile.full_name?.trim() || profile.email,
    subtitle: profile.email,
    meta:
      profile.role === "carrier"
        ? `${getEnumLabel(locale, "userRoles", profile.role)} • ${getUserVerificationLabel(locale, profile.role, carrierPacketMap.get(profile.id) ?? "pending")}`
        : getEnumLabel(locale, "userRoles", profile.role),
    href: buildAdminRoute(locale, "user", profile.id),
  }));
  if (userItems.length) groups.push({ kind: "user", label: searchLabel("user"), total: summary.user, items: userItems });

  const paymentItems = (paymentsResult.data ?? []).map((proof) => ({
    id: proof.id,
    title: proof.submitted_reference?.trim() || `Payment proof ${proof.id.slice(0, 8)}`,
    subtitle: proof.booking_id,
    meta: getEnumLabel(locale, "payment", proof.status),
    href: buildAdminRoute(locale, "payment", proof.booking_id),
  }));
  if (paymentItems.length) groups.push({ kind: "payment", label: searchLabel("payment"), total: summary.payment, items: paymentItems });

  const verificationItems = ((carrierProfilesResult.data ?? []) as Array<{
    id: string;
    email: string | null;
    full_name: string | null;
    company_name: string | null;
  }>).map((profile) => {
    return {
      id: profile.id,
      title: profile.company_name?.trim() || profile.full_name?.trim() || profile.email?.trim() || profile.id,
      subtitle: profile.email ?? profile.id,
      meta: getUserVerificationLabel(locale, "carrier", carrierPacketMap.get(profile.id) ?? "pending"),
      href: buildAdminRoute(locale, "verification", profile.id),
    };
  });
  if (verificationItems.length) groups.push({ kind: "verification", label: searchLabel("verification"), total: summary.verification, items: verificationItems });

  const disputeItems = (disputesResult.data ?? []).map((dispute) => ({
    id: dispute.id,
    title: dispute.reason,
    subtitle: dispute.booking_id,
    meta: getEnumLabel(locale, "dispute", dispute.status),
    href: buildAdminRoute(locale, "dispute", dispute.booking_id),
  }));
  if (disputeItems.length) groups.push({ kind: "dispute", label: searchLabel("dispute"), total: summary.dispute, items: disputeItems });

  const payoutItems = (payoutsResult.data ?? []).map((payout) => ({
    id: payout.id,
    title: payout.external_reference?.trim() || `Payout ${payout.id.slice(0, 8)}`,
    subtitle: payout.booking_id,
    meta: getEnumLabel(locale, "payout", payout.status),
    href: buildAdminRoute(locale, "payout", payout.booking_id),
  }));
  if (payoutItems.length) groups.push({ kind: "payout", label: searchLabel("payout"), total: summary.payout, items: payoutItems });

  const supportItems = (supportResult.data ?? []).map((request) => ({
    id: request.id,
    title: request.subject,
    subtitle: request.booking_id ?? request.id,
    meta: getEnumLabel(locale, "supportStatus", request.status),
    href: buildAdminRoute(locale, "support", request.id),
  }));
  if (supportItems.length) groups.push({ kind: "support", label: searchLabel("support"), total: summary.support, items: supportItems });

  if (shouldIncludeAdmins) {
    const adminItems = ((adminsResult.data ?? []) as Array<{
      profile_id: string;
      admin_role: string;
      profiles: { full_name: string | null; email: string | null } | { full_name: string | null; email: string | null }[] | null;
    }>)
      .map((row) => {
        const profile = Array.isArray(row.profiles) ? row.profiles[0] : row.profiles;
        return {
          id: row.profile_id,
          title: profile?.full_name?.trim() || profile?.email?.trim() || row.profile_id,
          subtitle: profile?.email ?? row.profile_id,
          meta: getEnumLabel(locale, "adminRoles", row.admin_role),
          href: buildAdminRoute(locale, "admin", row.profile_id),
        };
      })
      .filter((item) => `${item.title} ${item.subtitle} ${item.meta}`.toLowerCase().includes(trimmed.toLowerCase()))
      .slice(0, 5);

    if (adminItems.length) {
      groups.push({ kind: "admin", label: searchLabel("admin"), total: summary.admin, items: adminItems });
    }
  }

  return {
    query: trimmed,
    kind,
    page: currentPage,
    pageSize,
    totalResults: totalFromSummary(summary),
    summary,
    groups,
    selectedGroup: selectedResult,
  };
}

async function fetchSelectedSearchPage(
  supabase: Awaited<ReturnType<typeof createSupabaseServerClient>>,
  kind: GlobalSearchKindFilter,
  query: string,
  page: number,
  pageSize: number,
  locale: AppLocale | string,
  includeAdmins: boolean,
): Promise<GlobalSearchGroup | null> {
  const { from, to } = pageRange(page, pageSize);

  switch (kind) {
    case "booking": {
      const result = await supabase
        .from("bookings")
        .select("id, tracking_number, payment_reference, booking_status, payment_status", { count: "exact" })
        .or(withUuidFilter(query, [`tracking_number.ilike.%${query}%`, `payment_reference.ilike.%${query}%`]))
        .range(from, to);
      if (result.error) throw result.error;
      return {
        kind,
        label: searchLabel(kind),
        total: toCount(result.count, result.data?.length ?? 0),
        items: ((result.data ?? []) as Array<{
          id: string;
          tracking_number: string;
          payment_reference: string;
          booking_status: string;
          payment_status: string;
        }>).map((booking) => ({
          id: booking.id,
          title: booking.tracking_number,
          subtitle: booking.payment_reference,
          meta: `${getEnumLabel(locale, "booking", booking.booking_status)} • ${getEnumLabel(locale, "payment", booking.payment_status)}`,
          href: buildAdminRoute(locale, "booking", booking.id),
        })),
      } satisfies GlobalSearchGroup;
    }
    case "shipment": {
      const result = await supabase
        .from("shipments")
        .select("id, description, status", { count: "exact" })
        .or(withUuidFilter(query, [`description.ilike.%${query}%`]))
        .range(from, to);
      if (result.error) throw result.error;
      return {
        kind,
        label: searchLabel(kind),
        total: toCount(result.count, result.data?.length ?? 0),
        items: ((result.data ?? []) as Array<{ id: string; description: string | null; status: string }>).map((shipment) => ({
          id: shipment.id,
          title: shipment.description?.trim() || `Shipment ${shipment.id.slice(0, 8)}`,
          subtitle: shipment.id,
          meta: getEnumLabel(locale, "shipment", shipment.status),
          href: buildAdminRoute(locale, "shipment", shipment.id),
        })),
      } satisfies GlobalSearchGroup;
    }
    case "user": {
      const result = await supabase
        .from("profiles")
        .select("id, email, full_name, company_name, role", { count: "exact" })
        .neq("role", "admin")
        .or(
          withUuidFilter(query, [
            `full_name.ilike.%${query}%`,
            `company_name.ilike.%${query}%`,
            `email.ilike.%${query}%`,
            `phone_number.ilike.%${query}%`,
          ]),
        )
        .range(from, to);
      if (result.error) throw result.error;
      const carrierIds = ((result.data ?? []) as Array<{ id: string; role: string }>).filter((profile) => profile.role === "carrier").map((profile) => profile.id);
      const { data: carrierPackets, error: carrierPacketsError } = carrierIds.length
        ? await supabase.from("carrier_verification_packets").select("carrier_id, status").in("carrier_id", carrierIds)
        : { data: [], error: null };
      if (carrierPacketsError) throw carrierPacketsError;
      const carrierPacketMap = new Map<string, string>(
        ((carrierPackets ?? []) as Array<{ carrier_id: string; status: string }>).map((packet) => [packet.carrier_id, packet.status]),
      );
      return {
        kind,
        label: searchLabel(kind),
        total: toCount(result.count, result.data?.length ?? 0),
        items: ((result.data ?? []) as Array<{
          id: string;
          email: string;
          full_name: string | null;
          company_name: string | null;
          role: string;
        }>).map((profile) => ({
          id: profile.id,
          title: profile.company_name?.trim() || profile.full_name?.trim() || profile.email,
          subtitle: profile.email,
          meta:
            profile.role === "carrier"
              ? `${getEnumLabel(locale, "userRoles", profile.role)} • ${getUserVerificationLabel(locale, profile.role, carrierPacketMap.get(profile.id) ?? "pending")}`
              : getEnumLabel(locale, "userRoles", profile.role),
          href: buildAdminRoute(locale, "user", profile.id),
        })),
      } satisfies GlobalSearchGroup;
    }
    case "payment": {
      const result = await supabase
        .from("payment_proofs")
        .select("id, booking_id, submitted_reference, status", { count: "exact" })
        .or(withUuidFilter(query, [`submitted_reference.ilike.%${query}%`, `booking_id.eq.${maybeUuid(query)}`]))
        .range(from, to);
      if (result.error) throw result.error;
      return {
        kind,
        label: searchLabel(kind),
        total: toCount(result.count, result.data?.length ?? 0),
        items: ((result.data ?? []) as Array<{ id: string; booking_id: string; submitted_reference: string | null; status: string }>).map((proof) => ({
          id: proof.id,
          title: proof.submitted_reference?.trim() || `Payment proof ${proof.id.slice(0, 8)}`,
          subtitle: proof.booking_id,
          meta: getEnumLabel(locale, "payment", proof.status),
          href: buildAdminRoute(locale, "payment", proof.booking_id),
        })),
      } satisfies GlobalSearchGroup;
    }
    case "verification": {
      const result = await supabase
        .from("profiles")
        .select("id, email, full_name, company_name", { count: "exact" })
        .eq("role", "carrier")
        .or(withUuidFilter(query, [`full_name.ilike.%${query}%`, `company_name.ilike.%${query}%`, `email.ilike.%${query}%`]))
        .range(from, to);
      if (result.error) throw result.error;
      const carrierIds = ((result.data ?? []) as Array<{ id: string }>).map((profile) => profile.id);
      const { data: carrierPackets, error: carrierPacketsError } = carrierIds.length
        ? await supabase.from("carrier_verification_packets").select("carrier_id, status").in("carrier_id", carrierIds)
        : { data: [], error: null };
      if (carrierPacketsError) throw carrierPacketsError;
      const carrierPacketMap = new Map<string, string>(
        ((carrierPackets ?? []) as Array<{ carrier_id: string; status: string }>).map((packet) => [packet.carrier_id, packet.status]),
      );
      return {
        kind,
        label: searchLabel(kind),
        total: toCount(result.count, result.data?.length ?? 0),
        items: ((result.data ?? []) as Array<{
          id: string;
          email: string | null;
          full_name: string | null;
          company_name: string | null;
        }>).map((profile) => ({
          id: profile.id,
          title: profile.company_name?.trim() || profile.full_name?.trim() || profile.email?.trim() || profile.id,
          subtitle: profile.email ?? profile.id,
          meta: getUserVerificationLabel(locale, "carrier", carrierPacketMap.get(profile.id) ?? "pending"),
          href: buildAdminRoute(locale, "verification", profile.id),
        })),
      } satisfies GlobalSearchGroup;
    }
    case "dispute": {
      const result = await supabase
        .from("disputes")
        .select("id, booking_id, reason, status", { count: "exact" })
        .or(withUuidFilter(query, [`reason.ilike.%${query}%`, `booking_id.eq.${maybeUuid(query)}`]))
        .range(from, to);
      if (result.error) throw result.error;
      return {
        kind,
        label: searchLabel(kind),
        total: toCount(result.count, result.data?.length ?? 0),
        items: ((result.data ?? []) as Array<{ id: string; booking_id: string; reason: string; status: string }>).map((dispute) => ({
          id: dispute.id,
          title: dispute.reason,
          subtitle: dispute.booking_id,
          meta: getEnumLabel(locale, "dispute", dispute.status),
          href: buildAdminRoute(locale, "dispute", dispute.booking_id),
        })),
      } satisfies GlobalSearchGroup;
    }
    case "payout": {
      const result = await supabase
        .from("payouts")
        .select("id, booking_id, amount_dzd, status, external_reference", { count: "exact" })
        .or(withUuidFilter(query, [`external_reference.ilike.%${query}%`, `booking_id.eq.${maybeUuid(query)}`]))
        .range(from, to);
      if (result.error) throw result.error;
      return {
        kind,
        label: searchLabel(kind),
        total: toCount(result.count, result.data?.length ?? 0),
        items: ((result.data ?? []) as Array<{ id: string; booking_id: string; amount_dzd: number; status: string; external_reference: string | null }>).map((payout) => ({
          id: payout.id,
          title: payout.external_reference?.trim() || `Payout ${payout.id.slice(0, 8)}`,
          subtitle: payout.booking_id,
          meta: getEnumLabel(locale, "payout", payout.status),
          href: buildAdminRoute(locale, "payout", payout.booking_id),
        })),
      } satisfies GlobalSearchGroup;
    }
    case "support": {
      const result = await supabase
        .from("support_requests")
        .select("id, subject, status, booking_id", { count: "exact" })
        .or(withUuidFilter(query, [`subject.ilike.%${query}%`, `booking_id.eq.${maybeUuid(query)}`]))
        .range(from, to);
      if (result.error) throw result.error;
      return {
        kind,
        label: searchLabel(kind),
        total: toCount(result.count, result.data?.length ?? 0),
        items: ((result.data ?? []) as Array<{ id: string; subject: string; status: string; booking_id: string | null }>).map((request) => ({
          id: request.id,
          title: request.subject,
          subtitle: request.booking_id ?? request.id,
          meta: getEnumLabel(locale, "supportStatus", request.status),
          href: buildAdminRoute(locale, "support", request.id),
        })),
      } satisfies GlobalSearchGroup;
    }
    case "admin": {
      if (!includeAdmins) {
        return {
          kind,
          label: searchLabel(kind),
          total: 0,
          items: [],
        } satisfies GlobalSearchGroup;
      }

      const result = await supabase
        .from("admin_accounts")
        .select("profile_id, admin_role, profiles:profiles!admin_accounts_profile_id_fkey(full_name,email)", { count: "exact" })
        .range(from, to);
      if (result.error) throw result.error;
      return {
        kind,
        label: searchLabel(kind),
        total: toCount(result.count, result.data?.length ?? 0),
        items: ((result.data ?? []) as Array<{
          profile_id: string;
          admin_role: string;
          profiles: { full_name: string | null; email: string | null } | { full_name: string | null; email: string | null }[] | null;
        }>).map((row) => {
          const profile = Array.isArray(row.profiles) ? row.profiles[0] : row.profiles;
          return {
            id: row.profile_id,
            title: profile?.full_name?.trim() || profile?.email?.trim() || row.profile_id,
            subtitle: profile?.email ?? row.profile_id,
            meta: getEnumLabel(locale, "adminRoles", row.admin_role),
            href: buildAdminRoute(locale, "admin", row.profile_id),
          };
        }),
      } satisfies GlobalSearchGroup;
    }
  }

  return null;
}
