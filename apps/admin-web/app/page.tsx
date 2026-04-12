import { headers } from "next/headers";
import { redirect } from "next/navigation";

import { resolveEnabledLocaleForRequest } from "@/lib/i18n/runtime-localization-policy";
import { fetchRuntimeLocalizationPolicy } from "@/lib/queries/admin-settings";

export default async function RootPage() {
  const requestHeaders = await headers();
  const localizationPolicy = await fetchRuntimeLocalizationPolicy();
  const locale = resolveEnabledLocaleForRequest(
    requestHeaders.get("accept-language"),
    localizationPolicy,
  );

  redirect(`/${locale}/sign-in`);
}
