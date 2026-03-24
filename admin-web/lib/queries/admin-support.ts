import { requireServerAdminSession } from "@/lib/auth/require-server-admin-session";
import { createSupabaseServerClient } from "@/lib/supabase/server";

type SupportRequestRow = {
  id: string;
  subject: string;
  status: string;
  priority: string;
  booking_id: string | null;
  dispute_id: string | null;
  payment_proof_id: string | null;
  assigned_admin_id: string | null;
  last_message_at: string;
};

type SupportMessageRow = {
  id: string;
  request_id: string;
  sender_profile_id: string | null;
  sender_type: string;
  body: string;
  created_at: string;
};

export type AdminSupportDetail = {
  request: SupportRequestRow;
  messages: SupportMessageRow[];
};

export async function fetchSupportDetail(requestId: string): Promise<AdminSupportDetail | null> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const { data: request, error: requestError } = await supabase
    .from("support_requests")
    .select(
      "id, subject, status, priority, booking_id, dispute_id, payment_proof_id, assigned_admin_id, last_message_at",
    )
    .eq("id", requestId)
    .maybeSingle();

  if (requestError) {
    throw requestError;
  }
  if (!request) {
    return null;
  }

  const { data: messages, error: messagesError } = await supabase
    .from("support_messages")
    .select("id, request_id, sender_profile_id, sender_type, body, created_at")
    .eq("request_id", requestId)
    .order("created_at", { ascending: true });

  if (messagesError) {
    throw messagesError;
  }

  return {
    request: request as SupportRequestRow,
    messages: (messages ?? []) as SupportMessageRow[],
  };
}
