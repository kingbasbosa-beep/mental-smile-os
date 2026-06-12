# ASSET LIFECYCLE REFERENCE

Status: Reference  
Source: ASSET_CONSTITUTION_V1.md

## Lifecycle Values

| Lifecycle | Meaning | Allowed Actions | Forbidden Actions | Promotion | Retirement |
|---|---|---|---|---|---|
| ACTIVE | Proven current runtime, route, platform, or visible consumer depends on it | Register, document consumers, prepare migration, verify references | Delete without migration, move without path updates, duplicate ownership | From DORMANT when real consumer appears | To DORMANT or LEGACY after consumers are removed or migrated |
| DORMANT | Known and owned, no current visible consumer | Retain with owner, reason, future consumer, review date | Leave ownerless, use as vague storage, pretend it is a concept without ID | To ACTIVE when consumed | To DEAD when purpose expires |
| LEGACY | Historical, extinct, snapshot, previous-architecture, or compatibility asset | Preserve provenance, quarantine runtime use, classify duplicates | Treat as active, migrate by renaming, use as new runtime source | Cannot promote directly; must be re-carded or replaced | To deletion review after retention clears |
| DEAD | No proven consumer and no active retention reason | Mark for deletion review, prove no references | Delete without review, silently keep as dormant, use in runtime | To DORMANT only if owner and purpose are proven | Delete in later cleanup after verification |
| UNCLASSIFIED | Identity or ownership unknown | Quarantine, investigate, classify | Use in runtime, call future concept without purpose, leave untracked | To ACTIVE, DORMANT, LEGACY, or DEAD after evidence | Cannot delete until classified |

## Lifecycle Decision Tree

```text
Is it referenced by active runtime or platform?
  yes -> ACTIVE
  no ->
    Is it historical, extinct, or snapshot material?
      yes -> LEGACY
      no ->
        Does it have a named owner, future purpose, and review date?
          yes -> DORMANT
          no ->
            Is identity or ownership unknown?
              yes -> UNCLASSIFIED
              no -> DEAD
```

## Dormant Requirements

A dormant asset must have:

- Owner registry
- Asset Card
- Purpose
- Intended future consumer
- Review date
- Retention reason

## Legacy Requirements

A legacy asset must record:

- Original path
- Source era
- Historical reason
- Whether it is immutable snapshot, extinct runtime, or compatibility
- Whether a canonical active duplicate exists

## Dead Requirements

A dead asset must not be deleted until:

- Source references are checked.
- Pubspec references are checked.
- Platform references are checked.
- Asset manifests are checked when available.
- Duplicate aliases are checked.
- Retention obligations are cleared.

## Promotion Rules

- ACTIVE can only come from a verified consumer.
- DORMANT can reactivate when a consumer is added.
- LEGACY cannot become active by renaming.
- DEAD can return to DORMANT only with a proven owner and purpose.
- UNCLASSIFIED must be classified before any other action.

## Retirement Rules

- Active assets retire after consumers are migrated.
- Dormant assets expire after review failure.
- Legacy assets retire after historical retention review.
- Dead assets retire after deletion verification.
- Unclassified assets cannot retire until classified.
