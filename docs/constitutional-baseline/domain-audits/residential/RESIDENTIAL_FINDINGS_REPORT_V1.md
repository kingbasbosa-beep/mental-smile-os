# RESIDENTIAL_FINDINGS_REPORT_V1

Status: ACTIVE_DOMAIN_FINDINGS
Phase: 7A
Runtime effect: none

## Critical Findings

### MS-RES-FINDING-001

Severity: HIGH
Description: Residential signals span Client Room, Personal Space, Support Issue Selector, Saved Destinations, Chat, and Support Room without a dedicated Residential Signal Ownership Registry.
Impact: Future signal additions may blur ownership between Residential and Monitoring.
Classification: Missing

### MS-RES-FINDING-002

Severity: MEDIUM
Description: Residential localization is partially centralized; major residential pages use inline Arabic/English strings and direct locale checks.
Impact: Text consistency, reviewability, and translation completeness are harder to govern.
Classification: Unknown/Missing

### MS-RES-FINDING-003

Severity: MEDIUM
Description: Support language appears across Support Entry, Support Issue Selector, Chat, and Support Room.
Impact: Support pathways can duplicate responsibility unless support surfaces are explicitly bounded.
Classification: Duplicate

### MS-RES-FINDING-004

Severity: MEDIUM
Description: Chat escalation routes and collections cross Residential and Monitoring domains.
Impact: This is valid but requires explicit boundary governance to avoid monitoring authority leakage into residential chat.
Classification: Active/Cross-domain

### MS-RES-FINDING-005

Severity: LOW
Description: `/home` is an alias to the operational menu hub.
Impact: Route lineage is documented but should remain classified as alias, not a separate residential room.
Classification: Alias

## Recommended Archive Cards

- `ARCHIVE_CARD_RESIDENTIAL_PRE_SIGNAL_REGISTRY_V1`
- `ARCHIVE_CARD_RESIDENTIAL_INLINE_LOCALIZATION_ERA_V1`
- `ARCHIVE_CARD_SUPPORT_SIGNAL_BOUNDARY_V1`

## Recommended Registry Updates

- Add Residential Signal Ownership Registry.
- Add Residential Route Ownership entries for Client Room, Personal Space, Support Room, Chat, and Support Issue Selector.
- Add Residential Collection Ownership entries for `clients`, `saved_destinations`, `support_requests`, `chat_threads`, and `signal_events`.
- Add Residential Localization Registry.

## Finding Counts

- Critical/High: 1
- Medium: 3
- Low: 1
- Total: 5
