create or replace function public.get_public_carrier_profile(
  p_carrier_id uuid
)
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  select jsonb_build_object(
    'id', p.id,
    'full_name', p.full_name,
    'company_name', p.company_name,
    'verification_status', p.verification_status,
    'rating_average', p.rating_average,
    'rating_count', p.rating_count,
    'comments', coalesce(
      (
        select jsonb_agg(
          jsonb_build_object(
            'score', cr.score,
            'comment', cr.comment,
            'created_at', cr.created_at
          )
          order by cr.created_at desc
        )
        from (
          select score, comment, created_at
          from public.carrier_reviews
          where carrier_id = p.id
            and comment is not null
          order by created_at desc
          limit 5
        ) as cr
      ),
      '[]'::jsonb
    )
  )
  from public.profiles as p
  where p.id = p_carrier_id
    and p.role = 'carrier'
    and p.is_active = true;
$$;

revoke all on function public.get_public_carrier_profile(uuid) from public, anon;
grant execute on function public.get_public_carrier_profile(uuid) to authenticated, service_role;
