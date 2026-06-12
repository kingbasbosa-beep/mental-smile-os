# ASSET GOVERNANCE SUMMARY

Status: Summary Reference  
Source: ASSET_CONSTITUTION_V1.md

## Core Doctrine

```text
One Asset
One Owner
Many Consumers
```

Every asset must be known, owned, governed, and observable.

## Non-Negotiable Rules

- No asset without an Asset Card.
- No ownership without an official registry.
- No consumer without a reference.
- No duplicate ownership.
- No runtime use of unknown assets.
- No migration without reference verification.
- No deletion without deletion review.
- No legacy asset becomes active by renaming.

## Governance Objects

| Object | Meaning |
|---|---|
| Asset | Visual file, resource, or named visual contract |
| Asset Registry | Constitutional owner domain |
| Asset Card | Required asset record |
| Asset Owner | Single registry responsible for meaning and lifecycle |
| Asset Consumer | Runtime, route, page, feature, platform, or card that uses the asset |
| Canonical Asset | Authoritative record and destination |
| Duplicate Alias | Temporary copy or path alias of canonical content |
| Dormant Asset | Known and owned but not currently visible |
| Legacy Asset | Historical or previous-architecture asset |
| Dead Asset | No proven consumer or retention reason |

## Official Registries

- CLIENT_ROOM
- CITY_SYSTEM
- WEB_SYSTEM
- AUTH_SYSTEM
- BRANDING_SYSTEM
- ICONS_SYSTEM
- BACKGROUNDS_SYSTEM
- PLACEHOLDER_SYSTEM
- PROVIDER_ROOM
- CENTER_ROOM
- OWNER_ROOM
- MONITORING_ROOM
- FUTURE_CONCEPTS
- LEGACY_IMPORTS

## Migration Readiness

An asset is ready for migration only when:

- Its card exists.
- Its owner registry is known.
- Its canonical destination is known.
- Its consumers are listed.
- Its duplicate status is resolved.
- Its pubspec and platform references are mapped.
- Rollback can restore previous behavior.

## Forbidden Patterns

- `final.png`
- `copy.png`
- `new_logo.png`
- `image_test.png`
- Ownerless assets
- Unclassified runtime assets
- Feature-local copies of shared brand or icon assets
- Legacy imports used as runtime sources

## Observability Metrics

- Total Assets
- Active Assets
- Dormant Assets
- Legacy Assets
- Dead Assets
- Unclassified Assets
- Duplicate Groups
- Ownerless Assets
- Registry Distribution
- Migration Readiness

## Final Principle

The source code may consume assets, but the registry owns their meaning.
