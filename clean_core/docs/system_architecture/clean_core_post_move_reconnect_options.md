# Post-Move Reconnect Options

Phase: EX-40B - Post-Move Broken Consumer Strategy

## Option A - Roll Back Wave 2 A1/A2 Movement

Rollback would move the 15 safe-batch files back to their original `clean_core` locations and remove their package exports.

Pros:

- immediately restores sibling import graph
- returns analyzer stability for affected excluded files
- preserves reconnect-free posture
- avoids nested analyzer package import problems

Cons:

- reverses Wave 2 extraction progress
- shrinks current package surface
- requires updating milestone/freeze docs later

Risk level: low operational risk, moderate milestone rollback impact.

## Option B - Make clean_core a Package-Aware Consumer

This would make remaining `clean_core` source files consume moved contracts through a stable package import.

Pros:

- preserves Wave 2 extraction
- models the future extracted package relationship

Cons:

- package import is currently unsafe in this nested analyzer context
- cross-package relative import was also not reliable as a long-term architecture pattern
- may require package/workspace restructuring
- may force dependency/reconnect work before governance is ready

Risk level: high until package resolution architecture is fixed.

## Option C - Move Dependent Excluded Files Later After Split/Review

This would move dependent excluded files into the package after semantic review, especially the audit event/trace/snapshot and escalation assignment/request/resolution/review surfaces.

Pros:

- preserves package-local sibling graph after movement
- continues extraction direction
- avoids package-aware consumer problem

Cons:

- some dependent files are Firestore-coupled or runtime/queue/observability-sensitive
- movement requires additional semantic, Firebase, runtime, and authority reviews
- not appropriate for queue/observability/boundary files without stronger governance

Risk level: medium to high depending on file.

## Option D - Create Temporary Compatibility Barrels Inside clean_core

This would create local compatibility files under `clean_core` that re-export moved contracts.

Pros:

- preserves original sibling imports
- avoids touching affected consumers
- keeps Wave 2 movement mostly intact

Cons:

- creates duplicate compatibility surface
- can hide extraction boundary problems
- risks long-lived shim debt
- may imply public/local dual ownership
- still requires import/export design governance

Risk level: medium; acceptable only as explicitly temporary with removal plan.

## Option E - Defer Reconnect and Accept Known Analyzer Breakage Temporarily

This keeps the current extraction state and documents known analyzer errors until a later resolution phase.

Pros:

- preserves strict no-reconnect posture
- avoids unsafe import workaround
- keeps architectural truth visible

Cons:

- known analyzer breakage remains
- blocks clean validation
- increases coordination risk if left too long

Risk level: medium short-term, high if prolonged.

