# CARD_REPLACEMENT_MODEL_V1

Status: REGISTERED

## Replacement Purpose

Card replacement preserves continuity when a card must be superseded.

## Replacement Flow

```text
Existing Card
-> Replacement Candidate
-> Validation
-> Registry Supersession
-> Runtime Migration Notice
-> Old Card Retired or Archived
```

## Required Replacement Fields

- Replaced Card ID.
- Replacement Card ID.
- Replacement reason.
- Owner approval.
- Registry update.
- Consumer migration status.
- Archive status.

## Replacement Rules

- Replacement must not delete lineage.
- Old card remains historical evidence.
- Runtime must not consume both cards as active unless explicitly allowed.
- Replacement must emit supersession record.
