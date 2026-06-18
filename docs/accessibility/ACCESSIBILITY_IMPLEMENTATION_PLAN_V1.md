# Accessibility Implementation Plan V1

Status: ACTIVE_IMPLEMENTATION_PLAN
Classification: ROADMAP_ONLY
Phase: 7C
Runtime effect: none

## Purpose

Define the accessibility implementation roadmap before code changes.

This plan does not authorize implementation. Each wave requires separate Owner approval, scope review, runtime change operation, validation, and operation registration.

## Roadmap Summary

| Wave | Theme | Complexity | Dependencies | Primary Risk | Signal Impact |
| --- | --- | --- | --- | --- | --- |
| Wave 1 | Splash and early access entry points | Medium | Accessibility Gateway doctrine, route/UI approval, splash design review | Creating visible access paths before scope is approved | New access-entry signals may be needed |
| Wave 2 | Client login and registration extraction | High | Client Identity Extraction decision, registration forensic findings, auth/data migration plan | Breaking account creation or preserving stale profile signals | Reduces registration-origin signals; shifts emphasis to room/session signals |
| Wave 3 | Accessibility Room introduction | Medium/High | Accessibility Room Card, content/card registry, Owner-approved route plan | Room becomes segregated surface instead of shared access gateway | Room-open and card-open signals may be added |
| Wave 4 | Accessible communication buttons | High | Communication Card, provider/center page audit, contact request governance | Collecting labels instead of needs; changing contact expectations | Contact intent and access-need signals must be bounded |
| Wave 5 | Organizations directory | Medium | Organization Directory Card, external link policy, verification rules | Implied endorsement or stale organization data | Directory-open and organization-contact signals may be needed |
| Wave 6 | Accessibility TV | Medium | Accessibility TV Card, content source policy, YouTube/link governance | Unsafe or misleading external content | Video-open and learning-intent signals may be needed |
| Wave 7 | AI Gateway | High | AI authority doctrine, safety rules, escalation boundaries, privacy policy | AI overreach, diagnosis, hidden authority, unsafe advice | AI-access signals must be privacy-preserving |
| Wave 8 | Partnership outreach | Medium/High | Organization directory governance, legal/commercial review, Owner approval | Unapproved partnership claims or external commitments | Outreach lifecycle signals may require governance |

## Wave 1

### Splash Buttons

Introduce accessibility-aware entry buttons from the first public/app surface only after design and route scope approval.

Expected behavior:

- clear access entry
- no user classification
- no medical wording
- no diagnosis implication

Complexity estimate: Medium.

Dependencies:

- Accessibility Gateway Guide
- Accessibility Room Card
- approved navigation destination
- UX copy review

Risks:

- user may read accessibility as a separate class
- premature route activation may imply implementation maturity

Signal impact:

- possible `accessibility_entry_selected`
- source should identify splash/public entry

### Quick Access

Provide a quick access path for users who need low-friction navigation.

Complexity estimate: Medium.

Dependencies:

- route decision
- visual hierarchy rules
- accessibility copy approval

Risks:

- quick access can become a hidden shortcut to incomplete surfaces

Signal impact:

- quick access selection can indicate navigation need, not disability label

### Accessibility Access

Create the main accessibility access path into the future Accessibility Room.

Complexity estimate: Medium.

Dependencies:

- Wave 3 target definition
- gateway doctrine
- route governance

Risks:

- access path may imply live resources before they exist

Signal impact:

- access entry signal should not infer condition or identity

### Provider / Center Access

Plan accessibility entry paths from provider and center surfaces.

Complexity estimate: Medium/High.

Dependencies:

- provider/center page audit
- Accessible Communication Card
- contact request governance

Risks:

- provider/center access may imply verified accessibility support before verification exists

Signal impact:

- signals should track access-path use, not provider capability unless verified

## Wave 2

### Client Login Extraction

Evaluate whether client login can be reduced, delayed, or replaced with lighter session-room access where safe.

Complexity estimate: High.

Dependencies:

- Client Identity Extraction Decision
- auth boundary audit
- dashboard/personal-space dependency audit
- data retention review

Risks:

- breaking protected client flows
- losing necessary continuity
- leaving old login assumptions active

Signal impact:

- fewer login-origin identity signals
- stronger reliance on repeated room/session intent

### Client Registration Extraction

Extract or simplify registration-time profile/preference capture.

Complexity estimate: High.

Dependencies:

- Client Registration forensic audit
- Fresh Signal Preference Doctrine
- Owner-approved field decision
- migration and verification plan

Risks:

- old heavy registration remains active
- downstream screens still expect old fields
- data model drift

