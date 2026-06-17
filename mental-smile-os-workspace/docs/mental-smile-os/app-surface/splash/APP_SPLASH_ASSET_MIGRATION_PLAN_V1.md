# App Splash Asset Migration Plan V1

Status: PLANNING_ONLY
Prompt Asset: PROMPT_ASSET_016
Pubspec Status: NOT_MODIFIED
Runtime Status: NOT_MODIFIED

## 1. Purpose

Plan future migration of approved Splash source assets from Mental Smile Core into Mental Smile OS without editing `pubspec.yaml`, copying files, or changing runtime in this step.

## 2. Current Source Asset Paths

| Asset ID | Current Source Path | Classification |
| --- | --- | --- |
| SPLASH_BACKGROUND_MOBILE | `C:/mental_smile_workspace/app/mental-smile-app-clean2/assets/branding/splash/splash_mobile_v1.jpg` | USE_AFTER_PURIFICATION |
| SPLASH_BACKGROUND_TABLET | `C:/mental_smile_workspace/app/mental-smile-app-clean2/assets/branding/splash/splash_tablet_v1.jpg` | USE_AFTER_PURIFICATION |
| SPLASH_BACKGROUND_DESKTOP | `C:/mental_smile_workspace/app/mental-smile-app-clean2/assets/branding/splash/splash_web_v1.jpg` | USE_AFTER_PURIFICATION |
| SPLASH_LANGUAGE_BUTTON | `C:/mental_smile_workspace/app/mental-smile-app-clean2/assets/branding/language/en_gold.png` | USE_AFTER_PURIFICATION |

## 3. Future OS Asset Paths

| Asset ID | Future OS Path |
| --- | --- |
| SPLASH_BACKGROUND_MOBILE | `mental-smile-os-workspace/app/assets/app-surface/splash/ms_os_splash_bg_mobile_v1.jpg` |
| SPLASH_BACKGROUND_TABLET | `mental-smile-os-workspace/app/assets/app-surface/splash/ms_os_splash_bg_tablet_v1.jpg` |
| SPLASH_BACKGROUND_DESKTOP | `mental-smile-os-workspace/app/assets/app-surface/splash/ms_os_splash_bg_desktop_v1.jpg` |
| SPLASH_LANGUAGE_BUTTON | `mental-smile-os-workspace/app/assets/app-surface/splash/ms_os_lang_toggle_gold_v1.png` |

## 4. Asset Renaming Rule

Old source filenames are source evidence only. They must not become OS asset filenames.

| Asset ID | Old Source Name | New OS Asset Name | Rule |
| --- | --- | --- | --- |
| SPLASH_BACKGROUND_MOBILE | `splash_mobile_v1` | `ms_os_splash_bg_mobile_v1` | Rename before OS placement. |
| SPLASH_BACKGROUND_TABLET | `splash_tablet_v1` | `ms_os_splash_bg_tablet_v1` | Rename before OS placement. |
| SPLASH_BACKGROUND_DESKTOP | `splash_web_v1` | `ms_os_splash_bg_desktop_v1` | Rename before OS placement. |
| SPLASH_LANGUAGE_BUTTON | `en_gold` | `ms_os_lang_toggle_gold_v1` | Rename before OS placement. |

## 5. Future YAML References

Future `pubspec.yaml` references, when a Flutter OS runtime exists, should point to OS-owned asset paths only:

- `app/assets/app-surface/splash/ms_os_splash_bg_mobile_v1.jpg`
- `app/assets/app-surface/splash/ms_os_splash_bg_tablet_v1.jpg`
- `app/assets/app-surface/splash/ms_os_splash_bg_desktop_v1.jpg`
- `app/assets/app-surface/splash/ms_os_lang_toggle_gold_v1.png`

Future YAML must not reference:

- `splash_mobile_v1`
- `splash_tablet_v1`
- `splash_web_v1`
- `en_gold`

No YAML edit is authorized in this step.

## 6. Deprecated Paths

Future deprecated source paths after migration:

- `assets/branding/splash/splash_mobile_v1.jpg`
- `assets/branding/splash/splash_tablet_v1.jpg`
- `assets/branding/splash/splash_web_v1.jpg`
- `assets/branding/language/en_gold.png`

Deprecated means not active OS paths. It does not delete or modify Mental Smile Core.

## 7. Migration Rule

Future migration must follow:

Extract
Purify
Reclassify
Rebuild
Register

## 8. Boundary

This plan does not copy files, modify runtime, edit `pubspec.yaml`, or create Flutter code.
