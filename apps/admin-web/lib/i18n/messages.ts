import type { AppLocale } from "@/lib/i18n/config";

const localeMessageLoaders: Record<AppLocale, () => Promise<{ default: Record<string, unknown> }>> = {
  ar: () => import("@/messages/ar"),
  fr: () => import("@/messages/fr"),
  en: () => import("@/messages/en"),
};

export async function getMessagesForLocale(locale: AppLocale) {
  return (await localeMessageLoaders[locale]()).default;
}

type AdminMessages = {
  dictionary: typeof import("@/messages/en").default.dictionary;
  ui: typeof import("@/messages/en").default.ui;
};

export function asAdminMessages(messages: Record<string, unknown>): AdminMessages {
  return messages as AdminMessages;
}
