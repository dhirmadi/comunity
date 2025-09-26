# Functional Requirements Document (FRD) — MVP

Purpose: Translate the Feature List into atomic, testable requirements with traceability and acceptance criteria.

## FR-IDs

### FR-001 Accounts & Authentication
- **Summary:** Email/password registration, verification, reset; age confirmation (18+)
- **Acceptance:** 
  - Unverified users cannot post/comment/join groups
  - Age gate enforces 18+ requirement with legal attestation
  - Rate limits enforced: 3 signups/hour/IP, 1/minute/IP
  - Password reset requires email verification
  - Account lockout after 10 failed login attempts for 15 minutes
- **Traceability:** Product Brief §8.1; Feature List §1

### FR-002 Profiles & Privacy
- **Summary:** Display name, bio, avatar, location; consent profile; privacy controls
- **Acceptance:** 
  - EXIF data stripped from all uploaded avatars
  - Private profiles hide posts/activity from non-friends
  - Consent profile fields are optional but encouraged
  - Profile fields have individual visibility controls (friends/members/public)
  - Bio limited to 500 characters, location to 120 characters
- **Traceability:** Product Brief §8.2; Feature List §2

### FR-003 Groups & Communities
- **Summary:** Create/join groups; public/private visibility; group rules; moderation
- **Acceptance:** 
  - Private group content invisible to non-members
  - Group moderator actions logged in audit trail
  - Group rules template system available
  - Join gates can require rule acknowledgment
  - Maximum 50 groups per user (configurable)
- **Traceability:** Product Brief §8.3; Feature List §5

### FR-004 Posts & Comments
- **Summary:** Text posts with up to 5 images; comments; markdown subset rendering
- **Acceptance:** 
  - MIME type allowlist enforced (JPEG, PNG, GIF only)
  - Maximum 2MB per image, 10k characters per post
  - Signed URLs for private image access
  - Comments limited to 2k characters
  - Markdown subset: bold, italic, links, lists only
- **Traceability:** Product Brief §8.4; Feature List §4

### FR-005 Follow & Feed
- **Summary:** Follow users/groups; reverse-chronological home feed; pagination
- **Acceptance:** 
  - Feed shows content from followed users + joined groups
  - Keyset pagination maintains stable ordering
  - Feed updates within 5 minutes of new content
  - Private group content only shown to members
- **Traceability:** Product Brief §8.5; Feature List §3, §9

### FR-006 Search (MVP)
- **Summary:** Basic search across users, groups, posts using Postgres full-text search
- **Acceptance:** 
  - Search results returned in < 300ms p95 at 100k rows
  - Privacy-respecting: no demographic filters
  - Rate limited to 30 searches/minute/user
- **Traceability:** Product Brief §8.7

### FR-007 Reporting & Moderation
- **Summary:** Report content/users; moderation queue; community-driven review; audit logging
- **Acceptance:** 
  - All moderation actions soft-delete with 30-day retention
  - Action metadata includes actor, timestamp, reason
  - Community quorum system for report resolution
  - Appeal process with separate reviewer pool
  - Median time-to-action < 12 hours
- **Traceability:** Product Brief §8.6; Feature List §11

### FR-008 Admin Panel
- **Summary:** Site-wide configuration; rate limits; user/role management; content flags
- **Acceptance:** 
  - All administrative changes audited with actor tracking
  - Rate limit configuration per endpoint/user role
  - Banned word/domain list management
  - User role assignment with approval workflow
- **Traceability:** Product Brief §8.8

### FR-009 Rate Limits & Abuse Prevention
- **Summary:** Comprehensive rate limiting across all user actions
- **Acceptance:** 
  - HTTP 429 responses include Retry-After headers
  - Configurable limits stored in database
  - Progressive throttling for new/untrusted accounts
  - IP and user-based limit tracking
