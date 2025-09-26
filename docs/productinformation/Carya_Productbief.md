# MVP Product Brief — Community Platform (CH/EU)

> Working name: **Carya** (placeholder). Audience: Engineering, Design, Trust & Safety, DevOps. Goal: Ship a privacy-forward, community-based MVP focused on sexuality discussions, optimized for CH/EU deployment, with minimal ops and strong safety defaults.

---

## 1) Purpose & Goals
**Purpose:** Validate that a privacy-conscious, consent-first community for adult sexuality discussions can achieve early product-market fit in CH/EU, without heavy infrastructure.

**Primary goal (MVP):** Enable adults to sign up, join interest-based groups, post text/images, comment, follow members/groups, and report content—within a safe, moderated environment.

**Secondary goals:**
- Prove a simple content + group model leads to meaningful engagement (DAU/WAU, posts/comment ratios).
- Demonstrate moderation workflows can keep the environment safe with small staff.
- Ensure CH/EU data residency and vendor ToS alignment for adult content.

**Non-goals (MVP):** Video upload/streaming, DMs, events, complex search, realtime notifications, mobile apps.

---

## 2) Target Users & Personas
- **Explorer (25–40):** Curious, values anonymity, wants respectful, moderated spaces. KPIs: signup → first post within 48h.
- **Community Host (30–55):** Starts/curates groups, sets norms. KPIs: group creation, recurring posts, report responsiveness.
- **Lurker (20–60):** Reads more than posts. KPIs: time on site, saves/follows.
- **Moderator (staff/volunteer):** Handles reports quickly. KPIs: median report time-to-first-action < 12h.

**Constraints:** Adults only (18+). Clear consent norms. Harassment and illegal content are zero-tolerance.

---

## 3) Problem Statement (Why now)
Existing platforms either ban adult sexuality content broadly, or provide unsafe, poorly moderated spaces. We will test a middle path: consent-first, privacy-forward, EU/CH-resident platform with strong moderation tooling.

---

## 4) MVP Scope (In-Scope Features)
1. **Authentication & Accounts**
   - Email/password (Argon2 or bcrypt), email verification, password reset by email.
   - Age confirmation (checkbox + date-of-birth field). Add friction for <18 attempts.
   - Basic privacy settings: public/private profile; block/mute users.
2. **Profiles**
   - Display name, short bio, optional location (free text), avatar upload.
   - Profile visibility: public (logged-in required to view posts) vs. private.
3. **Groups (Communities)**
   - Create group (name, description, visibility: public/private). Group rules (markdown field).
   - Join/leave; owner/moderator roles; post within group scope.
4. **Posts & Comments**
   - Text posts, image attachments (up to 5 per post). Comments (flat threading).
   - Basic formatting (markdown subset), @mentions (non-notifying MVP).
5. **Following & Feed**
   - Follow users and/or groups. Feed = reverse-chron posts from followed sources + your groups.
6. **Search (MVP-simple)**
   - Postgres full-text search across users, groups, post titles/body. (No external search engine.)
7. **Moderation & Safety**
   - Report user/post/comment with reason taxonomy.
   - Admin/mod dashboard: queue, filter by type/severity, actions (remove, warn via email, ban, shadowban), audit log.
   - Block/mute, word-filter list (server-side), rate limits (IP+user).
   - EXIF stripping for images; filename sanitization; MIME checks.
8. **Content Policy & UX Gates**
   - Consent-first summary at signup, content rules in group creation, NSFW toggles, click-to-reveal for sensitive images.
9. **Admin**
   - Role assignment (admin, moderator), feature flags (DB-based), config (rate limits, upload caps).
10. **Analytics (Privacy-light)**
    - Basic events: signup, verify, create post/comment, join group, report submit/resolve.

---

## 5) Out of Scope (MVP)
- Video uploads/streaming (consider Bunny/Cloudflare Stream later).
- Direct messages.
- Realtime websockets/notifications (email digests only if needed).
- Advanced search (Meilisearch/OpenSearch).
- iOS/Android apps (mobile web only, responsive).

