import { buildAdminRoute } from "@/lib/admin-routes";
import { requireServerAdminSession } from "@/lib/auth/require-server-admin-session";
import { getEnumLabel, getUserVerificationLabel } from "@/lib/i18n/admin-ui";
import type { AppLocale } from "@/lib/i18n/config";
import { createSupabaseServerClient } from "@/lib/supabase/server";
import type { GlobalSearchGroup } from "@/lib/queries/admin-types";

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

export async function fetchGlobalSearchGroups({
  locale,
  query,
  includeAdmins,
}: {
  locale: AppLocale | string;
  query?: string;
  includeAdmins?: boolean;
}): Promise<GlobalSearchGroup[]> {
  const trimmed = query?.trim();
  if (!trimmed) {
    return [];
  }

  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const bookingOrId = maybeUuid(trimmed);

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
  ] = await Promise.all([
    supabase
      .from("bookings")
      .select("id, tracking_number, payment_reference, booking_status, payment_status")
      .or(withUuidFilter(trimmed, [`tracking_number.ilike.%${trimmed}%`, `payment_reference.ilike.%${trimmed}%`]))
      .limit(5),
    supabase
      .from("shipments")
      .select("id, description, status")
      .or(withUuidFilter(trimmed, [`description.ilike.%${trimmed}%`]))
      .limit(5),
    supabase
      .from("profiles")
      .select("id, email, full_name, company_name, role, verification_status")
      .neq("role", "admin")
      .or(withUuidFilter(trimmed, [`full_name.ilike.%${trimmed}%`, `company_name.ilike.%${trimmed}%`, `email.ilike.%${trimmed}%`, `phone_number.ilike.%${trimmed}%`]))
      .limit(5),
    supabase
      .from("payment_proofs")
      .select("id, booking_id, submitted_reference, status")
      .or(withUuidFilter(trimmed, [`submitted_reference.ilike.%${trimmed}%`, `booking_id.eq.${bookingOrId}`]))
      .limit(5),
    supabase
      .from("profiles")
      .select("id, email, full_name, company_name, verification_status")
      .eq("role", "carrier")
      .or(withUuidFilter(trimmed, [`full_name.ilike.%${trimmed}%`, `company_name.ilike.%${trimmed}%`, `email.ilike.%${trimmed}%`]))
      .limit(5),
    supabase
      .from("disputes")
      .select("id, booking_id, reason, status")
      .or(withUuidFilter(trimmed, [`reason.ilike.%${trimmed}%`, `booking_id.eq.${bookingOrId}`]))
      .limit(5),
    supabase
      .from("payouts")
      .select("id, booking_id, amount_dzd, status, external_reference")
      .or(withUuidFilter(trimmed, [`external_reference.ilike.%${trimmed}%`, `booking_id.eq.${bookingOrId}`]))
      .limit(5),
    supabase
      .from("support_requests")
      .select("id, subject, status, booking_id")
      .or(withUuidFilter(trimmed, [`subject.ilike.%${trimmed}%`, `booking_id.eq.${bookingOrId}`]))
      .limit(5),
    includeAdmins
      ? supabase
          .from("admin_accounts")
          .select("profile_id, admin_role, profiles:profile_id(full_name,email)")
          .limit(10)
      : Promise.resolve({ data: [], error: null }),
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

  const groups: GlobalSearchGroup[] = [];

  const bookingItems = (bookingsResult.data ?? []).map((booking) => ({
    id: booking.id,
    title: booking.tracking_number,
    subtitle: booking.payment_reference,
    meta: `${getEnumLabel(locale, "booking", booking.booking_status)} • ${getEnumLabel(locale, "payment", booking.payment_status)}`,
    href: buildAdminRoute(locale, "booking", booking.id),
  }));
  if (bookingItems.length) groups.push({ kind: "booking", label: "Bookings", items: bookingItems });

  const shipmentItems = (shipmentsResult.data ?? []).map((shipment) => ({
    id: shipment.id,
    title: shipment.description?.trim() || `Shipment ${shipment.id.slice(0, 8)}`,
    subtitle: shipment.id,
    meta: getEnumLabel(locale, "shipment", shipment.status),
    href: buildAdminRoute(locale, "shipment", shipment.id),
  }));
  if (shipmentItems.length) groups.push({ kind: "shipment", label: "Shipments", items: shipmentItems });

  const userItems = (usersResult.data ?? []).map((profile) => ({
    id: profile.id,
    title: profile.company_name?.trim() || profile.full_name?.trim() || profile.email,
    subtitle: profile.email,
    meta: `${getEnumLabel(locale, "userRoles", profile.role)} • ${getUserVerificationLabel(locale, profile.role, profile.verification_status)}`,
    href: buildAdminRoute(locale, "user", profile.id),
  }));
  if (userItems.length) groups.push({ kind: "user", label: "Users", items: userItems });

  const paymentItems = (paymentsResult.data ?? []).map((proof) => ({
    id: proof.id,
    title: proof.submitted_reference?.trim() || `Payment proof ${proof.id.slice(0, 8)}`,
    subtitle: proof.booking_id,
    meta: getEnumLabel(locale, "payment", proof.status),
    href: buildAdminRoute(locale, "payment", proof.booking_id),
  }));
  if (paymentItems.length) groups.push({ kind: "payment", label: "Payment proofs", items: paymentItems });

  const verificationItems = (carrierProfilesResult.data ?? []).map((profile) => ({
    id: profile.id,
    title: profile.company_name?.trim() || profile.full_name?.trim() || profile.email,
    subtitle: profile.email,
    meta: getUserVerificationLabel(locale, "carrier", profile.verification_status),
    href: buildAdminRoute(locale, "verification", profile.id),
  }));
  if (verificationItems.length) groups.push({ kind: "verification", label: "Verification packets", items: verificationItems });

  const disputeItems = (disputesResult.data ?? []).map((dispute) => ({
    id: dispute.id,
    title: dispute.reason,
    subtitle: dispute.booking_id,
    meta: getEnumLabel(locale, "dispute", dispute.status),
    href: buildAdminRoute(locale, "dispute", dispute.booking_id),
  }));
  if (disputeItems.length) groups.push({ kind: "dispute", label: "Disputes", items: disputeItems });

  const payoutItems = (payoutsResult.data ?? []).map((payout) => ({
    id: payout.id,
    title: payout.external_reference?.trim() || `Payout ${payout.id.slice(0, 8)}`,
    subtitle: payout.booking_id,
    meta: getEnumLabel(locale, "payout", payout.status),
    href: buildAdminRoute(locale, "payout", payout.booking_id),
  }));
  if (payoutItems.length) groups.push({ kind: "payout", label: "Payouts", items: payoutItems });

  const supportItems = (supportResult.data ?? []).map((request) => ({
    id: request.id,
    title: request.subject,
    subtitle: request.booking_id ?? request.id,
    meta: getEnumLabel(locale, "supportStatus", request.status),
    href: buildAdminRoute(locale, "support", request.id),
  }));
  if (supportItems.length) groups.push({ kind: "support", label: "Support", items: supportItems });

  if (includeAdmins) {
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
      groups.push({ kind: "admin", label: "Admins", items: adminItems });
    }
  }

  return groups;
}
