# clean_core Wave 2 Manual Review Queue

This queue lists areas requiring manual semantic and import review before any extraction.

## Highest Priority Review

1. `core/audit/`
2. `core/human_review/`
3. `core/legal/`
4. `core/conversation_session/`
5. `core/response_composition/`
6. `core/safety_registry/`

## Cautious Review

1. `core/ai_safety/`
2. `core/safety_memory/`
3. `core/architecture_manifest/`
4. `core/system_topology/`
5. `core/provider_governance/`
6. `core/provider_onboarding/`

## Deferred Review

1. `core/runtime_*`
2. `core/secure_runtime_envelope/`
3. `core/ai_runtime/`

## Manual Review Checklist

- Verify no Flutter import.
- Verify no Firebase import.
- Verify no generated import.
- Verify no app package import.
- Verify no provider SDK import.
- Verify no networking import.
- Verify no active runtime semantics.
- Verify no client-side authority expansion.
- Verify fail-closed defaults.
- Verify hidden guard/policy/export status.

## Queue Verdict

Manual review must precede all Wave 2 movement.
