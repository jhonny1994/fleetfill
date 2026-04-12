import arMessages from "@/messages/ar";
import enMessages from "@/messages/en";
import frMessages from "@/messages/fr";

import type { AppLocale } from "@/lib/i18n/config";
import { defaultLocale, isSupportedLocale } from "@/lib/i18n/config";

const messageCatalog = {
  ar: arMessages,
  fr: frMessages,
  en: enMessages,
} as const;

export const adminUiMessages = {
  ar: messageCatalog.ar.ui,
  fr: messageCatalog.fr.ui,
  en: messageCatalog.en.ui,
} as const;

export type AdminUi = (typeof adminUiMessages)[AppLocale];

function localeOf(locale: string | AppLocale): AppLocale {
  return isSupportedLocale(locale) ? locale : defaultLocale;
}

function humanize(value: string) {
  return value.replace(/_/g, " ").replace(/\b\w/g, (letter) => letter.toUpperCase());
}

function getAdminUi(locale: string | AppLocale) {
  return adminUiMessages[localeOf(locale)];
}

export function formatTemplate(template: string, values: Record<string, string | number | null | undefined>) {
  return template.replace(/\{(\w+)\}/g, (_, key: string) => String(values[key] ?? ""));
}

export function getEnumLabel(
  locale: string | AppLocale,
  group: keyof (typeof adminUiMessages)["en"]["enums"],
  value: string | null | undefined,
) {
  if (!value) {
    return getAdminUi(locale).labels.none;
  }

  const labels = getAdminUi(locale).enums[group] as Record<string, string>;
  return labels[value.toLowerCase()] ?? humanize(value);
}

export function getTimelineEventLabel(locale: string | AppLocale, value: string | null | undefined) {
  if (!value) {
    return getAdminUi(locale).labels.none;
  }

  const labels = getAdminUi(locale).timelineEventLabels as Record<string, string>;
  return labels[value.toLowerCase()] ?? humanize(value);
}

export function getPayoutRequestLabel(locale: string | AppLocale, value: string | null | undefined) {
  const labels = getAdminUi(locale).payoutRequestLabels as Record<string, string>;

  if (!value) {
    return labels.not_requested;
  }

  return labels[value.toLowerCase()] ?? humanize(value);
}

export function getPayoutRequestBlockedReasonLabel(locale: string | AppLocale, value: string | null | undefined) {
  if (!value) {
    return null;
  }

  const labels = getAdminUi(locale).payoutRequestLabels as Record<string, string>;
  return labels[value.toLowerCase()] ?? humanize(value);
}

export function getAdminRoleLabel(locale: string | AppLocale, value: string | null | undefined) {
  return getEnumLabel(locale, "adminRoles", value);
}

export function getDocumentLabel(locale: string | AppLocale, value: string | null | undefined) {
  return getEnumLabel(locale, "document", value);
}

export function getUserVerificationLabel(
  locale: string | AppLocale,
  role: string | null | undefined,
  value: string | null | undefined,
) {
  if (!role || role.toLowerCase() !== "carrier") {
    return getAdminUi(locale).labels.notApplicable;
  }

  return getEnumLabel(locale, "verification", value);
}

export function getAdminDetailCopy(locale: string | AppLocale) {
  return getAdminUi(locale).detail;
}

export function getAdminActionLabel(locale: string | AppLocale, value: string | null | undefined) {
  if (!value) {
    return getAdminUi(locale).labels.none;
  }

  const labels = getAdminUi(locale).actionLabels as Record<string, string>;
  return labels[value] ?? humanize(value);
}

export function getAuditTargetTypeLabel(locale: string | AppLocale, value: string | null | undefined) {
  if (!value) {
    return getAdminUi(locale).labels.none;
  }

  const labels = getAdminUi(locale).auditTargetTypeLabels as Record<string, string>;
  return labels[value.toLowerCase()] ?? humanize(value);
}

