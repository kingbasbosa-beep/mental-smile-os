# EX-125 Package Addition Decision Matrix

## Scope

Docs/review only. This matrix must be used before any future package addition,
barrel export, mapper, consumer reconnect, passive vocabulary exposure,
Firestore/Firebase code, AI/safety label, or operational/admin surface change.

EX-125 does not approve implementation. It does not create package contracts,
mappers, exports, imports, consumer migrations, providers, Firebase behavior,
or runtime activation.

## Default Rule

Every future package-surface proposal fails closed unless each required answer
is documented and the approving wave explicitly authorizes the change.

Pure Dart is necessary but not sufficient. Passive shape is necessary but not
sufficient. A safe proposal must also avoid fake authority, fake execution,
fake enforcement, fake emergency handling, fake provider causality, and fake
fallback recovery.

## Universal Review Questions

Every gate must answer:

- Is it passive?
- Is it pure Dart?
- Does the name imply authority?
- Does it imply execution?
- Does it imply routing/admission?
- Does it imply backend enforcement?
- Does it imply emergency handling?
- Does it imply provider causality?
- Does it imply retry/fallback recovery?
- Does it require mapper ownership?
- Is rollback local?
- Is compatibility preserved?
- Is public export justified?
- Is consumer migration explicitly approved?

## Decision Matrix

| Gate | Passive Required | Pure Dart Required | Name Authority Risk | Execution/Routing Risk | Mapper Risk | Rollback Requirement | Public Export Rule | Approval Result |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| New package contract | Yes | Yes | Must be no | Must be no | Must be no package-owned mapper dependency | Must be rollback-local before export | Export separately reviewed | Block unless all answers pass |
| New barrel export | Yes | Yes | Must be no | Must be no | Must not expose mapper/Firebase behavior | Must not break removal plan | Must be explicit file export only | Block unless export need is proven |
| New host mapper | Not sufficient by itself | Host may depend on Firebase | Name must not imply package authority | Must not imply package execution | Host-owned only | Must not force package rollback | No package export by default | Block unless host ownership is explicit |
| Consumer migration/reconnect | Existing behavior only | Not the main criterion | Must not imply new authority | Must not activate held-back flow | Must not move mapper ownership | Must be reversible | Requires explicit approval | Block unless migration is separately approved |
| Queue/boundary exposure | Must be passive only | Yes | High risk | High risk | Must not require mapper ownership | Must be isolated first | Not exportable by default | Block unless doctrine reopens it |
| Runtime/provider diagnostic exposure | Must be passive only | Yes | High risk | High risk | No public mapper | Must be isolated first | Not exportable by default | Block unless doctrine reopens it |
| Passive vocabulary exposure | Yes | Yes | Must be no | Must be no | Must not require mapper ownership | Must be rollback-local | Narrow explicit export only | Block unless caveats travel with it |
| Firestore/Firebase-related code | N/A | No for Firebase APIs | Must not imply package authority | Must stay host-side | Host mapper only | Must not couple package rollback | No package export | Block from package by default |
| AI/safety-related label | Yes | Yes | Very high risk | Must be no | Must not require mapper ownership | Must be isolated first | Export only after special review | Block unless fake guarantee risk is disproved |
| Operational/admin surface change | Usually no | Depends | High risk | High risk | Often host-owned | Must be reversible | No package export by default | Block unless host-owned and explicitly approved |

## Gate Answers Required

### New Package Contract

- Is it passive? Required yes.
- Is it pure Dart? Required yes.
- Does the name imply authority? Required no.
- Does it imply execution? Required no.
- Does it imply routing/admission? Required no.
- Does it imply backend enforcement? Required no.
- Does it imply emergency handling? Required no.
- Does it imply provider causality? Required no.
- Does it imply retry/fallback recovery? Required no.
- Does it require mapper ownership? Required no.
- Is rollback local? Required yes.
- Is compatibility preserved? Required yes.
- Is public export justified? Required separate export gate.
- Is consumer migration explicitly approved? Required no by default.

### New Barrel Export

- Is it passive? Required yes for any exported package concept.
- Is it pure Dart? Required yes.
- Does the name imply authority? Required no.
- Does it imply execution? Required no.
- Does it imply routing/admission? Required no.
- Does it imply backend enforcement? Required no.
- Does it imply emergency handling? Required no.
- Does it imply provider causality? Required no.
- Does it imply retry/fallback recovery? Required no.
- Does it require mapper ownership? Required no.
- Is rollback local? Required yes before exposure.
- Is compatibility preserved? Required yes.
- Is public export justified? Required yes, with explicit file export only.
- Is consumer migration explicitly approved? Required separate approval.

### New Host Mapper

- Is it passive? Mapper code may transform passive facts but is not a package
  contract.
- Is it pure Dart? Not required for host mapper code.
- Does the name imply authority? Required no package authority implication.
- Does it imply execution? Required no package execution implication.
- Does it imply routing/admission? Required no.
- Does it imply backend enforcement? Required no.
- Does it imply emergency handling? Required no.
- Does it imply provider causality? Required no.
- Does it imply retry/fallback recovery? Required no.
- Does it require mapper ownership? Required host-owned only.
- Is rollback local? Required yes relative to host mapper scope.
- Is compatibility preserved? Required yes.
- Is public export justified? Required no by default.
- Is consumer migration explicitly approved? Required separate approval.

### Consumer Migration/Reconnect

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
- Is rollback local? Required yes with a migration rollback plan.
- Is compatibility preserved? Required yes.
- Is public export justified? Required already approved.
- Is consumer migration explicitly approved? Required yes.

### Queue/Boundary Exposure

Default result: blocked. A future wave must first reopen doctrine and prove the
concept cannot be mistaken for queue admission, routing, ownership, emergency
handling, backend enforcement, or write authority.

### Runtime/Provider Diagnostic Exposure

Default result: blocked. A future wave must first reopen doctrine and prove the
concept cannot be mistaken for provider causality, provider trust, adapter
execution, runtime execution, fallback recovery, backend availability, privacy
proof, or enforcement proof.

### Passive Vocabulary Exposure

Default result: blocked until the vocabulary passes naming, caveat, rollback,
compatibility, export, and consumer-migration gates. Public labels must remain
narrow and must carry explicit caveats.

### Firestore/Firebase-Related Code

Default result: host-side only. Firestore, Firebase, Timestamp, FieldValue,
DocumentSnapshot, and collection/document ownership must not leak into
`mental_smile_clean_core` contracts or exports.

### AI/Safety-Related Label

Default result: blocked unless a special review proves that the label is
passive, non-operational, non-authoritative, and incapable of implying safety
ownership, moderation ownership, emergency response, enforcement, provider
causality, or guaranteed outcome.

### Operational/Admin Surface Change

Default result: host-owned and blocked from package exposure unless a future
wave proves it is passive metadata, compatible, rollback-local, and not an
execution, permission, enforcement, admin authority, or operational control
surface.

## Matrix Verdict

Pass. EX-125 defines a fail-closed decision matrix. It authorizes review
structure only, not implementation.
