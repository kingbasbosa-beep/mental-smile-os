# Clean Core Adapter Authority Matrix

Draft authority matrix for future adapter contracts.

| System | clean_core May Define | clean_core Must Never Execute | Host App Owns | Backend Owns |
| --- | --- | --- | --- | --- |
| Firebase | Safe data contracts | Firebase initialization/runtime | Firebase app setup | Server-owned enforcement |
| Auth/session | Identity references | Session refresh/auth runtime | Active session | Authorization decisions |
| Routing | Route intents | Navigation stack changes | Route tables/navigation | N/A |
| Localization | Text keys/fallback copy | Generated l10n runtime | Locale/generation | N/A |
| Environment | Config contracts | Environment switching runtime | Environment loading | Runtime authority policy |
| Observability | Sanitized observation contracts | Telemetry transport | SDK setup if app-side | Audit/telemetry pipeline |
| Analytics | Privacy-safe event contracts | Analytics SDK calls | Analytics runtime | Consent/governance policy |
| Provider bridge | Capability/governance contracts | Provider SDK calls | Optional UI/config | Provider execution authority |
| Backend bridge | Trusted request envelopes | Server orchestration | Client invocation shell | Trusted operation runtime |
| Deployment/release | Readiness contracts | Deployment/store release | Store/platform release | Governance approval |
| Emulator/test | Fixture contracts | Emulator startup | Test harness | Optional emulator backend |

## Runtime Authority

Runtime authority belongs to backend/host systems, not clean_core contracts.

clean_core must never execute:

- Provider calls.
- Firebase setup.
- Cloud Functions runtime.
- Networking.
- Runtime activation.
- Deployment.
- UI navigation.
- Platform bootstrapping.

## Fail-Closed Requirements

Fail closed when:

- Authority is missing.
- Backend is unavailable.
- Provider is unavailable.
- Auth is unavailable.
- Environment is unknown.
- Observability is required but unavailable.
- Review is required.

## Explicit Non-Action

No authority boundaries were implemented in code.
