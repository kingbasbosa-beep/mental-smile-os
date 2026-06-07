# Federation Meeting System Foundation

## Scope

Wave M-10 adds the foundation for federation decision and review cycles.

This foundation does not create UI, dashboards, notifications, scheduling,
calendar integrations, Firebase writes, Firestore collections, or runtime
meetings.

## Review Cycle

The meeting system follows this constitutional path:

```text
Signals
Monitoring
Reports
Archive Packages
Meeting Packs
Human Review
```

Meetings do not read raw signals and do not create operational authority.

## Meeting Types

- weekly_review
- monthly_review
- quarterly_review
- annual_review
- operational_review
- commercial_review
- residential_review
- strategic_review
- constitutional_review
- owner_review
- monitoring_review

## Agenda Structure

`MeetingAgendaItem` contains:

- agendaId
- title
- description
- category
- relatedReportCode
- relatedPackageCode
- priority

## Package References

`MeetingPackageReference` contains:

- packageCode
- packageType
- archiveCode
- classification

It contains no package payload.

## Participant Structure

`MeetingParticipant` contains only:

- participantType
- participantRole
- displayName
- department

It contains no account binding.

## Department Mapping

`DepartmentMeetingRegistry` maps departments to meeting types, report types,
and archive package types.

## Localization Alignment

`MeetingLocalizationMap` defines AR/EN labels for:

- Agenda
- Review
- Summary
- Risks
- Opportunities
- Recommendations
- Follow Up
- Decision Notes

## Readiness Snapshot

`MeetingSystemReadinessSnapshot` reports:

- supportedMeetingTypes
- supportedPackageTypes
- supportedReports
- complianceStatus

The current compliance status is foundation-only and does not imply runtime
meeting execution.

## Constitutional Boundary

The meeting foundation rejects references to:

- booking_requests
- bookingRequests
- sessionRatings
- client_sessions
- clinician_sessions
- payment proof
- adminPayments
- assignment
- payout

## Federation Separation Readiness

### Localization Ready

YES

### Naming Ready

YES

### Monitoring Ready

YES

### Archive Ready

YES

### Visual Identity Ready

YES

### Accessibility Ready

YES

### Separation Ready

YES

## Next Wave

This foundation prepares the project for Public Feedback Foundation by making
human review cycles explicit before any future UI or intelligence surface.
