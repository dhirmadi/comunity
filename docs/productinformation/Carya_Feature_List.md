
# Carya Platform — Full Feature List (including FetLife parity)  
_Last updated: 2025-09-26_

> This document lists **all core features we will build** for Carya, ensuring **parity with FetLife’s publicly-documented capabilities** and adding **consent-first, safety-by-default** enhancements suitable for CH/EU deployment. FetLife parity is drawn from public sources (e.g., eSafety Guide, Wikipedia) and community write-ups; exact UX may differ.

---

## 0) Principles
- **Consent first.** All interactions respect explicit consent, with clear controls and defaults.
- **Safety at scale.** Automated + community-powered moderation; minimal/no paid staff for routine reviews.
- **Privacy by design.** Pseudonymous by default; EU/CH data residency.
- **Portability.** Containerized, cloud-neutral stack.
- **Incremental delivery.** Monolith-first, feature-flagged rollout.

---

## 1) Accounts & Identity
**Parity with FetLife**
- Email registration, login, password reset.
- Pseudonymous display name and handle.
- Profile deletion and temporary deactivation.
- Multi-language UI (EN + DE/FR/IT; extend over time).

**Carya Enhancements**
- Age confirmation gate (18+), mandatory policy attestation.
- Optional 2FA (TOTP) for users; required for moderators/admins.
- Privacy presets at signup (Conservative / Standard / Custom).

---

## 2) Profiles
**Parity with FetLife**
- Profile fields: display name, avatar, bio, location (free text).
- Orientation/roles & “fetishes/kinks” list on profile.
- Relationship links to other members.
- Profile visibility controls (friends-only / members / everyone).

**Carya Enhancements**
- **Consent Profile:** boundaries (yes/maybe/no), aftercare preferences, safer-sex preferences (optional).
- **Audience controls per field** (e.g., show kinks to friends only).
- **Safety badges** (e.g., “Consent Pledge”, “Community Helper”) earned via behavior, not payment.
- **Red Flags** (private to user): personal block keywords; auto-hide posts with matching tags.

---

## 3) Social Graph: Friends, Following & Lists
**Parity with FetLife**
- Add friends; follow users; see a **home feed** of friends/follows’ activity.
- Block users.

**Carya Enhancements**
- **Trust lists** (close friends, mentors) with finer visibility.
- **Mute**, **restrict**, and **private notes** on users.
- **Safety circles**: opt-in mutual-consent friend requests (both must consent before DMs).

---

## 4) Content Types
**Parity with FetLife**
- **Writings/Blog entries** (long-form posts).
- **Photos** uploads (MVP) and **Videos** (Post‑MVP); per‑post visibility (friends‑only / all members).
- **Comments** on posts; likes/favorites.
- **Kinky & Popular / trending** type discovery feed.
- **Home feed** showing activity of friends/followed users and groups.

**Carya Enhancements**
- **Click-to-reveal** blur for NSFW by default; user preference toggles.
- **Safety captions** template (consent context, model releases where applicable, no minors statement).
- **EXIF stripping**; face-obscure tool (client-side optional) before upload.
- **Content warnings** (CW) system; auto-suggested tags from AI.
- **Rate limits** per user and IP; flood detection with cool-downs.

---

## 5) Groups & Discussions
**Parity with FetLife**
- Create/join **groups/communities**; forum-like threads and posts.
- Group visibility (public/private) and **group rules**.
- Group moderators with powers to remove content/ban members.

**Carya Enhancements**
- **Rule templates** (consent norms, harassment, illegal content, outing prohibition).
- **Join gates** (quiz/acknowledgement of rules).
- **Slow mode & first-post approval** for new members.
- **Automod**: filter lists, link spam detector, AI-assisted triage.
- **Community self-policing**: mod actions require multi-mod quorum or reputation threshold (configurable).

---

## 6) Events (Post‑MVP, DEC‑0001)
**Parity with FetLife**
- Create/advertise **events** (munches, classes, parties) with time, location, RSVP.
- Attendee lists, comments.

**Carya Enhancements**
- **Consent & accessibility checklist** on event creation (e.g., code of conduct, photo policy, gender-neutral facilities).
- Optional **verification** for hosts (KYC-lite or reputation) to unlock larger event capacity.
- **Safety brief** section + printable rules poster.
- **Anonymous feedback** channel post-event.

---

## 7) Messaging (DMs/Conversations) (Post‑MVP, DEC‑0001)
**Parity with FetLife**
- Private **direct messages** (1:1 and group threads).

**Carya Enhancements**
- **Inbox privacy filters**: only friends / friends & follows / anyone (with rate limits).
- **Attachment controls** (allow images? friends only?). Default: images from friends only.
- **Safety nudges**: anti-scam heuristics; unknown sender interstitial; consent reminders.
- **Message requests** queue; quick **block & report** with conversation context redaction for reviewer privacy.

