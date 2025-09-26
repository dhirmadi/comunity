# Carya MVP — End‑to‑End Implementation Plan (for Cursor with GPT‑5)

Purpose
- Single‑session, spec‑first build of the Carya MVP monolith (Django + DRF) using repo specs.
- Strictly follow the approved documents; reference FR‑IDs and DEC‑IDs.

Preconditions
Key Decisions (DEC)
- DEC‑0001: DMs & Events are Post‑MVP; Video Post‑MVP
- DEC‑0002: UI approach HTMX + Django templates for MVP
- DEC‑0003: Primary region CH (Exoscale) preferred
- DEC‑0004: Email provider Postmark (EU endpoints)
- DEC‑0005: Cookie + CSRF auth (no JWT for web)
- DEC‑0006: Media storage Exoscale SOS (CH) preferred over S3 (DE)

- Confirm Go in program/GO_NO_GO.md (set to Go)
- Use CH/EU region providers; confirm vendor ToS allow legal adult content
- Ensure the following docs are up to date and treated as source of truth:
  - docs/productinformation/Carya_Productbief.md
  - docs/productinformation/Carya_Feature_List.md
  - docs/productinformation/Carya_Roadmap.md
  - docs/productinformation/Carya_Document_Create_TODO.md
  - specs/FRD.md, specs/NFR_SLO.md, specs/taxonomies.yaml
  - architecture/README.md, architecture/c4/*.puml
  - data/DDL.sql
  - api/openapi.yaml
  - safety/Moderation_Governance.md, safety/ORCHESTRATION.md
  - privacy/DPIA.md, privacy/ROPA.md, privacy/RETENTION_SCHEDULE.md
  - security/THREAT_MODEL.md, security/CONTROLS.md, security/IR_PLAYBOOK.md
  - ops/OBSERVABILITY.md, ops/RUNBOOKS.md, ops/VENDOR_DUE_DILIGENCE.md
  - design/*, comms/*, governance/*

Architecture & Tech Stack
- Monolith‑first: Django 5 + DRF, Python 3.12
- Managed Postgres 16; Postgres FTS; Exoscale SOS (CH) preferred (DEC‑0006) or S3 (DE) with signed URLs
- Optional Redis for cache/rate limiting
- Cookie sessions + CSRF (DEC‑0005); HTTPS/HSTS/CSP; Argon2/bcrypt
- Sentry for errors; healthchecks; basic p95 dashboarding per NFRs

Global Build Strategy (Single Go)
1) Bootstrap project & env
2) Implement data models per data/DDL.sql
3) Wire storage, security, middleware, rate limits
4) Implement API per api/openapi.yaml with DRF
5) Implement moderation flows per safety/*
6) Admin, feature flags, configs
7) Observability, healthchecks, backups
8) Tests mapped to FR‑IDs; Release Criteria checks
9) Seed data & smoke tests
10) CI/CD workflow and deploy scaffolding

Acceptance Gates
- All FR‑IDs implemented with acceptance satisfied (specs/FRD.md)
- NFR/SLOs and error budgets covered (specs/NFR_SLO.md, ops/OBSERVABILITY.md)
- Security/Privacy controls wired (security/*, privacy/*)
- OpenAPI accurate and example‑complete (api/openapi.yaml)

Detailed Instructions

0) Repo & Environment Setup
- Create Python toolchain files:
  - requirements.txt with: Django==5.*, djangorestframework, django-allauth, argon2-cffi, bcrypt, psycopg[binary]==3.*, django-ratelimit, pillow, boto3, python-dotenv, sentry-sdk, whitenoise, gunicorn
  - .env template per Product Brief §27; do not commit secrets
- Create Django project: carya/ and apps:
  - accounts, profiles, groups, posts, comments, follows, reports, moderation, audit, core (settings), api
- Configure settings:
  - Security: SECURE_SSL_REDIRECT, HSTS, CSP, SESSION_COOKIE_SECURE, CSRF_COOKIE_SECURE
  - Auth: allauth email, Argon2/bcrypt
  - DB: Postgres via DATABASE_URL
  - Storage: boto3 S3/SOS; private bucket; presigned upload/view; size caps; MIME allowlist
  - Caches/Rate limit: Redis (if available) + django-ratelimit
  - Logging: JSON logs in production; Sentry init
  - Health: /healthz view

1) Data Model (FR‑IDs: 001–008, 009)
- Implement Django models mirroring data/DDL.sql tables:
  - users, profiles, groups, group_members, posts, comments, follows, reports, blocks, audit_logs
- Add DB indices per DDL; add FTS body_tsv trigger or approximate with Django signals
- Enforce image limits (≤ 5) and MIME/type allowlist; EXIF strip via Pillow
- Soft delete where required (posts/comments with deleted_at)

2) Storage & Upload Pipeline
- Centralized upload service: validate extension/MIME, EXIF strip, size limits
- Generate presigned URLs for client upload and server retrieval; store object keys only
- Deny public bucket; all access via signed URLs

3) Security & Privacy
- Cookie sessions + CSRF; CSRF on state changes
- CSP default-src 'self'; allow storage host for images
- Admin 2FA (at least for admin accounts)
- Data minimization; add deletion/export stubs to align with privacy docs

4) API Implementation (DRF) per api/openapi.yaml
- Define serializers and viewsets for:
  - Auth: register/login/logout (login per spec), session cookie
  - Profiles: GET/PATCH
  - Groups: POST/GET (list/search)
  - Posts: POST
  - Comments: POST
  - Follows: POST (if included now; else stage later)
  - Reports: POST
- Use a unified error envelope schema; include examples from OpenAPI
- Add pagination (keyset/cursor) for feeds and listing endpoints

5) Business Logic & Policies
- Visibility: enforce group privacy and profile settings on list/detail
- Moderation queue: CRUD for reports + admin actions (remove, warn, shadowban, ban) with audit log entries
- Rate limits per FR‑009: signup/login/post/comment/report/search/media
- Blocks: hide blocked users’ content and interaction

6) Admin & Tools
- Hardened Django admin; custom admin pages for moderation queue and audit logs
- Feature flags in DB for toggling risky features

7) Observability & Ops
- /healthz endpoint (200 OK)
- Sentry SDK wired; basic structured logs
- Management commands: backup_db_stub, seed_demo_data

8) Tests & Release Gates
- Unit tests for models/utils; integration for endpoints; smoke E2E flow (signup→post→report→moderate)
- Tag tests with FR‑IDs; ensure Release Criteria in qa/RELEASE_CRITERIA.md are met

9) CI/CD & Deploy Scaffolding
- GitHub Actions:
  - Lint/test on PRs; spell‑check (codespell) already configured
  - Optional build & deploy to EU/CH provider (CH preferred per DEC‑0003)
- Containerization: Dockerfile; healthcheck; env via secrets

10) Documentation Hooks
- Keep OpenAPI in sync; update schema examples if needed
- Update specs/FRD.md acceptance if implementation nuances evolve; log DEC‑IDs

Milestone Smoke Tests (must pass)
- Signup/verify/login; create profile; create group; create post with images; comment; follow; see feed; report; moderator acts; audit trail; rate limits trigger; search < 300ms on 100k rows

Env Vars (sample)
- DJANGO_SECRET_KEY, DJANGO_DEBUG, ALLOWED_HOSTS, DB_URL, REDIS_URL, STORAGE_BACKEND, S3_*, EMAIL_BACKEND, POSTMARK_TOKEN, SECURE_SSL_REDIRECT, SESSION_COOKIE_SECURE, CSRF_COOKIE_SECURE

Non‑Goals (MVP, per DEC‑0001)
- DMs, video upload/streaming, realtime notifications, advanced search, native apps

References
- specs/FRD.md; specs/NFR_SLO.md; api/openapi.yaml; data/DDL.sql; safety/*; privacy/*; security/*
