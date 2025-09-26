# Security Controls Catalogue — MVP

Policy & Access
- Deny-by-default; least privilege DB user; admin 2FA; audited admin/mod actions

Transport & AppSec
- TLS 1.2+; HSTS; CSP default-src 'self'; cookie+CSRF; input validation; markdown sanitization

Data & Storage
- Server-side encryption on object storage; private bucket; signed URLs; hashed filenames; EXIF strip

Ops & Backups
- Daily backups; restore drills by GA; restricted SSH; healthchecks; rate limits

Mapping to NFRs
- Security SLOs: no critical vulns open > SLA; 2FA enabled for admins; CSP enforced
- Performance SLOs: p95 API < 400ms @ 100 RPS (see )
