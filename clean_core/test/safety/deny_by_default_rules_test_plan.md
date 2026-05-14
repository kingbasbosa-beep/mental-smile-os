# Deny-by-Default Rules Test Plan

## Purpose

Define future emulator checks for protected Firestore boundaries. This plan is deterministic and runtime-AI-free.

## Validate Later

- Clients cannot write server-owned governance fields.
- Clients cannot write payment, escalation, AI moderation, admin decision, or lifecycle orchestration fields.
- Chat thread/message creation remains denied to clients until moved behind trusted backend operations.
- Legal consent writes use immutable-oriented payloads and do not include diagnosis, raw crisis content, or AI conversation data.
- AI safety collections deny direct unsafe client writes by default.

## Must Never Be Client-Controlled

- `adminDecision`
- `workflowStage`
- `paymentStatus`
- `reviewStatus`
- `escalationStatus`
- `crisisSeverity`
- `runtimeMode`
- `moderationOutcome`
- `policyPublished`
- `safetyLocked`

## Deferred

- Full Firebase emulator test execution.
- Cloud Function authenticated context.
- Backend enforcement tests.
- CI/CD integration.
