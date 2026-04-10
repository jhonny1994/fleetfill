import type { AppLocale } from "@/lib/i18n/config";

type SearchEntityKind =
  | "booking"
  | "shipment"
  | "user"
  | "admin"
  | "payment"
  | "verification"
  | "dispute"
  | "payout"
  | "support";

export function buildAdminRoute(locale: AppLocale | string, kind: SearchEntityKind, id: string) {
  switch (kind) {
    case "booking":
      return `/${locale}/bookings/${id}`;
    case "shipment":
      return `/${locale}/shipments/${id}`;
    case "user":
      return `/${locale}/users/${id}`;
    case "admin":
      return `/${locale}/admins/${id}`;
    case "payment":
      return `/${locale}/payments/${id}`;
    case "verification":
      return `/${locale}/verification/${id}`;
    case "dispute":
      return `/${locale}/disputes/${id}`;
    case "payout":
      return `/${locale}/payouts/${id}`;
    case "support":
      return `/${locale}/support/${id}`;
  }
}
