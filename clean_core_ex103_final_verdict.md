# EX-103 Final Verdict

## Final Verdict

Passive vocabulary candidates exist, but only after strict renaming and detox.
The current queue and boundary contracts remain blocked from package exposure.

## Candidate List

Candidate families reviewed:

- queue intent labels
- queue visibility labels
- queue lifecycle labels
- governance assertion labels
- emergency posture labels
- provider issue report labels
- fallback observation labels

## Package-Safe Findings

Potentially package-safe candidates include:

- passive review priority labels
- pending review state labels
- policy reference presence labels
- audit reference presence labels
- review boundary observation labels
- negative emergency capability labels
- human support encouragement labels

These must remain non-authoritative and must not imply routing, enforcement,
ownership, availability, or writes.

## Rename/Detox Findings

The following concepts need renaming or detox:

- `policyViolation` should become a policy issue observation.
- `providerFailure` should become a provider issue report.
- `fallbackLoop` should become a fallback loop observation.
- `safetyTeam` should become a safety review visibility label.
- assigned/in-review/resolved/rejected/archived states should be externally
  recorded labels when exposed at all.
- high/urgent priorities must carry no timing, human, or emergency guarantee.
- `backendGoverned` may only become an externally asserted governance label.

## Blocked Concepts

Blocked from package-facing vocabulary:

- `EscalationQueue.accepts`
- accepts predicates
- routing/admission guarantees
- team ownership guarantees
- emergency guarantees
- backend enforcement claims
- client outcome write permissions
- provider causality claims
- fallback recovery claims

## Recommended EX-104 Phase

EX-104 should be a no-code passive vocabulary specification phase:

- define final candidate names
- define allowed meaning for each label
- define prohibited meaning for each label
- define caveat text for detoxed labels
- define which labels are package-safe, host-only, backend-only, or blocked
- define migration blockers before any future contract work

## Closing Doctrine

The package may describe facts only. The host/backend decides routing,
admission, enforcement, emergency handling, provider causality, fallback
recovery, moderation ownership, review ownership, resolution ownership, and
outcome writes.