---

## 6) Success Metrics (MVP)
- **Activation:** ≥ 40% of verified signups create a post or comment within 7 days.
- **Engagement:** median weekly active user session length ≥ 6 minutes; ≥ 2 interactions/week (post/comment).
- **Safety:** median time-to-first moderation action on reports < 12h; removal appeal rate < 15%.
- **Reliability:** p95 API < 400ms for core endpoints at 100 RPS synthetic; 99.9% uptime over 30 days.
- **Cost:** Infra ≤ CHF 150/month at <5k MAU.

---

## 7) User Flows (Happy Paths)
1. **Signup → Verify → Create First Post**
2. **Create Group → Set Rules → Invite Members**
3. **Follow Group/User → See Feed → Comment**
4. **Encounter Violation → Report → Moderator Action**

(Design team to produce 1 low-fi and 1 hi-fi iteration per flow.)

---

## 8) Functional Requirements & Acceptance Criteria
### 8.1 Auth
- Users can create account with email/password; receive verification link.
- Passwords hashed with Argon2id or bcrypt(cost≥12). Rate limit login attempts.
- **Acceptance:** Unverified users cannot post/comment; verified state visible in DB.

### 8.2 Profiles
- Editable display name, bio (500 chars), avatar upload (<= 2MB, JPEG/PNG/WebP).
- **Acceptance:** EXIF removed; private profiles hide posts to non-followers (or strict: to non-members of group, depending on group visibility).

### 8.3 Groups
- Create with name (unique slug), description, visibility, rules.
- Owner can promote moderators; moderators can remove posts/comments and ban users within group.
- **Acceptance:** Private groups content hidden unless member.

### 8.4 Posts & Comments
- Create post with text (10k chars) and up to 5 images; comment (2k chars).
- Content stored server-side; client-side preview (markdown subset: bold, italic, link, lists).
- **Acceptance:** Invalid MIME rejected; images stored externally; URLs signed or private.

### 8.5 Feed
- Reverse-chron merge of followed users + groups + member groups.
- Pagination (cursor or keyset by `created_at, id`).
- **Acceptance:** Consistent ordering;

### 8.6 Reporting & Moderation
- Report form (type, description, optional evidence link).
- Mod queue: filter by type/status; actions: remove, ban, shadowban, warn (templated emails).
- Audit log for all mod/admin actions.
- **Acceptance:** Actions persist, are reversible (soft-delete for 30 days), and are recorded with actor, timestamp, reason.

### 8.7 Search (MVP)
- Single search box for users/groups/posts using Postgres full-text.
- **Acceptance:** Returns results < 300ms p95 at 100k rows.

### 8.8 Admin Panel
- Site-wide settings: rate limits, upload caps, blocked domains/emails, word filters.
- Role management.
- **Acceptance:** Changes audited.

---

## 9) Non-Functional Requirements
- **Security**: HTTPS only; HSTS; secure cookies; CSRF protection; content security policy (CSP) strict; password hashing argon2/bcrypt; minimal-privilege DB roles; input validation; output encoding.
- **Privacy**: GDPR/FADP compliant; delete/export account data; privacy policy/ToS; data minimization; log retention ≤ 30 days for PII.
- **Reliability**: Daily automated DB backups (PITR if provider supports); health checks; single-region HA (provider-managed).
- **Performance**: p95 core endpoints < 400ms at 100 RPS; image upload < 5s for 2MB; TTFB < 200ms from EU.
- **Accessibility**: WCAG 2.1 AA for core flows; keyboard nav; high-contrast mode.

---

## 10) Architecture (MVP, monolith-first)
**Pattern:** Single repo, monolith app + managed Postgres; object storage for media; optional Redis.

```
[ Client (Web) ]
     |
  HTTPS
     |
[ Monolith App: Django + DRF ]
  - Auth, Profiles, Groups, Posts, Comments
  - Admin & Mod Tools
  - Simple full-text search (Postgres)
     |
  ------------------------------
  |             |             |
[ Postgres ]  [ Redis* ]  [ Object Storage ]
                         (S3 eu-central-1 or Exoscale SOS CH)
*optional for sessions/cache
```

