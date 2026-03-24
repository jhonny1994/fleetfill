import { cache } from "react";

import { createSupabaseServerClient } from "@/lib/supabase/server";

export type AdminSession = {
  userId: string;
  email: string | null;
};

export const getAdminSession = cache(async (): Promise<AdminSession | null> => {
  const supabase = await createSupabaseServerClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return null;
  }

  return {
    userId: user.id,
    email: user.email ?? null,
  };
});
