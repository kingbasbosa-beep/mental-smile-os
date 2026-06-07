# Authority Split Foundation

## Purpose

C-1 started dismantling `isAdmin()` as the governing authority language in
Mental Smile Federation. C-2 begins removing admin fallback from independent
constitutional authorities.

The goal is not to delete legacy admin immediately. The goal is to introduce
constitutional authority roles inside Firestore Rules so future purge waves can
remove admin safely.

## Why `isAdmin()` Was Split

`isAdmin()` had become a single broad authority covering monitoring, registry
management, support observation, declaration review, and legacy lifecycle
control.

That conflicts with the federation doctrine:

```text
No one owns anyone.
Signals over lifecycle.
Knowledge over authority.
```

## Owner Is Not Admin

Owner is not a super admin, operations controller, booking controller, payment
controller, or session controller.

Owner represents sovereign custody only:

- federation identity
- constitutional memory
- legal ownership records
- recovery assets
- emergency capsules

Wave C-1 adds `isOwner()` but grants it no operational Firestore permissions.

## New Authority Roles

The new role language is:

- `isOwner()`
- `isMonitoringOperator()`
- `isRegistrySteward()`
- `isDeclarationReviewer()`
- `isSupportObserver()`

During the transition, roles may temporarily accept legacy `isAdmin()` as a
compatibility fallback until each authority reaches independence. This is
marked in rules as:

```text
TRANSITIONAL AUTHORITY SPLIT
```

## C-2 Monitoring And Registry Independence

Wave C-2 removed `isAdmin()` fallback from:

- `isMonitoringOperator()`
- `isRegistrySteward()`

These roles now require explicit custom claims:

```text
role = monitoring_operator
role = registry_steward
```

No authentication implementation was added in this wave. Claims must be granted
by trusted identity tooling or server-side administration outside the client
app.

Monitoring and registry independence means these surfaces no longer depend on
admin authority:

- monitoring reads system and aggregate visibility collections only
- registry stewardship manages tool, policy, resource, domain, and follow-up
  registry documents only

These roles do not own:

- clients
- providers
- centers
- bookings
- sessions
- payments
- assignments

## C-3 Declaration Review Independence

Wave C-3 removed `isAdmin()` fallback from:

- `isDeclarationReviewer()`

Declaration review now requires the explicit custom claim:

```text
role = declaration_reviewer
```

This separates declaration review from admin approval. The reviewer can review
profile completeness, required documents, declared capabilities, and visibility
readiness. The reviewer cannot approve existence, operate providers, control
centers, assign clients, schedule sessions, or control payments.

## C-4 Support Observer Independence

Wave C-4 removed `isAdmin()` fallback from:

- `isSupportObserver()`

Support observation now requires the explicit custom claim:

```text
role = support_observer
```

Support can observe, help, follow up, escalate, and document. Support cannot
approve providers, approve centers, schedule sessions, operate booking,
operate payments, operate assignment, or control client journeys.

## Migrated Authority

Monitoring authority moved to `isMonitoringOperator()` for:

- `system_health`
- `system_alerts`
- `analytics_summaries`

Registry stewardship moved to `isRegistrySteward()` for:

- `tool_registry`
- `ai_policies`
- `resources`
- `system_domains`
- `external_follow_up_registry`
- `external_follow_up_message_templates`
- `external_follow_up_campaigns`

Declaration review moved to `isDeclarationReviewer()` for:

- clinician visibility and review updates
- center visibility and review updates
- `clinician_profile_change_requests`
- `center_profile_change_requests`

Support observation moved to `isSupportObserver()` for:

- `support_requests`
- `provider_contact_requests`
- `center_contact_requests`
- `saved_destinations`
- `chat_threads`
- `chat_escalations`

## Legacy Authority Still Contained

The following areas still use `isAdmin()` temporarily:

- `booking_requests`
- `sessionRatings`
- `admins`
- client account management

These are marked as legacy authority where applicable and must be handled in
future purge waves.

## What Comes Later

Future waves should:

1. Freeze and purge booking/payment/session authority.
2. Rename admin UI surfaces to monitoring, support, registry, and review.
3. Retire the legacy `admins` compatibility surface.

## Non-Goals

Wave C-1 does not:

- delete `isAdmin()`
- delete collections
- remove routes
- change UI
- activate gateway
- activate reports
- activate owner intelligence
- grant Owner operational permissions