**Deployment target (MVP):**
- **Compute:** Render.com or Fly.io in EU (Frankfurt) **OR** Exoscale (CH) VM with Docker.
- **DB:** Managed Postgres (Render/Exoscale/Neon in EU).
- **Storage:** S3 (Frankfurt) or Exoscale SOS (CH), private bucket; signed URLs.
- **CDN:** Optional at MVP; if used, Cloudflare with EU-only routing.

> **Gate:** Proceed only after confirming provider ToS explicitly allow legal adult content and data residency.

**Why not Kubernetes now?** Overhead with no MVP benefit. Containers yes; orchestration minimal.

---

## 11) Tech Stack & Key Libraries
- **Backend:** Python 3.12, Django 5, Django REST Framework
- **Auth:** django-allauth (email), argon2-cffi/bcrypt
- **DB:** PostgreSQL 16 (managed); psycopg 3; Postgres FTS; pg_partman not needed yet
- **Cache/Rate limit:** Django cache (in-memory/Redis), django-ratelimit
- **Filestorage:** boto3 (S3-compatible), signed URLs, server-side encryption
- **Images:** Pillow (EXIF strip), optional imgproxy container later
- **Admin:** Django admin (hardened) + custom mod views
- **Frontend:** Django templates + HTMX (fast to build) or minimal React if team prefers
- **Email:** Postmark or SES (EU) for verification/resets
- **Analytics:** Server-side events to Postgres table (privacy-light)
- **CI/CD:** GitHub Actions (lint, test, build, deploy)
- **Monitoring:** Sentry; provider logs; uptime robot/synthetic checks

---

## 12) Data Model (Initial)
- `users(id, email, password_hash, dob, verified_at, is_private, created_at, ...)`
- `profiles(user_id PK/FK, display_name, bio, location, avatar_url, ...)`
- `groups(id, owner_id, name, slug, description, visibility, rules_md, created_at)`
- `group_members(group_id, user_id, role[owner|mod|member], created_at)`
- `posts(id, author_id, group_id, body_md, images jsonb[], visibility, created_at, deleted_at)`
- `comments(id, post_id, author_id, body_md, created_at, deleted_at)`
- `follows(follower_id, subject_type[user|group], subject_id, created_at)`
- `reports(id, reporter_id, subject_type, subject_id, reason_code, details, status[open|actioned|dismissed], action, actor_id, created_at, updated_at)`
- `blocks(blocker_id, blocked_id, created_at)`
- `audit_logs(id, actor_id, action, target_type, target_id, meta jsonb, created_at)`

**Indexes:**
- `posts(group_id, created_at desc)`, `posts(author_id, created_at desc)`
- `comments(post_id, created_at asc)`
- `follows(follower_id, created_at desc)`
- FTS GIN on `posts.body_tsv`, `profiles.display_name`, `groups.name, description`

---

## 13) API (Illustrative)
- `POST /api/v1/auth/register` `{email, password, dob}` → 200+verify
- `POST /api/v1/auth/login` → JWT or session cookie
- `GET /api/v1/profile/:id` / `PATCH /api/v1/profile`
- `POST /api/v1/groups` / `GET /api/v1/groups?query=` / `POST /api/v1/groups/:id/join`
- `POST /api/v1/posts` `{group_id, body_md, images[]}` / `GET /api/v1/feed?cursor=`
- `POST /api/v1/comments` `{post_id, body_md}`
- `POST /api/v1/follow` `{type, id}`
- `POST /api/v1/reports` `{subject_type, subject_id, reason, details}`
- `GET /api/v1/mod/reports` (admin) / `POST /api/v1/mod/action`

**Auth:** Cookie sessions (HttpOnly, Secure, SameSite=Lax). CSRF on state-changing endpoints.

---

