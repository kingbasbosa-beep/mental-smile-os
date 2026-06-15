# CARD_ARCHIVE_MODEL_V1

Status: REGISTERED

## Archive Purpose

Card archive preserves card history, lineage, evidence, and retired definitions.

## Archive Rules

- Archive stores snapshots.
- Archive does not own active card authority.
- Archive does not mutate source card history.
- Archived cards are not active unless restored through approved lifecycle.

## Archive Status

- NOT_ARCHIVED
- SNAPSHOTTED
- ARCHIVE_CANDIDATE
- ARCHIVED
- RESTORATION_CANDIDATE

## Required Archive Fields

- Card ID.
- Card version.
- Archive reason.
- Archive custodian.
- Snapshot ID.
- Replacement link if superseded.
- Retention status.
