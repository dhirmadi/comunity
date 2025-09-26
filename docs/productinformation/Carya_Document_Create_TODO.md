
# Carya — Spec‑Based AI Development To‑Do List
_Last updated: 2025-09-26_

> **Instructions for the AI Agent (GPT‑5):** Work through the tasks **in order**. Do not start a task if its **dependencies** are not yet satisfied. For each task, produce the listed **outputs**, meet the **acceptance criteria**, and update **status**. Use prior deliverables (Product Brief, Project Brief, Full Feature List, Roadmap) as base inputs.

Legend: **Status** = Pending / In‑Progress / Review / Blocked / Done

---

## Phase 0 — Program Framing (must be locked first)

- [ ] **T01 — Governance: RACI & Decision Log**
  - **Purpose:** Define decision ownership and a single source of truth for irreversible choices.
  - **Need:** Prevents ambiguity; enables fast trade‑offs when specs conflict.
  - **Objective:** A signed RACI and a living decision log with unique IDs.
  - **Inputs:** Product Brief (final), Project Brief (final).
  - **Outputs:** `/governance/RACI.md`, `/governance/DECISIONS.md`.
  - **Acceptance:** All core areas have owners; decision log template has ID, context, options, decision, rationale.
  - **Depends On:** —
  - **Status:** Pending

- [ ] **T02 — Success Metrics & Phase Gates**
  - **Purpose:** Define KPIs, SLOs, and go/no‑go gates per phase (MVP, Alpha, Beta, GA).
  - **Need:** Enables objective progress assessment and model threshold targets.
  - **Objective:** Metrics spec with formulas, data sources, alert thresholds.
  - **Inputs:** Roadmap, Product Brief.
  - **Outputs:** `/product/METRICS_AND_GATES.md`.
  - **Acceptance:** Each phase lists KPIs, SLOs, error budgets; tied to analytics events.
  - **Depends On:** T01
  - **Status:** Pending

- [ ] **T03 — Policy Set v1 (Guidelines, Consent Policy, ToS, Privacy, Cookie)**
  - **Purpose:** Establish enforceable rules and user rights for consent‑first operation.
  - **Need:** Required for moderation specs, classifier targets, and legal compliance.
  - **Objective:** Lawyer‑reviewed drafts ready for publication.
  - **Inputs:** Product Brief; jurisdiction requirements (CH/EU).
  - **Outputs:** `/policy/Community_Guidelines.md`, `/policy/Consent_Policy.md`, `/legal/ToS.md`, `/legal/Privacy_Policy.md`, `/legal/Cookie_Policy.md`.
  - **Acceptance:** Explicit bans (minors, non‑consensual), reporting & appeal process, data rights.
  - **Depends On:** T01
  - **Status:** Pending

---

## Phase 1 — Requirements Baseline

- [ ] **T04 — Functional Requirements (FRD)**
  - **Purpose:** Translate feature list into atomic, testable requirements.
  - **Need:** Basis for API, data model, and acceptance tests.
  - **Objective:** Numbered requirements with priority and traceability to parity matrix.
  - **Inputs:** Feature List, Roadmap, Policy Set v1.
  - **Outputs:** `/specs/FRD.md`.
  - **Acceptance:** Every FetLife‑parity feature + consent/safety additions mapped to FR‑IDs.
  - **Depends On:** T03
  - **Status:** Pending

- [ ] **T05 — Non‑Functional Requirements (NFRs & SLOs)**
  - **Purpose:** Define performance, availability, durability, security, privacy targets.
  - **Need:** Drives architecture and test thresholds.
  - **Objective:** Concrete SLOs (e.g., p95 latency) and RTO/RPO.
  - **Inputs:** Metrics & Gates (T02), Policy Set v1 (T03).
  - **Outputs:** `/specs/NFR_SLO.md`.
  - **Acceptance:** Quantified targets; error budgets; monitoring hooks defined.
  - **Depends On:** T02, T03
  - **Status:** Pending

- [ ] **T06 — Safety & Moderation Operating Model**
  - **Purpose:** Specify self‑policing workflow, reputation math, quorum rules, appeals.
  - **Need:** Conditions the automod and AI specs.
  - **Objective:** End‑to‑end flows and state diagrams.
  - **Inputs:** Policy Set v1 (T03).
  - **Outputs:** `/safety/Moderation_Governance.md`.
  - **Acceptance:** Quorum thresholds; roles; SLAs; transparency metrics.
  - **Depends On:** T03
  - **Status:** Pending

---

## Phase 2 — Architecture & Data