## 14) Trust & Safety (MVP)
- **Policies:** Community Guidelines & Consent Policy; Illegal content = immediate removal + account ban.
- **Reporting:** Simple taxonomy (harassment, hate, non-consensual, illegal, spam, other).
- **Moderation:** Remove/ban/shadowban; templated warning emails; audit log; soft-delete 30 days.
- **User tools:** Block/mute, hide posts by keyword (server-filtered list).
- **Rate limiting:** Per-IP and per-user for signup, login, posting, reporting.
- **Uploads:** Max 2MB/image, 5 per post; EXIF stripped; MIME checked; allowlist of extensions.
- **Privacy:** Pseudonyms by default; avoid collecting unnecessary PII.

**Future (post-MVP):** AV scanning, nudity classifiers, human triage SLAs, appeals workflow, geofencing, device fingerprinting.

---

## 15) Security & Compliance (MVP)
- **Hosting:** EU/CH only. Vendor ToS check for adult content (blocker).
- **Transport:** TLS 1.2+; HSTS; CSP default-src 'self'; image/media from storage domain/CDN.
- **Auth:** Argon2/bcrypt; email verification; brute-force rate limits; session rotation on privilege change.
- **Data:** Server-side encryption on object storage; DB access via least privilege; regular backups.
- **Legal:** Privacy Policy, Terms of Service, Cookie banner (strictly necessary cookies only). Age confirmation. Data export/delete endpoint.
- **Admin:** 2FA on admin accounts.

---

## 16) Observability & Ops
- **Monitoring:** Sentry for errors; uptime checks for /healthz; basic p95 latency dashboard (app-level).
- **Backups:** Daily automated DB backups; verify restore monthly (staging).
- **Deploys:** GitHub Actions → Render/Fly/Exoscale; blue/green or rolling; migrations run with maintenance page if needed.
- **Runbooks:** Incident playbook (outage), Abuse escalation playbook (illegal content), Security incident playbook (account takeover).

---

## 17) Rollout Plan
1. **Dev/Stage**: Internal seed data; test flows end-to-end.
2. **Closed Alpha (50–100 users)**: Invite only, one or two niche groups. Measure activation + safety signals.
3. **Open Beta**: Gated signup with queue; add a second mod.
4. **Marketing**: Low-key, community-first; clarify jurisdiction and privacy stance.

**Kill/Proceed Criteria:** Proceed if activation > 30% and safety manageable (<3% reports leading to bans per 100 active users); otherwise revisit scopes/policies.

---

## 18) Risks & Mitigations
- **Vendor ToS revocation**: Choose EU/CH-friendly providers; containerize for portability; IaC for quick redeploy.
- **Moderation overload**: Strict rate limits; small initial community; fast reporting UX.
- **Harassment/doxxing**: Block/mute; rapid takedown; private-by-default profiles.
- **Legal**: Consult counsel; maintain logs/audit; clear takedown workflow.
- **Scope creep**: Enforce non-goals; feature flags; 6–8 week MVP cap.

---

## 19) Project Plan & Milestones (Indicative)
**M0—Architecture & Setup**: Repo, CI/CD, environment, base Django app, auth skeleton, storage wiring.
**M1—Core Entities**: Profiles, Groups, Posts, Comments; CRUD + templates/API; media upload + EXIF strip.
**M2—Feeds & Follows**: Follow model, feed queries, pagination, basic search (Postgres FTS).
**M3—Moderation**: Report flows, mod dashboard, actions, audit log, rate limits.
**M4—Polish & Observability**: Admin hardening, analytics events, perf tuning, accessibility pass, backup/restore test.
**M5—Alpha Launch**: Seed groups, onboard mods, collect metrics.

---

## 20) Team & Responsibilities
- **PM (you)**: Scope, prioritization, KPI tracking, policies alignment.
- **Tech Lead**: Architecture, code review, security.
- **Backend Engineer(s)**: Models, API, moderation tools, storage.
- **Frontend/Full-stack**: Templates/HTMX (or React), accessibility, responsive.
- **Trust & Safety**: Policies, moderator training, escalation.
- **DevOps-lite**: CI/CD, backups, monitoring (can be shared).

---

