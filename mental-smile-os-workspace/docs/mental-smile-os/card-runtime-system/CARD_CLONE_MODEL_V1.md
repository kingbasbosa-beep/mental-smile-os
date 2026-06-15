# CARD_CLONE_MODEL_V1

Status: REGISTERED

## Clone Purpose

Card cloning creates a new governed card from a validated pattern without copying authority blindly.

## Clone Rules

- Clone receives a new Card ID.
- Clone must declare parent card.
- Clone must assign owner.
- Clone must be validated independently.
- Clone must bind to registry independently.

## Required Clone Fields

- Parent Card ID.
- Clone Card ID.
- Clone purpose.
- Differences from parent.
- Owner.
- Registry.
- Validation status.

## Forbidden Clone Behavior

- Clone without new ID.
- Clone without owner.
- Clone without validation.
- Clone used to bypass replacement lifecycle.
