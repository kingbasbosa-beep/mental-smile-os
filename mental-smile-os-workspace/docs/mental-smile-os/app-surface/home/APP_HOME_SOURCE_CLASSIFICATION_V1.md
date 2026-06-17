# App Home Source Classification V1

Status: SOURCE_CLASSIFICATION_COMPLETE
Prompt Asset: PROMPT_ASSET_018
Source Repository: Mental Smile Core / mental-smile-app-clean2

## Source Candidates

| Candidate ID | Asset ID | Source Evidence | Classification | Reason |
| --- | --- | --- | --- | --- |
| HOME_SRC_001 | HOME_BACKGROUND | `assets/c7_branding/home/home_bg.png`, `assets/branding/menu/*/menu_*_bg.png` | USE_AFTER_PURIFICATION | Useful mood/background source, but must be renamed and purified before OS use. |
| HOME_SRC_002 | HOME_PROFILE_BUTTON | Floating profile/dashboard shortcut in `MenuPage` | REBUILD_FROM_SCRATCH | Old behavior depends on Firebase role resolution and legacy routes. |
| HOME_SRC_003 | HOME_AVATAR_FRAME | Circle avatar/chat entry concept in `MenuPage` | REBUILD_FROM_SCRATCH | Useful visual concept; old chat behavior and placement are not migrated. |
| HOME_SRC_004 | HOME_LIBRARY_BUTTON | Library card in `MenuPage` | REBUILD_FROM_SCRATCH | Keep visible concept, rebuild for Library Web Surface link. |
| HOME_SRC_005 | HOME_PROVIDER_BUTTON | Specialists/providers card in `MenuPage` | REBUILD_FROM_SCRATCH | Keep visible concept, remove provider route coupling. |
| HOME_SRC_006 | HOME_CENTER_BUTTON | Centers card in `MenuPage` | REBUILD_FROM_SCRATCH | Keep visible concept, remove legacy route coupling. |
| HOME_SRC_007 | HOME_FAMILY_SUPPORT_BUTTON | Special needs/family card in `MenuPage` | REBUILD_FROM_SCRATCH | Keep supportive intent, remove diagnostic/special-needs framing if needed. |
| HOME_SRC_008 | HOME_RECOVERY_SUPPORT_BUTTON | Addiction/recovery card in `MenuPage` | REBUILD_FROM_SCRATCH | Keep recovery support concept with non-clinical wording. |
| HOME_SRC_009 | HOME_FOOTER_FEATURE_BAR | Old menu/home support framing | REBUILD_FROM_SCRATCH | New OS needs cleaner footer bar, not old layout layers. |
| HOME_SRC_010 | HOME_CORE_BRANDMARK | `assets/branding/logo_*`, `assets/c7_branding/logo/*` | USE_AFTER_PURIFICATION | Brandmark may be reused only after OS renaming and ownership review. |
| HOME_SRC_011 | Owner/monitoring/registry shortcuts | Role shortcuts in `MenuPage` | REMOVE | Not part of App Surface Home and belongs to Admin Owner Web Surface. |
| HOME_SRC_012 | Login/back/start journey controls | `HomePage` login/back/start controls | REMOVE | Not approved visible Home hub assets for this OS-native package. |
| HOME_SRC_013 | Old Flutter route logic | `Routes.*`, `Navigator`, Firebase role checks | REMOVE | Routing and runtime logic are forbidden in this step. |

## Rule

Old names and old code are source evidence only.

Future OS assets must use `ms_os_home_*` names.
