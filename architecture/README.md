# Architecture — Monolith-First MVP

Pattern
- Django + DRF; managed Postgres; S3-compatible storage; optional Redis.

Data Flows
- Upload: EXIF strip → MIME allowlist → storage → signed URLs.
- Moderation: Report → queue → action → audit log.

Security
- TLS, CSP, secure cookies, CSRF, admin 2FA.
