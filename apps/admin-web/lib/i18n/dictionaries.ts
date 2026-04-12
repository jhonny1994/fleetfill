import arMessages from "@/messages/ar";
import enMessages from "@/messages/en";
import frMessages from "@/messages/fr";

import type { AppLocale } from "@/lib/i18n/config";

export const dictionaries = {
  ar: arMessages.dictionary,
  fr: frMessages.dictionary,
  en: enMessages.dictionary,
} as const;

export type AdminDictionary = (typeof dictionaries)[AppLocale];
