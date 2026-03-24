import type { AppLocale } from "@/lib/i18n/config";

const dictionaries = {
  ar: {
    appTitle: "لوحة تشغيل FleetFill",
    signInTitle: "تسجيل دخول الإدارة",
    signInBody: "الوصول الداخلي فقط. استخدم حساب إدارة تمت دعوته مسبقا.",
  },
  fr: {
    appTitle: "Console FleetFill",
    signInTitle: "Connexion admin",
    signInBody: "Acces interne uniquement. Utilisez un compte admin deja invite.",
  },
  en: {
    appTitle: "FleetFill Admin",
    signInTitle: "Admin sign in",
    signInBody: "Internal access only. Use an already invited admin account.",
  },
} as const;

export async function getDictionary(locale: AppLocale) {
  return dictionaries[locale];
}
