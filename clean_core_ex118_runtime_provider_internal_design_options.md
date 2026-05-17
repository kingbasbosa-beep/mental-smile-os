# EX-118 Runtime/Provider Internal Design Options

## Scope

Docs/design only. This document explores internal-only design options for
runtime/provider diagnostics. It does not modify runtime/source files, create
package contracts, create mappers, export files, reconnect consumers, migrate
imports, run pub get/analyze, or activate providers, adapters, Firebase, or
runtime execution.

## Design Options

### Option 1: Keep all runtime/provider diagnostics host-only

Semantic safety: highest.

Consumer misuse risk: lowest.

Rollback locality: strongest because no package files are introduced.

Package introduction justified: no.

Finding: recommended default.

### Option 2: Create internal package-only unexported diagnostics later

Semantic safety: moderate if caveated and unexported.

Consumer misuse risk: moderate because internal files can still be mistaken for
future public contracts.

Rollback locality: good if isolated.

Package introduction justified: not yet.

Finding: possible only after another readiness review.

### Option 3: Create backend-only diagnostic records

Semantic safety: high if records are backend-owned.

Consumer misuse risk: low if not exposed to package consumers.

Rollback locality: backend-dependent.

Package introduction justified: no package surface needed.

Finding: strong future direction, but not part of package work.

### Option 4: Use audit/human-review existing metadata only

Semantic safety: high.

Consumer misuse risk: low because public reference labels already exist.

Rollback locality: strong.

Package introduction justified: no new package file.

Finding: recommended near-term approach.

### Option 5: Defer until runtime/provider orchestration isolation wave

Semantic safety: highest for runtime/provider execution semantics.

Consumer misuse risk: lowest.

Rollback locality: strongest.

Package introduction justified: no.

Finding: recommended for provider/fallback/runtime-state holdbacks.

## Design Recommendation

Use Option 1 plus Option 4 now: keep diagnostics host-only and rely on existing
metadata/reference labels. Defer unexported package diagnostics until after a
runtime/provider orchestration isolation wave.
