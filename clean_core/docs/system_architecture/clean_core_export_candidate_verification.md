# Clean Core Export Candidate Verification

Draft export candidate verification checklist.

## Verified For Future Extraction After Manual Scan

Candidate areas:

- Legal consent contracts.
- Safety contracts.
- Audit contracts.
- Backend-boundary contracts.
- Policy runtime contracts.
- Safety decision contracts.
- Trusted backend and trusted pipeline contracts.
- Selected review/escalation contracts.

Required checks:

- No Flutter UI imports.
- No Firebase setup/options imports.
- No generated files.
- No router/navigation imports.
- No platform setup.
- No provider SDK imports.
- No networking.

## Needs Manual Code Scan

Candidate areas:

- Provider governance.
- Provider onboarding.
- Runtime governance families.
- Governance kernel/lifecycle/compliance.
- Conversation/session contracts.
- Response composition contracts.
- Safety memory contracts.
- Architecture manifest contracts.

Manual scan should verify:

- Stable semantics.
- No app-owned imports.
- No active runtime behavior.
- No client-side authority expansion.

## Adapter-Only Candidates

- Firebase access contracts.
- Auth/session contracts.
- Routing intent contracts.
- Localization/text contracts.
- Environment/config contracts.
- Observability/analytics contracts.
- Provider/backend bridge contracts.
- Emulator/test fixture contracts.

## Deferred Until Runtime Phase

- Runtime execution.
- Provider execution.
- Cloud Functions orchestration.
- Chat AI.
- Escalation automation.
- Telemetry runtime.
- Deployment/release activation.

## Explicit Non-Action

No export candidate was promoted or exported.
