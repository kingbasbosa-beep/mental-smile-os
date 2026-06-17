# RESIDENTIAL_ROUTE_HEALTH_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7A
Runtime effect: none

## Residential Routes

| Route | Surface | Owner | Classification | Health |
| --- | --- | --- | --- | --- |
| `/client/dashboard` | Client Room | Client | ACTIVE | PASS |
| `/s/personal-space` | Personal Space | Client | ACTIVE | PASS |
| `/chat` | Chat | Client/System | ACTIVE | PASS |
| `/s/support-room` | Support Room | Support Observer | ACTIVE | PASS |
| `/module/support-issue-selector` | Support Issue Selector | Client/System | ACTIVE | PASS |
| `/menu` | Residential Shell/Menu | System | ACTIVE | PASS |
| `/home` | Home Alias | System | ALIAS | WARNING |
| `/language` | Language Entry | Public/System | ACTIVE | PASS |
| `/app/exit-social-links` | Exit Social Links | System | ACTIVE | PASS |
| `/account-blocked` | Blocked Account | System/Monitoring | ACTIVE | PASS |
| `/clinician/chat-inbox` | Clinician Chat Inbox | Clinician | ACTIVE | CROSS_DOMAIN |
| `/chat/escalations` | Chat Escalations | Monitoring Operator | ACTIVE | CROSS_DOMAIN |
| `/chat/escalation/report` | Chat Escalation Report | Monitoring Operator | ACTIVE | CROSS_DOMAIN |

## Route Measures

| Classification | Count |
| --- | ---: |
| Active | 11 |
| Alias | 1 |
| Legacy | 0 |
| Dead | 0 |
| Unknown | 0 |
| Duplicate | 1 |
| Missing | 0 |

## Notes

- `/home` is documented as an alias opening the operational menu hub.
- Chat routes cross Residential and Monitoring boundaries.
- Clinician chat inbox touches Residential communication but is owned by clinician role.
