import { headers } from "next/headers";
import { redirect } from "next/navigation";

import { resolvePreferredLocale } from "@/lib/i18n/config";

export default async function RootPage() {
  const requestHeaders = await headers();
  const locale = resolvePreferredLocale(requestHeaders.get("accept-language"));

  redirect(`/${locale}/sign-in`);
}
