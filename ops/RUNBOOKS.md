# Runbooks — Deploy, Rollback, Backup/Restore

Deploy
1. Merge to main → CI builds/tests → deploy to EU/CH target
2. Healthcheck ; verify smoke tests: signup, post with image, report flow

Rollback
1. Trigger previous release; confirm  and smoke tests

Backups/Restore
- Daily managed DB backups; monthly restore drill to staging; verify integrity and app boot

Emergency Actions
- Enable maintenance mode; raise rate limits; disable uploads; block offending accounts
