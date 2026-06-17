# Private Archive Transfer Plan V1

Status: OWNER_CONFIRMATION_REQUIRED

## Archive Destination

Recommended private archive root:

`C:\mental_smile_workspace\archive\mental-smile-private-history`

Do not create or move files until Owner confirms.

## Archive Value Filter

Archive only if useful for:

- rollback
- legal or compliance evidence
- engineering lessons
- governance cards
- release history
- Firebase migration proof
- technical problem / solution guide

Do not archive noise.

## Candidate Classification

| Item | Classification | Reason |
| --- | --- | --- |
| `mental_smile_clean_core/` | PRIVATE_ARCHIVE_USEFUL | Source extraction evidence and historical clean core era proof. |
| `android/app/google-services.json.backup-before-mental-smile-platform-cutover` | PRIVATE_ARCHIVE_USEFUL | Rollback evidence. |
| Infrastructure cutover docs | KEEP_ACTIVE and PRIVATE_ARCHIVE_USEFUL | Active release evidence and future rollback guidance. |
| Engineering knowledge docs | KEEP_ACTIVE | Project-specific lessons and prevention signals. |
| Archive cards | KEEP_ACTIVE | Historical identity and governance memory. |
| `.firebase/` | IGNORE_CACHE | Local Firebase hosting cache, not archive value. |
| `build/` | IGNORE_CACHE | Generated build output. |
| `.dart_tool/` | IGNORE_CACHE | Generated Flutter tooling cache. |
| `node_modules/` | IGNORE_CACHE | Reinstallable dependency output. |
| Temporary screenshots | OWNER_CONFIRM_DELETE | Delete only after Owner confirms no public/design value. |
| Obsolete duplicate reports | OWNER_CONFIRM_DELETE | Review before deletion; do not archive by default. |

## Transfer Sequence

1. Create clean active workspace at `C:\mental_smile_workspace\app\mental-smile-platform`.
2. Copy active source and useful docs only.
3. Copy rollback evidence to private archive.
4. Copy `mental_smile_clean_core/` to private archive as source evidence.
5. Validate clean workspace.
6. Only after validation, classify old `mental-smile-app-clean2` as private archive host.

Result: PRIVATE_ARCHIVE_TRANSFER_READY_FOR_OWNER_DECISION