---

## 8) Search & Discovery (MVP: simple; enhancements later)
**Parity with FetLife**
- Limited **member search**, group/event discovery (location-based).
- Tagging of writings; discover feeds (e.g., “Kinky & Popular”).

**Carya Enhancements**
- **Privacy-preserving search** (no sensitive filters by default: e.g., no age/gender targeting).
- **Local discovery** by city/region (opt-in location granularity).
- **Smart suggestions** driven by follows/groups, not demographics.
- **Explore** page with safe-mode toggle and consent-first educational content.

---

## 9) Notifications & Activity
**Parity with FetLife**
- Notifications for comments/likes/follows.
- Activity/home feed of friends and follows.
- Paid membership unlocks extended timeline/history (per eSafety public notes).

**Carya Enhancements**
- Digest emails (opt-in), rate limited.
- Granular controls per channel (push/email/web).
- Privacy mode (hide activity from others except where required by visibility).

---

## 10) Privacy & Safety Controls
**Parity with FetLife**
- Blocking and reporting tools; per-post visibility; friends-only options.

**Carya Enhancements**
- **Safety presets** (Strict / Standard / Custom).
- **Geo-fencing** & IP region blocks for sensitive groups/events.
- **One-click evidence package** when reporting (screenshots, post hashes, message excerpts).
- **Data export/delete** self-service per GDPR/FADP.

---

## 11) Moderation (Automation & Community)
> Goal: no paid staff needed for routine decisions; escalate only rare edge cases.

**Automated**
- **Upload pipeline**: EXIF strip → MIME/type allowlist → AV scan → AI classification (NSFW, minors/CSAM signals, violence, self-harm) → policy score → action (allow/queue/auto-hide).
- **Text classifiers**: harassment/hate/grooming detection with thresholds.
- **Rate-limit & trust models**: progressive throttling; sandbox new accounts.
- **Similarity matching**: hashed image/video (pHash) to catch re-uploads.

**Community Self-Policing**
- **Report & Review**: any user can flag; **reputation-weighted voting**; auto-action after quorum.
- **Reputation system**: earns weight via time-on-platform, rule-abiding behavior, accurate past flags.
- **Appeals** flow to a separate reviewer pool (again, community-based with stricter quorum).
- **Transparency reports**: periodic stats on removals, appeals, outcomes.

**Moderator Tools (for appointed volunteers)**
- Queues, evidence viewer, redaction, audit trail, shadowban, temp bans, content takedown with reason templates.

---

## 12) Compliance & Legal
- Jurisdiction: CH/EU data residency; ToS disallow illegal content; **minors strictly prohibited**.
- Clear **consent policy** (no doxxing, no non-consensual material, model age attestation on uploads).
- **IP takedown** (DMCA-equivalent) with standardized forms.

---

## 13) Internationalization & Accessibility
- Languages: EN, DE, FR, IT (expandable). RTL-ready.
- WCAG 2.1 AA targets; keyboard nav; color-blind safe palette.

---

## 14) Monetization (Later Phase)
**Parity with FetLife**
- Paid membership for additional features (e.g., extended activity timeline, video access per public sources).

**Carya Enhancements**
- Ad-free supporter tier; community funding for moderation tooling; **no pay-to-win visibility**.

---

## 15) Admin & Ops
- Admin roles; config flags; site-wide announcements; maintenance mode.
- Backups & restore drills; observability (Sentry/OTel); abuse rate dashboards.

---

## 16) Extra Consent-Centric Features (New)
- **Consent Checklists** on profiles and per-event.
- **Negotiation templates** for scenes; ability to attach to posts/events.
- **Safety Check-in** reminders after events or flagged conversations.
- **Education Hub**: curated resources on consent, safer sex, kink basics.
- **Community Codes of Conduct** with group-level variants and templated rule-sets.
- **Private Journals** (only-me) for reflective practice.

---

## 17) Parity Matrix (FetLife → Carya)
- Profiles with orientation/roles/fetishes → ✅ Carya Profiles & Consent Profile.
- Friends/Follow + Home feed → ✅ Social Graph & Notifications.
- Groups (forums) → ✅ Groups with rules, join gates, automod.
- Events (create/RSVP) → ✅ Events with consent checklist (Post‑MVP, DEC‑0001).
- Writings/Photos with per‑post visibility (MVP); Video (Post‑MVP, DEC‑0001) → ✅ Content types; blur & CW.
- DMs/Conversations → ✅ Messaging with privacy filters (Post‑MVP, DEC‑0001).
- Trending (“Kinky & Popular”) → ✅ Explore/Trending with safe-mode.
- Location-based discovery → ✅ Local discovery (opt-in granularity).
- Blocking & Reporting → ✅ Expanded with evidence, community quorum.
- Paid membership (extended timeline, video access) → ✅ Supporter tier (ethical, ad-free).
