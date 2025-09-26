# Data Protection Impact Assessment (DPIA) — Carya MVP

Purpose
- Assess data processing risks, mitigations, and residual risks for the MVP deployment in CH/EU.

Scope
- Systems: Django app (monolith), Managed Postgres, S3/SOS object storage, Email provider
- Users: Adults (18+); pseudonymous by default

Data Inventory (by category)
- Account: email, password_hash, dob, verified_at
- Profile: display_name, bio, location (free text), avatar_url
- Social: follows, group membership
- Content: posts (body_md, images[]), comments
- Moderation: reports (subject, reason, details), audit_logs
- Security/Ops: IPs in logs (minimized), analytics events (privacy-light)

Lawful Basis
- Account & core features: contract performance
- Moderation: legitimate interest + legal compliance
- Communications (verification/resets): legitimate interest
- Analytics (privacy-light): legitimate interest with minimization

Risks & Mitigations
- Unauthorized access → HTTPS/HSTS/CSP, least-priv DB, cookie+CSRF, 2FA for admins
- Sensitive content exposure → private buckets, signed URLs, per-post visibility, EXIF strip
- Data minimization → avoid unnecessary PII; limit logs to ≤ 30 days with redaction
- Rights handling → export/delete workflow; verified requests only

DSR Workflows
- Access/Export: user-initiated request → generate package from DB/object storage → deliver via secure link (time-limited)
- Deletion: soft-delete (30 days) → purge; media objects deleted; audit exception list for legal holds
- Correction: user-editable fields on profile

Retention
- See  for class-by-class durations and triggers

Vendors
- Managed Postgres (EU/CH), S3/SOS (CH/EU), Email provider (EU endpoints). Due-diligence in .

Residual Risk & Decision
- Residual risks deemed acceptable for MVP with above controls; re-evaluate at Alpha.

Approval
- Requested by: Evert (PM)
- Approver (Privacy/Legal): ____________________  Date: ___________
- Decision: Approved / Approved with conditions / Changes required
- Conditions / Notes: _____________________________________________
