revoke all on function public.write_admin_audit_log(text, text, uuid, text, text, jsonb) from public, anon, authenticated;
grant execute on function public.write_admin_audit_log(text, text, uuid, text, text, jsonb) to service_role;

revoke all on function public.get_client_settings() from public, anon;
grant execute on function public.get_client_settings() to authenticated, service_role;

revoke all on function public.claim_email_outbox_jobs(text, integer) from public, anon, authenticated;
grant execute on function public.claim_email_outbox_jobs(text, integer) to service_role;

revoke all on function public.release_retryable_email_job(uuid, text, text, integer) from public, anon, authenticated;
grant execute on function public.release_retryable_email_job(uuid, text, text, integer) to service_role;

revoke all on function public.complete_email_outbox_job(uuid, text, text, text) from public, anon, authenticated;
grant execute on function public.complete_email_outbox_job(uuid, text, text, text) to service_role;

revoke all on function public.record_email_provider_event(text, public.email_delivery_status, text, text) from public, anon, authenticated;
grant execute on function public.record_email_provider_event(text, public.email_delivery_status, text, text) to service_role;

revoke all on function public.recover_stale_email_outbox_jobs(integer) from public, anon, authenticated;
grant execute on function public.recover_stale_email_outbox_jobs(integer) to service_role;

revoke all on function public.create_upload_session(text, text, uuid, text, text, text, bigint, text) from public, anon;
grant execute on function public.create_upload_session(text, text, uuid, text, text, text, bigint, text) to authenticated, service_role;

revoke all on function public.finalize_payment_proof(uuid, numeric, text) from public, anon;
grant execute on function public.finalize_payment_proof(uuid, numeric, text) to authenticated, service_role;

revoke all on function public.finalize_verification_document(uuid) from public, anon;
grant execute on function public.finalize_verification_document(uuid) to authenticated, service_role;

revoke all on function public.authorize_private_file_access(text, text) from public, anon;
grant execute on function public.authorize_private_file_access(text, text) to authenticated, service_role;
