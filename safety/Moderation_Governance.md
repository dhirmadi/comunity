# Moderation Governance — Operating Model (v1)

Roles
- Member, Reporter, Moderator, Admin.

Queues & SLAs
- Report intake → triage → action; median TTF action < 12h (MVP).

Quorum & Reputation
- Community voting with reputation weights; thresholds configurable.

Actions & Audit
- Remove, warn, shadowban, ban; all actions audited with actor, reason, timestamp.

Appeals
- Separate reviewer pool; stricter quorum; transparency reporting.

SLA Targets
- P1 (illegal/urgent): triage ≤ 1h; action ≤ 6h
- P2 (harassment/hate): triage ≤ 6h; action ≤ 24h
- P3 (spam/other): triage ≤ 24h; action ≤ 72h

Quorum Examples
- Minimum 3 reviewers; majority with total reputation weight ≥ configured threshold
- New accounts cannot review until trust threshold achieved

Audit Fields
- actor_id, action, target_type/id, reason_code, evidence_refs, created_at
