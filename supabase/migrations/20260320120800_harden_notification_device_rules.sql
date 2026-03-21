create or replace function public.normalize_supported_locale(
  p_locale text
)
returns text
language sql
immutable
set search_path = public
as $$
  select case lower(trim(coalesce(p_locale, '')))
    when 'ar' then 'ar'
    when 'fr' then 'fr'
    when 'en' then 'en'
    else 'en'
  end;
$$;

create or replace function public.get_profile_preferred_locale(
  p_profile_id uuid
)
returns text
language sql
stable
set search_path = public
as $$
  select coalesce(
    (
      select public.normalize_supported_locale(locale)
      from public.user_devices
      where profile_id = p_profile_id
        and nullif(trim(locale), '') is not null
      order by last_seen_at desc nulls last, updated_at desc, created_at desc
      limit 1
    ),
    'en'
  );
$$;

drop policy if exists notifications_update_owner on public.notifications;
drop policy if exists notifications_update_admin_only on public.notifications;
create policy notifications_update_admin_only
on public.notifications for update to authenticated
using (public.is_admin())
with check (public.is_admin());

create or replace function public.register_user_device(
  p_push_token text,
  p_platform text,
  p_locale text default null
)
returns public.user_devices
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_push_token text := trim(coalesce(p_push_token, ''));
  v_platform text := lower(trim(coalesce(p_platform, '')));
  v_locale text := public.normalize_supported_locale(p_locale);
  v_result public.user_devices;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  if v_push_token = '' then
    raise exception 'Push token is required';
  end if;

  if length(v_push_token) > 512 then
    raise exception 'Push token is too large';
  end if;

  if v_platform not in ('android', 'ios', 'web') then
    raise exception 'Unsupported device platform';
  end if;

  delete from public.user_devices
  where push_token = v_push_token
    and profile_id <> v_actor_id;

  insert into public.user_devices (
    profile_id,
    push_token,
    platform,
    locale,
    last_seen_at
  ) values (
    v_actor_id,
    v_push_token,
    v_platform,
    v_locale,
    now()
  )
  on conflict (profile_id, push_token) do update
  set platform = excluded.platform,
      locale = excluded.locale,
      last_seen_at = now(),
      updated_at = now()
  returning * into v_result;

  return v_result;
end;
$$;
