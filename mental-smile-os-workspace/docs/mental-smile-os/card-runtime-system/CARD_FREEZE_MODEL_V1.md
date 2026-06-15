# CARD_FREEZE_MODEL_V1

Status: REGISTERED

## Freeze Purpose

Card freeze prevents unstable or disputed cards from being modified or consumed as active authority.

## Freeze States

- ACTIVE
- FROZEN_FOR_REVIEW
- FROZEN_FOR_COMPLIANCE
- FROZEN_FOR_REPLACEMENT
- FROZEN_FOR_ARCHIVE

## Freeze Rules

- Frozen cards may be read for evidence.
- Frozen cards may not be newly distributed.
- Runtime may continue consuming a frozen card only if continuity requires it and owner approves.
- Freeze must preserve reason, owner, and date.

## Forbidden Freeze Behavior

- Freezing to hide lineage.
- Freezing without owner.
- Runtime ignoring freeze status.
- Archive mutating frozen card.
