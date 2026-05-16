# clean_core Wave 2 Candidate Classification

This document classifies Wave 2 candidates by extraction posture.

## Safe Declarative Candidates

Potential candidates after file-by-file review:

- `core/audit/`
- `core/human_review/`
- `core/legal/`
- `core/conversation_session/`
- `core/response_composition/`
- `core/safety_registry/`

Expected safe file types:

- states
- markers
- scopes
- references
- requirements
- fallbacks
- redaction/visibility contracts

## Adapter-Boundary Candidates

Require adapter architecture review before extraction:

- `core/provider_governance/`
- `core/provider_onboarding/`
- future Firebase bridge contracts
- future auth/session contracts
- future print/export bridge contracts
- future routing/text bridge contracts

## Runtime-Owned Candidates

Defer until runtime phase:

- `core/runtime_activation/`
- `core/runtime_enablement/`
- `core/runtime_execution/`
- `core/runtime_wiring/`
- `core/runtime_environment/`
- `core/runtime_readiness/`
- `core/runtime_bootstrap/`
- `core/runtime_release/`
- `core/runtime_observability/`
- `core/runtime_isolation/`
- `core/runtime_rollback/`
- `core/secure_runtime_envelope/`

## Host-Owned Candidates

Do not extract into clean_core package:

- `features/**`
- `shared/ui_kit/**`
- `shared/analytics/**`
- `app/**`
- `l10n/**`
- `firebase_options.dart`
- `core/auth/**`
- `core/storage/**`

## Backend-Owned Candidates

Do not implement in clean_core:

- trusted execution
- signed authority
- privileged writes
- moderation execution
- AI execution
- escalation execution
- provider execution

## Blocked/High-Risk Candidates

- `core/ai_runtime/`
- Firestore-coupled files under `core/ai_safety/`
- orchestration/runtime files
- provider activation semantics
- Firebase execution leakage
- analytics/telemetry runtime leakage

## Classification Verdict

Wave 2 must begin with review, not movement. Safe declarative candidates are possible, but runtime/adapter/backend/host boundaries remain firm.
