# Data Retention & Deletion Schedule (MVP)

## Overview
This document defines data retention periods and automated purge workflows to ensure GDPR/FADP compliance while maintaining operational requirements.

## Data Classes & Retention Periods

### Account Data
| Data Type | Retention Period | Purge Trigger | Legal Basis |
|-----------|------------------|---------------|-------------|
| Email addresses | Account lifetime + 30 days | Account deletion + grace period | Contract |
| Password hashes | Account lifetime | Account deletion (immediate) | Contract |
| Date of birth | Account lifetime | Account deletion (immediate) | Legal requirement |
| Verification tokens | 24 hours | Token expiry or use | Legitimate interest |

### Profile & Content Data
| Data Type | Retention Period | Purge Trigger | Legal Basis |
|-----------|------------------|---------------|-------------|
| Display names | Account lifetime + 30 days | Account deletion + grace period | Contract |
| Bio/location text | Account lifetime + 30 days | Account deletion + grace period | Contract |
| Avatar images | Account lifetime + 30 days | Account deletion + grace period | Contract |
| Posts (text) | Account lifetime + 30 days | Account deletion + grace period | Contract |
| Post images | Account lifetime + 30 days | Account deletion + grace period | Contract |
| Comments | Account lifetime + 30 days | Account deletion + grace period | Contract |

### Social & Interaction Data
| Data Type | Retention Period | Purge Trigger | Legal Basis |
|-----------|------------------|---------------|-------------|
| Follow relationships | Account lifetime | Account deletion (immediate) | Contract |
| Group memberships | Account lifetime | Account deletion (immediate) | Contract |
| Likes/reactions | Account lifetime | Account deletion (immediate) | Contract |

### Moderation & Safety Data
| Data Type | Retention Period | Purge Trigger | Legal Basis |
|-----------|------------------|---------------|-------------|
| Reports (content) | 2 years | Fixed retention period | Legitimate interest |
| Moderation actions | 2 years | Fixed retention period | Legitimate interest |
| Audit logs | 1 year | Fixed retention period | Legitimate interest |
| Banned user records | 3 years | Fixed retention period | Legal compliance |

### Technical & Operational Data
| Data Type | Retention Period | Purge Trigger | Legal Basis |
|-----------|------------------|---------------|-------------|
| Application logs (with PII) | 30 days | Rolling window | Legitimate interest |
| Analytics events | 90 days → aggregated | Aggregation process | Legitimate interest |
| Session data | 30 days inactive | Session expiry | Legitimate interest |
| Rate limit counters | 24 hours | Rolling window | Legitimate interest |

### Backup Data
| Data Type | Retention Period | Purge Trigger | Legal Basis |
|-----------|------------------|---------------|-------------|
| Database backups | 12 months | Fixed retention period | Legitimate interest |
| Media backups | 12 months | Fixed retention period | Legitimate interest |
| Log backups | 90 days | Fixed retention period | Legitimate interest |

## Automated Purge Workflows

### Daily Purge Jobs
- Expired verification tokens
- Expired session data
- Old rate limit counters
- Application logs older than 30 days

### Weekly Purge Jobs
- Soft-deleted content older than 30 days
- Aggregated analytics raw data older than 90 days
- Inactive session cleanup

### Monthly Purge Jobs
- Audit logs older than 1 year
- Backup data older than 12 months
- Account deletion grace period cleanup

### Annual Review Jobs
- Moderation data older than 2 years
- Banned user records older than 3 years
- Policy compliance audit

## Data Subject Rights Implementation

### Right to Erasure ("Right to be Forgotten")
1. **User-initiated deletion:**
   - Immediate: password hash, verification tokens, sessions
   - 30-day grace: profile data, posts, comments (soft-delete)
   - Permanent: audit trail of deletion request (anonymized)

2. **Exceptions to deletion:**
   - Legal hold requirements
   - Fraud prevention (hashed identifiers only)
   - Safety/moderation records (anonymized where possible)

### Right to Data Portability
- Export format: JSON with media file links
- Includes: profile, posts, comments, group memberships
- Excludes: moderation records, other users' data

## Technical Implementation

### Database Triggers
```sql
-- Soft delete trigger for posts
CREATE OR REPLACE FUNCTION soft_delete_cleanup()
RETURNS void AS $$
BEGIN
  DELETE FROM posts WHERE deleted_at < NOW() - INTERVAL '30 days';
  DELETE FROM comments WHERE deleted_at < NOW() - INTERVAL '30 days';
END;
$$ LANGUAGE plpgsql;
```

### Cron Jobs (Kubernetes CronJob or equivalent)
- `0 2 * * *` - Daily purge job
- `0 3 * * 0` - Weekly purge job  
- `0 4 1 * *` - Monthly purge job
- `0 5 1 1 *` - Annual review job

## Compliance Notes

### GDPR Article 17 (Right to Erasure)
- Personal data erased without undue delay
- 30-day grace period for operational requirements
- Third parties notified of erasure requests where applicable

### GDPR Article 5 (Storage Limitation)
- Data kept only as long as necessary for stated purposes
- Regular review of retention periods
- Automated deletion where technically feasible

## Monitoring & Alerts

### Retention Compliance Metrics
- Purge job success/failure rates
- Data volume trends by category
- Compliance audit trail completeness

### Alerting Thresholds
- Purge job failures → immediate alert
- Retention period violations → daily report
- Storage growth anomalies → weekly review

## Review & Updates

This schedule will be reviewed:
- **Quarterly:** Operational effectiveness
- **Annually:** Legal compliance requirements
- **Ad-hoc:** Regulatory changes or incidents

---

**Approval Required:**
- Privacy Officer: _________________ Date: _________
- Legal Counsel: _________________ Date: _________
- Technical Lead: _________________ Date: _________
