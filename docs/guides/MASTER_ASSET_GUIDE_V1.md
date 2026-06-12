# Master Asset Guide V1

Status: GUIDE_DRAFT  
Runtime effect: none

## 1. Asset Doctrine

Assets are governed visual objects. Runtime asset registration currently lives mostly in `pubspec.yaml`; `AppAssets` only covers root logo constants. Existing docs under `docs/registry/assets` are documentation registries, not runtime registries.

## 2. Asset Groups

| Asset group | Owner | Consumers | Registry state | Status | Classification |
| --- | --- | --- | --- | --- | --- |
| branding root logos | Shared branding | logo widgets, splash/menu/client | `AppAssets` partial | Active | ACTIVE |
| shared navigation assets | Shared/navigation | shell actions | pubspec only | Active | ACTIVE |
| menu backgrounds | Shared navigation | MenuPage | pubspec only | Active | ACTIVE |
| client dashboard backgrounds | Residential | ClientDashboardPage | pubspec/docs | Active | ACTIVE |
| library assets | Content/residential | LibraryPage | duplicated docs/pubspec | Active duplicate | TRANSITIONAL |
| web library assets | Public/content | Web library | duplicated docs/pubspec | Active duplicate | TRANSITIONAL |
| web registration center assets | Center onboarding | web center pages | pubspec/docs | Active | ACTIVE |
| web registration clinician assets | Provider onboarding | web clinician pages | pubspec/docs | Active | ACTIVE |
| web_registration legacy path | Registration/legacy | pubspec includes path | duplicated path | Present | TRANSITIONAL |
| C5 assets | Legacy visual system | pubspec/docs | manifest/docs | Present | LEGACY |
| C6 library assets | Library/content | library | manifest/docs | Present | ACTIVE |
| C7 branding assets | Branding | splash/home/logo | pubspec/docs | Present | TRANSITIONAL |
| addiction/family support images | Residential support | modules | pubspec only | Active | ACTIVE |
| specialist images | Commercial/provider | specialists | pubspec only | Active | ACTIVE |
| center images | Commercial/center | centers | pubspec only | Active | ACTIVE |
| dashboard action images | Role dashboards | client/center/clinician pages | pubspec only | Active | ACTIVE |
| animations | Unknown | no consumer observed | none | empty | ORPHANED |
| icons | Unknown | no consumer observed | none | empty | ORPHANED |

## 3. Asset Registry References

| Registry docs | Purpose | Runtime consumer |
| --- | --- | --- |
| `docs/registry/assets/ASSET_CARD_REGISTRY.md` | asset card governance | none observed |
| `docs/registry/assets/ASSET_REGISTRY_REFERENCE.md` | asset reference | none observed |
| `docs/registry/assets/CLIENT_ROOM_ASSETS.md` | client asset domain | none observed |
| `docs/registry/assets/CENTER_ROOM_ASSETS.md` | center asset domain | none observed |
| `docs/registry/assets/PROVIDER_ROOM_ASSETS.md` | provider asset domain | none observed |
| `docs/registry/assets/MONITORING_ROOM_ASSETS.md` | monitoring asset domain | none observed |
| `docs/registry/assets/OWNER_ROOM_ASSETS.md` | owner asset domain | none observed |
| `docs/registry/assets/LEGACY_ASSETS.md` | legacy asset domain | none observed |

## 4. Asset Approval Checks

| Check | Pass condition |
| --- | --- |
| Path exists | Asset file exists in current tree or is marked FUTURE/FROZEN. |
| Pubspec exposure | Asset directory or file is declared when runtime use is intended. |
| Owner | Domain owner assigned by guide. |
| Surface | Residential, Commercial, Administrative, Owner, Monitoring, Shared, or FUTURE. |
| Duplication | Duplicate path families are marked transitional. |
| Language | Any embedded visible text follows surface language policy. |

