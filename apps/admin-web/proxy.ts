import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";

import { defaultLocale, getLocaleDirection, isSupportedLocale, locales } from "@/lib/i18n/config";
import {
  buildLocalizedPath,
  resolveEnabledLocaleForRequest,
  resolveRuntimeLocalizationPolicy,
} from "@/lib/i18n/runtime-localization-policy";

export async function proxy(request: NextRequest) {
  const { pathname } = request.nextUrl;
  const bypassLocalizedRouting = pathname === "/auth/mobile-callback";

  if (
    bypassLocalizedRouting ||
    pathname.startsWith("/_next") ||
    pathname.startsWith("/api") ||
    pathname.includes(".")
  ) {
    return NextResponse.next();
  }

  const hasLocale = locales.some(
    (locale) => pathname === `/${locale}` || pathname.startsWith(`/${locale}/`),
  );

  const localeSegment = pathname.split("/")[1] ?? defaultLocale;
  const requestedLocale = isSupportedLocale(localeSegment) ? localeSegment : defaultLocale;

  const baseRequestHeaders = new Headers(request.headers);
  baseRequestHeaders.set("x-fleetfill-pathname", pathname);
  baseRequestHeaders.set("x-fleetfill-search", request.nextUrl.search);

  let response = NextResponse.next({
    request: {
      headers: baseRequestHeaders,
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
          nextRequestHeaders.set("x-fleetfill-pathname", pathname);
          nextRequestHeaders.set("x-fleetfill-search", request.nextUrl.search);
          if (hasLocale) {
            nextRequestHeaders.set("x-fleetfill-locale", requestedLocale);
            nextRequestHeaders.set("x-fleetfill-direction", getLocaleDirection(requestedLocale));
          }
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

  const [{ data: localizationSettings }, authResult] = await Promise.all([
    supabase.from("platform_settings").select("value").eq("key", "localization").maybeSingle(),
    supabase.auth.getUser(),
  ]);
  void authResult;

  const localizationPolicy = resolveRuntimeLocalizationPolicy(
    (localizationSettings?.value ?? {}) as Record<string, unknown>,
  );

  if (hasLocale) {
    if (!localizationPolicy.enabledLocales.includes(requestedLocale)) {
      const url = request.nextUrl.clone();
      url.pathname = buildLocalizedPath(
        pathname,
        requestedLocale,
        localizationPolicy.fallbackLocale,
        request.nextUrl.search,
      );
      return NextResponse.redirect(url);
    }

    const requestHeaders = new Headers(request.headers);
    requestHeaders.set("x-fleetfill-locale", requestedLocale);
    requestHeaders.set("x-fleetfill-direction", getLocaleDirection(requestedLocale));
    requestHeaders.set("x-fleetfill-pathname", pathname);
    requestHeaders.set("x-fleetfill-search", request.nextUrl.search);

    response = NextResponse.next({
      request: {
        headers: requestHeaders,
      },
    });
    return response;
  }

  const locale = resolveEnabledLocaleForRequest(
    request.headers.get("accept-language"),
    localizationPolicy,
  );
  const url = request.nextUrl.clone();
  url.pathname = buildLocalizedPath(pathname, defaultLocale, locale, request.nextUrl.search);
  return NextResponse.redirect(url);
}

export const config = {
  matcher: ["/((?!_next/static|_next/image|favicon.ico).*)"],
};
