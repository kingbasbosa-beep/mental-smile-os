# LOCALIZATION PURIFICATION BLOCK 1 REPORT

## Status

Implementation block stopped before generated localization and analyzer steps.
The user will run generation and analysis manually.

## Files Changed

### ARB

- `lib/l10n/app_en.arb`
- `lib/l10n/app_ar.arb`

### Active UI Copy

- `lib/features/centers/data/models/center_pricing.dart`
- `lib/features/specialists/data/clinician_specialty_catalog.dart`
- `lib/features/s_city/presentation/pages/s_city_district_page.dart`
- `lib/features/s_capital/presentation/pages/s_signal_monitoring_room_page.dart`
- `lib/features/web_portal/presentation/pages/portal_skeleton_pages.dart`
- `lib/features/chat/presentation/pages/chat_page.dart`
- `lib/features/modules/presentation/pages/support_issue_selector_page.dart`
- `lib/features/modules/presentation/pages/support_entry_page.dart`
- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/library/presentation/pages/library_policy_page.dart`
- `lib/features/library/presentation/pages/library_page.dart`
- `lib/features/centers/presentation/pages/center_room_page.dart`

## ARB Keys Changed

Key names were preserved. Displayed values were purified only.

- `centerInboxTitle`
- `statusPending`
- `webCenterRegistrationPortalSubtitle`
- `webCenterNextPricingCapabilities`
- `webCenterPricingCapabilitiesTitle`
- `webCenterPrice`
- `webCenterPricingUnit`
- `webCenterReviewNoteOptional`
- `webCenterSubmitForReview`
- `webRegistrationBrowseLibraryDuringReview`
- `webCenterMissingSession`
- `webCenterSavePricingFailed`
- `webClinicianSessionPrice`
- `webClinicianSessionDuration`
- `webClinicianAuthenticationSessionMissing`
- `clientSupportRequests`
- `clinicianOpenCases`
- `clinicianSendSupportRequest`
- `clinicianSupportRequest`
- `clinicianCurrentSupportRequests`
- `clinicianReferredChatCases`
- `clinicianReferredChatCasesCount`
- `clinicianNewRequests`
- `clinicianActiveRequests` Arabic value only
- `clinicianClosed` Arabic value only
- `clinicianAcceptRequest`
- `clinicianRejectRequest`
- `clinicianProfileChangeTitle`
- `clinicianSendingRequest`
- `clinicianSendChangeRequest`
- `clinicianInboxTitle`
- `clinicianReject`
- `clinicianAccept`
- `clinicianRejectRequestTitle`
- `clinicianRejectReason`
- `clinicianRejectReasonHint`
- `clinicianConfirmReject`
- `clinicianRejectFailed`
- `clinicianAcceptFailed`
- `statusCenterFollowUp`
- `statusClientUpdateRequired`
- `statusCenterIntakePending`
- `statusCenterRecommendationPending`
- `statusResidencySetupPending`
- `statusResidencyScheduled`
- `statusResidencyInProgress`
- `statusPendingDischargeReviews`
- `statusRequestCompleted`
- `statusReschedulePending`
- `statusRejected`
- `statusClinicianRejected`
- `statusRequestCoordination`
- `statusRequestUpdateInProgress`
- `statusNewRequest`

## Missing Parity Fixed

- `statusCenterFollowUp`

English value added:

`Center availability signal incomplete`

Arabic value:

`إشارة توفر المركز غير مكتملة`

Both ARB files now contain 205 normal localization keys.

## Code Copy Changes

High-risk visible copy was replaced according to Block 1 doctrine:

- `session` language in service categories became support/service information language.
- `booking` doctrine in City footer became extinct transaction doctrine language.
- `Reports Inbox` became `Report Stream`.
- `Listening Session Notes` became `Listening Notes`.
- package/payment/manual review portal copy became external service cost information without financial decision language.
- chat structured request copy became structured support signal copy.
- chat `Ownership:` display became `Guidance:`.
- support selector request language became support signal language.
- support entry request language became support signal language.
- client dashboard support CTA became contact/share support language.
- library policy approval language became safety observation / confirmation language.
- center document/admin review copy became declaration signal copy.
- center image replacement request became image update declaration.

## Generated Localization Changes

Not completed in this block.

`flutter gen-l10n` was attempted but interrupted. The user will run localization generation manually.

Expected generated files after manual generation:

- `lib/l10n/app_localizations.dart`
- `lib/l10n/app_localizations_en.dart`
- `lib/l10n/app_localizations_ar.dart`

## Analyzer Result

Not run.

The user explicitly requested not to run the remaining analysis step.

## Remaining Active Blockers

Generated localization files may still contain old values until `flutter gen-l10n`
is run manually.

Known remaining hits requiring classification after generation:

- key names containing `Reject`, `Session`, or similar legacy terms remain as
  technical API names because this block did not rename keys.
- technical variables such as `assignedTools` remain because they are not
  user-facing copy.
- route/service/domain names containing `request` remain where they are runtime
  identifiers, not visible copy.
- any remaining Arabic safety/report words containing `حالة` in safety report
  contexts require human classification as `SAFETY_ONLY` or future Wave 2 work.

## Remaining Safe Technical Hits

- `webCenterMissingSession`
- `webClinicianSessionPrice`
- `webClinicianSessionDuration`
- `webClinicianAuthenticationSessionMissing`
- `clinicianReject*`
- `statusRejected`
- `statusClinicianRejected`

These remain as localization key/API names only. Their displayed values were
neutralized.

## Intentionally Not Changed

- No routes renamed.
- No runtime logic changed.
- No Firebase rules changed.
- No active screens deleted.
- No cosmetic Wave 2 or Wave 3 cleanup performed.
- Generated files were not manually edited after the interrupted generation step.

## Final Verdict

**BLOCK 1 PARTIAL**

Justification:

High-risk ARB values and several active UI copy surfaces were purified, and the
missing English parity for `statusCenterFollowUp` was fixed. The block is not
complete until generated localization files are regenerated and post-generation
search/analyzer verification is performed manually.

