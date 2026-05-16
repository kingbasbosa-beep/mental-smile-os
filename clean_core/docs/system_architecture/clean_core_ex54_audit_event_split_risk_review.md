# EX-54 Audit Event Split Risk Review

Phase: EX-54 - audit_event Split Design

## Complexity Compared With audit_snapshot

`audit_event` is higher risk than `audit_snapshot`.

Reasons:

- more fields
- multiple local value object dependencies
- runtime marker dependency
- nested list serialization
- authority-sensitive actor fields
- privacy-sensitive preview/reference fields
- broader event semantics

## Primary Risks

Risks:

- Firestore import entering the package
- runtime marker semantics entering the package without review
- event labels being mistaken for runtime execution
- actor fields being treated as authority proof
- visibility fields being treated as access-control enforcement
- references being treated as verified integrity links
- broad audit export growth

## Stop Conditions

Stop if:

- audit event contains runtime execution
- observability coupling becomes inseparable
- queue or boundary semantics appear
- split requires reconnect
- package would gain Firebase/runtime ownership
- runtime marker approval is missing
- mapper cannot remain host/backend-owned

## Risk Finding

`audit_event` should not be the next execution target until runtime marker strategy is resolved.