- **Specific Limits:**
  - Signup: 3/hour/IP, 1/minute/IP
  - Login: 10/minute/IP
  - Post creation: 6/hour/user, burst 2/minute
  - Comments: 20/hour/user, burst 5/minute
  - Reports: 10/hour/user
  - Media upload: 20/hour/user
- **Traceability:** Product Brief §26

### FR-010 Content Safety & NSFW Handling
- **Summary:** Automated content classification; click-to-reveal for NSFW; content warnings
- **Acceptance:**
  - All uploaded content scanned for NSFW/inappropriate material
  - NSFW content blurred by default with click-to-reveal
  - Content warning system with predefined categories
  - Zero tolerance for illegal content (auto-removed)
- **Traceability:** Feature List §4

### FR-011 Privacy & Data Protection
- **Summary:** GDPR/FADP compliance; data export/deletion; privacy by design
- **Acceptance:**
  - Self-service data export in machine-readable format
  - Account deletion removes/anonymizes personal data within 30 days
  - Privacy settings respect "deny by default" principle
  - Data retention schedules enforced automatically
- **Traceability:** Feature List §10; Privacy docs

### FR-012 Accessibility & Internationalization
- **Summary:** WCAG 2.1 AA compliance; multi-language support (EN, DE, FR, IT)
- **Acceptance:**
  - All UI elements keyboard accessible
  - High contrast mode available
  - Screen reader compatible
  - RTL text direction support ready
- **Traceability:** Feature List §13

## Parity Matrix (FetLife → Carya)

| FetLife Feature | Carya FR-ID | Status | Notes |
|---|---|---|---|
| Profile with fetish lists | FR-002 | ✅ | Enhanced with consent profile |
| Friends/Follow + Feed | FR-005 | ✅ | Privacy-first implementation |
| Groups/Forums | FR-003 | ✅ | Enhanced moderation tools |
| Events (RSVP) | Out of scope | 🔄 | Planned for Alpha phase |
| Photo/Video uploads | FR-004 | ✅ | Photos only in MVP |
| Direct Messages | Out of scope | 🔄 | Planned for Alpha phase |
| Location-based discovery | FR-006 | ⚠️ | Privacy-limited version |
| Paid membership features | Out of scope | 🔄 | Ethical monetization planned |

## Out of Scope (MVP)

The following features are explicitly excluded from MVP to maintain focus:
- Video uploads (Alpha phase)
- Direct messaging (Alpha phase)  
- Real-time notifications (Beta phase)
- Advanced search with filters (Beta phase)
- Native mobile applications (Post-GA)
- Event management with ticketing (Alpha phase)
- Live streaming features (Future consideration)

## Cross-References & Dependencies

- **Architecture:** All requirements must align with monolith-first Django architecture
- **Security:** Security controls defined in `/security/CONTROLS.md`
- **Privacy:** Data protection requirements in `/privacy/DPIA.md`
- **Safety:** Content moderation policies in `/safety/Moderation_Governance.md`
- **API:** Technical implementation defined in `/api/openapi.yaml`
- **Data:** Database schema defined in `/data/DDL.sql`

## Acceptance Testing Requirements

Each FR-ID requires:
1. **Unit tests** for business logic
2. **Integration tests** for API endpoints  
3. **End-to-end tests** for user workflows
4. **Performance tests** for scalability requirements
5. **Security tests** for authorization/access control
6. **Accessibility tests** for WCAG compliance

## Risk Assessment

**High Risk Requirements:**
- FR-007 (Moderation): Community-driven moderation is untested at scale
- FR-009 (Rate Limits): Complex rate limiting may impact user experience
- FR-011 (Privacy): GDPR compliance requires careful implementation

**Medium Risk Requirements:**
- FR-006 (Search): Performance requirements may be challenging with basic Postgres FTS
- FR-010 (Content Safety): AI-based classification may have false positives

**Low Risk Requirements:**
- FR-001, FR-002, FR-004, FR-005: Standard web application functionality
