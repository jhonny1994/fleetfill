import { redirect } from "next/navigation";

import { getAdminSession } from "@/lib/auth/get-admin-session";
import { isSupportedLocale, type AppLocale } from "@/lib/i18n/config";

export default async function LocalizedIndexPage({
  params,
}: {
  params: Promise<{ lang: string }>;
}) {
  const { lang } = await params;
  const locale = (isSupportedLocale(lang) ? lang : "ar") as AppLocale;
  const session = await getAdminSession();

  redirect(`/${locale}/${session ? "dashboard" : "sign-in"}`);
}