- [ ] **T07 — C4 Diagrams (Context, Container, Component, Code stubs)**
  - **Purpose:** Visualize system boundaries, services, and data flows.
  - **Need:** Guides API design and security modeling.
  - **Objective:** Versioned diagrams with narrative.
  - **Inputs:** FRD (T04), NFR (T05).
  - **Outputs:** `/architecture/c4/Context.puml`, `Container.puml`, `Component.puml` + `/architecture/README.md`.
  - **Acceptance:** Diagrams reflect MVP scope; data flows for uploads & moderation included.
  - **Depends On:** T04, T05
  - **Status:** Pending

- [ ] **T08 — Data Model: ERD + DDL**
  - **Purpose:** Define canonical schema, constraints, and soft‑delete strategy.
  - **Need:** Enables API contract and data privacy mapping.
  - **Objective:** ERD + PostgreSQL DDL (versioned migrations).

  - **Inputs:** FRD (T04), Safety Model (T06).
  - **Outputs:** `/data/ERD.png`, `/data/DDL.sql`.
  - **Acceptance:** Keys/indexes; FTS; audit logs; reports; blocks; appeals tables.
  - **Depends On:** T04, T06
  - **Status:** Pending

- [ ] **T09 — Data Protection: DPIA & ROPA**
  - **Purpose:** Map personal data, risks, mitigations, and processing records.
  - **Need:** Legal compliance; informs minimization & retention.
  - **Objective:** DPIA and ROPA documents with risk ratings.
  - **Inputs:** Data Model (T08), Policy Set (T03).
  - **Outputs:** `/privacy/DPIA.md`, `/privacy/ROPA.md`.
  - **Acceptance:** Data inventory; lawful basis; DSR workflows; retention tables.
  - **Depends On:** T08, T03
  - **Status:** Pending

---

## Phase 3 — API & Contract‑First Development

- [ ] **T10 — OpenAPI 3.1 Specification (MVP scope)**
  - **Purpose:** Contract for all client‑server interactions.
  - **Need:** Drives mocks, codegen, and e2e tests.
  - **Objective:** Validated OpenAPI with schemas, auth, errors.
  - **Inputs:** FRD (T04), Data Model (T08).
  - **Outputs:** `/api/openapi.yaml`.
  - **Acceptance:** No “TBD”; examples for key endpoints; error model unified.
  - **Depends On:** T04, T08
  - **Status:** Pending

- [ ] **T11 — Authorization Policy (ABAC/ReBAC)**
  - **Purpose:** Centralize access rules (posts, groups, DMs, moderation).
  - **Need:** Prevents privilege errors and leakage.
  - **Objective:** Machine‑readable policies (Oso/Cedar) + tests.
  - **Inputs:** FRD (T04), Safety Model (T06).
  - **Outputs:** `/auth/policy.cedar` (or `.polar`), `/auth/tests/`.
  - **Acceptance:** High‑risk rules covered; deny‑by‑default; audit hooks.
  - **Depends On:** T04, T06
  - **Status:** Pending

- [ ] **T12 — Content Schemas & Taxonomies**
  - **Purpose:** Standardize tags, CWs, report reasons, and consent metadata.
  - **Need:** Enables consistent UI, AI labels, and analytics.
  - **Objective:** Controlled vocabularies + schemas.
  - **Inputs:** FRD (T04), Moderation Model (T06).
  - **Outputs:** `/specs/taxonomies.yaml`.
  - **Acceptance:** Versioned; localized terms; mapping to classifier labels.
  - **Depends On:** T04, T06
  - **Status:** Pending

---

## Phase 4 — AI/ML Specification (Safety & Engagement)

- [ ] **T13 — AI Use‑Cases Catalogue**
  - **Purpose:** Enumerate AI tasks (NSFW, minor risk, harassment, spam, auto‑tagging, ranking, safety nudges).
  - **Need:** Prioritizes model work and evaluation.
  - **Objective:** Ranked backlog with risk classification.
  - **Inputs:** FRD (T04), Safety Model (T06).
  - **Outputs:** `/ai/USECASES.md`.
  - **Acceptance:** Each use‑case has goal, constraints, harm analysis, fallback behavior.
  - **Depends On:** T04, T06
  - **Status:** Pending

- [ ] **T14 — Labeling Guidelines & Ontology**
  - **Purpose:** Define ground truth for human/community labeling.
  - **Need:** Ensures consistent training/eval and community quorum clarity.
  - **Objective:** Instructions with positive/negative examples and edge cases.
  - **Inputs:** Taxonomies (T12), Policy Set (T03).
  - **Outputs:** `/ai/LABELING_GUIDE.md`.
  - **Acceptance:** Inter‑rater agreement target ≥ 0.8 on sample tasks.
  - **Depends On:** T12, T03
  - **Status:** Pending

