# Clean Core Master Architecture Report

Post OS-9I / Pre-Extraction Execution.

This report summarizes the architecture, governance posture, extraction readiness, and future runtime roadmap for Mental Smile `clean_core`. It does not claim that package extraction, Firebase integration, provider activation, AI execution, or runtime orchestration has been implemented.

## 1. Executive Summary

`clean_core` has reached a governance-complete architectural planning state. The system now contains a broad set of contracts, blueprints, readiness plans, authority models, adapter boundaries, extraction gates, and runtime deferral documentation.

The strategic outcome is clear: `clean_core` is not a normal Flutter module. It is being shaped as a governed kernel for Mental Smile. It is intended to become a future package surface for safe contracts and governance models while leaving runtime systems, Firebase setup, provider execution, UI, routing, generated files, and deployment infrastructure under host/backend ownership.

## 2. Vision & Philosophy

The core philosophy is safety before automation and governance before execution. Mental Smile operates in a sensitive support and wellness domain, so runtime intelligence cannot be treated as a simple feature toggle.

The architecture intentionally prioritizes:

- Contracts before integrations.
- Governance before generation.
- Backend authority before client convenience.
- Review before risky automation.
- Fail-closed behavior before permissive fallback.

## 3. Governance-First Architecture

The governance-first architecture creates policy, authority, review, audit, and adapter boundaries before any runtime activation. This allows future runtime systems to be introduced through controlled, reviewable, backend-governed paths.

Governance areas now documented include:

- Legal consent.
- AI safety.
- Policy governance.
- Backend authority.
- Human review and escalation.
- Provider governance and onboarding.
- Feedback intelligence and control-room operations.
- Runtime activation, enablement, release, rollback, observability, isolation, and bootstrap governance.

## 4. Fail-Closed / Deny-by-Default Philosophy

The system is intentionally designed to fail closed. Missing authority, missing audit links, stale policies, unavailable backends, unavailable providers, unknown environments, or uncertain risk states should not result in silent allow behavior.

Default outcomes should be:

- Blocked.
- Fallback-only.
- Review required.
- Escalation required.
- Runtime disabled.
- Provider blocked.

This posture is critical because the platform may eventually involve sensitive support interactions, safety decisions, backend-governed workflows, and provider-mediated intelligence.

## 5. clean_core Evolution Timeline

Across OS-2B through OS-9I, `clean_core` evolved from migration hardening into a full architecture governance program.

Major milestones:

- Legal consent foundation.
- AI governance placeholders.
- AI safety core skeleton.
- Crisis-safe support copy.
- Backend boundary contracts.
- Audit and observability foundations.
- Policy runtime contracts.
- Human review and escalation contracts.
- Runtime governance families.
- Extraction readiness and public API planning.
- Adapter boundary plans.
- Firebase/app-shell/test boundaries.
- Backend authority and signed operation blueprints.
- Final pre-extraction signoff.

## 6. Architecture Civilization Phases

The architecture can be understood as layered civilization:

1. Foundation contracts: legal, safety, backend boundaries, audit.
2. Governance contracts: policy, review, provider governance, runtime environment.
3. Runtime governance placeholders: activation, enablement, routing, rollback, release, bootstrap, observability, isolation.
4. Extraction governance: import audits, public API strategy, adapter strategy, app-owned boundaries.
5. Future operational governance: AI safety runtime blueprint, feedback intelligence, control room, backend authority.

## 7. Export & Extraction Readiness

Extraction has not been executed. However, the architecture is ready for manual extraction review.

Readiness materials include:

- Export contamination audit.
- Import graph audit.
- Boundary hardening.
- Public API candidate inventory.
- Exportable contract classification.
- App-owned dependency maps.
- Adapter blueprints.
- Test and emulator split plans.
- Firebase boundary plans.
- Routing/l10n/assets/generated-file boundary plans.
- Freeze checklists.
- Dry-run simulation.
- Final signoff.

## 8. Public API & Contract Strategy

The future package surface should be curated, not broad. No export-all barrels should be introduced.

Likely export-safe groups:

- Legal contracts.
- Safety contracts.
- Audit contracts.
- Policy contracts.
- Backend-boundary contracts.
- Review and escalation contracts after review.
- Provider governance contracts after semantic review.
- Runtime-disabled governance markers after stability review.

Excluded from first export:

- Flutter UI.
- Firebase runtime.
- Routing implementation.
- Generated files.
- Assets.
- Provider SDKs.
- Runtime execution.
- Networking.

## 9. Adapter Boundary Strategy

Adapters are the future boundary between `clean_core` and host/backend systems. `clean_core` may define adapter contracts, but implementations remain outside the package.

Adapter areas include:

- Firebase.
- Auth/session.
- Routing.
- Localization/text.
- Environment/config.
- Observability.
- Analytics.
- Provider bridge.
- Backend bridge.
- Deployment/release.
- Emulator/test harness.

Adapters preserve extraction safety by preventing runtime SDKs and app-owned systems from entering the core contract layer.

## 10. Backend Authority Model

Backend authority is central to the architecture. The client can submit intents, render state, and show fallback behavior, but it must not create trusted governance outcomes.

Backend-owned decisions include:

- Admin outcomes.
- Approval states.
- Payment/review/payout decisions.
- Escalation transitions.
- Moderation and safety verdicts.
- Provider governance state.
- Runtime activation state.
- Policy publication.
- Release/bootstrap approval.

## 11. AI Safety Governance

AI safety governance was prioritized because future AI support requires containment before generation.

The blueprint covers:

- Input safety filtering.
- Prompt injection detection.
- Risk classification.
- Confidence handling.
- Policy governor handoff.
- Response mode selection.
- Safe context building.
- Provider permission checks.
- Output validation.
- Fallback, escalation, review, and audit signals.

