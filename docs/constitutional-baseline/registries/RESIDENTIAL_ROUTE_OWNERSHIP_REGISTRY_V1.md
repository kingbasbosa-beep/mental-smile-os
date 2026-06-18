# RESIDENTIAL_ROUTE_OWNERSHIP_REGISTRY_V1

Status: ACTIVE_OWNERSHIP_REGISTRY
Phase: 8B
Runtime effect: none

| Entry | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `/client/session-room` | Client/System | Public client access | Router | fresh session intent | none | ACTIVE | Runtime | ACCOUNT_FREE_CLIENT_SESSION_ROOM |
| `/client/dashboard` | Client/System | Client Room, Personal Space | Auth, router, clients | clientSignals | `clients`, `saved_destinations` | ARCHIVED_PENDING_MANUAL_VERIFICATION | Runtime archive | CLIENT_LEGACY_REMOVED |
| `/s/personal-space` | Client/System | Client, signal board | Auth, clients, signal_events | personal/residential signals | `clients`, `signal_events` | ACTIVE | Runtime | ACTIVE |
| `/chat` | Client/System | Client, chat runtime | Auth, chat service | chat/support signals | `chat_threads`, messages | ACTIVE | Runtime | ACTIVE |
| `/s/support-room` | Support Observer/Owner | Support Observer, Monitoring | Role gate, support_requests | support/risk signals | `support_requests` | ACTIVE | Runtime | CROSS_DOMAIN |
| `/module/support-issue-selector` | Client/System | Client, Support Room | Auth, signals | support request signals | `support_requests` | ACTIVE | Runtime | ACTIVE |
| `/menu` | System | Client shell | Router | navigation intent | none | ACTIVE | Runtime | ACTIVE |
| `/home` | System | Entry alias | Router | none | none | ACTIVE | Runtime | ALIAS |
| `/language` | Public/System | Public, registration entry | Localization | none | none | ACTIVE | Runtime | ACTIVE |
| `/app/exit-social-links` | System | Exit/social handoff | Router | exit intent | none | ACTIVE | Runtime | ACTIVE |
| `/account-blocked` | System/Monitoring | blocked users | Account access, visibility readiness | account safety state | role/account docs | ACTIVE | Runtime | CROSS_DOMAIN |
