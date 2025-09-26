# Non-Functional Requirements & SLOs — MVP

## Overview
This document defines the non-functional requirements (NFRs) and Service Level Objectives (SLOs) for the Carya community platform MVP. These requirements ensure the platform meets performance, security, reliability, and compliance standards necessary for a privacy-focused adult community platform operating in CH/EU jurisdictions.

---

## Security Requirements

### Authentication & Authorization (SEC-001)
- **Requirement:** Secure user authentication and authorization framework
- **SLO:** 
  - Password hashing with Argon2id or bcrypt (cost factor ≥12)
  - Session tokens secure, httpOnly, sameSite=strict
  - Admin accounts require 2FA (TOTP)
  - Failed login lockout after 10 attempts for 15 minutes
- **Measurement:** Security audit scan results, penetration test findings
- **Error Budget:** Zero tolerance for authentication bypasses

### Transport & Data Security (SEC-002)
- **Requirement:** All data encrypted in transit and at rest
- **SLO:**
  - HTTPS/TLS 1.3 with HSTS (min 1 year)
  - Content Security Policy (CSP) strict-dynamic
  - Database encryption at rest with provider-managed keys
  - Object storage server-side encryption enabled
- **Measurement:** SSL Labs grade A+ required
- **Error Budget:** Zero tolerance for data exposure

### Access Control (SEC-003)
- **Requirement:** Principle of least privilege enforced
- **SLO:**
  - Database roles with minimal required permissions
  - API endpoints require appropriate authorization
  - Admin functions separated from user functions
  - Audit logging for all privileged operations
- **Measurement:** Regular access reviews, authorization test coverage
- **Error Budget:** Zero unauthorized access incidents

---

## Performance Requirements

### API Response Times (PERF-001)
- **Requirement:** Fast API response times for core user actions
- **SLO:**
  - p95 API response time < 400ms @ 100 concurrent users
  - p99 API response time < 800ms @ 100 concurrent users  
  - Search results returned in < 300ms p95 at 100k rows
  - Time to first byte (TTFB) < 200ms from EU locations
- **Measurement:** Application performance monitoring (APM) metrics
- **Error Budget:** 5% of requests per 30-day period may exceed targets

### Media Upload Performance (PERF-002)
- **Requirement:** Efficient media upload and processing
- **SLO:**
  - Image upload (2MB) completes in < 5 seconds
  - EXIF stripping and processing < 2 seconds
  - Thumbnail generation < 3 seconds
  - CDN cache hit ratio > 90% for media
- **Measurement:** Upload success rate, processing time metrics
- **Error Budget:** 2% of uploads may exceed timing targets

### Database Performance (PERF-003)
- **Requirement:** Scalable database performance
- **SLO:**
  - Database query p95 < 100ms
  - Connection pool utilization < 80%
  - Full-text search p95 < 200ms
  - Index hit ratio > 95%
- **Measurement:** Database monitoring metrics
- **Error Budget:** 5% of queries may exceed timing targets

### Feed Generation (PERF-004)
- **Requirement:** Timely feed generation and updates
- **SLO:**
  - Home feed loads in < 500ms p95
  - Feed updates appear within 5 minutes of posting
  - Pagination response < 300ms p95
- **Measurement:** Feed performance metrics, update latency tracking
- **Error Budget:** 3% of feed loads may exceed timing targets

---

## Reliability Requirements

### System Uptime (REL-001)
- **Requirement:** High availability for core platform functions
- **SLO:**
  - 99.9% uptime (8.76 hours downtime per year maximum)
  - Recovery Time Objective (RTO): 15 minutes for critical issues
  - Recovery Point Objective (RPO): 1 hour for data loss
- **Measurement:** Uptime monitoring, incident tracking
- **Error Budget:** 43.2 minutes downtime per 30-day period

### Data Durability (REL-002)
- **Requirement:** Protection against data loss
- **SLO:**
  - 99.99% data durability
  - Daily automated database backups
  - Cross-region backup replication
  - Backup restore testing monthly
  - Point-in-time recovery capability
- **Measurement:** Backup success rate, restore test results
- **Error Budget:** Zero tolerance for permanent data loss

### Error Rates (REL-003)
- **Requirement:** Low application error rates
- **SLO:**
  - HTTP 5xx error rate < 0.1%
  - Application exception rate < 0.5%
  - Failed job retry success rate > 95%
- **Measurement:** Application logs, error tracking (Sentry)
- **Error Budget:** 1% of requests may result in 5xx errors

---

## Scalability Requirements

### Concurrent User Capacity (SCALE-001)
- **Requirement:** Support expected user load
- **SLO:**
  - 500 concurrent active users (MVP target)
  - 100 requests/second sustained throughput
  - Auto-scaling triggers at 70% resource utilization
- **Measurement:** Load testing results, resource utilization metrics
- **Error Budget:** Performance degradation acceptable above 150% target load

### Storage Capacity (SCALE-002)
- **Requirement:** Adequate storage for user-generated content
- **SLO:**
  - 10TB initial media storage capacity
  - 1TB database storage capacity
  - Storage auto-scaling with 24h advance warning
- **Measurement:** Storage utilization monitoring
- **Error Budget:** Manual intervention acceptable for capacity expansion

---

## Privacy & Compliance Requirements

### GDPR/FADP Compliance (PRIV-001)
- **Requirement:** Full compliance with EU/Swiss data protection laws
- **SLO:**
  - Data subject request fulfillment within 30 days
  - Data export in machine-readable format within 7 days
  - Right to erasure processed within 30 days (with 30-day soft delete)
  - Privacy by design/default enforced in all features
- **Measurement:** Compliance audit results, request processing times
- **Error Budget:** Zero tolerance for non-compliance

