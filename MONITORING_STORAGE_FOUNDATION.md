# Monitoring Storage Foundation

Wave M-4 creates the Federation Memory Layer for Monitoring.

This is not Firebase, Firestore, collections, writes, UI, dashboard, archive
export, PDF, Excel, charting, or report rendering.

## Storage Flow

```text
Monitoring Domain
-> Snapshot
-> Storage Contract
-> Storage Record
-> Future Archive
```

Storage preserves federation memory. It does not make decisions, send
notifications, or own workflows.

## Storage Objects

The storage object type registry supports:

- `residential_snapshot`
- `commercial_snapshot`
- `operational_snapshot`
- `residential_report`
- `commercial_report`
- `operational_report`
- `strategic_summary`
- `constitutional_report`

Snapshots and reports are classified separately.

## Monitoring Storage Record

`MonitoringStorageRecord` contains:

- record id
- record type
- source domain
- created at
- period
- archive code
- report prefix
- version
- metadata
- payload reference

It stores references only. It must not store actual payload content.

## Retention

`RetentionClass` supports:

- `ephemeral`
- `operational`
- `annual`
- `historical`
- `constitutional`
- `sovereign`

No deletion lifecycle is implemented in this wave.

## Archive Eligibility

`ArchiveEligibility` supports:

- `eligible`
- `restricted`
- `constitutional_only`
- `owner_only`

No archive UI, export, PDF, Excel, or rendered artifact is introduced.

## Versioning

`StorageVersion` supports:

- major
- minor
- patch

The current foundation version is `1.0.0`.

## Storage Registry

`MonitoringStorageRegistry` maps storage object types to:

- retention class
- archive eligibility

This prepares future storage and archive rules without introducing any
infrastructure.

## Storage Contracts

Snapshot contracts:

- `ResidentialSnapshotStorageContract`
- `CommercialSnapshotStorageContract`
- `OperationalSnapshotStorageContract`

Report contracts:

- `ResidentialReportStorageContract`
- `CommercialReportStorageContract`
- `OperationalReportStorageContract`

Strategic contracts:

- `StrategicSummaryStorageContract`
- `ConstitutionalReportStorageContract`

All contracts store reference records only and have no implementation in this
wave.

## Builder Contracts

Builder contracts:

- `SnapshotStorageBuilder`
- `ReportStorageBuilder`

They build storage records only. They do not persist anything.

## Storage Readiness

Readiness models:

- `StorageHealthSnapshot`
- `StorageReadinessSnapshot`

These are foundation models only.

## Forbidden Boundary

Monitoring Storage must not accept sources from:

- `booking_requests`
- `bookingRequests`
- `sessionRatings`
- payment proof
- payout states
- assignment states
- session lifecycle
- admin lifecycle

The storage boundary delegates source rejection to
`ForbiddenSignalSourceGuard`.

## Federation Separation Readiness

Localization Ready: YES

Naming Ready: YES

Monitoring Ready: YES

Archive Ready: YES

Visual Identity Ready: NO

Separation Ready: YES

## Runtime Restrictions

- Firebase: none
- Firestore: none
- Collections: none
- Writes: none
- UI/widgets: none
- Dashboards: none
- Export: none
- PDF/Excel: none
- Charts: none

## Success State

```text
Residential Monitoring
+
Commercial Monitoring
+
Operational Monitoring
-> Storage Layer
```

Mental Smile now has:

```text
Monitoring
-> Memory
```

without Firebase, Archive, or UI, and is ready for:

```text
M-5 Federation Report Schema
```
