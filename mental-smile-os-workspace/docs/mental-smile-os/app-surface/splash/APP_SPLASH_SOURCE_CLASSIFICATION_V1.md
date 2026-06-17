# App Splash Source Classification V1

Status: SOURCE_CLASSIFICATION_COMPLETE
Prompt Asset: PROMPT_ASSET_015
Source Repository: Mental Smile Core / mental-smile-app-clean2

## 1. Source Candidates

| Source Candidate ID | Source Item | Evidence | Classification | Justification |
| --- | --- | --- | --- | --- |
| SPLASH_SOURCE_001 | Legacy Flutter SplashPage | lib/features/splash/presentation/pages/splash_page.dart | REBUILD_FROM_SCRATCH | Contains old routing to login and web portal, old layout behavior, hardcoded strings, and source repository coupling. |
| SPLASH_SOURCE_002 | Splash background images | assets/branding/splash/splash_mobile_v1.jpg, splash_tablet_v1.jpg, splash_web_v1.jpg | REBUILD_FROM_SCRATCH | Visual source can inform mood, but old images must not enter OS by direct copy. |
| SPLASH_SOURCE_003 | Existing logo assets | assets/branding/logo_*.png and shared logo paths | USE_AFTER_PURIFICATION | Brand memory may be reused only after ownership and visual purification; runtime preview uses placeholder instead. |
| SPLASH_SOURCE_004 | Old Start Journey label | lib/features/splash/presentation/pages/splash_page.dart | REMOVE | Replaced by Arabic-first neutral "متابعة / Continue". |
| SPLASH_SOURCE_005 | Old Back to Web Portal link | lib/features/splash/presentation/pages/splash_page.dart | REMOVE | Not allowed in clean App Surface Splash. |
| SPLASH_SOURCE_006 | Existing splash localization key | lib/l10n app localization splashTitle | NOT_RELEVANT | Describes old screen title only and does not provide approved App Surface copy. |

## 2. Extraction Rule

No source asset was copied.

All future Splash work must follow:

Extract
Purify
Reclassify
Rebuild
Register
