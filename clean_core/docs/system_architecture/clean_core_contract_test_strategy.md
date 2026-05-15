# Clean Core Contract Test Strategy

Draft contract test strategy for future extraction.

## Contract Test Goals

- Validate pure Dart contract behavior.
- Prove fail-closed defaults.
- Prove deny-by-default posture.
- Validate guard and policy decisions deterministically.
- Avoid Firebase, networking, provider SDKs, generated files, Flutter UI, and platform dependencies.

## Recommended Contract Test Areas

- Legal consent payload shape and version matching.
- AI safety risk/result/response-mode defaults.
- Audit redaction and sanitized reference behavior.
- Backend-boundary protected field definitions.
- Policy runtime fallback profile selection.
- Human review/escalation default states.
- Provider governance blocked defaults.
- Runtime governance locked/disabled defaults.
- Safety decision low-confidence/fail-safe behavior.
- Safety memory no-retention defaults.

## Fixture Rules

- No raw sensitive content.
- No raw crisis content.
- No full conversations.
- No diagnosis labels.
- No medication guidance.
- No API keys or secrets.
- No live project ids.

## Mock Rules

- Mock host/backend implementations only.
- No real Firebase SDKs.
- No HTTP clients.
- No provider SDKs.
- No Cloud Functions calls.

## Explicit Non-Action

No contract tests were implemented.
