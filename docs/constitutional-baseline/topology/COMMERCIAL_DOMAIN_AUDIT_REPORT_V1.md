# COMMERCIAL_DOMAIN_AUDIT_REPORT_V1

Status: ACTIVE_TOPOLOGY_REPORT
Phase: 4
Runtime effect: none

## Purpose

The Commercial Domain governs discovery, tools, marketplace surfaces, service discovery, and external resources without turning Mental Smile into an unmanaged booking system.

## Responsibilities

- Tools: support instruments and future utilities.
- Discovery: specialists, centers, categories, and resource paths.
- Marketplace Layer: structured service visibility without uncontrolled transactions.
- External Resources: links, content, and future outside references requiring safety governance.

## Inputs

- Client support needs.
- Clinician and center public profiles.
- Library categories.
- Support issue context.
- Marketplace route context.

## Outputs

- Discovery navigation.
- Specialist and center detail views.
- Support issue selections.
- Future tool usage signals.
- Future external resource governance events.

## Signals Produced

- Discovery intent.
- Category opening.
- Support pathway intent.
- Future tool usage signals.

## Signals Consumed

- Public profile availability.
- Safety policy decisions.
- Library policy state.
- Registration/verification outcomes.

## Collections

- `clinicians`
- `centers`
- `provider_contact_requests`
- `center_contact_requests`
- `support_requests`
- `tool_registry` as planned or residue requiring governance classification.

## Routes

- `Routes.specialists`
- `Routes.specialistsList`
- `Routes.specialistDetails`
- `Routes.centers`
- `Routes.centersList`
- `Routes.centerDetails`
- `Routes.sCityTools`
- `Routes.sCityMarketplace`
- `Routes.sCityServices`
- `Routes.portalServiceRequest`
- `Routes.portalPackageRequest`

## Dependencies

- Public profile data.
- Contact request repository.
- Library surface.
- Support issue selector.
- Web portal surfaces.
- Safety policy for external resources.

## Ownership

- Discovery: system-owned with clinician/center data participation.
- Marketplace Layer: Owner-governed until transaction rules exist.
- Tools: Owner-governed; monitoring-visible once active.
- External Resources: safety-governed.

## Risks

- Marketplace language can reintroduce booking-era expectations.
- External resources can bypass safety/monitoring if not registered.
- Tools can become features before registry ownership is established.

## Naming Drift

- `Marketplace`, `Services`, `Tools`, and `Discovery` need clear boundaries.
- `Contact Request` must remain distinct from `Booking`.

## Legacy Residue

- Booking-era vocabulary and old request patterns may still appear in doctrine or code names.
- Provider terminology may coexist with clinician runtime identity.

## Future Direction

- Establish a Tool Registry before activating any new tool.
- Require a Finding -> Card -> Guide -> Registry path before marketplace expansion.
- Keep service coordination separate from booking/payment.

## DNA Purity Score

70/100

Reason: discovery is active and useful, but commercial boundaries need stronger registry protection before expansion.
