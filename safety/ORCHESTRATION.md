# Safety Orchestration & Escalation Logic (MVP)

## Overview
This document defines the rule engine that orchestrates automated safety decisions, escalation paths, and logging requirements for content moderation.

## Content Classification Rule Engine

### NSFW Content Rules
| Condition | Score Range | Action | Queue | Notification |
|-----------|-------------|--------|-------|--------------|
| Safe content | 0.0 - 0.29 | Allow | No | None |
| Mild NSFW | 0.30 - 0.49 | Allow + Auto-blur | No | None |
| Moderate NSFW | 0.50 - 0.69 | Allow + Blur + Tag | Human review queue | None |
| Strong NSFW | 0.70 - 0.89 | Queue for review | High priority | Moderator alert |
| Extreme/Illegal | 0.90 - 1.0 | Block + Quarantine | Urgent queue | Safety Lead + Legal |

### Harassment/Toxicity Rules
| Condition | Score Range | Action | User Impact | Escalation |
|-----------|-------------|--------|-------------|------------|
| Clean text | 0.0 - 0.19 | Allow | None | None |
| Mild concern | 0.20 - 0.39 | Allow + Flag | Shadow flag | None |
| Moderate toxicity | 0.40 - 0.59 | Queue for review | None | Community review |
| High toxicity | 0.60 - 0.79 | Block + Queue | Temp restriction | Moderator review |
| Severe harassment | 0.80 - 1.0 | Block + Ban consideration | Account restriction | Safety Lead |

### Spam Detection Rules
| Condition | Indicators | Action | Duration | Appeals |
|-----------|------------|--------|----------|---------|
| Clean content | < 2 spam signals | Allow | N/A | N/A |
| Suspicious | 2-3 spam signals | Rate limit | 1 hour | Automatic |
| Likely spam | 4-5 spam signals | Queue + Restrict | 6 hours | Human review |
| Confirmed spam | > 5 spam signals | Block + Shadowban | 24 hours | Appeal process |

## User Reputation Integration

### Reputation Modifiers
| User Type | Score Multiplier | Review Priority | Actions Available |
|-----------|------------------|-----------------|-------------------|
| New user (< 7 days) | 1.5x | High | Report only |
| Regular user | 1.0x | Normal | Report + basic mod |
| Trusted user | 0.8x | Low | Report + community mod |
| Moderator | 0.5x | Lowest | All actions |

### Progressive Enforcement
| Violation Count | Action | Duration | Reset Period |
|-----------------|--------|----------|--------------|
| First offense | Warning email | N/A | 30 days |
| Second offense | Content removal | N/A | 60 days |
| Third offense | Rate limiting | 24 hours | 90 days |
| Fourth offense | Temporary ban | 7 days | 180 days |
| Fifth offense | Permanent ban | Permanent | Appeal only |

## Escalation Decision Matrix

### Automated Actions (No Human Review)
```
IF (content_score < 0.3 AND user_reputation > 0.7) 
THEN allow
LOG: decision_path="auto_allow", scores={content: X, user: Y}

IF (content_score > 0.9 OR contains_illegal_signals) 
THEN block_immediate + quarantine_media + notify_safety_lead
LOG: decision_path="auto_block_urgent", reason="illegal_content_detected"
```

### Human Review Required
```
IF (content_score BETWEEN 0.3 AND 0.9 AND user_reputation < 0.5)
THEN queue_human_review
SET priority = CASE 
  WHEN content_score > 0.7 THEN "high"
  WHEN user_violations > 2 THEN "high" 
  ELSE "normal"
END
```

### Override Paths
```
IF (moderator_override = true AND moderator_level >= required_level)
THEN execute_override_action
LOG: decision_path="manual_override", moderator_id=X, original_action=Y, override_action=Z, reason="manual review"
```

## Truth Tables

