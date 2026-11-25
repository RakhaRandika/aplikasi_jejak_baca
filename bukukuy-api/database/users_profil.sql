drop view if exists public.rak_baca_lengkap;
drop table if exists public.users_lama;
drop table if exists public.users;

create table public.users (
  id uuid not null,
  id_user bigint generated always as identity,
  nama text not null default '',
  email text not null default '',
  dibuat_pada timestamptz not null default now(),
  constraint users_profil_pkey primary key (id),
  constraint users_profil_id_user_key unique (id_user),
  constraint users_profil_auth_fkey foreign key (id) references auth.users (id) on delete cascade
);

alter table public.users enable row level security;

create policy "lihat data sendiri" on public.users
  for select to authenticated using (id = (select auth.uid()));

revoke all on public.users from anon, authenticated;
grant select on public.users to authenticated;

create or replace function public.salin_user_baru()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.users (id, nama, email)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'nama', ''),
    coalesce(new.email, '')
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists saat_user_dibuat on auth.users;
create trigger saat_user_dibuat
  after insert on auth.users
  for each row execute function public.salin_user_baru();

insert into public.users (id, nama, email)
select id, coalesce(raw_user_meta_data->>'nama', ''), coalesce(email, '')
from auth.users
on conflict (id) do nothing;

alter table public.rak_baca add column if not exists id_user bigint;
alter table public.rak_baca add column if not exists nama text;
alter table public.rak_baca add column if not exists email text;

create or replace function public.isi_info_user_rak()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  select u.id_user, u.nama, u.email
  into new.id_user, new.nama, new.email
  from public.users u
  where u.id = new.user_id;
  return new;
end;
$$;

drop trigger if exists isi_info_user on public.rak_baca;
create trigger isi_info_user
  before insert on public.rak_baca
  for each row execute function public.isi_info_user_rak();

update public.rak_baca r
set id_user = u.id_user, nama = u.nama, email = u.email
from public.users u
where u.id = r.user_id;

revoke update on public.rak_baca from authenticated;
grant update (status) on public.rak_baca to authenticated;
