# Declaration Review Independence

## Purpose

Wave C-3 ends the doctrine that provider or center existence depends on admin
approval.

Mental Smile Federation does not use:

```text
Approve To Exist
```

It moves toward:

```text
Declare
Complete
Review
Visibility Decision
```

## Declaration Reviewer Claim

Firestore Rules now require the explicit custom claim:

```text
role = declaration_reviewer
```

`isDeclarationReviewer()` no longer inherits `isAdmin()`.

## Reviewer Can

- verify declaration completeness
- verify required profile fields are present
- verify required documents were uploaded
- verify declared capabilities are represented in the profile
- review profile change requests for declaration integrity
- make visibility-oriented status changes during the transition

## Reviewer Cannot

- approve treatment
- approve a business as a service-quality guarantee
- approve existence
- assign clients
- control providers
- control centers
- schedule sessions
- control payments
- operate booking workflows

## Visibility Logic Classification

Current visibility fields still use legacy names:

- `approvalStatus`
- `approved`
- `pending_review`
- `pending_admin`
- `rejected`
- `rejected_admin`
- `isActive`
- `isBlocked`

Constitutional interpretation:

- `approved` should mean visible declaration, not permission to exist.
- `pending_review` should mean declaration completeness review.
- `pending_admin` is legacy wording and should be renamed later.
- `rejected` should mean declaration cannot be shown as submitted.
- `isBlocked` should remain safety/access restriction, not business control.

## Declared Signals

The following profile facts should be treated as declared signals, not approved
signals:

- specializations
- capabilities
- services
- languages
- accessibility
- education
- training
- documents uploaded
- profile transparency fields

## Legacy Residue

The codebase still contains legacy approval language in routes, localization,
admin pages, and visibility filters. This wave does not purge those references.

Remaining legacy dependencies include:

- provider and center onboarding status labels
- admin clinician/center review pages
- specialist and center discovery filters that require `approvalStatus`
- app route guards that redirect when accounts are not `approved` and active

## Future Work

Future waves should rename and migrate:

- `approvalStatus` to declaration/visibility status
- `pending_admin` to pending declaration review
- admin review pages to declaration review pages
- approval copy to visibility/completeness copy

This must happen without changing booking, session, payment, support,
monitoring, or registry workflows in C-3.