Signal impact:

- registration-origin goal/interest/accessibility signals should decrease
- repeated intent signals become more important

### Session Room Introduction

Introduce session-room behavior as the fresh signal source for current intent.

Complexity estimate: High.

Dependencies:

- Stateless Client Room Doctrine
- signal retention rules
- privacy review
- room lifecycle definition

Risks:

- session language could be confused with clinical or booking sessions
- repeated signals could become over-inferred

Signal impact:

- new room/session intent signals
- must avoid diagnosis or permanent labeling

## Wave 3

### Accessibility Room Introduction

Introduce the Accessibility Room as the governed access surface.

Complexity estimate: Medium/High.

Dependencies:

- Accessibility Room Card
- Gateway Guide
- fixed card approval
- route and UI approval

Risks:

- segregation risk if the room feels separate from the city
- placeholder risk if cards are visible before content exists

Signal impact:

- room opened
- fixed card opened
- resource intent

## Wave 4

### Accessible Communication Buttons

Introduce accessible contact options beside normal contact buttons.

Complexity estimate: High.

Dependencies:

- Accessibility Communication Card
- contact request schema review
- provider/center readiness policy
- copy review

Risks:

- collecting labels instead of needs
- changing support expectations
- creating unverified service promises

Signal impact:

- accessible contact selected
- communication need selected
- no diagnosis or identity label signal

### Provider Pages

Add accessible communication patterns to provider pages where approved.

Complexity estimate: High.

Dependencies:

- provider page audit
- provider accessibility readiness flag doctrine
- contact pathway governance

Risks:

- provider capability overclaim
- mixed provider/clinician terminology

Signal impact:

- provider accessible contact intent

### Center Pages

Add accessible communication patterns to center pages where approved.

Complexity estimate: High.

Dependencies:

- center page audit
- center accessibility readiness flag doctrine
- contact pathway governance

Risks:

- center capability overclaim
- accidental booking/session implication

Signal impact:

- center accessible contact intent

## Wave 5

### Organizations Directory

Introduce governed accessibility organization directory.

Complexity estimate: Medium.

Dependencies:

- Organization Directory Card
- external link policy
- organization verification rules
- content moderation/update process

Risks:

- stale directory data
- implied endorsement
- unsafe external links

Signal impact:

- directory opened
- category selected
- organization opened
- external contact selected

## Wave 6

### Accessibility TV

Introduce video-first accessibility learning surface.

Complexity estimate: Medium.

Dependencies:

- Accessibility TV Card
- YouTube/link policy
- video source review
- content language governance

Risks:

- unsafe video sources
- over-complex content
- content that implies diagnosis or treatment promise

Signal impact:

- accessibility TV opened
- video opened
- learning category selected

## Wave 7

### AI Gateway

Introduce accessibility-aware AI gateway only after AI safety and authority governance.

Complexity estimate: High.

Dependencies:

- AI authority guide
- privacy policy
- escalation rules
- safety filters
- Owner approval

Risks:

- diagnosis or treatment advice
- hidden authority
- unsafe dependence
- collecting sensitive labels

Signal impact:

- AI gateway opened
- assistance mode requested
- must avoid sensitive identity inference

## Wave 8

### Partnership Outreach

Introduce partnership outreach for accessibility organizations and resource providers.

Complexity estimate: Medium/High.

Dependencies:

- Owner approval
- legal/commercial review
- organization directory governance
- outreach templates
- archive and memory policy

Risks:

- partnership claims without approval
- external commitment without legal review
- public trust confusion

Signal impact:

- outreach candidate registered
- outreach status updated
- partner response recorded only under approved governance

## Cross-Wave Dependencies

- Accessibility Gateway Guide
- Accessibility Room Card
- Accessibility Communication Card
- Accessibility Organization Directory Card
- Accessibility TV Card
- Client Identity Extraction Decision
- Fresh Signal Preference Doctrine
- Owner approval before implementation
- Route, collection, signal, and copy governance before runtime changes

## Cross-Wave Risks

- user classification by implication
- segregated accessibility pathway
- stale resources
- over-promising provider or center readiness
- collecting labels instead of needs
- signal over-inference
- unapproved AI authority
- unapproved external partnership claims

## Signal Impact Doctrine

Accessibility signals should record access intent and barrier-removal needs.

They must not record:

- diagnosis
- permanent disability labels
- clinical identity
- eligibility status
- unsupported provider capability

Future signal additions must be separately governed before implementation.

## Final Boundary

This document is an implementation roadmap only.

No code, routes, models, collections, Firebase rules, UI, or signal constants are created by this plan.