- [ ] **T15 — Dataset Plan & Governance**
  - **Purpose:** Identify data sources, privacy controls, consent, and retention.
  - **Need:** Legal and ethical dataset handling.
  - **Objective:** Data acquisition and de‑identification strategy.
  - **Inputs:** DPIA/ROPA (T09), Labeling Guide (T14).
  - **Outputs:** `/ai/DATASET_PLAN.md`.
  - **Acceptance:** Minimization, PII scrubbing, licensing/ToS compliance documented.
  - **Depends On:** T09, T14
  - **Status:** Pending

- [ ] **T16 — Model Spec Sheets (per use‑case)**
  - **Purpose:** Define inputs/outputs, thresholds, latency, and escalation paths.
  - **Need:** Contract between product and MLOps for each model.
  - **Objective:** One spec per model (e.g., NSFW_v1, Harassment_v1).
  - **Inputs:** Use‑Cases (T13), Dataset Plan (T15).
  - **Outputs:** `/ai/specs/NSFW_v1.md`, etc.
  - **Acceptance:** Metrics (precision/recall), decision table (allow/blur/queue/block).
  - **Depends On:** T13, T15
  - **Status:** Pending

- [ ] **T17 — Evaluation Plan (Benchmarks & Audits)**
  - **Purpose:** Define test sets, sampling cadence, fairness checks, and drift detection.
  - **Need:** Guarantees quality and ethical performance.
  - **Objective:** Scheduled evaluations + dashboards.
  - **Inputs:** Model Specs (T16), Dataset Plan (T15).
  - **Outputs:** `/ai/EVALUATION_PLAN.md`.
  - **Acceptance:** Target metrics per model; alerting thresholds; audit sampling %.
  - **Depends On:** T16, T15
  - **Status:** Pending

- [ ] **T18 — Safety Orchestration & Escalation Logic**
  - **Purpose:** Specify how model scores trigger actions and queues.
  - **Need:** Cohesive policy execution, no conflicting actions.
  - **Objective:** Rule engine doc & truth table.
  - **Inputs:** Policy Set (T03), Model Specs (T16).
  - **Outputs:** `/safety/ORCHESTRATION.md`.
  - **Acceptance:** Deterministic outcomes; logging requirements; override paths.
  - **Depends On:** T03, T16
  - **Status:** Pending

---

## Phase 5 — Security, Privacy, and Compliance

- [ ] **T19 — Threat Model (STRIDE) & Security Controls**
  - **Purpose:** Identify threats and mitigations across components.
  - **Need:** Drives security backlog and configs.
  - **Objective:** STRIDE matrix + control catalogue.
  - **Inputs:** C4 (T07), OpenAPI (T10).
  - **Outputs:** `/security/THREAT_MODEL.md`, `/security/CONTROLS.md`.
  - **Acceptance:** Top risks have owners; controls mapped to NFRs.
  - **Depends On:** T07, T10
  - **Status:** Pending

- [ ] **T20 — Incident Response Plan**
  - **Purpose:** Define processes for abuse, security, and legal incidents.
  - **Need:** Reduce impact and time‑to‑mitigation.
  - **Objective:** Playbooks, comms templates, LEA request SOP.
  - **Inputs:** Policy Set (T03), Threat Model (T19).
  - **Outputs:** `/security/IR_PLAYBOOK.md`.
  - **Acceptance:** Severity matrix; on‑call roles; evidence handling.
  - **Depends On:** T03, T19
  - **Status:** Pending

- [ ] **T21 — Data Retention & Deletion Schedule**
  - **Purpose:** Define retention by data class and purge workflows.
  - **Need:** GDPR/FADP compliance and privacy by design.
  - **Objective:** Tables with durations and triggers.
  - **Inputs:** DPIA/ROPA (T09), Data Model (T08).
  - **Outputs:** `/privacy/RETENTION_SCHEDULE.md`.
  - **Acceptance:** Scriptable rules; user‑initiated delete/export steps.
  - **Depends On:** T09, T08
  - **Status:** Pending

---

## Phase 6 — Ops, Observability & Testing

- [ ] **T22 — Observability Plan**
  - **Purpose:** Define logs/metrics/traces and dashboards for SLOs.
  - **Need:** Enables error budgets and rapid debugging.
  - **Objective:** OTel signals, SLO dashboards, alert routes.
  - **Inputs:** NFRs (T05), Metrics & Gates (T02).
  - **Outputs:** `/ops/OBSERVABILITY.md`.
  - **Acceptance:** Dashboards cover p95 latency, error rate, feed freshness, moderation backlog.
  - **Depends On:** T05, T02
  - **Status:** Pending

