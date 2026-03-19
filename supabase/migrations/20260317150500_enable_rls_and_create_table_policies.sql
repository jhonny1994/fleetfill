alter table public.wilayas enable row level security;
alter table public.communes enable row level security;
alter table public.profiles enable row level security;
alter table public.vehicles enable row level security;
alter table public.payout_accounts enable row level security;
alter table public.platform_payment_accounts enable row level security;
alter table public.verification_documents enable row level security;
alter table public.routes enable row level security;
alter table public.route_departure_instances enable row level security;
alter table public.oneoff_trips enable row level security;
alter table public.route_revisions enable row level security;
alter table public.shipments enable row level security;
alter table public.shipment_items enable row level security;
alter table public.bookings enable row level security;
alter table public.payment_proofs enable row level security;
alter table public.tracking_events enable row level security;
alter table public.carrier_reviews enable row level security;
alter table public.financial_ledger_entries enable row level security;
alter table public.disputes enable row level security;
alter table public.refunds enable row level security;
alter table public.payouts enable row level security;
alter table public.generated_documents enable row level security;
alter table public.email_delivery_logs enable row level security;
alter table public.email_outbox_jobs enable row level security;
alter table public.notifications enable row level security;
alter table public.user_devices enable row level security;
alter table public.platform_settings enable row level security;
alter table public.admin_audit_logs enable row level security;
alter table public.upload_sessions enable row level security;
alter table public.security_rate_limits enable row level security;
alter table public.security_abuse_events enable row level security;

drop policy if exists wilayas_read_authenticated on public.wilayas;
create policy wilayas_read_authenticated
on public.wilayas for select to authenticated
using (true);

drop policy if exists communes_read_authenticated on public.communes;
create policy communes_read_authenticated
on public.communes for select to authenticated
using (true);

drop policy if exists profiles_select_self_or_admin on public.profiles;
create policy profiles_select_self_or_admin
on public.profiles for select to authenticated
using (id = (select auth.uid()) or public.is_admin());

drop policy if exists profiles_insert_self_or_admin on public.profiles;
create policy profiles_insert_self_or_admin
on public.profiles for insert to authenticated
with check (id = (select auth.uid()) or public.is_admin());

drop policy if exists profiles_update_self_or_admin on public.profiles;
create policy profiles_update_self_or_admin
on public.profiles for update to authenticated
using (id = (select auth.uid()) or public.is_admin())
with check (id = (select auth.uid()) or public.is_admin());

drop policy if exists vehicles_select_owner_or_admin on public.vehicles;
create policy vehicles_select_owner_or_admin
on public.vehicles for select to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists vehicles_modify_owner_or_admin on public.vehicles;
drop policy if exists vehicles_insert_owner_or_admin on public.vehicles;
create policy vehicles_insert_owner_or_admin
on public.vehicles for insert to authenticated
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists vehicles_update_owner_or_admin on public.vehicles;
create policy vehicles_update_owner_or_admin
on public.vehicles for update to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin())
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists vehicles_delete_owner_or_admin on public.vehicles;
create policy vehicles_delete_owner_or_admin
on public.vehicles for delete to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists payout_accounts_select_owner_or_admin on public.payout_accounts;
create policy payout_accounts_select_owner_or_admin
on public.payout_accounts for select to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists payout_accounts_modify_owner_or_admin on public.payout_accounts;
drop policy if exists payout_accounts_insert_owner_or_admin on public.payout_accounts;
create policy payout_accounts_insert_owner_or_admin
on public.payout_accounts for insert to authenticated
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists payout_accounts_update_owner_or_admin on public.payout_accounts;
create policy payout_accounts_update_owner_or_admin
on public.payout_accounts for update to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin())
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists payout_accounts_delete_owner_or_admin on public.payout_accounts;
create policy payout_accounts_delete_owner_or_admin
on public.payout_accounts for delete to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists platform_payment_accounts_admin_only on public.platform_payment_accounts;
create policy platform_payment_accounts_admin_only
on public.platform_payment_accounts for all to authenticated
using (public.is_admin())
with check (public.is_admin());

