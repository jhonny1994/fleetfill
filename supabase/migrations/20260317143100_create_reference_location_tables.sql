create table if not exists public.wilayas (
  id integer primary key,
  name text not null,
  name_ar text not null
);

create table if not exists public.communes (
  id integer primary key,
  wilaya_id integer not null references public.wilayas (id),
  name text not null,
  name_ar text not null
);
