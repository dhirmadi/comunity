# DECISIONS — Carya Program (Living Log)

Template
- ID: DEC-0001
- Date:
- Context:
- Options:
  - A)
  - B)
  - C)
- Decision:
- Rationale:
- Owners:
- Links: (PRs, specs)

Entries
- (add here)

## DEC-0001 — DMs scope (MVP)
Date: 2025-09-26
Context: Feature List describes DMs; Product Brief excludes DMs from MVP.
Options: A) Post‑MVP (Alpha) [Recommended], B) Include in MVP
Decision: A) Post‑MVP (Alpha)
Rationale: Safety load and non‑core to MVP loops; reduces complexity.
Links: specs/FRD.md, docs/productinformation/Carya_ProductBrief.md

## DEC-0002 — UI approach (HTMX vs minimal React)
Date: 2025-09-26
Context: Product Brief leaves UI stack open.
Options: A) HTMX + Django templates [Recommended], B) Minimal React
Decision: A) HTMX + Django templates
Rationale: Faster MVP delivery, simpler infra, strong server‑rendered security posture.
Links: architecture/README.md

## DEC-0003 — Primary region (CH vs DE)
Date: 2025-09-26
Context: CH/Exoscale vs DE/Frankfurt.
Options: A) CH (Exoscale) [Recommended], B) DE (Frankfurt)
Decision: A) CH (Exoscale)
Rationale: CH residency preference; competitive latency; portability retained.
Links: product/METRICS_AND_GATES.md

## DEC-0004 — Email provider (Postmark vs SES EU)
Date: 2025-09-26
Context: Need high deliverability EU provider.
Options: A) Postmark [Recommended], B) SES (EU)
Decision: A) Postmark
Rationale: Simplicity, strong deliverability, EU endpoints.
Links: docs/productinformation/Carya_ProductBrief.md

## DEC-0005 — API auth (cookie+CSRF vs JWT)
Date: 2025-09-26
Context: Web‑first API; CSRF protection desired.
Options: A) Cookie + CSRF [Recommended], B) JWT
Decision: A) Cookie + CSRF
Rationale: Built‑in CSRF protections, fewer token pitfalls on web.
Links: api/openapi.yaml

## DEC-0006 — Media storage (Exoscale SOS vs S3 eu‑central‑1)
Date: 2025-09-26
Context: Object storage location for media.
Options: A) Exoscale SOS (CH) [Recommended], B) S3 (Frankfurt)
Decision: A) Exoscale SOS (CH)
Rationale: CH residency preference; S3 compatibility retained; can switch if needed.
Links: architecture/README.md
