import type { AdminDictionary } from "@/lib/i18n/dictionaries";

function inferEnvironmentKind(siteUrl: string | undefined) {
  if (!siteUrl) {
    return "local" as const;
  }

  if (
    siteUrl.includes("localhost") ||
    siteUrl.includes("127.0.0.1") ||
    siteUrl.includes("192.168.") ||
    siteUrl.includes(".local")
  ) {
    return "local" as const;
  }

  if (siteUrl.includes("vercel.app")) {
    return "preview" as const;
  }

  return "production" as const;
}

export function getAdminEnvironmentLabel(dictionary: AdminDictionary) {
  const override = process.env.NEXT_PUBLIC_ADMIN_ENVIRONMENT_LABEL?.trim();
  if (override) {
    return override;
  }

  const kind = inferEnvironmentKind(process.env.NEXT_PUBLIC_SITE_URL);
  switch (kind) {
    case "local":
      return dictionary.shell.environmentLocal;
    case "preview":
      return dictionary.shell.environmentPreview;
    default:
      return dictionary.shell.environmentProduction;
  }
}
