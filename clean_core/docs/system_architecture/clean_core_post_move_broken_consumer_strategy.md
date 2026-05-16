# Post-Move Broken Consumer Strategy

Phase: EX-40B - Post-Move Broken Consumer Strategy

## Problem Statement

Wave 2 moved safe audit and human review contracts into `mental_smile_clean_core`, while excluded files under `clean_core/lib/core/audit` and `clean_core/lib/core/human_review` still reference those contracts through original sibling imports.

The remaining excluded files are now broken consumers because their sibling import targets no longer exist in the original folders.

Package imports and cross-package relative imports are not currently safe in this nested analyzer context.

## Affected Audit Consumers

Affected audit files:

- `audit_event.dart`
- `audit_snapshot.dart`
- `audit_trace.dart`
- `safety_observability_contract.dart`

Moved audit contracts they depend on:

- `audit_actor_type.dart`
- `audit_event_type.dart`
- `audit_reference.dart`
- `audit_severity.dart`
- `audit_visibility_scope.dart`

## Affected Human Review Consumers

Affected human review files:

- `escalation_assignment.dart`
- `escalation_queue.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`

Moved human review contracts they depend on:

- `escalation_audit_link.dart`
- `escalation_level.dart`
- `escalation_policy_reference.dart`
- `escalation_reason.dart`
- `escalation_state.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`

## Root Cause

Wave 2 extracted foundational declarative contracts before extracting or reconnecting their dependent excluded consumers.

This produced a split graph:

- extracted contracts live in `mental_smile_clean_core`
- excluded consumers remain in `clean_core`
- excluded consumers still import moved contracts as local siblings

## Strategy Need

The resolution must preserve:

- no runtime activation
- no provider execution
- no Firebase reconnect
- no unsafe package import workaround
- no broad migration
- rollback clarity
- extraction governance

