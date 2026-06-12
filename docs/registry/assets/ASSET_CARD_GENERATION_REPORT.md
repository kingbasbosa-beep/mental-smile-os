# ASSET CARD GENERATION REPORT

Phase 2.5 generated constitutional cards only. No asset, code, or pubspec file was moved, renamed, deleted, or modified.

## Counts

- Total Asset Cards: **306**
- Discovered File Cards: **297**
- Client Room Component-Contract Cards: **9**
- Active Cards: **114**
- Dormant Cards: **58**
- Legacy Cards: **126**
- Dead Cards: **7**
- Orphan Cards: **1**
- Unclassified Cards: **0**
- Duplicate Groups: **77**
- Cards Ready For Migration: **100**
- Cards Blocked From Migration: **206**

## Registry Distribution

| Registry | Cards |
|---|---:|
| CLIENT_ROOM | 13 |
| BRANDING_SYSTEM | 18 |
| ROOM_SYSTEM | 3 |
| ICONS_SYSTEM | 6 |
| BACKGROUNDS_SYSTEM | 5 |
| PLACEHOLDER_SYSTEM | 2 |
| CITY_SYSTEM | 26 |
| WEB_SYSTEM | 16 |
| AUTH_SYSTEM | 10 |
| PROVIDER_ROOM | 36 |
| CENTER_ROOM | 37 |
| OWNER_ROOM | 0 |
| MONITORING_ROOM | 0 |
| FUTURE_CONCEPTS | 0 |
| LEGACY_IMPORTS | 134 |
| UNCLASSIFIED | 0 |

## Registries With Zero Assets

- OWNER_ROOM
- MONITORING_ROOM
- FUTURE_CONCEPTS
- UNCLASSIFIED

## Top 20 Migration Risks

1. 111 discovered active files have runtime or platform consumers whose paths must be migrated atomically with code and packaging declarations.
2. 219 files participate in duplicate groups; alias paths cannot be removed before every consumer resolves to the canonical card.
3. 126 legacy cards require separation between immutable snapshot provenance and removable extinct-runtime copies.
4. 52 discovered dormant assets lack a proven visible runtime consumer and need named destinations plus review dates before movement.
5. Android launcher and drawable files can be consumed indirectly by manifests or resource names even when direct path reference counts are zero.
6. Three KEEP_SEPARATE duplicate groups reuse identical bytes for different semantic roles; a product meaning decision is required before consolidation.
7. Four branding duplicate groups need one approved canonical mark and channel-specific variant policy.
8. Provider and center success images share identical bytes across domains; shared WEB_SYSTEM ownership must be accepted before migration.
9. Library visuals exist in current, web-prefixed, and historical paths; consumer migration must select CITY_SYSTEM/library as the only owner.
10. Broad pubspec asset roots can keep obsolete aliases bundled after code references move.
11. Active app asset constants and direct string paths must be updated together in a future implementation wave.
12. Responsive desktop, tablet, and mobile families must move as complete sets to avoid missing-device fallbacks.
13. Seven DEAD cards include platform resources and require manifest/resource-resolution proof before deletion eligibility can be acted upon.
14. The orphan flutter_01.png has no constitutional owner and must remain quarantined until its origin is proven.
15. No dedicated Owner Room or Monitoring Room assets exist; migration must not invent ownership for unrelated visuals.
16. Six Client Room component contracts have no dedicated bitmap and are blocked until accessible asset families exist.
17. Client avatar art requires representation and privacy review before it becomes a canonical identity placeholder.
18. Legacy action visuals encode extinct operational concepts and cannot be purified through destination renaming.
19. Hash identity does not prove semantic interchangeability; card purpose must remain authoritative for KEEP_SEPARATE groups.
20. No physical ASSIST_LIBRARY root or consumer migration exists yet, so this registry is ready for planning but not for a one-step file move.

## Final Verdict

Is the project ready for asset migration?

**NO**

Blocking conditions:

- Active consumer paths and pubspec/platform declarations have not been migrated.
- Duplicate aliases remain physically present and 219 members require ordered canonicalization.
- Dormant assets lack complete retention metadata and review dates.
- Platform resources need indirect manifest verification.
- Six named Client Room visuals have no complete accessible asset family.
- KEEP_SEPARATE duplicate groups still require semantic decisions.
- The ASSIST_LIBRARY physical root and migration verification procedure do not exist yet.

Card generation is complete; physical migration remains blocked by the conditions above.