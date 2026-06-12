# ASSET CONSTITUTION AUDIT REPORT

Workspace-wide discovery across current assets and `_archive`; generated build/dependency directories excluded.

## Totals

- Total Assets: **297**
- Active Assets: **111**
- Dormant Assets: **52**
- Legacy Assets: **126**
- Orphan Assets: **1**
- Dead Assets: **7**
- Duplicate Candidates: **77 byte-identical groups**
- Unclassified Assets: **1**

## Registry Distribution

| Registry | Count |
|---|---:|
| AUTH_SYSTEM | 10 |
| BACKGROUND_SYSTEM | 5 |
| BRANDING_SYSTEM | 12 |
| CENTER_ROOM | 48 |
| CITY_SYSTEM | 2 |
| CLIENT_ROOM | 12 |
| ICONS_SYSTEM | 12 |
| LEGACY_IMPORTS | 109 |
| LIBRARY_SYSTEM | 27 |
| PROVIDER_ROOM | 46 |
| UNCLASSIFIED | 1 |
| WEB_SYSTEM | 13 |

## Audit Notes

- ACTIVE means a current Dart/platform runtime reference was proven.
- DORMANT means the asset is bundled or intentionally grouped but has no direct current runtime reference.
- LEGACY covers historical snapshot assets and assets whose names encode extinct lifecycle concepts.
- ORPHAN means no clear constitutional owner or runtime reference was found.
- DEAD means no current reference and no intentional retention signal was found.
- Duplicate candidates are byte-identical SHA-256 groups; no deletion decision is made in this phase.
- OWNER_ROOM and MONITORING_ROOM have no dedicated visual assets in the discovered set.

## Reports

- [CLIENT_ROOM_ASSETS.md](./CLIENT_ROOM_ASSETS.md)
- [CITY_SYSTEM_ASSETS.md](./CITY_SYSTEM_ASSETS.md)
- [PROVIDER_ROOM_ASSETS.md](./PROVIDER_ROOM_ASSETS.md)
- [CENTER_ROOM_ASSETS.md](./CENTER_ROOM_ASSETS.md)
- [OWNER_ROOM_ASSETS.md](./OWNER_ROOM_ASSETS.md)
- [MONITORING_ROOM_ASSETS.md](./MONITORING_ROOM_ASSETS.md)
- [WEB_SYSTEM_ASSETS.md](./WEB_SYSTEM_ASSETS.md)
- [AUTH_SYSTEM_ASSETS.md](./AUTH_SYSTEM_ASSETS.md)
- [BRANDING_SYSTEM_ASSETS.md](./BRANDING_SYSTEM_ASSETS.md)
- [LEGACY_ASSETS.md](./LEGACY_ASSETS.md)
- [UNCLASSIFIED_ASSETS.md](./UNCLASSIFIED_ASSETS.md)
