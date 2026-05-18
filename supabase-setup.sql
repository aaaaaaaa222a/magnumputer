-- Supabase SQL Editor에서 한 번 실행하세요.
-- 이 설정은 스토리는 누구나 읽을 수 있고, 글 작성/수정/삭제는 관리자 이메일만 가능하게 만듭니다.

create table if not exists public.stories (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  title text not null,
  content text not null,
  created_at timestamp with time zone default now()
);

alter table public.stories enable row level security;

drop policy if exists "Anyone can read stories" on public.stories;
drop policy if exists "Admin can insert stories" on public.stories;
drop policy if exists "Admin can update own stories" on public.stories;
drop policy if exists "Admin can delete own stories" on public.stories;

create policy "Anyone can read stories"
on public.stories
for select
using (true);

create policy "Admin can insert stories"
on public.stories
for insert
to authenticated
with check (
  auth.jwt() ->> 'email' = 'jangh3073@gmail.com'
  and auth.uid() = user_id
);

create policy "Admin can update own stories"
on public.stories
for update
to authenticated
using (
  auth.jwt() ->> 'email' = 'jangh3073@gmail.com'
  and auth.uid() = user_id
)
with check (
  auth.jwt() ->> 'email' = 'jangh3073@gmail.com'
  and auth.uid() = user_id
);

create policy "Admin can delete own stories"
on public.stories
for delete
to authenticated
using (
  auth.jwt() ->> 'email' = 'jangh3073@gmail.com'
  and auth.uid() = user_id
);