### Data Retention (PRIV-002)
- **Requirement:** Appropriate data retention policies
- **SLO:**
  - PII logs purged after 30 days maximum
  - Deleted content soft-deleted for 30 days then purged
  - Analytics data aggregated and anonymized after 90 days
  - Backup retention for 12 months maximum
- **Measurement:** Automated retention policy execution logs
- **Error Budget:** 1% deviation in retention timing acceptable

### Consent Management (PRIV-003)
- **Requirement:** Explicit consent tracking and management
- **SLO:**
  - Consent withdrawal processed within 24 hours
  - Consent audit trail maintained for 3 years
  - Granular consent controls available to users
- **Measurement:** Consent management system metrics
- **Error Budget:** Zero tolerance for processing without valid consent

---

## Content Safety Requirements

### Moderation Response Times (SAFETY-001)
- **Requirement:** Timely response to content reports
- **SLO:**
  - P1 (illegal/urgent) reports: triage ≤ 1 hour, action ≤ 6 hours
  - P2 (harassment/hate) reports: triage ≤ 6 hours, action ≤ 24 hours  
  - P3 (spam/other) reports: triage ≤ 24 hours, action ≤ 72 hours
  - Median time to first action < 12 hours
- **Measurement:** Moderation queue metrics, response time tracking
- **Error Budget:** 10% of reports may exceed SLO timing

### Content Classification Accuracy (SAFETY-002)
- **Requirement:** Accurate automated content classification
- **SLO:**
  - NSFW detection precision > 95%, recall > 90%
  - Spam detection false positive rate < 5%
  - Prohibited content (CSAM) detection: 100% precision required
- **Measurement:** Classification accuracy metrics, human review audits
- **Error Budget:** 1% classification error acceptable (except prohibited content)

---

## Accessibility Requirements

### WCAG 2.1 Compliance (ACCESS-001)
- **Requirement:** Full accessibility for users with disabilities
- **SLO:**
  - WCAG 2.1 AA compliance for all public interfaces
  - Keyboard navigation support for all functionality
  - Screen reader compatibility maintained
  - Color contrast ratio ≥ 4.5:1 for normal text
- **Measurement:** Automated accessibility testing, manual audits
- **Error Budget:** Minor accessibility issues acceptable if <1% of functionality

### Multi-language Support (ACCESS-002)
- **Requirement:** Internationalization support
- **SLO:**
  - English, German, French, Italian language support
  - RTL text direction support ready
  - Unicode text handling throughout
  - Localized error messages and UI text
- **Measurement:** Localization completeness metrics
- **Error Budget:** 5% of text may remain untranslated during MVP

---

## Monitoring & Observability Requirements

### Application Monitoring (MONITOR-001)
- **Requirement:** Comprehensive application monitoring
- **SLO:**
  - 99% metric collection success rate
  - Alert response time < 5 minutes for critical issues
  - Dashboard availability 99.5%
  - Log retention for 30 days minimum
- **Measurement:** Monitoring system health metrics
- **Error Budget:** 1% monitoring data loss acceptable

### Security Monitoring (MONITOR-002)
- **Requirement:** Security event monitoring and alerting
- **SLO:**
  - Failed login attempts tracked and alerted
  - Suspicious activity patterns detected within 15 minutes
  - Security incident response initiated within 1 hour
- **Measurement:** Security monitoring effectiveness metrics
- **Error Budget:** Zero tolerance for undetected security incidents

---

## Testing Requirements

### Test Coverage (TEST-001)
- **Requirement:** Comprehensive test coverage
- **SLO:**
  - Unit test coverage ≥ 80%
  - Integration test coverage for all API endpoints
  - End-to-end test coverage for critical user paths
  - Security test coverage for authentication/authorization
- **Measurement:** Test coverage reports, CI/CD pipeline metrics
- **Error Budget:** Test coverage may drop to 75% temporarily during development

### Performance Testing (TEST-002)
- **Requirement:** Regular performance testing
- **SLO:**
  - Load testing performed weekly during development
  - Stress testing performed before each release
  - Performance regression testing automated in CI/CD
- **Measurement:** Test execution frequency, performance trend analysis
- **Error Budget:** 5% of performance tests may show temporary regressions

---

## Error Budget Policy

**Error Budget Calculation:**
- **30-day rolling window** for all SLO measurements
- **Composite error budget** considers all services together
- **Error budget burn rate** alerts when 25%, 50%, 75% consumed

**Error Budget Exhaustion Response:**
1. **25% consumed:** Engineering review of reliability practices
2. **50% consumed:** Freeze on non-critical feature development
3. **75% consumed:** All hands on reliability improvement
4. **100% consumed:** Feature freeze until error budget replenished

**SLO Review Process:**
- **Weekly:** SLO performance review in engineering standup
- **Monthly:** Comprehensive SLO review with stakeholder feedback
- **Quarterly:** SLO target adjustment based on user feedback and business needs

---

## Dependencies & Integration Points

**External Service SLOs:**
- **Cloud Provider:** 99.95% uptime SLA minimum
- **Email Service:** 99.9% delivery rate
- **CDN/Media Storage:** 99.99% availability
- **Third-party APIs:** Circuit breaker pattern for ≥99% availability

**Monitoring Stack:**
- **APM:** Sentry or equivalent for error tracking
- **Metrics:** Prometheus + Grafana or cloud-native solution
- **Logs:** Centralized logging with structured JSON format
- **Uptime:** External monitoring service (Pingdom/StatusPage)

**Alerting Strategy:**
- **Critical:** Page on-call engineer immediately
- **Warning:** Slack notification, review within 24 hours  
- **Info:** Dashboard notification, weekly review
