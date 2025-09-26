# Safety Orchestration & Escalation (Draft)

Truth Table (example)
- NSFW score < 0.3 → allow
- 0.3–0.7 → blur + queue
- > 0.7 → block

Logging & Overrides
- Deterministic outcomes; override paths; audit requirements.