## 21) Budget (MVP ballpark, monthly)
- Compute (Render/Fly or Exoscale VM): CHF 20–60
- Managed Postgres: CHF 20–40
- Storage + egress (S3/SOS): CHF 10–30
- Email (Postmark/SES): CHF 10–20
- Sentry/Monitoring: CHF 0–20 (free tier likely)
**Total:** ~CHF 60–170 / month at small scale.

---

## 22) Future Roadmap (Post-MVP)
- **Video** (provider or self-managed pipeline), **DMs**, **Events** with RSVPs.
- **Realtime** notifications; **Meilisearch** then **OpenSearch**.
- **Advanced Safety**: AV scan, classifiers, geo/age controls, appeals.
- **Mobile apps** (React Native), passkeys.
- **Scale**: Move to Cloud Run/ECS or K8s; introduce Redis jobs; outbox pattern; CDN.

---

## 23) Appendix: Definitions & Policies
- **Visibility:** Public (login required to interact), Private (members only).
- **Shadowban:** Content visible to user but not to others (mod-only tool).
- **Reason codes (reports):** Harassment, Hate, Non-consensual, Illegal, Spam, Other.
- **Content norms:** No minors; no doxxing; consensual adult content only; follow group rules; respect boundaries.

---

### Final Notes
- Keep it simple; optimize for safety and speed-to-learning.
- Containerize, deploy in EU/CH, keep media external, and make reporting frictionless.
- Reassess at Alpha exit using activation + safety KPIs to decide next investments.



---

## 24) Low‑Fi Wireframes (text)
**Home / Feed**
- Header: logo • Search • Create Post • Profile menu
- Left rail: Your Groups (list) • Discover Groups
- Main: Composer (textarea + add images) → Post
  - Post card: avatar • display name • group chip • timestamp • body • images (grid) • actions (comment, report)
- Right rail: Suggestions (groups/users)

**Group Page**
- Header: Group name • Join/Leave • Members • Rules
- Tabs: Posts | About | Members
- Admin/Mod: Actions (remove post, ban user)

**Profile**
- Avatar • Display Name • Bio • Follow/Unfollow • Block
- Tabs: Posts | Groups | About

**Report Flow**
- Modal: Subject (auto) • Reason (select) • Details (textarea) • Submit
- Confirmation toast

**Mod Queue**
- Filters: Type • Status • Severity • Date
- Table: Item • Reporter • Reason • Age • Actions (View, Remove, Ban, Shadowban)
- Detail panel: Evidence, history, audit log

**Auth**
- Sign up: email • password • DOB (date) • consent checkbox • Create Account
- Verify screen: "Check your email"
- Login: email • password • Forgot link

---

## 25) Database DDL (PostgreSQL 16)
> Note: stores post images in `images jsonb` for MVP. App enforces ≤ 5 images and size.

