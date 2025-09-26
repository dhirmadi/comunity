# Architecture — Monolith-First MVP

Pattern
- Django + DRF; managed Postgres; S3-compatible storage; optional Redis.

Services & Responsibilities
- Web App (Django): Auth, Profiles, Groups, Posts, Comments, Admin/Mod tools
- Database (Postgres): Primary data store; FTS; backups
- Object Storage (S3/SOS): Private bucket; signed URLs for media
- (Optional) Redis: cache/rate limit/session if needed

Data Flows
- Upload: client → app → EXIF strip → MIME allowlist → object storage → signed URL → client
- Moderation: report → queue → triage → action (remove/warn/shadowban/ban) → audit log
- Feed: query followed users/groups + member groups → keyset pagination → render

Security
- TLS, HSTS, CSP; cookie sessions + CSRF; Argon2/bcrypt; admin 2FA
- Allowlist MIME/types; sanitize markdown; least-privilege DB roles

Performance & Reliability
- p95 < 400ms @ 100 RPS; healthchecks; daily backups; single-region HA via provider

Deploy & Ops
- Containerized app; GitHub Actions → EU/CH provider; healthz endpoint; Sentry

C4 Diagrams
- See , , 
