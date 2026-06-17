# FIRST_CONSTITUTIONAL_COMMIT_SCOPE_V1

Status: READY_FOR_OWNER_STAGING_APPROVAL
Operation: OP-WAVE-1-5-FIRST-CONSTITUTIONAL-COMMIT-SCOPE-V1
Date: 2026-06-17
Branch: `post-separation-pure-dna-v1`
Remote: `origin`
Runtime effect: none
Firebase effect: none
Git effect: status and dry-run only; no real staging

## Purpose

Define the exact first constitutional commit scope before any real `git add`, commit, tag, push, Firebase action, cleanup, refactor, or runtime change.

## Included Categories

| Category | Classification | Reason |
| --- | --- | --- |
| Active Flutter runtime source | INCLUDE | Required active runtime baseline |
| Firebase config/rules source files | INCLUDE | Required platform baseline, excluding secrets |
| `docs/` | INCLUDE | Constitutional and project memory |
| `docs/constitutional-baseline/` | INCLUDE | Pure DNA baseline governance layer |
| `mental-smile-os-workspace/` | INCLUDE | Strategic Memory / Constitutional Memory; not runtime |
| Archive evidence governed by archive cards | INCLUDE | Evidence is not junk |
| Governance guides | INCLUDE | Source of truth |
| Archive cards | INCLUDE | Governance units |
| Registries | INCLUDE | Governance indexes |
| Operations registry | INCLUDE | Execution memory |
| Snapshots | INCLUDE | Baseline memory |
| Topology | INCLUDE | Constitutional topology |
| Inventory | INCLUDE | Constitutional inventory |
| Domain audits | INCLUDE | Domain baseline evidence |
| Seal package | INCLUDE | Pure DNA V2 seal evidence |
| Memory and strategic evidence | INCLUDE | Required to explain lineage and baseline |

## Held Categories

| Category | Classification | Reason |
| --- | --- | --- |
| `.github/workflows/` | HOLD | Avoid accidental GitHub Actions / Firebase deployment behavior before branch policy is finalized |

## Excluded Categories

| Category | Classification | Reason |
| --- | --- | --- |
| `build/` | EXCLUDE | Generated build artifact |
| `node_modules/` | EXCLUDE | Dependency artifact |
| `test/node_modules/` | EXCLUDE | Dependency artifact |
| `.dart_tool/` | EXCLUDE | Generated Flutter/Dart tool state |
| `.idea/` | EXCLUDE | Local IDE state |
| `android/.gradle/` | EXCLUDE | Generated Gradle state |
| `.flutter-plugins-dependencies` | EXCLUDE | Generated Flutter state |
| logs and `firebase-debug.log` | EXCLUDE | Local/debug artifact |
| secrets | EXCLUDE | Sensitive material |
| keystores | EXCLUDE | Sensitive signing material |
| service account files | EXCLUDE | Sensitive Firebase/Admin material |
| local env files | EXCLUDE | Sensitive/local material |
| `google-services.json` and backup | EXCLUDE | Firebase app secret/config material excluded by policy |

## Unknown Categories

No top-level category remains `UNKNOWN_OWNER_DECISION` after applying Owner default decisions.

## Top-Level Staging Map

