# clean_core Future Adapter Categories

This inventory lists future adapter categories and their expected ownership.

## Categories

| Category | Future Contract Shape | Implementation Owner |
| --- | --- | --- |
| Firebase bridge | safe read/write intent, protected-field result | Host/backend |
| Auth/session | identity reference, session snapshot, role marker | Host/backend |
| Provider bridge | provider intent, capability scope, blocked result | Backend/host |
| Routing | route intent, route target key, navigation block | Host app |
| Localization | text key, locale hint, fallback copy | Host app |
| Telemetry | sanitized event, consent marker, audit reference | Host/backend |
| Print/PDF/export | export intent, format scope, privacy marker | Host app |
| Trusted operation | signed request, authority marker, result envelope | Backend |
| Audit/review | audit link, review marker, queue reference | Host/backend |
| Emulator/test | fixture intent, mock bridge result | Test harness |

## Export Guidance

Adapter contracts should not be exported until:

- semantic review is complete
- implementation ownership is clear
- failure behavior is fail-closed
- no runtime dependency is introduced
- no hidden authority is exposed

## Category Verdict

Adapter categories are future reconnect lanes, not current runtime systems.
