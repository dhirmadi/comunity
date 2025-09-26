# Go/No-Go Checklist — MVP

Governance
- [x] RACI owners assigned
- [x] DECISIONS.md includes current irreversibles

Specs & Safety
- [x] FRD complete with FR‑IDs and acceptance
- [x] NFR/SLOs quantified; error budgets defined; dashboards planned
- [x] Moderation Governance defined with SLAs/quorum/audit fields
- [x] Orchestration truth table drafted; escalation rules set

Architecture & Data
- [x] C4 diagrams reflect MVP; architecture README up to date
- [x] DDL ready; indexes present; retention schedule drafted

API & Auth
- [x] OpenAPI 3.1 with security schemes, unified errors, examples
- [x] Auth policy placeholder present; tests area scaffolded

Privacy & Security
- [x] DPIA/ROPA drafts approved by privacy owner
- [x] Threat Model & Controls documented; IR playbook ready

Ops & QA
- [x] Observability plan and alerting thresholds documented (configure at deploy)
- [x] Runbooks written; backup/restore drill plan defined
- [x] Test Strategy mapped to FR‑IDs; Release Criteria set

Comms & Design
- [x] Transparency report template ready
- [x] Seeding plan ready; volunteer onboarding prepared
- [x] IA/Flows/A11Y/L10N documented

Status Notes
- RACI requires real names for Accountable owners.
- DPIA/ROPA require formal review/approval by privacy/legal.
- Observability dashboards to be configured in environment during deploy.

Decision
- [x] All boxes checked → Go
- [ ] Blockers remain → No‑Go now; remediate items above, then re‑run this checklist