drop policy if exists verification_documents_select_owner_or_admin on public.verification_documents;
create policy verification_documents_select_owner_or_admin
on public.verification_documents for select to authenticated
using (owner_profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists verification_documents_admin_update on public.verification_documents;
create policy verification_documents_admin_update
on public.verification_documents for update to authenticated
using (public.is_admin())
with check (public.is_admin());

drop policy if exists routes_select_owner_or_admin on public.routes;
create policy routes_select_owner_or_admin
on public.routes for select to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists routes_modify_owner_or_admin on public.routes;
drop policy if exists routes_insert_owner_or_admin on public.routes;
create policy routes_insert_owner_or_admin
on public.routes for insert to authenticated
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists routes_update_owner_or_admin on public.routes;
create policy routes_update_owner_or_admin
on public.routes for update to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin())
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists routes_delete_owner_or_admin on public.routes;
create policy routes_delete_owner_or_admin
on public.routes for delete to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists route_departure_instances_select_owner_or_admin on public.route_departure_instances;
create policy route_departure_instances_select_owner_or_admin
on public.route_departure_instances for select to authenticated
using (
  exists (
    select 1 from public.routes as r
    where r.id = route_departure_instances.route_id
      and (r.carrier_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists oneoff_trips_select_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_select_owner_or_admin
on public.oneoff_trips for select to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists oneoff_trips_modify_owner_or_admin on public.oneoff_trips;
drop policy if exists oneoff_trips_insert_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_insert_owner_or_admin
on public.oneoff_trips for insert to authenticated
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists oneoff_trips_update_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_update_owner_or_admin
on public.oneoff_trips for update to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin())
with check (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists oneoff_trips_delete_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_delete_owner_or_admin
on public.oneoff_trips for delete to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists route_revisions_select_owner_or_admin on public.route_revisions;
create policy route_revisions_select_owner_or_admin
on public.route_revisions for select to authenticated
using (
  exists (
    select 1 from public.routes as r
    where r.id = route_revisions.route_id
      and (r.carrier_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists route_revisions_modify_owner_or_admin on public.route_revisions;
drop policy if exists route_revisions_insert_owner_or_admin on public.route_revisions;
create policy route_revisions_insert_owner_or_admin
on public.route_revisions for insert to authenticated
with check (
  exists (
    select 1 from public.routes as r
    where r.id = route_revisions.route_id
      and (r.carrier_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists route_revisions_update_owner_or_admin on public.route_revisions;
create policy route_revisions_update_owner_or_admin
on public.route_revisions for update to authenticated
using (
  exists (
    select 1 from public.routes as r
    where r.id = route_revisions.route_id
      and (r.carrier_id = (select auth.uid()) or public.is_admin())
  )
)
with check (
  exists (
    select 1 from public.routes as r
    where r.id = route_revisions.route_id
      and (r.carrier_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists route_revisions_delete_owner_or_admin on public.route_revisions;
create policy route_revisions_delete_owner_or_admin
on public.route_revisions for delete to authenticated
using (
  exists (
    select 1 from public.routes as r
    where r.id = route_revisions.route_id
      and (r.carrier_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists shipments_select_owner_or_admin on public.shipments;
create policy shipments_select_owner_or_admin
on public.shipments for select to authenticated
using (shipper_id = (select auth.uid()) or public.is_admin());

drop policy if exists shipments_insert_owner_or_admin on public.shipments;
create policy shipments_insert_owner_or_admin
on public.shipments for insert to authenticated
with check ((shipper_id = (select auth.uid()) and status = 'draft') or public.is_admin());

drop policy if exists shipments_update_draft_owner_or_admin on public.shipments;
create policy shipments_update_draft_owner_or_admin
on public.shipments for update to authenticated
using ((shipper_id = (select auth.uid()) and status = 'draft') or public.is_admin())
with check ((shipper_id = (select auth.uid()) and status = 'draft') or public.is_admin());

drop policy if exists shipments_delete_draft_owner_or_admin on public.shipments;
create policy shipments_delete_draft_owner_or_admin
on public.shipments for delete to authenticated
using ((shipper_id = (select auth.uid()) and status = 'draft') or public.is_admin());

drop policy if exists shipment_items_select_owner_or_admin on public.shipment_items;
create policy shipment_items_select_owner_or_admin
on public.shipment_items for select to authenticated
using (public.shipment_is_visible_to_current_user(shipment_id));

drop policy if exists shipment_items_modify_owner_or_admin on public.shipment_items;
drop policy if exists shipment_items_insert_owner_or_admin on public.shipment_items;
create policy shipment_items_insert_owner_or_admin
on public.shipment_items for insert to authenticated
with check (
  exists (
    select 1
    from public.shipments as s
    where s.id = shipment_items.shipment_id
      and ((s.shipper_id = (select auth.uid()) and s.status = 'draft') or public.is_admin())
  )
);

drop policy if exists shipment_items_update_owner_or_admin on public.shipment_items;
create policy shipment_items_update_owner_or_admin
on public.shipment_items for update to authenticated
using (
  exists (
    select 1
    from public.shipments as s
    where s.id = shipment_items.shipment_id
      and ((s.shipper_id = (select auth.uid()) and s.status = 'draft') or public.is_admin())
  )
)
with check (
  exists (
    select 1
    from public.shipments as s
    where s.id = shipment_items.shipment_id
      and ((s.shipper_id = (select auth.uid()) and s.status = 'draft') or public.is_admin())
  )
);

drop policy if exists shipment_items_delete_owner_or_admin on public.shipment_items;
create policy shipment_items_delete_owner_or_admin
on public.shipment_items for delete to authenticated
using (
  exists (
    select 1
    from public.shipments as s
    where s.id = shipment_items.shipment_id
      and ((s.shipper_id = (select auth.uid()) and s.status = 'draft') or public.is_admin())
  )
);

drop policy if exists bookings_select_participant_or_admin on public.bookings;
create policy bookings_select_participant_or_admin
on public.bookings for select to authenticated
using (
  shipper_id = (select auth.uid())
  or carrier_id = (select auth.uid())
  or public.is_admin()
);

drop policy if exists payment_proofs_select_shipper_or_admin on public.payment_proofs;
drop policy if exists payment_proofs_select_participant_or_admin on public.payment_proofs;
create policy payment_proofs_select_shipper_or_admin
on public.payment_proofs for select to authenticated
using (
  exists (
    select 1
    from public.bookings as b
    where b.id = payment_proofs.booking_id
      and (b.shipper_id = (select auth.uid()) or public.is_admin())
  )
);

drop policy if exists tracking_events_select_participant_or_admin on public.tracking_events;
create policy tracking_events_select_participant_or_admin
on public.tracking_events for select to authenticated
using (public.booking_is_visible_to_current_user(booking_id));

drop policy if exists carrier_reviews_select_participant_or_admin on public.carrier_reviews;
create policy carrier_reviews_select_participant_or_admin
on public.carrier_reviews for select to authenticated
using (
  shipper_id = (select auth.uid())
  or carrier_id = (select auth.uid())
  or public.is_admin()
);

drop policy if exists carrier_reviews_insert_shipper_or_admin on public.carrier_reviews;
create policy carrier_reviews_insert_shipper_or_admin
on public.carrier_reviews for insert to authenticated
with check (shipper_id = (select auth.uid()) or public.is_admin());

drop policy if exists financial_ledger_entries_select_participant_or_admin on public.financial_ledger_entries;
create policy financial_ledger_entries_select_participant_or_admin
on public.financial_ledger_entries for select to authenticated
using (public.booking_is_visible_to_current_user(booking_id));

drop policy if exists disputes_select_participant_or_admin on public.disputes;
create policy disputes_select_participant_or_admin
on public.disputes for select to authenticated
using (public.booking_is_visible_to_current_user(booking_id));

drop policy if exists refunds_select_participant_or_admin on public.refunds;
create policy refunds_select_participant_or_admin
on public.refunds for select to authenticated
using (public.booking_is_visible_to_current_user(booking_id) or public.is_admin());

drop policy if exists payouts_select_participant_or_admin on public.payouts;
create policy payouts_select_participant_or_admin
on public.payouts for select to authenticated
using (carrier_id = (select auth.uid()) or public.is_admin());

drop policy if exists generated_documents_select_participant_or_admin on public.generated_documents;
create policy generated_documents_select_participant_or_admin
on public.generated_documents for select to authenticated
using (
  booking_id is not null
  and public.booking_is_visible_to_current_user(booking_id)
);

drop policy if exists email_delivery_logs_admin_only on public.email_delivery_logs;
create policy email_delivery_logs_admin_only
on public.email_delivery_logs for select to authenticated
using (public.is_admin());

drop policy if exists email_outbox_jobs_admin_only on public.email_outbox_jobs;
create policy email_outbox_jobs_admin_only
on public.email_outbox_jobs for select to authenticated
using (public.is_admin());

drop policy if exists notifications_select_owner on public.notifications;
create policy notifications_select_owner
on public.notifications for select to authenticated
using (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists notifications_update_owner on public.notifications;
create policy notifications_update_owner
on public.notifications for update to authenticated
using (profile_id = (select auth.uid()) or public.is_admin())
with check (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists user_devices_owner_or_admin on public.user_devices;
drop policy if exists user_devices_select_owner_or_admin on public.user_devices;
create policy user_devices_select_owner_or_admin
on public.user_devices for select to authenticated
using (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists user_devices_insert_owner_or_admin on public.user_devices;
create policy user_devices_insert_owner_or_admin
on public.user_devices for insert to authenticated
with check (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists user_devices_update_owner_or_admin on public.user_devices;
create policy user_devices_update_owner_or_admin
on public.user_devices for update to authenticated
using (profile_id = (select auth.uid()) or public.is_admin())
with check (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists user_devices_delete_owner_or_admin on public.user_devices;
create policy user_devices_delete_owner_or_admin
on public.user_devices for delete to authenticated
using (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists platform_settings_admin_only on public.platform_settings;
create policy platform_settings_admin_only
on public.platform_settings for all to authenticated
using (public.is_admin())
with check (public.is_admin());

drop policy if exists admin_audit_logs_admin_read_only on public.admin_audit_logs;
create policy admin_audit_logs_admin_read_only
on public.admin_audit_logs for select to authenticated
using (public.is_admin());

drop policy if exists upload_sessions_select_owner_or_admin on public.upload_sessions;
create policy upload_sessions_select_owner_or_admin
on public.upload_sessions for select to authenticated
using (profile_id = (select auth.uid()) or public.is_admin());

drop policy if exists security_rate_limits_admin_only on public.security_rate_limits;
create policy security_rate_limits_admin_only
on public.security_rate_limits for select to authenticated
using (public.is_admin());

drop policy if exists security_abuse_events_admin_only on public.security_abuse_events;
create policy security_abuse_events_admin_only
on public.security_abuse_events for select to authenticated
using (public.is_admin());

drop policy if exists payment_proofs_upload_via_session on storage.objects;
