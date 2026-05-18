-- Story Archive setup
-- Supabase SQL Editor에서 전체 실행하세요.
-- 관리자 이메일을 바꿀 경우 아래 email 값을 전부 바꿔주세요.

create table if not exists public.stories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete set null,
  title text not null,
  content text,
  content_html text,
  thumbnail_url text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.stories add column if not exists content_html text;
alter table public.stories add column if not exists thumbnail_url text;
alter table public.stories add column if not exists updated_at timestamptz default now();

alter table public.stories enable row level security;

drop policy if exists "Anyone can read stories" on public.stories;
drop policy if exists "Only admin can insert stories" on public.stories;
drop policy if exists "Only admin can update stories" on public.stories;
drop policy if exists "Only admin can delete stories" on public.stories;

create policy "Anyone can read stories"
on public.stories
for select
using (true);

create policy "Only admin can insert stories"
on public.stories
for insert
with check (
  auth.jwt() ->> 'email' = 'jangh3073@gmail.com'
);

create policy "Only admin can update stories"
on public.stories
for update
using (
  auth.jwt() ->> 'email' = 'jangh3073@gmail.com'
)
with check (
  auth.jwt() ->> 'email' = 'jangh3073@gmail.com'
);

create policy "Only admin can delete stories"
on public.stories
for delete
using (
  auth.jwt() ->> 'email' = 'jangh3073@gmail.com'
);

-- 이미지 저장용 공개 버킷
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'story-images',
  'story-images',
  true,
  10485760,
  array['image/jpeg', 'image/png', 'image/webp', 'image/gif']
)
on conflict (id) do update
set public = true,
    file_size_limit = 10485760,
    allowed_mime_types = array['image/jpeg', 'image/png', 'image/webp', 'image/gif'];

drop policy if exists "Anyone can view story images" on storage.objects;
drop policy if exists "Only admin can upload story images" on storage.objects;
drop policy if exists "Only admin can update story images" on storage.objects;
drop policy if exists "Only admin can delete story images" on storage.objects;

create policy "Anyone can view story images"
on storage.objects
for select
using (bucket_id = 'story-images');

create policy "Only admin can upload story images"
on storage.objects
for insert
with check (
  bucket_id = 'story-images'
  and auth.jwt() ->> 'email' = 'jangh3073@gmail.com'
);

create policy "Only admin can update story images"
on storage.objects
for update
using (
  bucket_id = 'story-images'
  and auth.jwt() ->> 'email' = 'jangh3073@gmail.com'
)
with check (
  bucket_id = 'story-images'
  and auth.jwt() ->> 'email' = 'jangh3073@gmail.com'
);

create policy "Only admin can delete story images"
on storage.objects
for delete
using (
  bucket_id = 'story-images'
  and auth.jwt() ->> 'email' = 'jangh3073@gmail.com'
);
