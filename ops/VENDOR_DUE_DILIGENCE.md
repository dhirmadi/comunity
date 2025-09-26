# Vendor Due Diligence — Hosting/CDN/Email/Storage/Video

Requirements
- ToS explicitly allow legal adult content; EU/CH data residency; incident contacts

Vendors
- Hosting: Render/Fly/Exoscale (EU/CH) — confirm adult content allowed
- DB: Managed Postgres (EU/CH); backups enabled
- Storage: S3 (Frankfurt) or Exoscale SOS (CH); private bucket; encryption
- Email: Postmark or SES (EU); bounce/spam thresholds; DMARC/SPF/DKIM

Alternatives
- CDN optional; ensure EU-only routing if used; confirm ToS

Records
- Capture approvals and links; renewal and review schedule
