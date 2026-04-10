import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";

import { defaultLocale, getLocaleDirection, isSupportedLocale, locales, resolvePreferredLocale } from "@/lib/i18n/config";

export async function proxy(request: NextRequest) {
  const { pathname } = request.nextUrl;

  if (
    pathname.startsWith("/_next") ||
    pathname.startsWith("/api") ||
    pathname.includes(".")
  ) {
    return NextResponse.next();
  }

  const hasLocale = locales.some(
    (locale) => pathname === `/${locale}` || pathname.startsWith(`/${locale}/`),
  );

  if (hasLocale) {
    const localeSegment = pathname.split("/")[1] ?? defaultLocale;
    const locale = isSupportedLocale(localeSegment) ? localeSegment : defaultLocale;
    const requestHeaders = new Headers(request.headers);
    requestHeaders.set("x-fleetfill-locale", locale);
    requestHeaders.set("x-fleetfill-direction", getLocaleDirection(locale));

    let response = NextResponse.next({
      request: {
        headers: requestHeaders,
      },
    });

    const supabase = createServerClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL ?? "",
      process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ?? "",
      {
        cookies: {
          getAll() {
            return request.cookies.getAll();
          },
          setAll(cookiesToSet) {
            cookiesToSet.forEach(({ name, value }) => request.cookies.set(name, value));
            const nextRequestHeaders = new Headers(request.headers);
            nextRequestHeaders.set("x-fleetfill-locale", locale);
            nextRequestHeaders.set("x-fleetfill-direction", getLocaleDirection(locale));
            response = NextResponse.next({
              request: {
                headers: nextRequestHeaders,
              },
            });
            cookiesToSet.forEach(({ name, value, options }) =>
              response.cookies.set(name, value, options),
            );
          },
        },
      },
    );

    await supabase.auth.getUser();
    return response;
  }

  const url = request.nextUrl.clone();
  url.pathname = `/${resolvePreferredLocale(request.headers.get("accept-language"))}${pathname}`;
  return NextResponse.redirect(url);
}

export const config = {
  matcher: ["/((?!_next/static|_next/image|favicon.ico).*)"],
};
