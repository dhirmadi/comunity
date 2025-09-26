# Product Metrics & Phase Gates

Purpose: Define KPIs, SLOs, and objective go/no‑go gates per phase (MVP, Alpha, Beta, GA).

## KPIs & Targets by Phase
### MVP
- Activation: ≥ 40% verified signups create a post/comment within 7 days
- Safety: median time‑to‑first moderation action < 12h
- Reliability: p95 API < 400ms @ 100 RPS; 99.9% uptime (rolling 30d)
- Cost: ≤ CHF 150/mo at <5k MAU

### Alpha
- Activation: ≥ 45%; DAU/WAU ≥ 0.35
- Safety: median TTF action < 12h; appeal uphold 60–80%
- Reliability: p95 API < 350ms @ 150 RPS; 99.9% uptime
- Email deliverability: bounce < 1%, spam complaints < 0.1%

### Beta
- Activation: ≥ 50%; DAU/WAU ≥ 0.40
- Safety: backlog < 24h; abuse recidivism < 5%
- Reliability: p95 API < 300ms @ 200 RPS; 99.9% uptime
- Privacy: export/delete live; DPIA/ROPA approved

### GA
- Churn within target; 99.9% uptime 30‑day rolling; median TTF action < 6h
- Restore drill success; transparency report v2 published

## SLOs & Error Budgets
- API latency p95: 400ms (budget: 5% of minutes per 30d)
- Uptime: 99.9% (budget: 43m/30d)
- Moderation TTF: 12h median (budget: 10% of items allowed to breach)

## Metrics → Analytics Events Mapping
- signup_verified, create_post, create_comment, report_submitted, report_actioned, follow_created

## Phase Gates
- Advance when: KPIs met for 2 consecutive weeks and safety backlog < target
- Security gates: TLS/HSTS/CSP, admin 2FA, backups enabled (pre‑MVP)

## Data Sources
- App analytics table (privacy‑light), provider uptime, Sentry errors, moderation queue

## Alerts
- Pager for uptime/SLO breaches; weekly KPI digest to team

Acceptance
- KPIs, SLOs, and gates listed per phase; tied to events; dashboards configured.
