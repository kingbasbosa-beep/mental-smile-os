# FEDERATION_ROUTE_OPERATING_MODEL_V1

## Purpose

Define how routes operate as movement contracts inside the federation.

## Route Types

- Internal Route.
- Gateway Route.
- Cross-Zone Route.
- Monitoring Route.
- Strategic Route.
- Archive Route.
- Emergency Route.
- Continuity Route.

## Route Authority

Routes do not grant authority. Routes must inherit authority from zone, gateway, signal, card, and registry doctrine.

## Runtime Rule

Runtime may implement only registered routes. An unregistered route is not launch-valid even if technically reachable.

## Forbidden

- No route bypasses a gateway.
- No route creates direct cross-zone mutation.
- No route bypasses owner approval where approval is required.
- No route points to unregistered screens, districts, archives, or tools.