No AI runtime has been implemented.

## 12. Human Review & Escalation Governance

Human review exists because some decisions should not be automated. Sensitive cases, crisis markers, unsafe output, policy integrity failures, provider failures, and escalation loops require review-aware governance.

The future model includes:

- Review queues.
- Escalation routing.
- Sensitive-case handling.
- Audit-linked state transitions.
- Backend-governed review outcomes.
- Emergency freeze and override expectations.

No review runtime or queue system has been implemented.

## 13. Feedback Intelligence & Control Room

Feedback intelligence is designed as a permanent operational intelligence layer. It is not merely a pre-launch testing tool.

It should eventually support:

- UX/UI improvement.
- Content quality improvement.
- Accessibility improvement.
- Provider/service quality monitoring.
- Technical stability tracking.
- Business and operations insights.
- Marketing/design decision support.
- Department-specific review queues.
- Future control-room dashboards.

This remains a blueprint only.

## 14. Runtime Deferral Philosophy

Runtime was intentionally deferred because execution before governance would create avoidable risk.

Deferral protects:

- User safety.
- Sensitive data.
- Backend authority.
- Provider governance.
- Auditability.
- Rollback readiness.
- Extraction clarity.

Runtime activation must be a later, separately approved backend-governed phase.

## 15. Firebase & Backend Readiness

Firebase remains host/backend-owned. `clean_core` does not initialize Firebase, own project ids, deploy rules, or perform runtime Firestore/Auth/Functions/Storage operations.

`clean_core` owns:

- Authority models.
- Protected-field definitions.
- Adapter plans.
- Trusted operation contracts.
- Firestore governance expectations.

This prevents Firebase contamination before extraction.

## 16. Rollback / Reconnect Strategy

Rollback and reconnect are designed around staged extraction and temporary dual-link behavior.

Reconnect order:

1. Environment/config.
2. Auth/session.
3. Firebase access.
4. Backend bridge.
5. Provider bridge.
6. Routing/localization/asset intents.
7. Observability/analytics.
8. Release/deployment governance.

Rollback must preserve fail-closed behavior, backend authority, provider-blocked defaults, and host-owned implementations.

## 17. Security & Authority Principles

Key principles:

- Backend authority over client convenience.
- Security over convenience.
- Governance before execution.
- No privileged client writes.
- No hidden activation.
- No provider execution from clean_core.
- No client-side signed authority.
- Review and audit requirements must not be bypassed.

## 18. Privacy & Sensitive Data Principles

The architecture avoids unsafe long-term sensitive storage.

Forbidden or strongly restricted:

- Raw crisis content.
- Full raw conversations.
- Diagnosis labels.
- Medication details.
- Psychological profiling.
- Hidden personalization.
- Public exposure of sensitive feedback.

Preferred:

- Sanitized previews.
- Hashes and references.
- Audit links.
- Policy references.
- Session-scoped markers.
- Retention boundaries.

## 19. Operational Roadmap

Future operational systems may include:

- Control-room dashboards.
- Department review queues.
- Feedback intelligence.
- Provider quality workflows.
- Release-impact tracking.
- Safety observability.
- Audit review tools.
- Moderation visibility.

All operational systems require backend authority, privacy controls, and review boundaries.

## 20. Future Runtime Roadmap

A future runtime path should proceed through:

1. Policy governor.
2. Safety decision engine.
3. Runtime activation gateway.
4. Environment readiness.
5. Backend bridge.
6. Provider governance.
7. Audit/observability readiness.
8. Human review readiness.
9. Rollback/shutdown readiness.

## 21. Future AI Runtime Roadmap

AI runtime requires:

- Legal consent readiness.
- Policy snapshots.
- Safe context builder.
- Output validator.
- Prompt injection guard.
- Provider onboarding.
- Backend authority.
- Circuit breaker.
- Human review path.
- Observability and audit.

No provider integration is currently active.

## 22. Future Launch & Pilot Strategy

Future launch should be staged:

- Contract extraction first.
- Adapter boundary reconnect second.
- Emulator/security validation.
- Limited pilot.
- Feedback/control-room monitoring.
- Runtime dry-runs only after approval.
- Gradual activation only through backend-governed gates.

## 23. Risk Analysis

Key risks:

- Firebase leakage into export-safe contracts.
- Provider SDK leakage.
- Runtime activation before governance approval.
- Generated-file coupling.
- BuildContext contamination.
- Privileged client writes.
- Weakening fail-closed defaults.
- Exporting unstable internal markers.

Stop conditions have been documented across the extraction planning materials.

## 24. Remaining Deferred Areas

The following remain intentionally deferred:

- Runtime execution.
- Provider execution.
- Firebase runtime.
- Cloud Functions runtime.
- Networking.
- AI execution.
- Analytics/telemetry runtime.
- Deployment/release activation.
- Live escalation runtime.
- Chat AI.

## 25. Extraction Execution Readiness

Current status: ready for manual extraction review.

Not yet ready for automatic extraction.

Before extraction:

- Manual import scan.
- Export review.
- App-owned verification.
- Adapter-only verification.
- Runtime-deferral verification.
- Security/fail-closed review.
- Rollback checkpoint creation.

## 26. Final Strategic Assessment

`clean_core` is now a governed architecture kernel prepared for future extraction review. Its strongest strategic achievement is the separation of contracts and authority from runtime execution.

This is the correct direction for Mental Smile: a platform dealing with mental wellness support should not activate AI, providers, Firebase authority, or operational automation before governance, review, audit, rollback, and backend authority are mature.

The architecture is extraction-ready for manual review, governance-mature, and intentionally runtime-deferred.
