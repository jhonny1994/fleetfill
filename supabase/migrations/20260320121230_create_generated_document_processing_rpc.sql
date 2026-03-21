create or replace function public.claim_generated_document_jobs(
  p_worker_id text,
  p_batch_size integer default 5
)
returns setof public.generated_documents
language plpgsql
security definer
set search_path = public
as $$
declare
  v_limit integer := greatest(1, least(coalesce(p_batch_size, 5), 25));
begin
  if not public.is_service_role() then
    raise exception 'Generated document claims require service role access';
  end if;

  return query
  with claimed as (
    update public.generated_documents as documents
    set locked_at = now(),
        locked_by = p_worker_id
    where documents.id in (
      select candidate.id
      from public.generated_documents as candidate
      where candidate.status = 'pending'
        and candidate.locked_at is null
      order by candidate.created_at
      limit v_limit
      for update skip locked
    )
    returning documents.*
  )
  select * from claimed;
end;
$$;

create or replace function public.complete_generated_document_processing(
  p_document_id uuid,
  p_content_type text,
  p_byte_size bigint,
  p_checksum_sha256 text
)
returns public.generated_documents
language plpgsql
security definer
set search_path = public
as $$
declare
  v_document public.generated_documents;
  v_booking public.bookings;
  v_recipient public.profiles;
  v_result public.generated_documents;
begin
  if not public.is_service_role() then
    raise exception 'Generated document completion requires service role access';
  end if;

  select * into v_document
  from public.generated_documents
  where id = p_document_id
  for update;

  if not found then
    raise exception 'Generated document not found';
  end if;

  select * into v_booking
  from public.bookings
  where id = v_document.booking_id;

  if not found then
    raise exception 'Booking not found for generated document';
  end if;

  if v_document.document_type = 'payout_receipt' then
    select * into v_recipient
    from public.profiles
    where id = v_booking.carrier_id;
  else
    select * into v_recipient
    from public.profiles
    where id = v_booking.shipper_id;
  end if;

  update public.generated_documents
  set status = 'ready',
      content_type = left(nullif(trim(coalesce(p_content_type, '')), ''), 120),
      byte_size = greatest(coalesce(p_byte_size, 0), 0),
      checksum_sha256 = left(nullif(trim(coalesce(p_checksum_sha256, '')), ''), 128),
      available_at = now(),
      failure_reason = null,
      locked_at = null,
      locked_by = null
  where id = p_document_id
  returning * into v_result;

  if v_recipient.id is not null then
    insert into public.notifications (
      profile_id,
      type,
      title,
      body,
      data
    ) values (
      v_recipient.id,
      'generated_document_ready',
      'generated_document_ready_title',
      'generated_document_ready_body',
      jsonb_build_object(
        'booking_id', v_booking.id,
        'document_id', v_result.id,
        'document_type', v_result.document_type
      )
    );

    if nullif(trim(coalesce(v_recipient.email, '')), '') is not null then
      perform public.enqueue_transactional_email(
        'generated_document_available',
        v_recipient.id,
        lower(trim(v_recipient.email)),
        v_booking.id,
        'generated_document_available',
        null,
        jsonb_build_object(
          'booking_id', v_booking.id,
          'booking_reference', v_booking.tracking_number,
          'document_id', v_result.id,
          'document_type', v_result.document_type,
          'document_route', '/shared/generated-document/' || v_result.id::text
        ),
        'generated_document_available:' || v_result.id::text,
        'normal'
      );
    end if;
  end if;

  return v_result;
end;
$$;

create or replace function public.fail_generated_document_processing(
  p_document_id uuid,
  p_failure_reason text default null
)
returns public.generated_documents
language plpgsql
security definer
set search_path = public
as $$
declare
  v_result public.generated_documents;
begin
  if not public.is_service_role() then
    raise exception 'Generated document failure updates require service role access';
  end if;

  update public.generated_documents
  set status = 'failed',
      failure_reason = left(nullif(trim(coalesce(p_failure_reason, '')), ''), 500),
      available_at = null,
      locked_at = null,
      locked_by = null
  where id = p_document_id
  returning * into v_result;

  if not found then
    raise exception 'Generated document not found';
  end if;

  return v_result;
end;
$$;

create or replace function public.recover_stale_generated_document_jobs(
  p_lock_age_seconds integer default 900
)
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_recovered_count integer := 0;
  v_lock_age integer := greatest(60, least(coalesce(p_lock_age_seconds, 900), 86400));
begin
  if not public.is_service_role() then
    raise exception 'Generated document recovery requires service role access';
  end if;

  update public.generated_documents
  set locked_at = null,
      locked_by = null
  where status = 'pending'
    and locked_at is not null
    and locked_at < now() - make_interval(secs => v_lock_age);

  get diagnostics v_recovered_count = row_count;
  return v_recovered_count;
end;
$$;

revoke all on function public.claim_generated_document_jobs(text, integer) from public, anon, authenticated;
grant execute on function public.claim_generated_document_jobs(text, integer) to service_role;

revoke all on function public.complete_generated_document_processing(uuid, text, bigint, text) from public, anon, authenticated;
grant execute on function public.complete_generated_document_processing(uuid, text, bigint, text) to service_role;

revoke all on function public.fail_generated_document_processing(uuid, text) from public, anon, authenticated;
grant execute on function public.fail_generated_document_processing(uuid, text) to service_role;

revoke all on function public.recover_stale_generated_document_jobs(integer) from public, anon, authenticated;
grant execute on function public.recover_stale_generated_document_jobs(integer) to service_role;
