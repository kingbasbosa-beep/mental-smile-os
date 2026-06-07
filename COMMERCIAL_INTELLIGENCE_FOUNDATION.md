# Commercial Intelligence Foundation

Wave M-2 creates the Commercial Intelligence Foundation for Mental Smile
Federation.

This is not UI, not a dashboard, not report rendering, not Firebase, and not a
storage layer.

## Supply

Supply is observed through declared provider and center capability signals:

- provider specializations
- provider services
- provider declared capabilities
- center programs
- center services
- center specialties

Supply analysis remains contractual only in this wave.

## Demand

Demand is observed through clean commercial signals:

- `provider_profile_opened`
- `provider_contact_started`
- `provider_saved`
- `center_profile_opened`
- `center_contact_started`
- `center_saved`
- tool demand signals
- service request/view signals
- ecosystem engagement signals

Demand is aggregate-only. It must not reconstruct individual journeys.

## Gap

Gap models compare aggregate demand with aggregate supply:

- `DemandGap`
- `CapabilityGap`

Example:

```text
Recovery Demand: 4200
Recovery Providers: 700
Gap: 3500
```

No real calculation engine is introduced in this wave.

## Opportunity

Opportunity intelligence is represented by models only:

- `MarketOpportunity`
- `EmergingNeed`

No operational decisions, assignments, approvals, or lifecycle control are
introduced.

## Commercial Signals

Provider signals:

- `provider_profile_opened`
- `provider_contact_started`
- `provider_saved`
- `provider_specialization_declared`
- `provider_service_declared`
- `provider_capability_declared`
- `verification_requested`
- `verification_viewed`

Center signals:

- `center_profile_opened`
- `center_contact_started`
- `center_saved`
- `center_program_declared`
- `center_service_declared`
- `center_specialty_declared`
- `verification_requested`
- `verification_viewed`

Commercial service signals:

- `marketing_service_viewed`
- `marketing_service_requested`
- `technical_service_viewed`
- `technical_service_requested`
- `verification_service_viewed`
- `verification_service_requested`

## Tool Signals

Tool demand:

- `tool_opened`
- `tool_saved`
- `tool_requested`

Tool adoption:

- `tool_added`
- `tool_removed`
- `tool_replaced`

Tool opportunity:

- `tool_requested_without_availability`

## Ecosystem Signals

- `external_app_viewed`
- `external_app_opened`
- `external_app_saved`
- `external_knowledge_viewed`
- `partner_resource_viewed`

## Info Card Contract

`UniversalInfoCardContract` prepares shared information cards with:

- title
- icon
- short description
- learn more reference
- optional audio reference

It does not render UI and does not implement accessibility presentation.

## Constitutional Boundaries

Commercial Monitoring must not accept:

- `booking_requests`
- `bookingRequests`
- `sessionRatings`
- payment proof
- payout states
- assignment states
- session lifecycle
- admin lifecycle decisions

The commercial boundary delegates source rejection to
`ForbiddenSignalSourceGuard`.

## Federation Separation Readiness

Localization Ready: NO

Naming Ready: YES

Monitoring Ready: YES

Archive Ready: YES

Visual Identity Ready: NO

Separation Ready: YES

## Runtime Restrictions

- Firebase writes: none
- Firestore collections: none
- UI/widgets: none
- dashboards: none
- report rendering: none
- booking/session/payment sources: forbidden

## Success State

Mental Smile now has:

```text
Residential Monitoring
+
Commercial Monitoring
```

Commercial Intelligence now has its first foundation:

```text
Demand
-> Supply
-> Gap
-> Opportunity
```
