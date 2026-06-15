# MASTER_ROUTE_REGISTRY_MODEL_V1

Status: REGISTERED

## Registry Purpose

The Master Route Registry records all constitutional route definitions before runtime implementation.

## Required Registry Fields

| Field | Purpose |
|---|---|
| Route ID | Stable identifier. |
| Route Name | Human-readable name. |
| Route Type | Classification model value. |
| Source Zone | Origin zone. |
| Producer | Surface, district, gateway, or capsule creating the package. |
| Target Zone | Destination zone if applicable. |
| Consumer | Destination gateway, surface, district, archive, monitor, or strategy unit. |
| Owner | Authority accountable for route definition. |
| Allowed Flow | Approved path. |
| Forbidden Flow | Explicit forbidden behavior. |
| Payload Class | Signal, card package, summary, snapshot, report, emergency package. |
| Gateway Required | YES / NO. |
| Pipe Required | YES / NO. |
| Archive Policy | Snapshot, no snapshot, retention, preservation. |
| Lifecycle Status | Route lifecycle value. |
| Compliance Status | Compliance model value. |
| Runtime Status | Runtime status value. |

## Registration Rule

No route may enter runtime until its registry row exists and is compliance-reviewed.