### Content + User Signal Combinations
| Content Risk | User Trust | Reputation | Action |
|--------------|------------|------------|--------|
| Low | High | Good | Auto-allow |
| Low | Low | Poor | Allow + monitor |
| Medium | High | Good | Allow + soft flag |
| Medium | Low | Poor | Queue for review |
| High | High | Good | Queue for review |
| High | Low | Poor | Block + review |
| Critical | Any | Any | Block + escalate |

### Multi-Signal Decision Logic
| NSFW Score | Toxicity Score | Spam Score | Final Action |
|------------|---------------|------------|--------------|
| < 0.3 | < 0.3 | < 0.3 | Allow |
| < 0.3 | < 0.3 | 0.3-0.6 | Rate limit |
| < 0.3 | 0.3-0.6 | < 0.3 | Soft flag |
| 0.3-0.7 | < 0.3 | < 0.3 | Blur + allow |
| 0.3-0.7 | 0.3-0.6 | < 0.3 | Queue review |
| > 0.7 | Any | Any | Block + escalate |
| Any | > 0.6 | Any | Block + escalate |

## Logging Requirements

### Required Log Fields
```json
{
  "timestamp": "2025-09-26T10:00:00Z",
  "content_id": "p_12345",
  "user_id": "u_67890",
  "decision_path": "auto_allow|queue_review|block_immediate|manual_override",
  "scores": {
    "nsfw": 0.25,
    "toxicity": 0.15,
    "spam": 0.05
  },
  "user_reputation": 0.85,
  "user_violation_count": 0,
  "action_taken": "allow|blur|queue|block|ban",
  "queue_priority": "low|normal|high|urgent",
  "moderator_id": "u_mod123",
  "override_reason": "manual review determined safe",
  "notification_sent": ["safety_lead", "moderator_pool"],
  "processing_time_ms": 150
}
```

### Audit Trail Requirements
- All automated decisions logged with full context
- Manual overrides require justification
- Model scores and thresholds preserved for appeals
- Processing time tracked for performance monitoring
- Queue assignment and priority changes logged

## Notification & Escalation Triggers

### Immediate Notifications (< 5 minutes)
- Illegal content detected → Safety Lead + Legal
- Account takeover signals → Security Team
- System errors in safety pipeline → Engineering

### Hourly Digest Notifications
- High-priority queue backlog > threshold
- False positive rate anomalies
- Model performance degradation

### Daily Summary Reports
- Total actions by type and severity
- Queue processing times and backlogs
- User appeal outcomes and trends
- Model accuracy metrics

## Override Authority Matrix

| Action Type | Minimum Role | Approval Required | Audit Level |
|-------------|--------------|-------------------|-------------|
| Allow blocked content | Moderator | None | Standard |
| Block allowed content | Moderator | None | Standard |
| Unban user | Senior Moderator | Yes | Enhanced |
| Override illegal content block | Safety Lead | Legal approval | Maximum |
| Modify rule thresholds | Admin | Product approval | Maximum |

## Performance & SLA Requirements

### Response Time SLAs
- Automated decisions: < 200ms p95
- Queue assignment: < 1 second
- Notification delivery: < 30 seconds
- Manual override processing: < 2 minutes

### Accuracy Targets
- False positive rate: < 5% for automated actions
- False negative rate: < 1% for critical content
- Override rate: < 10% of automated decisions
- Appeal success rate: 60-80% (indicates good calibration)

## Error Handling & Fallbacks

### System Failure Modes
```
IF (classification_service_down)
THEN default_to_human_review
SET queue_priority = "high"
NOTIFY engineering_team

IF (queue_system_failure)
THEN email_fallback_to_moderators
LOG error_condition = "queue_system_failure"

IF (database_unavailable)
THEN fail_safe_to_block
LOG error_condition = "data_unavailable"
```

### Circuit Breaker Patterns
- Classification API: 5 failures → 30 second circuit break
- Queue service: 3 failures → manual fallback mode
- Notification service: 10 failures → email backup system

---

**Implementation Notes:**
- Rule engine implemented as configurable decision tree
- All thresholds stored in database for runtime adjustment
- A/B testing framework for rule modifications
- Regular model retraining based on human review feedback
