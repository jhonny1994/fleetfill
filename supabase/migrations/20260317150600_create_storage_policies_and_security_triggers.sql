create policy payment_proofs_upload_via_session
on storage.objects for insert to authenticated
with check (
  bucket_id = 'payment-proofs'
  and public.can_upload_storage_object(bucket_id, name)
);

drop policy if exists verification_documents_upload_via_session on storage.objects;
create policy verification_documents_upload_via_session
on storage.objects for insert to authenticated
with check (
  bucket_id = 'verification-documents'
  and public.can_upload_storage_object(bucket_id, name)
);

create or replace trigger upload_sessions_set_updated_at
before update on public.upload_sessions
for each row execute function public.set_updated_at();

create or replace trigger security_rate_limits_set_updated_at
before update on public.security_rate_limits
for each row execute function public.set_updated_at();

create or replace trigger profiles_normalize_columns
before insert or update on public.profiles
for each row execute function public.normalize_profile_columns();

create or replace trigger profiles_protect_sensitive_columns
before insert or update on public.profiles
for each row execute function public.protect_profile_sensitive_columns();

create or replace trigger vehicles_protect_sensitive_columns
before insert or update on public.vehicles
for each row execute function public.protect_vehicle_sensitive_columns();

create or replace trigger payout_accounts_protect_sensitive_columns
before insert or update on public.payout_accounts
for each row execute function public.protect_payout_account_sensitive_columns();

create or replace trigger payment_proofs_append_only_guard
before update or delete on public.payment_proofs
for each row execute function public.enforce_append_only_history();

create or replace trigger verification_documents_append_only_guard
before update or delete on public.verification_documents
for each row execute function public.enforce_append_only_history();

create or replace trigger tracking_events_append_only_guard
before update or delete on public.tracking_events
for each row execute function public.enforce_append_only_history();

create or replace trigger financial_ledger_entries_append_only_guard
before update or delete on public.financial_ledger_entries
for each row execute function public.enforce_append_only_history();

create or replace trigger admin_audit_logs_append_only_guard
before update or delete on public.admin_audit_logs
for each row execute function public.enforce_append_only_history();
