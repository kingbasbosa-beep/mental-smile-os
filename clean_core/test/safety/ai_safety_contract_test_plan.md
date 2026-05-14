# AI Safety Contract Test Plan

## Purpose

Define offline and emulator-ready validation for the AI safety skeleton without live AI runtime.

## Validate Now or Later

- Unknown risk keys fail closed to safer risk states.
- Low-confidence policy results use fail-safe response mode.
- Disabled runtime config keeps AI, crisis detection, escalation, and logging disabled.
- Sanitizers truncate previews and create placeholder hashes only.
- Governance payloads avoid raw prompts, full conversations, diagnosis fields, medication recommendations, and therapist roleplay authority.

## Must Remain Runtime-Free

- No OpenAI/Gemini calls.
- No moderation APIs.
- No NLP services.
- No chat AI.
- No crisis automation.

## Deferred

- Provider isolation tests.
- Policy snapshot enforcement against backend.
- Incident creation runtime tests.
- Audit trace persistence tests.
