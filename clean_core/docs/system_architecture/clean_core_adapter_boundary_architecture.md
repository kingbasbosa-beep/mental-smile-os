# clean_core Adapter Boundary Architecture

EX-24 defines the future adapter and bridge architecture for Mental Smile. This is planning documentation only. No adapters, runtime bridges, imports, exports, dependencies, Firebase reconnects, provider reconnects, or runtime systems were implemented.

## Architecture Position

`mental_smile_clean_core` remains a declarative governed kernel. It may define contracts that describe future integration boundaries, but it must not own or execute integrations.

Adapters are reconnect boundaries between clean_core contracts and host/backend runtime systems.

## Adapter Categories

| Adapter Category | Purpose | Runtime Owner |
| --- | --- | --- |
| Firebase bridge adapters | Map safe data intents to Firestore/Auth/Functions/Storage behavior. | Host/backend |
| Auth/session adapters | Resolve current identity/session context. | Host/backend |
| Provider adapters | Bridge provider capabilities and blocked execution decisions. | Backend/host |
| Routing adapters | Translate route intents into host navigation. | Host app |
| Localization adapters | Resolve text keys and safe fallback copy. | Host app |
| Telemetry adapters | Emit sanitized observability events where approved. | Host/backend |
| Print/PDF/export adapters | Render, save, print, share, or export reports. | Host app |
| Backend trusted-operation adapters | Submit trusted operation requests to backend authority. | Backend |
| Audit/review adapters | Link actions to review queues and audit records. | Host/backend |

## Adapter Principles

- Adapters are reconnect boundaries only.
- Adapters do not own authority.
- Adapters do not bypass governance.
- Adapters do not activate runtime independently.
- Adapters do not create provider execution authority.
- Adapters must preserve fail-closed behavior.
- Adapter implementations remain outside clean_core.

## clean_core Role

clean_core may define:

- adapter contracts
- safe request/result envelopes
- block reasons
- visibility scopes
- audit/review references
- fail-closed defaults

clean_core must not define:

- adapter implementations
- Firebase SDK calls
- provider SDK calls
- routing execution
- platform file/print/share execution
- telemetry transport
- network clients
- runtime bootstrapping

## Architecture Verdict

Future adapters are allowed only as host/backend-owned implementation boundaries consuming clean_core contracts. They must not become clean_core runtime systems.
