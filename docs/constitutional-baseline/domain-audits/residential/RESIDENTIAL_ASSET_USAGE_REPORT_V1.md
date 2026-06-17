# RESIDENTIAL_ASSET_USAGE_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7A
Runtime effect: none

## Active Residential Asset Families

| Asset/Family | Used By | Classification | Health |
| --- | --- | --- | --- |
| `assets/images/avatar_client.png` | Chat avatar fallback | ACTIVE | PASS |
| `assets/images/backgrounds/specialists_bg_mobile.png` | Chat, support flows | ACTIVE | PASS |
| `assets/images/backgrounds/specialists_bg_tablet.png` | Chat, support flows | ACTIVE | PASS |
| `assets/images/backgrounds/specialists_bg_desktop.png` | Chat, support flows | ACTIVE | PASS |
| `assets/branding/navigation/back/back_right_gold.png` | Chat/support back affordance | ACTIVE_BRANDING | PASS |
| `assets/branding/navigation/back/back_left_gold.png` | Chat/support back affordance | ACTIVE_BRANDING | PASS |
| `assets/branding/logo_primary_dark.png` | Client/support branding | ACTIVE_BRANDING | PASS |
| `assets/images/addiction/*` | Support entry addiction module paths | ACTIVE_RUNTIME | PASS |
| `assets/images/family_support/*` | Support entry family/special-needs paths | ACTIVE_RUNTIME | PASS |
| `assets/c7_branding/home/home_bg.png` | Support entry atmospheric/background visual | ACTIVE_BRANDING | PASS |

## Measures

| Classification | Count |
| --- | ---: |
| Active | 10 |
| Legacy | 0 |
| Dead | 0 |
| Unknown | 0 |
| Duplicate | 1 |
| Missing | 0 |

## Duplicate/Overlap

- `specialists_bg_*` appears as residential support/chat background while also serving broader specialist/discovery contexts.

## Asset Health

Residential asset usage is mostly clean after C5/C6 purification. The active chat avatar now uses `assets/images/avatar_client.png`.
