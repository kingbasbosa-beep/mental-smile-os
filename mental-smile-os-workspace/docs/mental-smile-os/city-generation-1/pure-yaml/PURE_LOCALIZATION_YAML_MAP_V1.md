# Pure Localization YAML Map V1

Status: LOCALIZATION_YAML_MAP
Prompt Asset: PROMPT_ASSET_045

## Purpose

Define how future localization YAML entries must be registered.

## Localization Entry Model

| Field | Requirement |
| --- | --- |
| Localization Key | Required |
| Arabic Term | Required |
| English Term | Required when supported |
| Localization Card | Required |
| Zone | Required |
| Screen or District | Required |
| Allowed Usage | Required |
| Forbidden Usage | Required |
| Status | Required |

## Arabic-First Rule

Arabic is the first language layer for Mental Smile OS App Surface and constitutional documentation labels.

English may be supported, but English support may not replace Arabic-first registration.

## Forbidden Localization Entries

- Clinical promises.
- Diagnostic language.
- Forced labels.
- Booking language unless future doctrine authorizes booking.
- Legacy terms without review.
- Placeholder keys without owner or expiry.

