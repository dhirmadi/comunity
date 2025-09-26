create extension if not exists pg_trgm;
create extension if not exists unaccent;

-- USERS
create table if not exists users (
  id bigserial primary key,
  email citext unique not null,
  password_hash text not null,
  dob date not null,
  verified_at timestamptz,
  is_private boolean default false not null,
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null
);

-- PROFILES
create table if not exists profiles (
  user_id bigint primary key references users(id) on delete cascade,
  display_name varchar(80) not null,
  bio varchar(500),
  location varchar(120),
  avatar_url text,
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null
);

-- GROUPS
create table if not exists groups (
  id bigserial primary key,
  owner_id bigint not null references users(id) on delete restrict,
  name varchar(120) not null,
  slug varchar(140) unique not null,
  description text,
  visibility varchar(10) not null check (visibility in ('public','private')),
  rules_md text,
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null
);
create index if not exists idx_groups_owner on groups(owner_id);

-- GROUP MEMBERS
create table if not exists group_members (
  group_id bigint not null references groups(id) on delete cascade,
  user_id bigint not null references users(id) on delete cascade,
  role varchar(10) not null check (role in ('owner','mod','member')),
  created_at timestamptz default now() not null,
  primary key (group_id, user_id)
);
create index if not exists idx_group_members_user on group_members(user_id);

-- POSTS
create table if not exists posts (
  id bigserial primary key,
  author_id bigint not null references users(id) on delete cascade,
  group_id bigint not null references groups(id) on delete cascade,
  body_md text not null,
  images jsonb default '[]'::jsonb not null,
  visibility varchar(10) not null default 'group',
  created_at timestamptz default now() not null,
  deleted_at timestamptz
);
create index if not exists idx_posts_group_created on posts(group_id, created_at desc);
create index if not exists idx_posts_author_created on posts(author_id, created_at desc);
create index if not exists idx_posts_deleted_null on posts((deleted_at is null));

-- COMMENTS
create table if not exists comments (
  id bigserial primary key,
  post_id bigint not null references posts(id) on delete cascade,
  author_id bigint not null references users(id) on delete cascade,
  body_md text not null,
  created_at timestamptz default now() not null,
  deleted_at timestamptz
);
create index if not exists idx_comments_post_created on comments(post_id, created_at asc);

-- FOLLOWS (user follows user or group)
create table if not exists follows (
  follower_id bigint not null references users(id) on delete cascade,
  subject_type varchar(10) not null check (subject_type in ('user','group')),
  subject_id bigint not null,
  created_at timestamptz default now() not null,
  primary key (follower_id, subject_type, subject_id)
);
create index if not exists idx_follows_subject on follows(subject_type, subject_id);

-- REPORTS
create table if not exists reports (
  id bigserial primary key,
  reporter_id bigint not null references users(id) on delete cascade,
  subject_type varchar(10) not null check (subject_type in ('user','post','comment')),
  subject_id bigint not null,
  reason_code varchar(30) not null,
  details text,
  status varchar(12) not null default 'open' check (status in ('open','actioned','dismissed')),
  action varchar(20),
  actor_id bigint references users(id),
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null
);
create index if not exists idx_reports_status_created on reports(status, created_at desc);

-- BLOCKS
create table if not exists blocks (
  blocker_id bigint not null references users(id) on delete cascade,
  blocked_id bigint not null references users(id) on delete cascade,
  created_at timestamptz default now() not null,
  primary key (blocker_id, blocked_id)
);

-- AUDIT LOGS
create table if not exists audit_logs (
  id bigserial primary key,
  actor_id bigint references users(id),
  action varchar(50) not null,
  target_type varchar(12) not null,
  target_id bigint,
  meta jsonb,
  created_at timestamptz default now() not null
);

-- FTS (optional MVP)
alter table if exists posts add column if not exists body_tsv tsvector;
create index if not exists idx_posts_tsv on posts using gin(body_tsv);
create or replace function posts_tsvector_trigger() returns trigger as 71338
begin
  new.body_tsv := to_tsvector('simple', unaccent(coalesce(new.body_md,'')));
  return new;
end
71338 language plpgsql;
create trigger if not exists posts_tsvector_update before insert or update of body_md on posts
for each row execute function posts_tsvector_trigger();
