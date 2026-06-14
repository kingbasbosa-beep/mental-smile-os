# Generation 1 Local Validation Sequence V1

Status: LOCAL_VALIDATION_SEQUENCE_PREPARED
Prompt Asset: PROMPT_ASSET_066

## Validation Targets

| Target | Required Result |
| --- | --- |
| YAML valid | PASS before activation |
| Assets valid | PASS before activation |
| Localization valid | PASS before activation |
| Firebase rules syntactically valid | PASS before activation |
| Storage rules syntactically valid | PASS before activation |
| Runtime imports valid | PASS before activation |
| No admin authority | PASS before activation |
| No booking/session/payment authority | PASS before activation |
| No dead placeholders | PASS before activation |
| No unknown critical residue | PASS before activation |

## YAML Validation

Verify:

- Only active OS asset names are referenced.
- Splash, Home, Client Registration, Client Room, Provider Room, Center Room, Login, and Exit assets map to registered cards.
- No legacy asset paths enter active YAML.
- No undefined localization keys.

## Firebase Validation

Verify:

- Firestore rules follow approved collection families only.
- Storage rules follow approved storage boundaries only.
- No `admin`, `super_admin`, `god_mode`, or wildcard authority.
- No booking, session, or payment collections.
- Signal collections preserve source ownership and gateway routing.

## Runtime Validation

Verify:

- Routes map to approved route registry entries.
- Screens map to registered app screen packages.
- Gateways exist for every active zone.
- Signals travel through local gateways.
- No direct cross-zone mutation.

## Validation State

Prepared only. Validation commands are not executed by this document.

