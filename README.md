# Carya — Spec‑First Community Platform (CH/EU)

Carya is a privacy‑forward, consent‑first community platform focused on adult sexuality discussions. The project is built spec‑first and optimized for development in Cursor with repository rules and task‑specific agents.

## MVP Overview
- Adults‑only signup with email verification and age confirmation
- Profiles, Groups (public/private), Posts (text + up to 5 images), Comments
- Follow users/groups and a reverse‑chron Home Feed
- Reporting and Moderation Queue with audit logs and rate limits
- Basic Postgres FTS search (users, groups, posts)
- Admin settings (rate limits, flags) and privacy‑light analytics

Out of scope (MVP): video uploads, direct messages, realtime notifications, advanced search, native apps.

## Architecture (monolith‑first)
- Backend: Django + DRF, managed Postgres
- Media: S3‑compatible object storage (S3 eu‑central‑1 or Exoscale SOS CH)
- Security: HTTPS/HSTS/CSP, cookie sessions + CSRF, Argon2/bcrypt
- Observability: Sentry, healthchecks, simple latency dashboards

See `architecture/README.md` and `architecture/c4/*.puml`.

## Spec‑First Workflow
1) Define/update specs → 2) Record decisions → 3) Update architecture/data → 4) Author OpenAPI → 5) Implement
- Phase gates: code begins only after T01–T12 are Done and T13–T18 ≥ Review (see To‑Do)
- Traceability: PRs must list FR‑IDs and link to spec files; decisions go to `governance/DECISIONS.md`

Key specs and docs
- Product Brief: `docs/productinformation/Carya_Productbief.md`
- Feature List: `docs/productinformation/Carya_Feature_List.md`
- Roadmap: `docs/productinformation/Carya_Roadmap.md`
- Spec To‑Do: `docs/productinformation/Carya_Document_Create_TODO.md`

## Repository Structure
- Specs: `specs/FRD.md`, `specs/NFR_SLO.md`, `specs/taxonomies.yaml`
- Governance: `governance/RACI.md`, `governance/DECISIONS.md`
- Architecture: `architecture/README.md`, `architecture/c4/*`
- Data: `data/DDL.sql`
- API: `api/openapi.yaml`
- Safety & Privacy: `safety/*`, `privacy/*`
- Security & Ops/QA: `security/*`, `ops/*`, `qa/*`
- Comms/Program/Design: `comms/*`, `program/*`, `design/*`

## Cursor Setup
- Rules (always on): `.cursor/rules/core.mdc`, `.cursor/rules/spec-first.mdc`
- Agents (on demand): `.cursor/agents/*.mdc` (e.g., `document-review.mdc`, `spec-author.mdc`, `openapi-author.mdc`, `data-modeler.mdc`, `safety-policy.mdc`, `security-privacy.mdc`, `ops-qa.mdc`, `governance.mdc`, `ai-ml.mdc`, `comms.mdc`)

Recommended flow in Cursor
- Start with `document-review.mdc` to reconcile `docs/productinformation/*`
- Use `spec-author.mdc` to expand `specs/FRD.md` and `specs/NFR_SLO.md`
- Use `openapi-author.mdc` to flesh out `api/openapi.yaml` with schemas and examples
- Use `data-modeler.mdc` to refine `data/DDL.sql` and migrations
- Use `safety-policy.mdc` and `security-privacy.mdc` for moderation, DPIA/ROPA, controls

## Contributing
- Follow `CONTRIBUTING.md` (spec‑first). Open issues via `.github/ISSUE_TEMPLATE/*` for FRD, NFR, Decisions, OpenAPI, Data, Safety.
- In every PR: list FR‑IDs, link specs, confirm acceptance criteria, note safety/privacy impacts.

## Metrics & Gates (MVP targets)
- Activation ≥ 40% (7‑day post/comment), p95 API < 400ms @ 100 RPS, median mod TTF < 12h, 99.9% uptime, ≤ CHF 150/mo at <5k MAU
- See `product/METRICS_AND_GATES.md`

## Legal & Safety
- Consent‑first; minors strictly prohibited; explicit bans on non‑consensual/illegal content
- Transparency reporting and appeals (community quorum) — see `safety/*` and `comms/*`

