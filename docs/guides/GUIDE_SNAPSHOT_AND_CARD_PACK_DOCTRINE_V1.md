# Guide Snapshot And Card Pack Doctrine V1

Status: GUIDE_DRAFT  
Runtime effect: none

## 1. Doctrine

A Guide Snapshot freezes the guide interpretation at a point in time. A Card Pack derives governance cards from that snapshot. Neither artifact modifies runtime code.

## 2. Snapshot Rules

| Rule ID | Rule |
| --- | --- |
| SNAP-R01 | Every guide update creates a new snapshot. |
| SNAP-R02 | Snapshot ID must be unique and versioned. |
| SNAP-R03 | Snapshot records source docs, runtime reality, known gaps, and card pack link. |
| SNAP-R04 | Snapshot cannot silently mutate previous card versions. |
| SNAP-R05 | Previous snapshots are archived, not overwritten. |

## 3. Card Pack Rules

| Rule ID | Rule |
| --- | --- |
| PACK-R01 | Card pack is generated from snapshot, not hand-approved independently. |
| PACK-R02 | Old cards are suspended when mismatched. |
| PACK-R03 | New cards are cloned from current snapshot. |
| PACK-R04 | Card operation remains open until old card removal, new card install, and validation pass. |
| PACK-R05 | Card pack must mark runtime gaps and FUTURE systems honestly. |

## 4. Required Snapshot Fields

| Field | Required |
| --- | --- |
| snapshotId | YES |
| guideSystemVersion | YES |
| sourceRealitySnapshot | YES |
| sourcePolicies | YES |
| sourceRegistries | YES |
| domainCoverage | YES |
| missingRuntimeRegistries | YES |
| cardPackId | YES |
| validationStatus | YES |

## 5. Required Card Pack Fields

| Field | Required |
| --- | --- |
| cardPackId | YES |
| snapshotId | YES |
| generatedFrom | YES |
| cardCountByDomain | YES |
| suspendedCards | YES |
| deployedCards | YES |
| blockedCards | YES |
| missingOwners | YES |
| missingRegistries | YES |
| validationStatus | YES |

## 6. Version Preservation

| Artifact | Preservation rule |
| --- | --- |
| Guide | New version file or explicit version section. |
| Snapshot | New file under `docs/guides/snapshots`. |
| Card pack | New file under `docs/guides/card_packs`. |
| Old card | Suspended then archived, never silently patched. |
| Report | Block report preserved with created files and readiness. |

