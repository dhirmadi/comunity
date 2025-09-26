# Product Metrics & Phase Gates

Purpose: Define KPIs, SLOs, and objective go/no-go gates per phase (MVP, Alpha, Beta, GA).

## KPIs & Targets by Phase
- MVP:
  - Activation: ≥ 40% verified signups create a post/comment within 7 days
  - Safety: median time-to-first mod action < 12h
  - Reliability: p95 API < 400ms @ 100 RPS; 99.9% uptime (rolling 30d)
  - Cost: ≤ CHF 150/mo at <5k MAU
- Alpha/Beta/GA: fill based on Roadmap targets

## SLOs & Error Budgets
- API latency p95: 400ms (budget: 5% of minutes per 30d)
- Uptime: 99.9% (budget: 43m per 30d)

## Metrics → Analytics Events Mapping
- signup_verified, create_post, create_comment, report_submitted, report_actioned

## Phase Gates
- Advance when: KPIs met for 2 consecutive weeks and safety backlog < target

## Data Sources
- App analytics table (privacy-light), provider uptime, Sentry errors

## Alerts
- Pager for uptime/SLO breaches; weekly KPI report

Acceptance
- KPIs, SLOs, and gates listed per phase; tied to events.
