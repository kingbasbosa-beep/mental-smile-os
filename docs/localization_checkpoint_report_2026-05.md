# Mental Smile Localization Checkpoint Report

Date: May 2026  
Project: Mental Smile  
Stack: Flutter / Dart with Firebase Auth and Firestore  
Localization strategy: Arabic-first, English secondary

## Executive Summary

Mental Smile has moved from a mostly hardcoded bilingual/Arabic UI toward a structured Arabic-first localization foundation. The project now has a growing ARB-based localization surface, uses `AppLocalizations` in several high-value user-facing flows, and has completed multiple controlled RTL/LTR hardening batches.

Arabic is treated as the native/source product language, not as a secondary translation layer. English is being introduced as a production-safe secondary locale through small, controlled extraction phases.

The current state is promising but not production-complete. The largest remaining risks are generated localization file synchronization, untranslated deep forms, admin surfaces, web registration flows, AI/legal/crisis copy, and full bilingual visual QA.

## 1. Foundation

The localization foundation is based on Flutter `gen_l10n` with ARB files under `lib/l10n/`.

Current foundation characteristics:

- Arabic is the intended source/template language.
- `app_ar.arb` and `app_en.arb` are the primary translation files.
- `AppLocalizations.of(context)!` has been introduced across multiple feature areas.
- The generated files are expected under:
  - `lib/l10n/app_localizations.dart`
  - `lib/l10n/app_localizations_ar.dart`
  - `lib/l10n/app_localizations_en.dart`
- Locale behavior is intended to default to Arabic when no explicit user preference exists.
- Locale persistence exists through the app locale provider/storage layer.
- The project is ready for larger extraction phases once generation stability is handled outside the Codex runtime.

Important foundation observation:

`flutter gen-l10n` repeatedly timed out or hung inside the Codex execution environment. ARB files were validated during the extraction phases, but generated localization files may be out-of-sync until generation is run manually from PowerShell.

Recommended manual generation command:

```powershell
flutter gen-l10n
```

## 2. RTL/LTR Hardening

Several controlled RTL/LTR hardening phases have been completed. The objective was to make English mode direction-safe while preserving the Arabic visual identity.

Completed hardening areas:

- Auth pages:
  - Login
  - Client registration
  - Clinician registration
- Client dashboard
- Booking user-facing pages:
  - Booking request
  - Center booking request
  - My bookings
- Center public pages:
  - Centers list
  - Center details
  - Center registration page

Patterns improved:

- Replaced hardcoded RTL roots with locale-aware `TextDirection`.
- Migrated semantic `TextAlign.right/left` toward `TextAlign.start/end`.
- Migrated semantic `Alignment.centerRight/centerLeft` toward `AlignmentDirectional`.
- Improved back button behavior using directional icon handling where appropriate.
- Preserved decorative/background positioning where directionality changes could cause unintended visual shifts.

Intentionally preserved constraints:

- Some gallery chevrons and decorative placements remain visually directional and should be verified by screenshot QA.
- Some technical/numeric LTR patterns were intentionally preserved where they represent codes, IDs, dates, or external values.

Remaining RTL/LTR QA recommendations:

- Run side-by-side Arabic and English screenshots for mobile, tablet, and desktop.
- Verify buttons with long English labels.
- Verify chips, badges, and status labels in constrained card layouts.
- Verify back/next navigation icons in all onboarding and form steps.

## 3. Localization Phases Completed

The project has completed several small-batch localization extraction phases.

Completed extraction areas:

- Common and menu labels
- Auth and login labels
- Auth validation and simple error messages
- Center public labels
- Booking labels
- Client dashboard labels
- Clinician operations labels
- Shared/user-facing status labels and status mappers

Approximate key growth:

- The ARB files have grown from a small baseline to roughly 190+ non-metadata keys.
- Key namespaces now cover common, auth, menu, home, centers, booking, client dashboard, clinician operations, and status labels.

Status mapping improvements:

- A shared status key family was added using `status*` keys.
- User-facing status labels were localized in high-value areas such as:
  - Client sessions
  - My bookings
  - Clinician operations
  - Central value label mapping

Examples of localized status concepts:

- Pending review
- Approved
- Rejected
- Awaiting payment
- Payment proof under review
- Session setup pending
- Residency setup pending
- Session scheduled
- In progress
- Pending reviews
- Completed
- Cancelled
- Center available/unavailable/no response

## 4. Current Coverage

Localized or substantially localized:

