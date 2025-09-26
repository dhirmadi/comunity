# Threat Model — STRIDE (MVP)

Components
- Django App, Managed Postgres, Object Storage, Email Provider, Optional Redis

STRIDE Analysis (high level)
- Spoofing: credential stuffing → rate limits, bcrypt/argon2, 2FA (admins)
- Tampering: request forgery → CSRF tokens; input validation; markdown sanitization
- Repudiation: audit logs for mod/admin actions with actor, timestamp, reason
- Information Disclosure: private media → signed URLs, bucket private, per-post visibility
- Denial of Service: rate limits per IP/user; burst limits on posts/comments/reports
- Elevation of Privilege: role checks in policy; deny-by-default; admin actions gated

Top Risks & Owners
- Account Takeover (Tech Lead) — mitigations: rate limits, password hashing, admin 2FA
- Abuse/Harassment (Safety Lead) — mitigations: report flow, moderation SLAs, block/mute
- Sensitive Media Leakage (Tech Lead) — mitigations: signed URLs, private buckets, access checks

Monitoring
- Sentry errors; 4xx/5xx rates; moderation backlog; auth failures velocity
