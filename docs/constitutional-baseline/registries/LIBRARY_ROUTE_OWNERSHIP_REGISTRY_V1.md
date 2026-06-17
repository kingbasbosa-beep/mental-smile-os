# LIBRARY_ROUTE_OWNERSHIP_REGISTRY_V1

Status: ACTIVE_OWNERSHIP_REGISTRY
Phase: 8B
Runtime effect: none

| Entry | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `/module/library` | Owner/System | app clients | LibraryPage, signals | libraryCategoryOpened | `signal_events` | ACTIVE | Runtime | ACTIVE |
| `/web/library` | Owner/System | public web users | LibraryPage | libraryCategoryOpened | `signal_events` | ACTIVE | Runtime | ACTIVE |
| `/web/library/policy` | Owner/System | public web users | LibraryPolicyPage | policy view intent | none | ACTIVE | Runtime | ACTIVE |
| `/library` | Owner/System | portal users | LibraryPage | libraryCategoryOpened | `signal_events` | ACTIVE | Runtime | ACTIVE |
| `/s/city/library` | Owner/System | city/public users | City surface, metadata | future library discovery signals | unknown | ACTIVE | Future | ACTIVE_FUTURE |
