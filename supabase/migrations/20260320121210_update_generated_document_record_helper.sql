create or replace function public.create_generated_document_record(
  p_booking_id uuid,
  p_document_type text,
  p_storage_path text
)
returns public.generated_documents
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_booking public.bookings;
  v_document_type text := lower(trim(coalesce(p_document_type, '')));
  v_storage_path text := trim(coalesce(p_storage_path, ''));
  v_result public.generated_documents;
begin
  if p_booking_id is null then
    raise exception 'Booking id is required';
  end if;

  if v_document_type not in ('booking_invoice', 'payment_receipt', 'payout_receipt') then
    raise exception 'Unsupported generated document type';
  end if;

  if v_storage_path = '' then
    raise exception 'Generated document storage path is required';
  end if;

  if not public.is_service_role() and not public.is_admin() then
    raise exception 'Generated document creation requires privileged access';
  end if;

  select * into v_booking
  from public.bookings
  where id = p_booking_id
  for update;

  if not found then
    raise exception 'Booking not found';
  end if;

  if v_document_type in ('booking_invoice', 'payment_receipt')
     and v_booking.payment_status not in ('secured', 'released_to_carrier') then
    raise exception 'Booking financial documents require secured payment';
  end if;

  if v_document_type = 'payout_receipt'
     and v_booking.payment_status <> 'released_to_carrier' then
    raise exception 'Payout receipt requires released payout state';
  end if;

  if v_storage_path !~ ('^generated/' || p_booking_id::text || '/' || replace(v_document_type, '_', '-') || '-v[0-9]+\.pdf$') then
    raise exception 'Generated document path does not match canonical format';
  end if;

  insert into public.generated_documents (
    booking_id,
    document_type,
    storage_path,
    version,
    generated_by,
    status,
    available_at,
    failure_reason
  ) values (
    p_booking_id,
    v_document_type,
    v_storage_path,
    (
      select coalesce(max(version), 0) + 1
      from public.generated_documents
      where booking_id = p_booking_id
        and document_type = v_document_type
    ),
    v_actor_id,
    'pending',
    null,
    null
  )
  returning * into v_result;

  return v_result;
end;
$$;
