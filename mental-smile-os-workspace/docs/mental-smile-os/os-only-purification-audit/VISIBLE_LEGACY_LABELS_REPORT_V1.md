# VISIBLE_LEGACY_LABELS_REPORT_V1

## Public README

`README.md` is aligned with Mental Smile OS and does not expose the Flutter template identity.

## Web/Public Surfaces

No active `Mental Key`, `flutterprojects`, or `A new Flutter project` labels were found in `web/` or `public-landing/`.

## Active App Runtime

| File | Label | Visibility | Classification | Recommendation |
| --- | --- | --- | --- | --- |
| `lib/app/app.dart` | `MentalKeyApp` | Internal Dart symbol; not app title | ACTIVE_BLOCKER | Rename in Wave 1. |
| `lib/shared/ui_kit/app_theme.dart` | `buildMentalKeyTheme` | Internal Dart symbol; not visible label | ACTIVE_BLOCKER | Rename in Wave 1. |
| `lib/features/app_exit/presentation/pages/app_exit_social_links_page.dart` | `https://mental-smile-app-clean.web.app` | Visible official Website button destination | VISIBLE_RESIDUE | Replace only after Owner confirms final public URL. |
| `android/app/build.gradle.kts` | `com.mentalkey.app.flutterprojects` | Android package identity | VISIBLE_RESIDUE | Defer. Owner decision required. |

## Firebase/Public Config

| File | Label | Classification | Recommendation |
| --- | --- | --- | --- |
| `firebase.json` | `mental-smile-app-clean` | VISIBLE_RESIDUE | Defer until Firebase project identity decision. |
| `.github/workflows/firebase-hosting-merge.yml` | `mental-smile-app-clean` | VISIBLE_RESIDUE | Defer with Firebase identity. |
| `.github/workflows/firebase-hosting-pull-request.yml` | `mental-smile-app-clean` | VISIBLE_RESIDUE | Defer with Firebase identity. |
| `lib/firebase_options.dart` | `mental-smile-app-clean` | ACTIVE_BLOCKER | Defer. Runtime Firebase config cannot be changed casually. |

## Localization

No active generated localization key currently exposes `Mental Key` as app title in the direct runtime search.

## Verdict

Visible residue remains, but the most dangerous items are infrastructure identity, not simple labels.

