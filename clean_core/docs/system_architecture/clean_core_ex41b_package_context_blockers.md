# EX-41B Package Context Blockers

Phase: EX-41B - Consumer Dependency Topology Audit

## Package Context Problem

After movement, remaining `clean_core` consumers could not safely resolve moved contracts through:

- original sibling imports, because files had moved
- package imports, because nested analyzer context did not safely resolve the package
- cross-package relative imports, because that is not a stable or approved architecture pattern

## Blocker 1 - Nested Analyzer Context

`clean_core` is not currently operating as a clean package-aware consumer of `mental_smile_clean_core` for these nested source files.

This blocks movement-first extraction if remaining source files need to import extracted contracts.

## Blocker 2 - Sibling Import Dependency

Both audit and human review directories use sibling imports as their internal contract graph.

Moving foundational files before their consumers breaks that graph.

## Blocker 3 - Mixed Pure and Runtime-Coupled Files

Pure contracts sit next to Firestore-coupled consumers. This makes simple folder slicing unsafe without mapper separation.

## Blocker 4 - Reconnect Governance

Package-aware reconnect requires an authorized import strategy and should not be improvised during extraction movement.

## Package Context Finding

Future extraction must first solve package-consumer context or move complete reviewed clusters. Movement-first extraction will continue to create analyzer breakage when moved files are still sibling dependencies of excluded consumers.

