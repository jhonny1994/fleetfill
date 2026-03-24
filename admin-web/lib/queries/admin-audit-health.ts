import { createSupabaseServerClient } from "@/lib/supabase/server";
import type {
  AdminAuditLogItem,
  AuditAndHealthSnapshot,
  EmailDeadLetterItem,
  EmailDeliveryHealthItem,
  PushDeadLetterItem,
} from "@/lib/queries/admin-types";

type AuditRow = {
  id: string;
  action: string;
  target_type: string;
  target_id: string | null;
  outcome: string;
  reason: string | null;
  metadata: Record<string, unknown> | null;
  created_at: string | null;
};

type EmailDeliveryRow = {
  id: string;
  booking_id: string | null;
  recipient_email: string;
  template_key: string;
  status: string;
  provider: string;
  error_code: string | null;
  error_message: string | null;
  created_at: string | null;
  last_attempt_at: string | null;
};

type EmailOutboxRow = {
  id: string;
  booking_id: string | null;
  recipient_email: string;
  template_key: string;
  status: string;
  attempt_count: number;
  max_attempts: number;
  last_error_code: string | null;
  last_error_message: string | null;
  created_at: string | null;
  updated_at: string | null;
};

type PushOutboxRow = {
  id: string;
  profile_id: string;
  event_key: string;
  title: string;
  status: string;
  attempt_count: number;
  max_attempts: number;
  last_error_code: string | null;
  last_error_message: string | null;
  created_at: string | null;
  updated_at: string | null;
};

function mapAuditLog(row: AuditRow): AdminAuditLogItem {
  return {
    id: row.id,
    action: row.action,
    targetType: row.target_type,
    targetId: row.target_id,
    outcome: row.outcome,
    reason: row.reason,
    metadata: row.metadata ?? {},
    createdAt: row.created_at,
  };
}

export async function fetchAuditAndHealthSnapshot(): Promise<AuditAndHealthSnapshot> {
  const supabase = await createSupabaseServerClient();
  const [auditResult, emailDeliveriesResult, deadLettersResult, pushDeadLettersResult] = await Promise.all([
    supabase
      .from("admin_audit_logs")
      .select("id, action, target_type, target_id, outcome, reason, metadata, created_at")
      .order("created_at", { ascending: false })
      .limit(50),
    supabase
      .from("email_delivery_logs")
      .select("id, booking_id, recipient_email, template_key, status, provider, error_code, error_message, created_at, last_attempt_at")
      .order("created_at", { ascending: false })
      .limit(25),
    supabase
      .from("email_outbox_jobs")
      .select("id, booking_id, recipient_email, template_key, status, attempt_count, max_attempts, last_error_code, last_error_message, created_at, updated_at")
      .eq("status", "dead_letter")
      .order("updated_at", { ascending: false })
      .limit(20),
    supabase
      .from("push_outbox_jobs")
      .select("id, profile_id, event_key, title, status, attempt_count, max_attempts, last_error_code, last_error_message, created_at, updated_at")
      .eq("status", "dead_letter")
      .order("updated_at", { ascending: false })
      .limit(12),
  ]);

  if (auditResult.error) throw auditResult.error;
  if (emailDeliveriesResult.error) throw emailDeliveriesResult.error;
  if (deadLettersResult.error) throw deadLettersResult.error;
  if (pushDeadLettersResult.error) throw pushDeadLettersResult.error;

  return {
    auditLogs: ((auditResult.data ?? []) as AuditRow[]).map(mapAuditLog),
    emailDeliveries: ((emailDeliveriesResult.data ?? []) as EmailDeliveryRow[]).map<EmailDeliveryHealthItem>((row) => ({
      id: row.id,
      bookingId: row.booking_id,
      recipientEmail: row.recipient_email,
      templateKey: row.template_key,
      status: row.status,
      provider: row.provider,
      errorCode: row.error_code,
      errorMessage: row.error_message,
      createdAt: row.created_at,
      lastAttemptAt: row.last_attempt_at,
    })),
    deadLetterEmails: ((deadLettersResult.data ?? []) as EmailOutboxRow[]).map<EmailDeadLetterItem>((row) => ({
      id: row.id,
      bookingId: row.booking_id,
      recipientEmail: row.recipient_email,
      templateKey: row.template_key,
      status: row.status,
      attemptCount: row.attempt_count,
      maxAttempts: row.max_attempts,
      lastErrorCode: row.last_error_code,
      lastErrorMessage: row.last_error_message,
      createdAt: row.created_at,
      updatedAt: row.updated_at,
    })),
    deadLetterPushes: ((pushDeadLettersResult.data ?? []) as PushOutboxRow[]).map<PushDeadLetterItem>((row) => ({
      id: row.id,
      profileId: row.profile_id,
      eventKey: row.event_key,
      title: row.title,
      status: row.status,
      attemptCount: row.attempt_count,
      maxAttempts: row.max_attempts,
      lastErrorCode: row.last_error_code,
      lastErrorMessage: row.last_error_message,
      createdAt: row.created_at,
      updatedAt: row.updated_at,
    })),
  };
}
