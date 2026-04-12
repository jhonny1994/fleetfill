"use client";

import { useMessages } from "next-intl";

import { asAdminMessages } from "@/lib/i18n/messages";

function useAdminMessages() {
  return asAdminMessages(useMessages() as Record<string, unknown>);
}

export function useAdminDictionary() {
  return useAdminMessages().dictionary;
}

export function useAdminUi() {
  return useAdminMessages().ui;
}