```sql
create extension if not exists pg_trgm;
create extension if not exists unaccent;

-- USERS
create table users (
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
create table profiles (
  user_id bigint primary key references users(id) on delete cascade,
  display_name varchar(80) not null,
  bio varchar(500),
  location varchar(120),
  avatar_url text,
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null
);

-- GROUPS
create table groups (
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
create index idx_groups_owner on groups(owner_id);

-- GROUP MEMBERS
create table group_members (
  group_id bigint not null references groups(id) on delete cascade,
  user_id bigint not null references users(id) on delete cascade,
  role varchar(10) not null check (role in ('owner','mod','member')),
  created_at timestamptz default now() not null,
  primary key (group_id, user_id)
);
create index idx_group_members_user on group_members(user_id);

-- POSTS
create table posts (
  id bigserial primary key,
  author_id bigint not null references users(id) on delete cascade,
  group_id bigint not null references groups(id) on delete cascade,
  body_md text not null,
  images jsonb default '[]'::jsonb not null,
  visibility varchar(10) not null default 'group',
  created_at timestamptz default now() not null,
  deleted_at timestamptz
);
create index idx_posts_group_created on posts(group_id, created_at desc);
create index idx_posts_author_created on posts(author_id, created_at desc);
create index idx_posts_deleted_null on posts((deleted_at is null));

-- COMMENTS
create table comments (
  id bigserial primary key,
  post_id bigint not null references posts(id) on delete cascade,
  author_id bigint not null references users(id) on delete cascade,
  body_md text not null,
  created_at timestamptz default now() not null,
  deleted_at timestamptz
);
create index idx_comments_post_created on comments(post_id, created_at asc);

-- FOLLOWS (user follows user or group)
create table follows (
  follower_id bigint not null references users(id) on delete cascade,
  subject_type varchar(10) not null check (subject_type in ('user','group')),
  subject_id bigint not null,
  created_at timestamptz default now() not null,
  primary key (follower_id, subject_type, subject_id)
);
create index idx_follows_subject on follows(subject_type, subject_id);

-- REPORTS
create table reports (
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
create index idx_reports_status_created on reports(status, created_at desc);

-- BLOCKS
create table blocks (
  blocker_id bigint not null references users(id) on delete cascade,
  blocked_id bigint not null references users(id) on delete cascade,
  created_at timestamptz default now() not null,
  primary key (blocker_id, blocked_id)
);

-- AUDIT LOGS
create table audit_logs (
  id bigserial primary key,
  actor_id bigint references users(id),
  action varchar(50) not null,
  target_type varchar(12) not null,
  target_id bigint,
  meta jsonb,
  created_at timestamptz default now() not null
);

-- FTS (optional MVP)
alter table posts add column body_tsv tsvector;
create index idx_posts_tsv on posts using gin(body_tsv);
create function posts_tsvector_trigger() returns trigger as $$
begin
  new.body_tsv := to_tsvector('simple', unaccent(coalesce(new.body_md,'')));
  return new;
end
$$ language plpgsql;
create trigger posts_tsvector_update before insert or update of body_md on posts
for each row execute function posts_tsvector_trigger();
```

---

## 26) Rate Limits & Abuse Controls (MVP)
- **Signup**: 3/hour/IP, 1/minute/IP, captcha after 2 failures.
- **Login**: 10/min/IP, lockout after 10 bad passwords for 15 min.
- **Post create**: 6/hour/user; burst 2/min.
- **Comment**: 20/hour/user; burst 5/min.
- **Report**: 10/hour/user.
- **Search**: 30/min/user.
- **Media upload**: 20/hour/user, max 2MB per image.
- **Global**: 429 with `Retry-After`; server-side word/URL filters; blocked email domains list.

Implementation: `django-ratelimit` middleware + per-route keys (user id or IP). Track velocity in Redis if available; otherwise default in-memory with conservative values.

---

## 27) Environment & Secrets (.env template)
```
DJANGO_SECRET_KEY=change-me
DJANGO_DEBUG=false
ALLOWED_HOSTS=app.example.ch
DB_URL=postgres://user:pass@host:5432/db
REDIS_URL=redis://:pass@host:6379/0
STORAGE_BACKEND=s3
S3_ENDPOINT=https://s3.eu-central-1.amazonaws.com
S3_BUCKET=carya-media
S3_REGION=eu-central-1
S3_ACCESS_KEY=...
S3_SECRET_KEY=...
EMAIL_BACKEND=postmark
POSTMARK_TOKEN=...
SECURE_SSL_REDIRECT=true
SESSION_COOKIE_SECURE=true
CSRF_COOKIE_SECURE=true
```

---

## 28) Deploy Checklists
### A) Render.com (EU)
1. **Repository** connected; **Dockerfile** present, `PORT` respected.
2. Create **Web Service** (Frankfurt region), autoscaling off initially. Set env vars from `.env` (use Render Secrets).
3. Provision **Managed PostgreSQL** (EU); enable daily backups; set connection string.
4. (Optional) Provision **Redis**. Point `REDIS_URL`.
5. Configure storage: use **S3 (Frankfurt)** or **Exoscale SOS (CH)**; set bucket policy private; app uses signed URLs.
6. Healthcheck endpoint `/healthz` returning 200.
7. Configure allowed hosts, HSTS, HTTPS redirect.
8. Logs & alerts: connect to Sentry; set Render alerts on restarts/failures.
9. Domain: add custom domain, Render TLS.
10. Test: signup, verify, create post with image, report flow, admin actions.

