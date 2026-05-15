# Clean Core Final Export Manifest

Draft final export/public API manifest before future extraction. No extraction, import rewrite, package movement, runtime activation, provider execution, Firebase integration, networking, or command execution was performed.

## Export-Safe Groups

Future curated exports may include:

- Governance contracts.
- Policy contracts.
- Audit/review contracts.
- Safety contracts.
- Escalation/review contracts.
- Backend-boundary contracts.
- Signed-operation contracts.
- Feedback/control-room contracts.
- Legal/compliance contracts.
- Runtime-disabled governance markers after stability review.

## Export Restrictions

Do not export:

- Flutter UI.
- Firebase runtime.
- Provider SDKs.
- Routing runtime.
- Localization generation.
- Assets.
- Generated files.
- Orchestration runtime.
- AI runtime execution.
- Networking runtime.
- Cloud Functions runtime.
- Deployment/runtime activation.

## Export Posture

All exported contracts should preserve:

- Fail-closed defaults.
- Deny-by-default posture.
- Backend-governed authority.
- Review awareness.
- Audit awareness.
- No client-side authority expansion.

## Future Manifest Rules

- Use curated exports only.
- Avoid export-all barrels.
- Keep internal/runtime-sensitive contracts hidden unless stabilized.
- Keep adapter implementations outside clean_core.
- Keep runtime/provider execution out of public API.

## Explicit Non-Action

No public export surface or barrel file was created.
