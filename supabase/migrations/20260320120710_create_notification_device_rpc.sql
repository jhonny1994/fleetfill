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
  v_result public.user_devices;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  insert into public.user_devices (
    profile_id,
    push_token,
    platform,
    locale,
    last_seen_at
  ) values (
    v_actor_id,
    trim(p_push_token),
    trim(p_platform),
    nullif(trim(p_locale), ''),
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

create or replace function public.mark_notification_read(
  p_notification_id uuid
)
returns public.notifications
language plpgsql
security definer
set search_path = public
as $$
declare
  v_actor_id uuid := (select auth.uid());
  v_result public.notifications;
begin
  if v_actor_id is null then
    raise exception 'authentication_required';
  end if;

  update public.notifications
  set is_read = true,
      read_at = coalesce(read_at, now())
  where id = p_notification_id
    and profile_id = v_actor_id
  returning * into v_result;

  if not found then
    raise exception 'Notification not found';
  end if;

  return v_result;
end;
$$;

create unique index if not exists user_devices_profile_push_token_idx
on public.user_devices (profile_id, push_token);

revoke all on function public.register_user_device(text, text, text) from public, anon;
grant execute on function public.register_user_device(text, text, text) to authenticated, service_role;

revoke all on function public.mark_notification_read(uuid) from public, anon;
grant execute on function public.mark_notification_read(uuid) to authenticated, service_role;
