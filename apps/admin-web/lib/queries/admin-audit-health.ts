import { requireServerAdminSession } from "@/lib/auth/require-server-admin-session";
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

function clampPage(page: number | undefined) {
  return Number.isFinite(page) && (page ?? 1) > 0 ? Math.floor(page as number) : 1;
}

function pageRange(page: number, pageSize: number) {
  const from = (page - 1) * pageSize;
  return { from, to: from + pageSize - 1 };
}

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

function mapEmailDelivery(row: EmailDeliveryRow): EmailDeliveryHealthItem {
  return {
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
  };
}

function mapDeadLetterEmail(row: EmailOutboxRow): EmailDeadLetterItem {
  return {
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
  };
}

function mapDeadLetterPush(row: PushOutboxRow): PushDeadLetterItem {
  return {
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
  };
}

export async function fetchAuditAndHealthSnapshot(): Promise<AuditAndHealthSnapshot> {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const [
    auditResult,
    emailDeliveriesResult,
    deadLettersResult,
    pushDeadLettersResult,
    auditCountResult,
    emailCountResult,
    deadLetterEmailCountResult,
    deadLetterPushCountResult,
  ] = await Promise.all([
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
    supabase.from("admin_audit_logs").select("id", { count: "exact", head: true }),
    supabase.from("email_delivery_logs").select("id", { count: "exact", head: true }),
    supabase.from("email_outbox_jobs").select("id", { count: "exact", head: true }).eq("status", "dead_letter"),
    supabase.from("push_outbox_jobs").select("id", { count: "exact", head: true }).eq("status", "dead_letter"),
  ]);

  if (auditResult.error) throw auditResult.error;
  if (emailDeliveriesResult.error) throw emailDeliveriesResult.error;
  if (deadLettersResult.error) throw deadLettersResult.error;
  if (pushDeadLettersResult.error) throw pushDeadLettersResult.error;
  if (auditCountResult.error) throw auditCountResult.error;
  if (emailCountResult.error) throw emailCountResult.error;
  if (deadLetterEmailCountResult.error) throw deadLetterEmailCountResult.error;
  if (deadLetterPushCountResult.error) throw deadLetterPushCountResult.error;

  return {
    auditLogs: ((auditResult.data ?? []) as AuditRow[]).map(mapAuditLog),
    emailDeliveries: ((emailDeliveriesResult.data ?? []) as EmailDeliveryRow[]).map(mapEmailDelivery),
    deadLetterEmails: ((deadLettersResult.data ?? []) as EmailOutboxRow[]).map(mapDeadLetterEmail),
    deadLetterPushes: ((pushDeadLettersResult.data ?? []) as PushOutboxRow[]).map(mapDeadLetterPush),
    totals: {
      auditLogs: auditCountResult.count ?? 0,
      emailDeliveries: emailCountResult.count ?? 0,
      deadLetterEmails: deadLetterEmailCountResult.count ?? 0,
      deadLetterPushes: deadLetterPushCountResult.count ?? 0,
    },
  };
}

export async function fetchAdminAuditTrailPage(page?: number, pageSize = 50) {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const currentPage = clampPage(page);
  const { from, to } = pageRange(currentPage, pageSize);
  const result = await supabase
    .from("admin_audit_logs")
    .select("id, action, target_type, target_id, outcome, reason, metadata, created_at", { count: "exact" })
    .order("created_at", { ascending: false })
    .range(from, to);

  if (result.error) throw result.error;

  return {
    items: ((result.data ?? []) as AuditRow[]).map(mapAuditLog),
    total: result.count ?? 0,
    page: currentPage,
    pageSize,
  };
}

export async function fetchEmailDeliveryHealthPage(page?: number, pageSize = 50) {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const currentPage = clampPage(page);
  const { from, to } = pageRange(currentPage, pageSize);
  const result = await supabase
    .from("email_delivery_logs")
    .select("id, booking_id, recipient_email, template_key, status, provider, error_code, error_message, created_at, last_attempt_at", { count: "exact" })
    .order("created_at", { ascending: false })
    .range(from, to);

  if (result.error) throw result.error;

  return {
    items: ((result.data ?? []) as EmailDeliveryRow[]).map(mapEmailDelivery),
    total: result.count ?? 0,
    page: currentPage,
    pageSize,
  };
}

export async function fetchDeadLetterHealthPage(page?: number, pageSize = 50) {
  await requireServerAdminSession();
  const supabase = await createSupabaseServerClient();
  const currentPage = clampPage(page);
  const { from, to } = pageRange(currentPage, pageSize);
  const [deadLetterEmailsResult, deadLetterPushesResult] = await Promise.all([
    supabase
      .from("email_outbox_jobs")
      .select("id, booking_id, recipient_email, template_key, status, attempt_count, max_attempts, last_error_code, last_error_message, created_at, updated_at", { count: "exact" })
      .eq("status", "dead_letter")
      .order("updated_at", { ascending: false })
      .range(from, to),
    supabase
      .from("push_outbox_jobs")
      .select("id, profile_id, event_key, title, status, attempt_count, max_attempts, last_error_code, last_error_message, created_at, updated_at", { count: "exact" })
      .eq("status", "dead_letter")
      .order("updated_at", { ascending: false })
      .range(from, to),
  ]);

  if (deadLetterEmailsResult.error) throw deadLetterEmailsResult.error;
  if (deadLetterPushesResult.error) throw deadLetterPushesResult.error;

  return {
    deadLetterEmails: ((deadLetterEmailsResult.data ?? []) as EmailOutboxRow[]).map(mapDeadLetterEmail),
    deadLetterPushes: ((deadLetterPushesResult.data ?? []) as PushOutboxRow[]).map(mapDeadLetterPush),
    totalDeadLetterEmails: deadLetterEmailsResult.count ?? 0,
    totalDeadLetterPushes: deadLetterPushesResult.count ?? 0,
    page: currentPage,
    pageSize,
  };
}