| Top-Level Item | Classification | Notes |
| --- | --- | --- |
| `.cursorignore` | INCLUDE | workspace configuration |
| `.firebaserc` | INCLUDE | points to `mental-smile-platform`; not a secret |
| `.gitattributes` | INCLUDE | repository behavior |
| `.github/` | HOLD | specifically hold `.github/workflows/` |
| `.gitignore` | INCLUDE | secret/build exclusion policy |
| `.metadata` | INCLUDE | Flutter project metadata |
| `README.md` | INCLUDE | project entry documentation |
| `analysis_options.yaml` | INCLUDE | analyzer policy |
| `android/` | INCLUDE_WITH_EXCLUSIONS | include source/config; exclude `.gradle`, local properties, google services, generated artifacts |
| `assets/` | INCLUDE | active runtime assets plus governed archive evidence |
| `docs/` | INCLUDE | governance, memory, reports, seal package |
| `firebase.json` | INCLUDE | Firebase project configuration, not deploy action |
| `firestore.indexes.json` | INCLUDE | Firebase indexes source |
| `firestore.rules` | INCLUDE | Firebase rules source |
| `functions/` | INCLUDE_WITH_EXCLUSIONS | include source/package files; exclude `functions/node_modules/` |
| `l10n.yaml` | INCLUDE | localization configuration |
| `lib/` | INCLUDE | active Flutter runtime source |
| `mental-smile-os-workspace/` | INCLUDE | Strategic Memory / Constitutional Memory |
| `package-lock.json` | INCLUDE | Node dependency lock source |
| `package.json` | INCLUDE | Node package source |
| `public-landing/` | INCLUDE | public/presentation surface source |
| `pubspec.lock` | INCLUDE | Flutter dependency lock source |
| `pubspec.yaml` | INCLUDE | Flutter package/asset source |
| `storage.rules` | INCLUDE | Firebase storage rules source |
| `test/` | INCLUDE_WITH_EXCLUSIONS | include tests; exclude `test/node_modules/` |
| `web/` | INCLUDE | Flutter web source |
| `.dart_tool/` | EXCLUDE | ignored generated state |
| `.idea/` | EXCLUDE | ignored local IDE state |
| `build/` | EXCLUDE | ignored generated build output |
| `firebase-debug.log` | EXCLUDE | ignored local debug log |

## Special Decisions

### mental-smile-os-workspace/

Classification: INCLUDE

Reason: Strategic Memory / Constitutional Memory. It is not runtime and is required to explain the baseline lineage.

### .github/workflows/

Classification: HOLD

Reason: Avoid accidental Actions/deployments before branch policy is finalized.

### C5/C6/archive evidence

Classification: INCLUDE IF GOVERNED BY ARCHIVE CARD

Reason: Evidence is not junk. C5 Booking Era and C6 Library Era are already governed by archive cards.

### Secrets/build artifacts

Classification: EXCLUDE

Reason: Secrets, keystores, service accounts, local env files, generated build outputs, dependency folders, and logs must not enter the first constitutional commit.

## Dry-Run Staging Result

Command executed: `git add --dry-run .`

Result: PASS_DRY_RUN

No real staging was performed.

Dry-run confirms a naive `git add .` would include nearly the full project, including `.github/workflows/`. Therefore the real first staging must either:

- use explicit pathspec excludes for `.github/workflows/`, or
- stage approved top-level paths individually.

## Suspicious Files

| Item | Reason | Required Handling |
| --- | --- | --- |
| `.github/workflows/firebase-hosting-merge.yml` | could create GitHub Actions/deployment behavior later | HOLD |
| `.github/workflows/firebase-hosting-pull-request.yml` | could create GitHub Actions/Firebase preview behavior on PR | HOLD |
| `assets/branding/web_registration/**` | duplicate asset evidence exists beyond active pubspec exception | INCLUDE as evidence, not active runtime |
| `assets/c5/**` | archive evidence, not active bundled runtime | INCLUDE if governed by archive card |
| `assets/c6_library/**` | archive evidence, not active bundled runtime | INCLUDE if governed by archive card |
| `mental-smile-os-workspace/` | large strategic memory body | INCLUDE by Owner default decision |

## First Commit Readiness

Scope readiness: READY_FOR_OWNER_STAGING_APPROVAL

The scope is now decided:

- Include active runtime, docs, constitutional baseline, strategic memory, governed archive evidence, Firebase/rules source, tests, web/public source.
- Hold `.github/workflows/`.
- Exclude generated files, dependency folders, logs, secrets, keystores, service accounts, local env files, and Firebase app secret files.

## Exact Owner Approvals Still Required

Before real `git add`, Owner must approve this exact sentence:

OWNER APPROVES FIRST CONSTITUTIONAL STAGING: include active runtime, docs, constitutional-baseline, mental-smile-os-workspace, governed archive evidence, Firebase/rules source, tests, web/public source; hold `.github/workflows/`; exclude secrets, build artifacts, dependency folders, logs, keystores, service account files, env files, and google-services files.

## Final Verdict

READY_FOR_OWNER_STAGING_APPROVAL

