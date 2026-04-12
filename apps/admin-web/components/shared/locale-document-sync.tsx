"use client";

import { useEffect } from "react";

export function LocaleDocumentSync({
  lang,
  dir,
}: {
  lang: string;
  dir: "ltr" | "rtl";
}) {
  useEffect(() => {
    const root = document.documentElement;
    root.lang = lang;
    root.dir = dir;
  }, [dir, lang]);

  return null;
}
