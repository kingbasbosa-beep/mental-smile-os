# Accessible Communication Execution Decision V1

Status: ACTIVE_DECISION
Date: 2026-06-18
Related Operation: OP-PHASE-9-ACCESSIBLE-COMMUNICATION-V1
Domain: ACCESSIBILITY / COMMERCIAL / SIGNALS
Runtime effect: provider and center contact surfaces extended

## Decision

Mental Smile will expose accessible contact as a parallel contact path on provider and center detail pages.

This does not classify users. It gives users a lower-barrier way to request communication that can fit their needs.

## Reason

Phase 7B established that accessibility is access, not segregation. Phase 9 applies that doctrine to commercial discovery surfaces where a user may need contact without having to explain identity labels first.

## Scope Approved By Prompt

- Add `accessible_communication_ready` support.
- Add accessible communication capability labels.
- Show normal contact and accessible contact actions on provider pages.
- Show normal contact and accessible contact actions on center pages.
- Emit accessible contact signals.
- Register cards, findings, and operations.

## Prohibited Scope

- No Firebase rule changes.
- No collection deletion.
- No provider or center route removal.
- No user classification.
- No diagnosis, disability, or label collection.

## Alternatives Considered

1. Replace the normal contact button.
2. Add an accessibility-only directory before provider and center pages.
3. Add a parallel accessible contact button beside the normal contact button.

## Why Chosen

The parallel button preserves the existing contact workflow and adds an access path without segregating users or removing legacy behavior.

## Expected Impact

- Users can request accessible communication from provider and center pages.
- Commercial monitoring can observe accessible contact demand.
- Future accessibility directory and partnership work can rely on fresh repeated intent signals.

## Evidence

- Provider detail page accessible contact button.
- Center detail page accessible contact button.
- Signal registry entries for accessible contact.
- Operation card and registries updated.

## Owner Review

Owner manual formatting, analyze, and runtime checks remain required before commit.