- Home/menu basics
- Login and simple auth labels
- Simple auth validation messages
- Client dashboard action labels and metrics
- Center public labels
- Booking request labels
- My bookings primary tabs/buttons/empty states
- Clinician operations primary labels/buttons/tabs
- Many user-facing status badges and chips

Partially localized:

- Booking status details
- Client sessions
- Center booking request form
- Clinician operational cards
- Profile change request labels
- Payment proof and payment-related flows
- Status display helpers

Not yet fully localized:

- Web registration mega flows
- Admin surface and control room pages
- Full payment proof workflow
- Deep intake/assessment dialogs
- Clinician review/session review flows
- AI safety, crisis, and legal copy
- Long support/onboarding paragraphs
- Store-facing copy and screenshots

## 5. Remaining Work

High-priority remaining localization areas:

1. Web registration localization
   - Clinician web registration
   - Center web registration
   - Document/media/pricing/profile steps

2. Admin surface localization
   - Admin hub
   - Approvals
   - Payment review
   - Session operations
   - Maintenance/audit pages

3. Payment proof localization
   - Upload proof flow
   - Payment instructions
   - Payment review states
   - Receipt and transfer labels

4. Deep forms and clinical-adjacent text
   - Intake dialogs
   - Session review forms
   - Rating forms
   - Assessment-oriented labels

5. AI/legal/crisis localization
   - Must not be translated mechanically.
   - Requires tone-safe bilingual review.
   - Should be handled after stable app localization foundation and human review.

6. Pluralization and interpolation
   - Count strings currently use simple interpolation in some areas.
   - Future improvement should add proper plural-aware ARB messages.

## 6. Risks & Technical Observations

Generation pipeline risk:

- `flutter gen-l10n` repeatedly hung or timed out inside the Codex runtime.
- Manual PowerShell generation is currently the safest path.
- Until manual generation succeeds, Dart files that reference newly added localization getters may be ahead of generated files.

Line ending observations:

- Several operations reported CRLF/LF warnings.
- These warnings do not necessarily indicate functional issues, but they should be normalized intentionally later to reduce noisy diffs.

Generated-file synchronization:

- ARB files were updated in multiple phases.
- Generated localization files may lag behind ARB changes.
- Manual generation should be performed before compile/analyze/testing.

Recommended future checks:

- Add CI validation for:
  - ARB JSON validity
  - Matching ARB key sets
  - Successful `flutter gen-l10n`
  - No missing generated getters
  - No obvious mojibake sequences in user-facing ARB values

## 7. Production Readiness

Current multilingual readiness:

- Foundation: partially ready
- Arabic-first product direction: strong
- English support: emerging and structured
- Generated file sync: needs immediate manual stabilization
- Full production localization: not complete yet

Arabic readiness:

- Arabic is now the intended product-native language.
- Important user-facing flows have started moving toward natural Arabic labels.
- Some older text still requires mojibake review and extraction.

English readiness:

- English is present in selected user-facing flows.
- English visual QA remains necessary, especially for long labels and LTR layout behavior.

International expansion readiness:

- The architecture is becoming suitable for additional locales after Arabic/English stabilization.
- African and international expansion is realistic if future phases add:
  - Locale-aware formatting
  - Currency/date formatting
  - Country-aware registration/legal flows
  - Culturally reviewed clinical/support language

Tourism/medical expansion considerations:

- Center and accommodation-related flows need careful bilingual terminology.
- Legal, medical, and crisis text should receive human review before release.
- Payment, pricing, and service descriptions should be validated for both local and international users.

## 8. Recommended Next Steps

Recommended order:

1. Run manual localization generation from PowerShell.
2. Confirm generated localization files compile with the newly added keys.
3. Run a targeted build/analyze check only after generation succeeds.
4. Localize web registration flows.
5. Localize payment proof and payment status flows.
6. Localize admin surfaces in controlled batches.
7. Localize clinician/session review forms after clinical wording review.
8. Localize AI safety, crisis, and legal copy with human review.
9. Run full Arabic/English visual QA across mobile, tablet, and desktop.
10. Prepare store screenshots and release copy in both languages.
11. Add CI checks for ARB validity, key parity, and generation.

## Checkpoint Verdict

Mental Smile has reached a meaningful localization checkpoint. The project now has an Arabic-first localization direction, visible RTL/LTR improvements, and localized labels in several high-value user-facing flows.

It is not yet production-localized. The next critical step is stabilizing localization generation outside Codex, then continuing extraction in larger but still controlled feature batches.

This checkpoint is suitable as a handoff reference before the next localization, QA, or production-clean-core migration phase.
