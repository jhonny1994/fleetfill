drop policy if exists vehicles_insert_owner_or_admin on public.vehicles;
create policy vehicles_insert_owner_or_admin
on public.vehicles for insert to authenticated
with check (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists vehicles_update_owner_or_admin on public.vehicles;
create policy vehicles_update_owner_or_admin
on public.vehicles for update to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
)
with check (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists vehicles_delete_owner_or_admin on public.vehicles;
create policy vehicles_delete_owner_or_admin
on public.vehicles for delete to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists payout_accounts_insert_owner_or_admin on public.payout_accounts;
create policy payout_accounts_insert_owner_or_admin
on public.payout_accounts for insert to authenticated
with check (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists payout_accounts_update_owner_or_admin on public.payout_accounts;
create policy payout_accounts_update_owner_or_admin
on public.payout_accounts for update to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
)
with check (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists payout_accounts_delete_owner_or_admin on public.payout_accounts;
create policy payout_accounts_delete_owner_or_admin
on public.payout_accounts for delete to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_active_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists routes_insert_owner_or_admin on public.routes;
create policy routes_insert_owner_or_admin
on public.routes for insert to authenticated
with check (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists routes_update_owner_or_admin on public.routes;
create policy routes_update_owner_or_admin
on public.routes for update to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
)
with check (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists routes_delete_owner_or_admin on public.routes;
create policy routes_delete_owner_or_admin
on public.routes for delete to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists oneoff_trips_insert_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_insert_owner_or_admin
on public.oneoff_trips for insert to authenticated
with check (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists oneoff_trips_update_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_update_owner_or_admin
on public.oneoff_trips for update to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
)
with check (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
);

drop policy if exists oneoff_trips_delete_owner_or_admin on public.oneoff_trips;
create policy oneoff_trips_delete_owner_or_admin
on public.oneoff_trips for delete to authenticated
using (
  (carrier_id = (select auth.uid()) and public.is_verified_carrier((select auth.uid())))
  or public.is_admin()
);
