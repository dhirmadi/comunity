# Functional Requirements Document (FRD) — MVP

Purpose: Translate the Feature List into atomic, testable requirements with traceability and acceptance criteria.

## FR-IDs
- FR-001 Accounts & Auth
  - Summary: Email/password, verification, reset; age confirmation.
  - Acceptance: Unverified cannot post/comment; rate limits enforced.
  - Traceability: Product Brief §4.1; Feature List §1.
- FR-002 Profiles
  - Summary: Display name, bio, avatar, privacy.
  - Acceptance: EXIF stripped on avatars; private hides posts to non-members.
  - Traceability: Brief §4.2; Feature List §2.
- FR-003 Groups
  - Summary: Create/join, visibility, rules, moderators.
  - Acceptance: Private content hidden unless member; mod actions audited.
  - Traceability: Brief §4.3; Feature List §5.
- FR-004 Posts & Comments
  - Summary: Text posts, up to 5 images; comments; markdown subset.
  - Acceptance: MIME allowlist; size ≤ 2MB/image; signed URLs.
  - Traceability: Brief §4.4; Feature List §4.
- FR-005 Follow & Feed
  - Summary: Follow users/groups; reverse-chron feed.
  - Acceptance: Keyset pagination; stable ordering.
  - Traceability: Brief §4.5; Feature List §3, §9.
- FR-006 Search (MVP)
  - Summary: Postgres FTS across users, groups, posts.
  - Acceptance: < 300ms p95 at 100k rows.
  - Traceability: Brief §4.6.
- FR-007 Reporting & Moderation
  - Summary: Report flows; mod queue; actions; audit log.
  - Acceptance: Soft-delete 30 days; action metadata recorded.
  - Traceability: Brief §4.7; Feature List §11.
- FR-008 Admin Panel
  - Summary: Flags, rate limits, role management.
  - Acceptance: All changes audited.
  - Traceability: Brief §4.9.

## Parity Matrix
- Map FetLife parity features → FR-IDs. See Feature List §17.

## Out of Scope (MVP)
- Video, DMs, realtime notifications, advanced search, native apps.

- FR-009 Rate Limits
  - Summary: Per-IP and per-user limits for signup/login/post/comment/report/search.
  - Acceptance: 429 with Retry-After; configurable; logged; safe defaults.
  - Traceability: Product Brief §26.
