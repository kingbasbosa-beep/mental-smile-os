# FEDERATION_RUNTIME_LIFECYCLE_MODEL_V1

## Purpose

Define how runtime is activated from federation doctrine.

## Lifecycle

1. Validate active generation.
2. Load active zones.
3. Load gateway registry.
4. Load route registry.
5. Load signal families.
6. Load card packages.
7. Load asset and localization registries.
8. Bind runtime screens and districts.
9. Validate authority boundaries.
10. Run local validation.
11. Activate candidate runtime.

## Runtime Consumption Rule

Runtime consumes registered objects only.

## Rejection Rule

Runtime must reject:

- Unregistered assets.
- Unregistered routes.
- Unregistered signals.
- Orphan cards.
- Unknown collections.
- Direct cross-zone mutation.
- Legacy admin authority.
- Booking/session/payment authority in Generation 1.
