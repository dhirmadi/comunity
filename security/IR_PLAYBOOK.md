# Incident Response Playbook — MVP

Severity Levels
- Sev1: data breach/legal; Sev2: major outage; Sev3: user-impacting bug; Sev4: minor issue

On-Call & Roles
- Tech Lead (incident commander), Backend (fix), Safety Lead (user comms), PM (stakeholder)

Process
1. Detect (monitoring alert/user report)
2. Triage (assign severity, assemble team)
3. Contain (feature flags, rate limits, temp blocks)
4. Eradicate (fix, hotfix deploy)
5. Recover (validate, monitor)
6. Postmortem (within 5 business days) with action items

Communication
- Status page or repo issue; user comms template if user data impacted; legal consult if needed
