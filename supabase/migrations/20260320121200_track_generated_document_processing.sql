alter table public.generated_documents
add column if not exists status text not null default 'pending',
add column if not exists available_at timestamptz,
add column if not exists failure_reason text;

update public.generated_documents
set status = 'pending'
where status is null;

create index if not exists generated_documents_status_created_at_idx
on public.generated_documents (status, created_at desc);

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
  v_result public.generated_documents;
begin
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
    p_document_type,
    p_storage_path,
    (
      select coalesce(max(version), 0) + 1
      from public.generated_documents
      where booking_id = p_booking_id
        and document_type = p_document_type
    ),
    (select auth.uid()),
    'pending',
    null,
    null
  )
  returning * into v_result;

  return v_result;
end;
$$;
