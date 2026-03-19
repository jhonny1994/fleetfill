insert into storage.buckets (id, name, public)
values
  ('payment-proofs', 'payment-proofs', false),
  ('verification-documents', 'verification-documents', false),
  ('generated-documents', 'generated-documents', false)
on conflict (id) do update
set public = excluded.public;
