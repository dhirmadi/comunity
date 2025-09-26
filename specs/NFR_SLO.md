# Non-Functional Requirements & SLOs — MVP

Security
- HTTPS/HSTS, CSP strict; CSRF; argon2/bcrypt; least-priv DB.

Performance
- p95 API < 400ms @ 100 RPS; image upload < 5s for 2MB; TTFB < 200ms EU.

Reliability
- 99.9% uptime; daily backups; health checks.

Privacy
- GDPR/FADP; export/delete; log retention ≤ 30 days (PII).

Accessibility
- WCAG 2.1 AA; keyboard nav; high-contrast mode.

Monitoring
- Sentry; basic dashboards; error budgets defined.
