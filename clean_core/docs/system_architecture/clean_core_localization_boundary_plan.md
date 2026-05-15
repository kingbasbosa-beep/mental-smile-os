# Clean Core Localization Boundary Plan

Draft localization boundary plan. No localization generation or adapter implementation was performed.

## Localization Ownership

Localization generation remains host-app owned.

Host app owns:

- Generated localization files.
- Locale resolution.
- App string resources.
- Flutter localization delegates.
- Generated l10n tooling.

clean_core may define:

- Semantic text identifiers.
- Legal/support copy contracts.
- Safe fallback copy.
- Text resolution request shapes.

## Boundary Rules

- No generated l10n imports inside pure contracts.
- No generated localization files in public clean_core API.
- No app localization delegate ownership in clean_core.
- Pure contracts should use semantic identifiers or plain reusable copy only.
- Critical legal/support text should have safe fallback behavior.

## Future Adapter Reconnect

Future text adapter may accept:

- Text identifier.
- Locale hint.
- Fallback copy.
- Safety/legal context marker.
- Visibility scope.

Host app resolves actual localized strings.

## Failure Expectations

If localization is unavailable:

- Use safe fallback text for critical legal/support copy.
- Do not fetch remote strings from clean_core.
- Do not block safety-critical support solely because generated l10n is unavailable.
- Do not expose raw internal keys to users when fallback copy exists.

## Explicit Non-Action

No localization code or generation was changed.
