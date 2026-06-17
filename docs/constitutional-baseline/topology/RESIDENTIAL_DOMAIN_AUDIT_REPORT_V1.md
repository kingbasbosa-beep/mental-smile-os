# RESIDENTIAL_DOMAIN_AUDIT_REPORT_V1

Status: ACTIVE_TOPOLOGY_REPORT
Phase: 4
Runtime effect: none

## Purpose

The Residential Domain is the lived user environment of Mental Smile. It contains the client-facing room, the professional room, the center room, and the personal continuity space.

## Responsibilities

- Client Room: daily navigation, discovery entry, support entry, personal continuity.
- Provider Room: clinician identity, profile stewardship, inbox access, support handoff.
- Center Room: center identity, center profile stewardship, service presentation.
- Personal Space: client self-continuity, signal board, saved context, trusted return surface.

## Inputs

- Authenticated role state.
- Client, clinician, and center profile records.
- Saved destinations.
- Support issue selections.
- Chat and signal context.

## Outputs

- Client navigation decisions.
- Profile edit requests from provider and center rooms.
- Support requests and chat entry.
- Signal events from personal space and library usage.

## Signals Produced

- Library category opened signals.
- Personal space signal events.
- Support request intent.
- Chat thread activity.

## Signals Consumed

- Account access state.
- Role gateway state.
- Saved destination context.
- Monitoring outcomes when account state is blocked or escalated.

## Collections

- `clients`
- `clinicians`
- `centers`
- `saved_destinations`
- `support_requests`
- `chat_threads`
- `signal_events`
- `clinician_profile_change_requests`
- `center_profile_change_requests`

## Routes

- `Routes.clientDashboard`
- `Routes.sPersonalSpace`
- `Routes.clinicianRoom`
- `Routes.clinicianChatInbox`
- `Routes.clinicianProfileEditRequest`
- `Routes.centerDashboard`
- `Routes.centerRoom`
- `Routes.centerProfileEditRequest`
- `Routes.chat`
- `Routes.supportIssueSelector`

## Dependencies

- Authentication.
- Firestore profile collections.
- Role access gateway.
- Chat runtime.
- Signal runtime.
- Shared UI kit.

## Ownership

- Client Room: Client owner, with system protection.
- Provider Room: Clinician owner, governed by declaration review.
- Center Room: Center owner, governed by declaration review.
- Personal Space: Client owner, monitored by safety boundaries.

## Risks

- Provider and clinician naming drift can confuse ownership.
- Center dashboard and center room responsibilities can overlap.
- Personal space may become a dumping ground for support, saved items, and monitoring signals unless boundaries are documented.

## Naming Drift

- `provider` and `clinician` appear as conceptual neighbors, but runtime uses `clinician` for the professional identity.
- `clientDashboard` and `sPersonalSpace` are separate surfaces and should remain distinct.

## Legacy Residue

- Booking-era mental model may still influence support/request naming.
- Pre-purification C5 avatar lineage remains historical only after Phase 3.

## Future Direction

- Formalize personal space as the continuity layer, not a generic dashboard.
- Keep provider naming as business language only if mapped clearly to clinician runtime identity.
- Create room-level domain cards before adding new residential features.

## DNA Purity Score

78/100

Reason: active room structure is clear, but naming and request lineage still need constitutional registry precision.
