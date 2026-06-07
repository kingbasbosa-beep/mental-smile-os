# Operational Monitoring Foundation

Wave M-3 creates the Operational Monitoring Foundation for Mental Smile
Federation.

This is not management, authority, a workflow command system, task UI,
notifications, Firebase, or report rendering.

## Goal

```text
Department Actions
-> Operational Signals
-> Operational Aggregates
-> Department Performance Snapshot
-> Operational Report Contract
```

Departments do not own users, clients, providers, centers, or service journeys.
Departments only perform their own work and generate aggregate signals about
their performance.

## Departments

Operational Monitoring supports:

- Technical Department
- Support Department
- Registry Department
- Declaration Review Department
- Commercial Services Department
- Archive Department
- Monitoring Department
- Owner Strategy

Each department has:

- department id
- Arabic name
- English name
- color token
- icon key
- report prefix

## Work Cards

`OperationalWorkCard` represents sanitized operational work only.

It includes:

- card id
- department id
- card type
- priority
- lifecycle timestamps
- status
- sanitized summary
- source type
- sanitized source reference
- archive code
- report prefix
- period

It must not store private messages, treatment data, booking references, payment
references, session references, payout references, or assignment references.

## Operational Signals

Work card signals:

- `work_card_created`
- `work_card_received`
- `work_card_acknowledged`
- `work_card_started`
- `work_card_blocked`
- `work_card_resolved`
- `work_card_verified`
- `work_card_archived`

Issue signals:

- `issue_detected`
- `issue_resolved`
- `issue_reopened`

Complaint signals:

- `complaint_received`
- `complaint_resolved`
- `complaint_escalated`

Report activity signals:

- `report_created`
- `report_reviewed`
- `report_archived`

Department performance signals:

- `department_note_added`
- `department_delay_detected`
- `department_handoff_created`
- `department_handoff_received`

These signals are operational only. They do not describe or control a client
journey.

## Aggregates

Operational Monitoring includes:

- `WorkCardAggregate`
- `IssueAggregate`
- `ComplaintAggregate`
- `ReportActivityAggregate`
- `DepartmentPerformanceAggregate`

Aggregates are count and summary models only.

## Snapshots

`OperationalMonitoringSnapshot` contains:

- timestamp
- department summaries
- work card summary
- issue summary
- complaint summary
- report activity summary
- performance summary

Snapshots include archive readiness fields:

- archive code
- report prefix
- department id
- period
- created at

## Reports

`OperationalMonitoringReport` is a contract only.

It contains:

- department summaries
- issues
- complaints
- work cards
- delays
- risks
- recommendations

No PDF, Excel, dashboard, chart, or rendering is introduced.

## Archive Readiness

Work cards, snapshots, aggregates, and reports include or support:

- archive code
- report prefix
- department id
- period
- created at

No archive UI or export format is created in this wave.

## Visual Identity Readiness

Department registry includes:

- color token
- icon key
- Arabic label
- English label
- report prefix

No visual rendering is created in this wave.

## Forbidden Boundaries

Operational Monitoring must not accept signals from:

- `booking_requests`
- `bookingRequests`
- `sessionRatings`
- payment proof
- payout states
- assignment states
- session lifecycle
- admin lifecycle

The operational boundary delegates source rejection to
`ForbiddenSignalSourceGuard`.

## Federation Separation Readiness

Localization Ready: YES

Naming Ready: YES

Monitoring Ready: YES

Archive Ready: YES

Visual Identity Ready: YES

Separation Ready: YES

## Runtime Restrictions

- Firebase writes: none
- Firestore collections: none
- UI/widgets: none
- dashboards: none
- reports rendering: none
- charts: none
- notifications: none
- workflow ownership: none

## Success State

Mental Smile now has three monitoring foundations:

```text
Residential Monitoring
Commercial Monitoring
Operational Monitoring
```

This enables future:

```text
Storage
-> Reports
-> Archive
-> Meeting Packs
```

without reinventing the monitoring domains.
