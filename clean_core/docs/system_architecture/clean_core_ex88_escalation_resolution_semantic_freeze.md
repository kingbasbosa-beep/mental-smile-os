# EX-88 EscalationResolution Semantic Freeze

## Scope

This freeze covers a future package-safe `EscalationResolution` model only. It does not approve movement of the existing host file and does not approve reconnect or consumer migration.

## Current Shape

Current host file:

- `clean_core/lib/core/human_review/escalation_resolution.dart`

Current dependencies:

- `package:cloud_firestore/cloud_firestore.dart`
- `escalation_audit_link.dart`
- `escalation_state.dart`

Current host-owned behavior:

- Firestore map serialization through `toMap`
- `FieldValue.serverTimestamp()`
- `Timestamp.fromDate`
- nested `EscalationAuditLink.toMap`
- `EscalationState.key` serialization

## Frozen Package-Safe Fields

A future package-safe `EscalationResolution` may contain only:

- `escalationId`
- `resolvedBy`
- `state`
- `outcomeKey`
- `sanitizedResolutionNote`
- `auditLink`
- `resolvedAt`

## Required Meaning Boundaries

- `resolvedBy` is metadata only and does not prove resolver authorization or approval authority.
- `state` is passive and does not complete workflow.
- `outcomeKey` is metadata only and does not enforce policy, moderation, punishment, escalation outcome, or backend action.
- `sanitizedResolutionNote` is not a privacy or security boundary.
- `auditLink` remains metadata only and does not prove audit persistence, integrity, or policy approval.
- `resolvedAt` is timestamp metadata only and does not prove backend execution, completion, closure, or finality.
- A resolution record does not approve, close, enforce, execute, resolve workflow ownership, or guarantee escalation outcome.

## Freeze Result

`EscalationResolution` is not safe for direct movement because the current host file is Firestore-coupled. It is suitable for a future additive split only if the package model is pure Dart and host mapping remains outside `mental_smile_clean_core`.
