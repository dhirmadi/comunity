# Carya — Spec-First Development Repo

This repository is optimized for a specification-first workflow in Cursor.

- Start in `docs/productinformation/` and `/specs`.
- Use `.cursor/agents/*.mdc` and `.cursor/rules/spec-first.mdc` to guide agents.
- Use GitHub templates to propose FRDs/NFRs, decisions, OpenAPI, data, and safety changes.

## Workflow
1) Define/Update specs (FRD/NFR/Safety) → 2) Make decisions → 3) Update architecture/data → 4) Author OpenAPI → 5) Implement.

## Paths
- Specs: `/specs/*`
- Governance: `/governance/*`
- Architecture: `/architecture/*`
- Data: `/data/*`
- API: `/api/*`
- Safety: `/safety/*`
- Privacy: `/privacy/*`
- Ops/QA/Comms/Program as needed

## Cursor
- Agents live in `.cursor/agents/`.
- Rules live in `.cursor/rules/`.
- Start with `document-review.mdc` to reconcile docs, then use specialized agents.
