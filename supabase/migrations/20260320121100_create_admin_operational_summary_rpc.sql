create or replace function public.current_admin_email_resend_enabled()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce((value->>'admin_email_resend_enabled')::boolean, true)
  from public.platform_settings
  where key = 'feature_flags';
$$;

create or replace function public.admin_get_operational_summary()
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_delivery_grace_hours integer := public.current_delivery_review_grace_window_hours();
  v_payment_deadline_hours integer := public.current_payment_resubmission_deadline_hours();
begin
  if not public.is_admin() and not public.is_service_role() then
    raise exception 'Admin summary access requires privileged execution';
  end if;

  return jsonb_build_object(
    'verification_packets', (
      select count(*)
      from public.profiles as p
      where p.role = 'carrier'::public.app_role
        and p.is_active = true
        and p.verification_status in ('pending', 'rejected')
    ),
    'pending_verification_documents', (
      select count(*)
      from public.verification_documents as vd
      where vd.status = 'pending'
    ),
    'payment_proofs', (
      select count(*)
      from public.payment_proofs as pp
      where pp.status = 'pending'
    ),
    'disputes', (
      select count(*)
      from public.disputes as d
      where d.status = 'open'
    ),
    'eligible_payouts', (
      select count(*)
      from public.bookings as b
      where b.booking_status = 'completed'
        and b.payment_status = 'secured'
        and not exists (
          select 1
          from public.disputes as d
          where d.booking_id = b.id
            and d.status = 'open'
        )
        and not exists (
          select 1
          from public.payouts as p
          where p.booking_id = b.id
        )
    ),
    'email_backlog', (
      select count(*)
      from public.email_outbox_jobs as jobs
      where jobs.status in ('queued', 'retry_scheduled', 'processing')
    ),
    'email_dead_letter', (
      select count(*)
      from public.email_outbox_jobs as jobs
      where jobs.status = 'dead_letter'
    ),
    'audit_events_last_24h', (
      select count(*)
      from public.admin_audit_logs as logs
      where logs.created_at >= now() - interval '24 hours'
    ),
    'overdue_delivery_reviews', (
      select count(*)
      from public.bookings as b
      where b.booking_status = 'delivered_pending_review'
        and b.delivered_at is not null
        and b.delivered_at <= now() - make_interval(hours => v_delivery_grace_hours)
    ),
    'overdue_payment_resubmissions', (
      with latest_rejection as (
        select pp.booking_id, max(pp.reviewed_at) as reviewed_at
        from public.payment_proofs as pp
        where pp.status = 'rejected'
        group by pp.booking_id
      )
      select count(*)
      from public.bookings as b
      inner join latest_rejection as lr on lr.booking_id = b.id
      where b.payment_status = 'rejected'
        and lr.reviewed_at is not null
        and lr.reviewed_at <= now() - make_interval(hours => v_payment_deadline_hours)
    )
  );
end;
$$;

revoke all on function public.admin_get_operational_summary() from public, anon;
grant execute on function public.admin_get_operational_summary() to authenticated, service_role;
