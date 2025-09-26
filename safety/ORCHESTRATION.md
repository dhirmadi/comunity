# Safety Orchestration & Escalation (Draft)

Truth Table (example)
- NSFW score < 0.3 → allow
- 0.3–0.7 → blur + queue
- > 0.7 → block

Logging & Overrides
- Deterministic outcomes; override paths; audit requirements.

Escalation Rules (examples)
- Minor risk signals + low reputation → queue for review
- Strong illegal content signals → immediate block + quarantine media; notify Safety Lead
- Repeated offenders → progressive throttles → shadowban → ban

Logging
- Persist model scores, thresholds, decision path, and reviewer overrides

Escalation Rules (examples)
- Minor risk signals + low reputation → queue for review
- Strong illegal content signals → immediate block + quarantine media; notify Safety Lead
- Repeated offenders → progressive throttles → shadowban → ban

Logging
- Persist model scores, thresholds, decision path, and reviewer overrides
