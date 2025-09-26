# Observability Plan — MVP

Signals
- Logs: app logs (info/error), auth failures, moderation actions
- Metrics: p95 latency by endpoint, error rate, queue depths, DB connections
- Traces: request spans for slow endpoints (optional MVP)

Dashboards
- API latency (p50/p95), error rate (4xx/5xx), feed freshness, moderation backlog

Alerting
- p95 latency > SLO, error rate spikes, queue backlog > threshold, uptime failures

Implementation
- Sentry for errors; provider uptime checks; lightweight metrics (exporter or app endpoints)

Runbooks
- Link to ops/RUNBOOKS.md for incident/response procedures
