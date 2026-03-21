alter table public.generated_documents
add column if not exists status text not null default 'pending',
add column if not exists available_at timestamptz,
add column if not exists failure_reason text;

update public.generated_documents
set status = 'pending'
where status is null;

create index if not exists generated_documents_status_created_at_idx
on public.generated_documents (status, created_at desc);
