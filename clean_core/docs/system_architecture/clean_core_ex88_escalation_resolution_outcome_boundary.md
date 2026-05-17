# EX-88 EscalationResolution Outcome Boundary

## Outcome Field

The frozen package-safe field is:

- `outcomeKey`

## Allowed Semantics

`outcomeKey` may identify a passive outcome label chosen by host/backend systems. It may be used for display, audit context, or declarative review metadata.

## Prohibited Semantics

`outcomeKey` must not:

- enforce policy
- apply moderation
- apply punishment
- grant approval
- prove closure
- trigger backend action
- trigger provider behavior
- guarantee escalation outcome
- imply workflow ownership

## Mapper Ownership

Any persisted field name, canonical outcome registry, backend action mapping, or moderation effect must remain outside `mental_smile_clean_core`.

## Outcome Verdict

`outcomeKey` is package-safe only as passive metadata with explicit caveats.