- [ ] **T23 — Test Strategy & Release Criteria**
  - **Purpose:** Define unit/integration/e2e/security/perf testing and gates.
  - **Need:** Spec‑driven, automated quality bar.
  - **Objective:** Matrix of test types and pass/fail criteria by phase.
  - **Inputs:** FRD (T04), NFRs (T05), OpenAPI (T10).
  - **Outputs:** `/qa/TEST_STRATEGY.md`, `/qa/RELEASE_CRITERIA.md`.
  - **Acceptance:** CI gates enforce criteria; test data and mocks defined.
  - **Depends On:** T04, T05, T10
  - **Status:** Pending

- [ ] **T24 — Runbooks (Deploy, Rollback, Backup/Restore)**
  - **Purpose:** Operational playbooks for routine and emergency actions.
  - **Need:** Consistent operations and DR readiness.
  - **Objective:** Step‑by‑step procedures + checklists.
  - **Inputs:** Architecture (T07), Observability (T22).
  - **Outputs:** `/ops/RUNBOOKS.md`.
  - **Acceptance:** Verified via staging drills; time targets met.
  - **Depends On:** T07, T22
  - **Status:** Pending

- [ ] **T25 — Vendor Due‑Diligence (Hosting/CDN/Email/Storage/Video)**
  - **Purpose:** Confirm ToS allow adult content; verify EU/CH residency.
  - **Need:** Avoid migration fires; legal posture.
  - **Objective:** Dossier with approvals and contacts.
  - **Inputs:** Policy Set (T03), Architecture (T07).
  - **Outputs:** `/ops/VENDOR_DUE_DILIGENCE.md`.
  - **Acceptance:** Explicit confirmations captured; alternates listed.
  - **Depends On:** T03, T07
  - **Status:** Pending

---

## Phase 7 — Design & Accessibility

- [ ] **T26 — Information Architecture & User Flows**
  - **Purpose:** Blueprint of navigation and core flows.
  - **Need:** Aligns UI with consent/safety posture.
  - **Objective:** Sitemap + flow diagrams for signup/post/report/moderation/event.
  - **Inputs:** FRD (T04), Safety Model (T06).
  - **Outputs:** `/design/IA.md`, `/design/FLOWS.pdf`.
  - **Acceptance:** Covers all parity modules; includes safety interstitials.
  - **Depends On:** T04, T06
  - **Status:** Pending

- [ ] **T27 — Accessibility & Localization Plan**
  - **Purpose:** Meet WCAG 2.1 AA and plan DE/FR/IT localization.
  - **Need:** Legal/ethical requirement and user reach.
  - **Objective:** Criteria, testing tools, language rollout.
  - **Inputs:** IA/Flows (T26).
  - **Outputs:** `/design/A11Y_L10N.md`.
  - **Acceptance:** Checklists for components; translation process defined.
  - **Depends On:** T26
  - **Status:** Pending

---

## Phase 8 — Launch Readiness

- [ ] **T28 — Transparency Report Template**
  - **Purpose:** Public accountability for moderation outcomes.
  - **Need:** Builds trust; guides metrics collection.
  - **Objective:** Monthly template with key stats.
  - **Inputs:** Safety Model (T06), Metrics (T02).
  - **Outputs:** `/comms/TRANSPARENCY_TEMPLATE.md`.
  - **Acceptance:** Includes removals, appeals, uphold rates; privacy‑safe.
  - **Depends On:** T06, T02
  - **Status:** Pending

- [ ] **T29 — Community Seeding & Volunteer Onboarding Pack**
  - **Purpose:** Recruit initial groups and reviewers.
  - **Need:** Bootstraps self‑policing and healthy norms.
  - **Objective:** Messaging, code of conduct summary, reviewer guide.
  - **Inputs:** Policy Set (T03), Safety Model (T06).
  - **Outputs:** `/comms/SEEDING_PLAN.md`, `/safety/VOLUNTEER_ONBOARDING.md`.
  - **Acceptance:** Includes invite criteria, training tasks, and NDAs if needed.
  - **Depends On:** T03, T06
  - **Status:** Pending

- [ ] **T30 — Go/No‑Go Checklist**
  - **Purpose:** Single checklist for kickoff approval.
  - **Need:** Ensures all critical artifacts exist and are approved.
  - **Objective:** Binary pass/fail list aligned to dependencies.
  - **Inputs:** All prior tasks.
  - **Outputs:** `/program/GO_NO_GO.md`.
  - **Acceptance:** Sign‑off from owners in RACI; no open blockers.
  - **Depends On:** T01–T29
  - **Status:** Pending

---

## Notes
- Tasks are designed to be **spec‑first**; code should only begin once **T01–T12** are **Done** and **T13–T18** are at least **Review**.
- Update this file as tasks change status. Link all outputs in PR descriptions for traceability.
