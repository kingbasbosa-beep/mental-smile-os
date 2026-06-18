# OP Phase 8 Client Access Execution Card V1

Operation ID: OP-PHASE-8-CLIENT-ACCESS-EXECUTION-V1

Operation Title: Phase 8 Client Access Execution

Phase: 8

Date: 2026-06-18

Triggered By: Owner prompt

Prompt / Block Name: PHASE 8 CLIENT ACCESS EXECUTION

Purpose: Implement account-free client access from splash, introduce Client Session Room, and mark client login/registration/profile as LEGACY_CANDIDATE.

Scope: Runtime UI/route addition and governance documentation only. No Firebase change, no route deletion, no collection change, no legacy auth removal.

Execution Type:

- RUNTIME_CHANGE
- DOC_CREATION

## Files Created

- `lib/features/client/presentation/pages/client_session_room_page.dart`
- `docs/constitutional-baseline/cards/decision/CLIENT_ACCESS_EXECUTION_DECISION_V1.md`
- `docs/constitutional-baseline/findings/FINDING_CLIENT_ACCESS_ACCOUNT_FIRST_BARRIER_V1.md`
- `docs/constitutional-baseline/cards/archive/ARCHIVE_CARD_CLIENT_LOGIN_REGISTRATION_PROFILE_LEGACY_V1.md`
- `docs/constitutional-baseline/operations/OP_PHASE_8_CLIENT_ACCESS_EXECUTION_CARD_V1.md`

## Files Modified

- `lib/features/splash/presentation/pages/splash_page.dart`
- `lib/app/router/routes.dart`
- `lib/app/router/app_router.dart`
- `docs/constitutional-baseline/registries/FINDING_REGISTRY_V1.md`
- `docs/constitutional-baseline/registries/ARCHIVE_REGISTRY_V1.md`
- `docs/constitutional-baseline/registries/MEMORY_REGISTRY_V1.md`
- `docs/constitutional-baseline/registries/GOVERNANCE_DECISION_REGISTRY_V1.md`
- `docs/constitutional-baseline/registries/ROUTE_REGISTRY_V1.md`
- `docs/constitutional-baseline/registries/ADMINISTRATIVE_ROUTE_OWNERSHIP_REGISTRY_V1.md`
- `docs/constitutional-baseline/registries/RESIDENTIAL_ROUTE_OWNERSHIP_REGISTRY_V1.md`
- `docs/constitutional-baseline/operations/EXECUTED_OPERATIONS_REGISTRY_V1.md`
- `docs/constitutional-baseline/operations/EXECUTED_OPERATIONS_INDEX_V1.md`

## Cards Created

- `CLIENT_ACCESS_EXECUTION_DECISION_V1`
- `FINDING_CLIENT_ACCESS_ACCOUNT_FIRST_BARRIER_V1`
- `ARCHIVE_CARD_CLIENT_LOGIN_REGISTRATION_PROFILE_LEGACY_V1`

## Guides Created

None.

## Registries Updated

- Finding Registry
- Archive Registry
- Memory Registry
- Governance Decision Registry
- Route Registry
- Administrative Route Ownership Registry
- Residential Route Ownership Registry
- Executed Operations Registry
- Executed Operations Index

## Reports Created

- `PHASE_8_CLIENT_ACCESS_EXECUTION_INTEGRITY_VERIFICATION_V1.md`

## Runtime Effect

- Splash now shows Quick Access, Accessibility Access, Provider / Center Access, Legacy Login, and Web Portal.
- Quick Access opens `/client/session-room`.
- `/client/session-room` opens without account requirement.
- Provider / Center Access opens a provider/center choice sheet linking to public city provider and center surfaces.
- Legacy `/login`, `/register/client`, and `/client/dashboard` routes remain available temporarily.

## Git Effect

None.

## Firebase Effect

None.

## Result

COMPLETED

## Validation Status

Owner instructed Codex not to run commands.

Manual validation is required for:

- `dart format`
- `flutter analyze`
- any runtime smoke check the Owner chooses to run

## Summary

Phase 8 introduced account-free client session access while preserving legacy account routes as `LEGACY_CANDIDATE`.

## Reason

The prior splash flow was login-first. This made account identity the first gate before support, accessibility, learning, or discovery access.

## Alternatives Considered

- Remove legacy login/registration now: rejected as too risky without migration.
- Keep login-first splash: rejected because it preserves the access barrier.
- Build full accessibility room now: rejected as too broad for this phase.
- Send everyone to menu: rejected because it does not establish stateless client session doctrine.

## Why Chosen

This approach adds low-risk access routes while preserving continuity for existing account workflows.

## Expected Impact

- Lower friction for first-time users.
- More visible accessibility access.
- Clearer provider/center public discovery path.
- Legacy account routes stay available pending future extraction.

## Evidence

- `/client/session-room` route added.
- Splash action list updated.
- Governance decision, finding, archive, memory, and route registries updated.

## Related Findings

- `FINDING_CLIENT_ACCESS_ACCOUNT_FIRST_BARRIER_V1.md`
- `FINDING_FRESH_SIGNALS_OVER_STORED_PREFERENCES_V1.md`

## Related Cards

- `CLIENT_ACCESS_EXECUTION_DECISION_V1.md`
- `ARCHIVE_CARD_CLIENT_LOGIN_REGISTRATION_PROFILE_LEGACY_V1.md`
- `CLIENT_IDENTITY_EXTRACTION_DECISION_V1.md`

## Owner Approval Required

Future login, registration, profile, dashboard, or data removal requires separate Owner approval.

## Owner Approval Status

APPROVED_BY_PROMPT

## Next Action

Owner runs manual formatting/analyze/runtime checks and reports any blockers in a follow-up operation if needed.

## Archive Needed

Archive card created.

## Memory Impact

Creates Phase 8 Client Access Execution memory.
