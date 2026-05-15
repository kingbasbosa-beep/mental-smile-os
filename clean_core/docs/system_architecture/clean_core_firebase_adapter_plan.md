# Clean Core Firebase Adapter Plan

Draft adapter-only plan. No Firebase adapters were implemented.

## Adapter Principle

Firebase adapters should allow future reconnect while keeping Firebase SDKs and runtime initialization outside clean_core.

## Firestore Access Adapter

clean_core may define:

- Safe read/write intent contracts.
- Protected-field result contracts.
- Trusted operation request envelopes.
- Audit-linked write expectations.

Host/backend owns:

- Firestore SDK.
- Data source implementation.
- Runtime auth context.
- Rules-aware behavior.

## Auth/Session Adapter

clean_core may define:

- User identity reference.
- Session snapshot.
- Unknown/unauthenticated marker.

Host/backend owns:

- Auth SDK.
- Active session runtime.
- Role/claim refresh.
- Authorization decisions.

## Functions Bridge Adapter

clean_core may define:

- Trusted operation request.
- Signed authority placeholder.
- Backend result envelope.
- Fail-closed fallback result.

Backend owns:

- Cloud Functions implementation.
- Orchestration runtime.
- Provider execution.
- Governance enforcement.

## Storage Bridge Adapter

clean_core may define:

- Storage reference contracts if needed.
- Upload intent boundaries.
- Protected review status expectations.

Host/backend owns:

- Storage SDK.
- Upload implementation.
- Access control.
- Review and moderation state.

## Analytics Bridge Adapter

clean_core may define:

- Privacy-safe event contracts.
- Consent marker.
- Redaction marker.

Host/backend owns:

- Analytics SDK.
- Consent enforcement.
- Event transport.

## Emulator Bridge Adapter

clean_core may define:

- Fixture contracts.
- Protected-field test payloads.
- Mock trusted operation shapes.

Host/test harness owns:

- Emulator startup.
- Project ids.
- Rules loading.
- Integration test runtime.

## Explicit Non-Action

No Firebase adapter code was created.
