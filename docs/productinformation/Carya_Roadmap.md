
# Carya Platform — Full Roadmap (MVP → GA and beyond)  
_Last updated: 2025-09-26_

> Delivery is **incremental**, safety-first, with automated/community moderation from day one. Phases are outcomes-based, not date-based; advance when KPIs and safety gates are met.

> Scope decisions: DMs/Events are Post‑MVP per DEC‑0001.

---

## Phase 0 — Foundations (Weeks 1–2)
**Goals:** Repo + CI/CD, EU/CH hosting choice, auth skeleton, minimal UI.

**Deliverables**
- Containerized monolith (Django), baseline models (users, profiles, groups, posts, comments).
- Email verification, password reset; age gate; consent/ToS acceptance.
- Object storage wiring; image upload; EXIF strip; per-post visibility.
- Postgres FTS search (basic).
- Rate limiting middleware; audit logging; Sentry.

**Safety Gates**
- HTTPS/HSTS; CSP; admin 2FA; backups enabled.
- Vendor ToS checked for adult content; EU/CH data residency configured.

---

## Phase 1 — MVP (Weeks 3–8)
**Goals:** Prove core loops: create → consume → interact → report.

**Deliverables**
- Profiles with orientation/roles/fetishes; consent profile.
- Groups (public/private) with rules; join/leave; group mods.
- Posts (text + up to 5 images), comments, likes.
- Friends/follow; **Home feed** (reverse-chron from follows/groups).
- **Reports** + queue; community quorum proto; block/mute; word filters.

**Safety Automation v1**
- Upload pipeline: MIME allowlist, EXIF strip, size limits, simple NSFW classifier, spam heuristics.
- Text toxicity heuristic + keyword filters.

**KPIs to advance**
- Activation ≥ 30%; report median TTF action < 24h (community-only).

---

## Phase 2 — Alpha (Weeks 9–14)
**Goals:** Scale moderation without staff; improve discovery; polish.

**Deliverables**
- Events (basic create/RSVP/list) without ticketing. (DEC‑0001)
- Messaging (DMs) with inbox privacy filters and message requests.
- Explore/Trending (safe-mode toggle); location-based discovery (opt-in city/region).
- Group automod: slow mode, first-post approval, link spam detection.
- Consent checklist on events; feedback channel post-event.
- Digest emails; notification preferences.

**Safety Automation v2**
- AV scanning; pHash similarity checks; reputation-weighted triage; progressive throttles for new accounts.
- Community reputation model seeded; appeal workflow with separate quorum.

**KPIs to advance**
- Median TTF action < 12h; false-positive rate < 10%; appeal uphold rate 60–80%.

---

## Phase 3 — Beta (Weeks 15–22)
**Goals:** Performance, media, and moderation maturity.

**Deliverables**
- Video uploads (provider-backed), click-to-reveal, signed playback.
- Meilisearch for richer search; search privacy guardrails.
- Event enhancements: host verification (optional), capacity limits, attendee privacy controls.
- Transparency report v1; admin dashboards; export/delete data self-service.

**Safety Automation v3**
- ML text models for harassment/hate/grooming; URL reputation; device/velocity fingerprints.
- Geo/IP blocks for sensitive groups; jurisdiction-aware policy flags.

**Scalability**
- Redis for caching/queues; background jobs for feed/materialization; CDN for media.

**KPIs to advance**
- p95 API < 400ms @ 100 RPS; moderation backlog < 24h; abuse recidivism < 5%.

---

## Phase 4 — GA (Weeks 23–30)
**Goals:** Supporter monetization; reliability & governance.

**Deliverables**
- Supporter tier (ad-free, extended activity history, video perks) — no engagement paywalls.
- Consent education hub; negotiation templates; safety check-ins.
- Multilingual polish (DE/FR/IT); accessibility pass (WCAG AA).
- Incident runbooks; transparency report v2; formal appeals SLAs.

**Reliability**
- PITR DB; restore drill; synthetic monitoring for signup/post/upload.

**KPIs to exit GA**
- 99.9% uptime rolling 30d; median report TTF action < 6h; churn < target.

---

## Phase 5 — Scale-Up (Post-GA)
**Options based on traction**
- Realtime notifications; hybrid fanout feeds; events ticketing.
- OpenSearch migration; outbox/CDC; analytics warehouse (privacy-first).
- Federation pilots for inter-community portability (ActivityPub-style, scoped).
- Mobile apps (React Native) with passkeys.

---

## Cross-Cutting Workstreams
- **Policy & Safety**: evolving taxonomy, country/jurisdiction rules, child-safety guardrails.
- **Privacy**: data minimization, per-field audience controls, retention schedules.
- **Observability**: OTel traces, dashboards, error budgets gating deploys.
- **Community**: onboarding helpers, community guidelines, code of conduct updates.

---

## Risk Register & Mitigations
- **Vendor ToS changes** → container portability; multi-cloud storage; IaC.
- **Moderation overload** → stricter defaults, increased thresholds, invite-only growth.
- **Model drift (AI)** → human-in-the-loop audits on samples; re-train cadence.
- **Legal takedowns** → standardized process; verified requester workflow.

---

## Acceptance Gates per Phase (condensed)
- **Security**: TLS, CSP, admin 2FA, backups ✔ before MVP.
- **Safety**: automod on uploads + reports + community quorum ✔ before MVP.
- **Privacy**: export/delete ✔ by Beta.
- **Reliability**: restore drill ✔ by GA.

---

## Resourcing (minimum viable)
- 2x full-stack, 1x backend, 0.5x designer, 0.5x PM, 0.5x policy/safety advisor (contract). Community volunteers for moderation quorum.
