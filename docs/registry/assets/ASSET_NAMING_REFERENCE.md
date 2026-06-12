# ASSET NAMING REFERENCE

Status: Reference  
Source: ASSET_CONSTITUTION_V1.md

## Naming Doctrine

Asset names must be stable, semantic, uppercase, and version-aware when needed.

```text
<OWNER>_<MEANING>_<VARIANT>_<VERSION>
```

## Required Qualities

- Names describe meaning, not temporary appearance.
- Names begin with the owner or owning domain.
- Names are readable without opening the source code.
- Names do not encode extinct doctrine.
- Names avoid vague terms like final, copy, new, temp, or test.
- Device variants appear only when the asset is truly variant-specific.
- Version suffixes appear when the visual identity may evolve.

## Good Names

| Name | Why Valid |
|---|---|
| CLIENT_ROOM_DESKTOP_BACKGROUND_V1 | Owner, surface, variant, version |
| CLIENT_ROOM_EXIT_CUP_BUTTON | Owner and function are clear |
| CLIENT_ROOM_NAV_LEFT_BUTTON | Directional control is explicit |
| MENTAL_SMILE_PRIMARY_LOGO | Brand identity is clear |
| EMPTY_TOOL_SLOT | Purpose is clear |
| PHARAONIC_ROOM_THEME_V1 | Named concept and version |

## Forbidden Names

- final.png
- final2.png
- copy.png
- new_logo.png
- image_test.png
- temp.png
- old.png
- screenshot.png
- unnamed.png

## Registry Prefix Examples

| Registry | Example |
|---|---|
| CLIENT_ROOM | CLIENT_ROOM_DESKTOP_BACKGROUND_V1 |
| CITY_SYSTEM | CITY_LIBRARY_ARTICLES_CATEGORY_V1 |
| WEB_SYSTEM | WEB_APP_ICON_512_V1 |
| AUTH_SYSTEM | AUTH_LANGUAGE_EN_BUTTON_V1 |
| BRANDING_SYSTEM | MENTAL_SMILE_PRIMARY_LOGO |
| ICONS_SYSTEM | ICON_NAV_BACK_LEFT_GOLD_V1 |
| BACKGROUNDS_SYSTEM | MENU_DESKTOP_BACKGROUND_V1 |
| PLACEHOLDER_SYSTEM | PLACEHOLDER_EMPTY_LIBRARY_V1 |
| PROVIDER_ROOM | PROVIDER_CATEGORY_PSYCHOLOGY_V1 |
| CENTER_ROOM | CENTER_CATEGORY_REHABILITATION_V1 |
| OWNER_ROOM | OWNER_ROOM_OVERVIEW_BACKGROUND_V1 |
| MONITORING_ROOM | MONITORING_SIGNAL_HEALTH_VISUAL_V1 |
| FUTURE_CONCEPTS | PHARAONIC_ROOM_THEME_V1 |
| LEGACY_IMPORTS | LEGACY_2026_05_25_CLIENT_DASHBOARD_BG |

## File Naming Guidance

Physical files should use lowercase snake_case when migrated:

```text
client_room_desktop_background_v1.png
mental_smile_primary_logo.png
icon_nav_back_left_gold_v1.png
```

Asset card IDs may use uppercase semantic names:

```text
CLIENT_ROOM_DESKTOP_BACKGROUND_V1
MENTAL_SMILE_PRIMARY_LOGO
ICON_NAV_BACK_LEFT_GOLD_V1
```

## Versioning

Use version suffixes when:

- A visual identity may evolve.
- A theme may receive future variants.
- A brand asset may be updated.
- A room background has a designed family.

Do not version random copies.

## Forbidden Doctrine In Names

Asset names must not preserve extinct runtime concepts as active meaning:

- approval
- rejected
- booking
- session
- assignment
- admin_control
- operation_queue
- case_owner

If such words appear in legacy files, the asset remains LEGACY_IMPORTS until reviewed.
