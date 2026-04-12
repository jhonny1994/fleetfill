import { getIntlLocale, type AppLocale } from "@/lib/i18n/config";

export function formatCompactReference(value: string) {
  if (value.length <= 12) {
    return value;
  }

  return `${value.slice(0, 6)}...${value.slice(-4)}`;
}

export function formatCurrencyDzd(value: number, locale: AppLocale | string = "en-DZ") {
  return new Intl.NumberFormat(getIntlLocale(locale), {
    style: "currency",
    currency: "DZD",
    maximumFractionDigits: 0,
  }).format(value);
}

export function formatDateTime(
  value: string | Date | null | undefined,
  locale: AppLocale | string = "en-DZ",
  emptyValue = "—",
) {
  if (!value) {
    return emptyValue;
  }

  const date = value instanceof Date ? value : new Date(value);
  if (Number.isNaN(date.getTime())) {
    return emptyValue;
  }

  return new Intl.DateTimeFormat(getIntlLocale(locale), {
    dateStyle: "medium",
    timeStyle: "short",
  }).format(date);
}

export function diffHoursFromNow(value: string | Date | null | undefined) {
  if (!value) {
    return 0;
  }

  const date = value instanceof Date ? value : new Date(value);
  if (Number.isNaN(date.getTime())) {
    return 0;
  }

  return Math.max(0, Math.round((Date.now() - date.getTime()) / 3600000));
}

export function formatQueueAge(hours: number, locale: AppLocale | string = "en") {
  const intlLocale = getIntlLocale(locale);
  const number = new Intl.NumberFormat(intlLocale);

  if (hours < 24) {
    return `${number.format(hours)}h`;
  }

  const days = Math.floor(hours / 24);
  const remainingHours = hours % 24;
  return remainingHours === 0
    ? `${number.format(days)}d`
    : `${number.format(days)}d ${number.format(remainingHours)}h`;
}