### B) Exoscale (CH) VM + Docker
1. Create **Ubuntu LTS** instance (2 vCPU / 4GB), security group: 80/443 open; 22 restricted.
2. Install Docker & Docker Compose; keep system patched.
3. Reverse proxy: **Caddy** or **Traefik** with auto TLS; redirect HTTP→HTTPS; HSTS.
4. App container (monolith), `.env` mounted as secrets. Run as non-root; read-only FS except `/tmp`.
5. DB: use **Managed DBaaS** (Exoscale PostgreSQL) or dedicated Postgres VM (if so, enable PITR and backups).
6. Object storage: **Exoscale SOS** bucket (private). Configure credentials with least privilege.
7. Backups: `pg_dump` nightly to SOS with encryption and retention policy.
8. Monitoring: fail2ban/ufw if self-hosted DB; Sentry in app; Prometheus node exporter optional.
9. Domain & DNS: point A/AAAA to VM; CDN optional.
10. Smoke tests: same as above.

---

## 29) CI/CD Example (GitHub Actions → Render)
```yaml
name: ci-cd
on:
  push:
    branches: [ main ]
jobs:
  build-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with: { python-version: '3.12' }
      - run: pip install -r requirements.txt
      - run: pytest -q
  deploy-render:
    needs: build-test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: render-examples/gh-actions/deploy@v1
        with:
          serviceId: ${{ secrets.RENDER_SERVICE_ID }}
          apiKey: ${{ secrets.RENDER_API_KEY }}
```

---

## 30) Moderator Email Templates (snippets)
**Warning (Harassment):**
"Hello {{display_name}},

We removed your content for violating our Harassment policy. Please review our Guidelines: {{link}}. Further violations may lead to suspension.

— Carya Safety Team"

**Ban Notice:**
"Your account has been suspended for repeated violations. You may appeal by replying to this email within 7 days."

---

## 31) Threat Model (MVP quick pass)
- **Abuse**: spam signups → rate limits + email verification.
- **Account takeover**: credential stuffing → rate limits + 2FA for admins; user education.
- **XSS/CSRF**: markdown sanitization; CSP; CSRF tokens on state changes.
- **SSRF/RCE**: never fetch remote URLs on server; strict file type checks.
- **Data exfiltration**: least-privilege DB user; no direct object URLs without signature; rotate keys quarterly.

---

## 32) QA Test Plan (Smoke)
- Auth: signup/verify/login/reset; rate limits trigger.
- Profiles: edit fields; upload avatar; privacy toggle.
- Groups: create/join/leave; private visibility enforcement.
- Posts: create with images; markdown render; pagination; delete.
- Comments: add/delete; ordering correct.
- Feed: follows affect content; ordering stable; private groups excluded when not a member.
- Reports: submit; mod sees & action; audit log entries created.
- Performance: seed 100k posts; search returns <300ms; feed <400ms p95.
- Backups: take and restore to staging; verify integrity.

---

## 33) Open Questions / Decisions to Make
- Use HTMX vs minimal React for MVP UI? (Team vote)
- Choose primary region: CH (Exoscale) vs DE (Frankfurt) depending on cost/latency.
- Pick email provider: Postmark vs SES (EU). 
- Set initial invite policy (closed alpha vs open waitlist).

---

## 34) Next Actions (1–2 weeks)
1. Confirm vendors & ToS (hosting, storage, email).
2. Scaffold Django app, auth, and models from this DDL.
3. Implement file upload to S3/SOS with EXIF strip + MIME checks.
4. Build group/post/comment flows and basic feed.
5. Implement reports + mod dashboard + audit log.
6. Wire Sentry, healthcheck, backups.
7. Deploy to chosen EU/CH target and run smoke tests.
8. Prepare content policies and moderator onboarding.

