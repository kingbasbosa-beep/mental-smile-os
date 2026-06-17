# Card Package Transfer Model V1

Status: ACTIVE_CONNECTION_MODEL
Connection Type: CARD_PACKAGE

## 1. Purpose

Card Package Transfer moves approved constitutional card packages between surfaces without copying raw legacy structures.

It supports clean build packages, UI packages, localization packages, tool packages, and future domain packages.

## 2. Required Fields

- Card Package ID.
- Package Name.
- Source Surface.
- Consumer Surface.
- Package Purpose.
- Included Cards.
- Birth Prompt.
- Birth Authority.
- Related Signals.
- Purification Status.
- Reclassification Status.
- Validation Status.

## 3. Transfer Rule

Every transferred package must follow:

Extract
Purify
Reclassify
Rebuild
Register

## 4. Forbidden Transfers

Forbidden:

- Raw copy from Mental Smile Core.
- Unregistered UI packages.
- Cards without parent guide.
- Cards without lineage.
- Packages with unclear ownership.
- Legacy menu package reuse.
