# Partnership Foundation Decision V1

Status: ACTIVE_DECISION
Date: 2026-06-18
Related Operation: OP-PHASE-11-PARTNERSHIP-FOUNDATION-V1
Domain: ACCESSIBILITY / PARTNERSHIPS
Runtime effect: Organizations Directory and Partnership Request Flow added

## Decision

Mental Smile will create an accessibility organizations directory foundation and a partnership request preparation flow.

The directory starts empty until organizations are reviewed and approved.

## Reason

Accessibility work needs trusted organizations, but public directory entries must not imply endorsement before review. A governed empty registry and request flow preserves structure without false claims.

## Approved Scope

- Create organization model fields:
  - Name
  - Country
  - Category
  - Website
  - Email
  - WhatsApp
- Create governed categories:
  - Deaf
  - Blind
  - Autism
  - Learning Difficulties
  - Literacy
  - Family Support
  - Recovery
  - Mental Health
- Create Organizations Directory runtime surface.
- Create Partnership Request preparation flow.
- Create Partnership Registry document.

## Prohibited Scope

- No Firebase action.
- No public verification claim.
- No endorsement claim.
- No submitted partnership approval.
- No persisted user request data.

## Why Chosen

The foundation gives Mental Smile a concrete partnership intake surface while keeping approval and publication under governance.

## Verification State

Owner manual formatting, analyze, and smoke checks remain required before commit.
