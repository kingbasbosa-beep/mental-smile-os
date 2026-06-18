# Accessibility TV Execution Decision V1

Status: ACTIVE_DECISION
Date: 2026-06-18
Related Operation: OP-PHASE-10-ACCESSIBILITY-TV-V1
Domain: ACCESSIBILITY / CONTENT
Runtime effect: Accessibility Hub opens a YouTube gateway

## Decision

Mental Smile will introduce Accessibility TV as a YouTube Gateway only.

The runtime will not create a CMS, embedded video player, playlist engine, or video collection in this phase.

## Reason

Phase 7B established a YouTube-first Accessibility TV doctrine. Phase 10 executes that doctrine by adding a simple access point for video learning without expanding runtime complexity.

## Approved Scope

- Add an Accessibility TV card to the Accessibility Hub.
- Open Mental Smile Accessibility Channel through YouTube.
- Display fixed support topics:
  - Sign Language
  - Rights
  - Complaints
  - Platform Usage
  - Family Support
  - Autism
  - Learning Difficulties
  - Literacy Support
- Register cards, findings, and operations.

## Prohibited Scope

- No CMS.
- No video runtime.
- No embedded player.
- No content collection.
- No Firebase action.
- No route removal.

## Alternatives Considered

1. Build an in-app video player.
2. Create a Firestore-backed video catalog.
3. Add a YouTube-only gateway card.

## Why Chosen

The YouTube-only gateway follows the Owner's constraint and keeps the platform focused on access rather than content infrastructure.

## Expected Impact

- Users get a fast video-first entry point.
- Accessibility support topics become visible without a complex CMS.
- Future video expansion remains governed by a separate operation.

## Verification State

Owner manual formatting, analyze, and smoke checks remain required before commit.