export function getAuditOutcomeLabel(locale: string | AppLocale, value: string | null | undefined) {
  if (!value) {
    return getAdminUi(locale).labels.none;
  }

  const labels = getAdminUi(locale).auditOutcomeLabels as Record<string, string>;
  return labels[value.toLowerCase()] ?? humanize(value);
}

export function getNotificationTemplateLabel(locale: string | AppLocale, value: string | null | undefined) {
  if (!value) {
    return getAdminUi(locale).labels.none;
  }

  const labels = getAdminUi(locale).notificationTemplateLabels as Record<string, string>;
  return labels[value.toLowerCase()] ?? humanize(value);
}

export function getAuditHealthErrorLabel(
  locale: string | AppLocale,
  errorCode: string | null | undefined,
  errorMessage: string | null | undefined,
) {
  const labels = getAdminUi(locale).healthErrorLabels as Record<string, string>;
  const normalizedCode = errorCode?.toLowerCase() ?? "";
  const normalizedMessage = errorMessage?.toLowerCase() ?? "";

  if (normalizedMessage.includes("firebase_service_account_json is not valid json")) {
    return labels.firebase_service_account_invalid;
  }

  if (normalizedCode === "unknown_push_error") {
    return labels.unknown_push_error;
  }

  return errorMessage ?? errorCode ?? getAdminUi(locale).labels.noProviderMessage;
}

export function getSupportMessageTitle(locale: string | AppLocale, sender: string | null | undefined) {
  return formatTemplate(getAdminUi(locale).support.messageTitle, {
    sender: getEnumLabel(locale, "sender", sender),
  });
}

export function getSupportMessagePreview(locale: string | AppLocale, body: string | null | undefined) {
  const supportCopy = getAdminUi(locale).support;
  const preview = body?.replace(/\s+/g, " ").trim().slice(0, 140);

  if (!preview) {
    return supportCopy.emptyMessagePreview;
  }

  return formatTemplate(supportCopy.messagePreviewLabel, { preview });
}

export function getSupportUiCopy(locale: string | AppLocale) {
  return getAdminUi(locale).support;
}

export function getAdminActionErrorMessage(
  ui: AdminUi,
  errorMessage: string | null | undefined,
  errorCode?: string | null | undefined,
) {
  const normalizedCode = errorCode?.toLowerCase() ?? "";
  const normalizedMessage = errorMessage?.toLowerCase() ?? "";
  const labels = ui.actionErrors;

  if (
    normalizedMessage.includes("failed to fetch") ||
    normalizedMessage.includes("network") ||
    normalizedMessage.includes("fetcherror")
  ) {
    return labels.network;
  }

  if (normalizedMessage.includes("timeout") || normalizedMessage.includes("timed out")) {
    return labels.timeout;
  }

  if (
    normalizedCode === "403" ||
    normalizedMessage.includes("permission denied") ||
    normalizedMessage.includes("forbidden") ||
    normalizedMessage.includes("not allowed") ||
    normalizedMessage.includes("not authorized") ||
    normalizedMessage.includes("unauthorized")
  ) {
    return labels.forbidden;
  }

  if (
    normalizedCode === "404" ||
    normalizedMessage.includes("not found") ||
    normalizedMessage.includes("does not exist")
  ) {
    return labels.notFound;
  }

  if (
    normalizedCode === "409" ||
    normalizedMessage.includes("already exists") ||
    normalizedMessage.includes("already been") ||
    normalizedMessage.includes("already processed") ||
    normalizedMessage.includes("conflict")
  ) {
    return labels.conflict;
  }

  if (
    normalizedCode === "400" ||
    normalizedCode === "422" ||
    normalizedMessage.includes("invalid") ||
    normalizedMessage.includes("required") ||
    normalizedMessage.includes("constraint") ||
    normalizedMessage.includes("violates")
  ) {
    return labels.validation;
  }

  return labels.generic;
}
