# Test Strategy — MVP

Layers
- Unit: models/utils; markdown sanitization; rate limit helpers
- Integration: endpoints (auth, profiles, groups, posts, comments, reports)
- E2E (smoke): signup, verify, create post with image, report flow, mod action
- Security: CSRF present on state changes; cookie flags set; auth bypass attempts fail
- Performance: p95 latency tests at target RPS; basic search < 300ms @ 100k rows

Mapping to FR‑IDs
- Tag tests with FR‑IDs; require coverage for all MVP features in CI
