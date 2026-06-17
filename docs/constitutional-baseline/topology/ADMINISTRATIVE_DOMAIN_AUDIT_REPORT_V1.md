# ADMINISTRATIVE_DOMAIN_AUDIT_REPORT_V1

Status: ACTIVE_TOPOLOGY_REPORT
Phase: 4
Runtime effect: none

## Purpose

The Administrative Domain controls registrations, declarations, verification flow, and role admission without reviving the old Admin Era.

## Responsibilities

- Client registration.
- Clinician registration.
- Center registration.
- Declaration review.
- Profile change review.
- Verification flow.

## Inputs

- Registration forms.
- Uploaded or declared professional data.
- Center profile data.
- Auth identity.
- Review room decisions.

## Outputs

- `clients`, `clinicians`, and `centers` records.
- Profile update requests.
- Registration success routing.
- Declaration review queues.

## Signals Produced

- Registration completion events as future candidate.
- Declaration review requests.
- Profile change requests.

## Signals Consumed

- Auth state.
- Role access state.
- Review role authorization.

## Collections

- `clients`
- `clinicians`
- `centers`
- `clinician_profile_change_requests`
- `center_profile_change_requests`

## Routes

- `Routes.clientRegister`
- `Routes.clinicianRegister`
- `Routes.centerRegister`
- `Routes.webClinicianRegister`
- `Routes.webClinicianProfile`
- `Routes.webClinicianDocuments`
- `Routes.webCenterRegister`
- `Routes.webCenterProfile`
- `Routes.webCenterMedia`
- `Routes.webCenterPricing`
- `Routes.webCenterDocuments`
- `Routes.webRegistrationSuccess`
- `Routes.sDeclarationReviewRoom`

## Dependencies

- Firebase Auth.
- Firestore profile collections.
- Web registration assets.
- Role access gateway.
- Declaration reviewer authority.

## Ownership

- Registration: user-submitted, system-validated.
- Declaration Review: declaration reviewer role, Owner-supervised.
- Verification Flow: constitutional governance, not generic admin.

## Risks

- Admin naming can leak back into review authority.
- Registration and declaration review can be mistaken for feature approval.
- Profile changes can bypass review if direct writes expand.

## Naming Drift

- `Admin` should not be used as active authority language.
- `Declaration Review` is the correct constitutional name for admission/verification review.

## Legacy Residue

- Admin Era residue remains a conceptual risk.
- Some registration flows still use direct collection writes and require governance documentation.

## Future Direction

- Create a Declaration Review Registry.
- Separate admission, verification, and profile mutation policies.
- Require Owner approval before any new authority role.

## DNA Purity Score

74/100

Reason: active routes are clear, but admin-zero doctrine needs stronger registry enforcement.
