# EX-125 Mapper Creation Gate

## Scope

Docs/review only. This gate must be used before any future mapper creation or
mapper relocation.

## Mapper Baseline

EX-124 verified that audit and human-review Firestore mappers remain host-side
under:

- `clean_core/lib/core/audit/firestore/`
- `clean_core/lib/core/human_review/firestore/`

Firestore/Firebase/Timestamp/FieldValue behavior did not leak into the package
barrel.

## Required Answers

- Is it passive? Mapper output may represent passive facts only.
- Is it pure Dart? Required only for package contracts; host mappers may use
  Firebase APIs.
- Does the name imply authority? Required no package authority implication.
- Does it imply execution? Required no package execution implication.
- Does it imply routing/admission? Required no.
- Does it imply backend enforcement? Required no.
- Does it imply emergency handling? Required no.
- Does it imply provider causality? Required no.
- Does it imply retry/fallback recovery? Required no.
- Does it require mapper ownership? Required host-owned only unless a future
  wave explicitly approves otherwise.
- Is rollback local? Required yes.
- Is compatibility preserved? Required yes.
- Is public export justified? Required no by default.
- Is consumer migration explicitly approved? Required separate approval.

## Host Mapper Approval Conditions

A host mapper may be considered only when:

- the mapped package contract is already approved
- persistence semantics remain host-owned
- Firestore/Firebase details stay outside `mental_smile_clean_core`
- mapper names do not imply backend enforcement proof
- mapper output does not prove audit validity, policy compliance, emergency
  handling, provider causality, runtime execution, fallback recovery, or
  privacy/telemetry proof
- rollback can remove the mapper without changing package contracts
- consumer migration is separately approved if any consumer changes are needed

## Package Mapper Rule

Package mappers remain blocked by default. A future wave must explicitly
override mapper doctrine before any mapper can be added to
`mental_smile_clean_core`.

## Firestore/Firebase Rule

Firestore/Firebase-related code is host-side by default. The following must not
appear in package contracts or barrel exports without a future doctrine
override:

- `cloud_firestore`
- `FirebaseFirestore`
- `Timestamp`
- `FieldValue`
- `DocumentSnapshot`
- `QueryDocumentSnapshot`
- collection/document write ownership

## Mapper Gate Verdict

Pass. Mapper creation remains host-owned and fail-closed, with package mappers
blocked by default.
