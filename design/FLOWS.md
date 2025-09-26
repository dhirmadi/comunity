# User Flows — MVP

## Overview
This document defines the critical user flows for the Carya MVP, ensuring consent-first, safety-by-default interactions throughout the platform.

## Flow 1: New User Onboarding
```
Start → Age Gate (18+) → Email/Password → Verify Email → Privacy Settings → Consent Acknowledgment → Profile Setup → First Group Join → Success
```

### Detailed Steps
1. **Landing Page**
   - Clear 18+ warning and jurisdiction notice
   - "Create Account" CTA prominent
   
2. **Age Verification Gate**
   - Date of birth input (required)
   - Legal attestation checkbox: "I am 18 years or older"
   - Jurisdiction-specific warnings (CH/EU)
   
3. **Account Creation**
   - Email address (verified)
   - Strong password requirements
   - Display name selection
   - Privacy preset choice (Conservative/Standard/Custom)
   
4. **Email Verification**
   - Verification email sent immediately
   - Clear instructions and backup options
   - Account locked until verified
   
5. **Privacy & Consent Setup**
   - Privacy settings explanation
   - Consent policy acknowledgment (required)
   - Community guidelines acceptance
   - Optional: consent profile setup
   
6. **Profile Completion**
   - Avatar upload (optional, EXIF stripped)
   - Bio and interests (optional)
   - Visibility settings per field
   
7. **First Group Discovery**
   - Curated "New User Friendly" groups
   - Group rules preview before joining
   - Join confirmation with rule acknowledgment

**Exit Criteria:** User has verified account, set privacy preferences, and joined at least one group

## Flow 2: Content Creation & Sharing
```
Compose → Content Warnings → Audience Selection → Media Upload → Safety Check → Publish → Notifications
```

### Detailed Steps
1. **Content Composer**
   - Text editor with markdown support
   - Character count and formatting preview
   - Group/audience selector
   
2. **Content Warnings (CW) System**
   - Auto-suggested tags based on content analysis
   - Manual CW addition encouraged
   - NSFW toggle with click-to-reveal preview
   
3. **Audience & Visibility**
   - Group selection (if posting to group)
   - Visibility level: group members only/followers/public
   - Friend-only option for personal posts
   
4. **Media Upload Pipeline**
   - Drag-and-drop or file selection
   - EXIF stripping notification
   - MIME type validation
   - Size limits and compression
   
5. **Pre-Publish Safety Check**
   - Automated content classification
   - Safety warnings if needed
   - Final review prompt for sensitive content
   
6. **Publish & Distribution**
   - Content saved to database
   - Feed distribution to relevant audiences
   - Notification to followers (if enabled)

**Exit Criteria:** Content is published and visible to intended audience with appropriate safety measures

## Flow 3: Community Moderation & Reporting
```
Encounter Issue → Report Decision → Evidence Collection → Submit Report → Triage → Community Review → Action → Appeal Option
```

### Detailed Steps
1. **Issue Identification**
   - User encounters problematic content/behavior
   - Clear reporting options on all content
   - Quick access to blocking/muting tools
   
2. **Report Type Selection**
   - Harassment/bullying
   - Non-consensual content
   - Illegal content
   - Spam/commercial
   - Community rule violation
   - Other (with description)
   
3. **Evidence Collection**
   - Screenshot tool integrated
   - Context preservation (thread/conversation)
   - Optional additional details
   - Anonymization options
   
4. **Report Submission**
   - Confirmation of report details
   - Estimated response time
   - Immediate safety actions (block/mute) offered
   
5. **Automated Triage**
   - Priority assignment based on content type
   - Initial safety screening
   - Queue assignment to appropriate reviewers
   
6. **Community Review Process**
   - Multiple reviewers assigned (quorum system)
   - Evidence presentation to reviewers
   - Voting/decision interface
   - Consensus building tools
   
7. **Action Implementation**
   - Automated action based on community decision
   - Notification to reporter and subject
   - Audit log entry creation
   
8. **Appeal Process**
   - Clear appeal instructions
   - Separate reviewer pool
   - Higher evidence bar for overturning
   - Final decision notification

**Exit Criteria:** Issue is resolved through community process with clear outcome and appeal option

## Flow 4: Group Management & Governance
```
Create Group → Set Rules → Configure Moderation → Invite Members → Manage Discussions → Handle Issues → Growth
```

### Detailed Steps
1. **Group Creation**
   - Group name and description
   - Visibility setting (public/private)
   - Category/topic selection
   - Initial rule template selection
   
2. **Rule Configuration**
   - Community guidelines customization
   - Consent-specific rules (encouraged)
   - Posting guidelines and content policies
   - Consequence framework
   
3. **Moderation Setup**
   - Moderator invitation system
   - Permission levels and responsibilities
   - Automated moderation settings
   - Review thresholds and quorum rules
   
4. **Member Onboarding**
   - Join gate configuration
   - Welcome message and rule acknowledgment
   - New member restrictions (slow mode)
   - Mentorship/buddy system (optional)
   
5. **Discussion Facilitation**
   - Pinned posts and announcements
   - Topic threading and organization
   - Event planning (post-MVP)
   - Resource sharing and curation
   
6. **Conflict Resolution**
   - Group-specific reporting flows
   - Escalation to platform-wide moderation
   - Member mediation tools
   - Removal and ban procedures
   
7. **Community Growth**
   - Invitation management
   - Public discovery settings
   - Activity metrics and health indicators
   - Feedback collection from members

**Exit Criteria:** Group is active, well-moderated, and growing sustainably

## Flow 5: Privacy & Safety Management
```
Privacy Audit → Settings Review → Data Export → Consent Updates → Safety Tools → Account Management
```

### Detailed Steps
1. **Privacy Dashboard Access**
   - Clear navigation to privacy settings
   - Overview of current privacy status
   - Recent activity summary
   
2. **Data Visibility Audit**
   - What information is public/private
   - Who can see what content
   - Third-party data sharing status
   - Search visibility settings
   
3. **Granular Control Updates**
   - Per-field visibility settings
   - Content audience controls
   - Communication preferences
   - Blocking and muting management
   
4. **Data Subject Rights**
   - Data export request (GDPR Article 20)
   - Account deletion process (GDPR Article 17)
   - Data correction tools (GDPR Article 16)
   - Processing objection options
   
5. **Safety Tool Configuration**
   - Content filtering preferences
   - Automatic blocking rules
   - Consent reminder settings
   - Safety check-in preferences
   
6. **Account Security**
   - Password management
   - 2FA setup (optional for users, required for mods)
   - Login activity review
   - Suspicious activity alerts

**Exit Criteria:** User has full control over privacy and safety settings with clear understanding of implications

## Cross-Flow Considerations

### Accessibility Requirements
- All flows must be keyboard navigable
- Screen reader compatible at each step
- High contrast mode support
- Clear language and instructions

### Mobile Responsiveness
- Touch-friendly interface elements
- Simplified navigation for small screens
- Optimized image upload for mobile cameras
- Offline capability for draft content

### Performance Targets
- Page load times < 3 seconds on 3G
- Form submission feedback < 1 second
- Image upload progress indicators
- Graceful degradation for slow connections

### Error Handling
- Clear error messages with recovery options
- Form validation with helpful guidance
- Network error recovery
- Data loss prevention (auto-save drafts)

---

**Implementation Notes:**
- All flows should be A/B tested during development
- User feedback collection at key decision points
- Analytics tracking for flow completion rates
- Regular usability testing with target demographics
