# EX-125 Consumer Migration Gate

## Scope

Docs/review only. This gate must be used before any future consumer migration,
reconnect, import migration, or host/app adoption of package surface.

## Consumer Baseline

EX-124 found no current consumer reconnect under the inspected host consumer
paths. EX-125 does not reconnect consumers or migrate imports.

## Required Answers

- Is it passive? The target package surface must be passive.
- Is it pure Dart? The target package surface must be pure Dart.
- Does the name imply authority? Required no.
- Does it imply execution? Required no new execution activation.
- Does it imply routing/admission? Required no.
- Does it imply backend enforcement? Required no.
- Does it imply emergency handling? Required no.
- Does it imply provider causality? Required no.
- Does it imply retry/fallback recovery? Required no.
- Does it require mapper ownership? Required no ownership move by default.
- Is rollback local? Required yes with a rollback plan.
- Is compatibility preserved? Required yes.
- Is public export justified? Required already approved.
- Is consumer migration explicitly approved? Required yes.

## Migration Approval Conditions

A migration or reconnect may be considered only when:

- the target package contract has passed the package addition matrix
- the target export has passed the export approval gate
- host mapper ownership remains unchanged unless separately approved
- no runtime/provider/Firebase/adapters are activated by the migration
- no held-back queue/boundary or runtime/provider concept is adopted
- behavior remains compatible with the current host implementation
- rollback is local and documented
- the approving wave names the exact consumers and imports to change

## Blocked Migration Patterns

- reconnecting consumers to unexported package internals
- migrating imports before export approval
- migrating imports to make an experimental contract real
- reconnecting runtime/provider diagnostics
- reconnecting queue admission, routing, or boundary enforcement concepts
- moving Firestore mapping ownership into the package by consumer usage
- treating passive labels as commands or workflow states
- relying on consumer adoption as proof that a package surface is safe

## Consumer Gate Verdict

Pass. Consumer migration remains separately gated and explicitly approved only;
no migration is authorized by EX-125.
