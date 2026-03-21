alter table public.generated_documents
add column if not exists locked_at timestamptz,
add column if not exists locked_by text;

create index if not exists generated_documents_pending_lock_idx
on public.generated_documents (status, locked_at, created_at)
where status = 'pending';
