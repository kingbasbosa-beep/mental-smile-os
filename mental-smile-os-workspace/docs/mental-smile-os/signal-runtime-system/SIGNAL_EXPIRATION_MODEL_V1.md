# SIGNAL_EXPIRATION_MODEL_V1

Status: REGISTERED

## Expiration Purpose

Signal expiration prevents temporary operational packages from becoming hidden archives or unauthorized databases.

## Expiration Rules

- Temporary buffers expire.
- Continuity capsule packages expire after 24 hours maximum.
- Emergency exchange packages expire after 24 hours maximum.
- Expired packages may not be replayed as active signals.
- Expiration must preserve any required archive snapshot if archive policy requires it.

## Expiration States

- ACTIVE
- BUFFERED
- REPLAYED
- VERIFIED
- PURGED
- EXPIRED
- SNAPSHOTTED

## Forbidden Expiration Behavior

- Keeping temporary buffer indefinitely.
- Converting capsule into archive.
- Replaying expired packages without owner review.
- Deleting required lineage evidence.
