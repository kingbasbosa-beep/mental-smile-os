# clean_core Pubspec Risk Assessment

This assessment covers risks related to first pubspec creation, local path dependency, package imports, and scoped reconnect.

## Key Risks

| Risk | Severity | Mitigation |
| --- | --- | --- |
| Premature package activation | High | Create pubspec only in a dedicated approved phase. |
| Broad import rewrites | High | Migrate one contract group at a time. |
| Runtime leakage | High | Keep package dependencies empty and pure Dart. |
| Provider leakage | High | Block provider SDKs and provider execution. |
| Firebase leakage | High | Keep Firebase host-owned and adapter-only later. |
| Accidental authority exposure | High | Keep guards/policies/locks/resolvers hidden until review. |
| Package misuse | Medium | Use explicit docs, private publish posture, and narrow exports. |
| Semantic misunderstanding | Medium | Avoid names or docs implying active runtime authority. |
| Host compile instability | Medium | Use checkpoints and rollback after each scoped migration. |

## Dependency Risk Controls

- No Firebase dependencies.
- No Flutter dependencies.
- No networking dependencies.
- No analytics/telemetry dependencies.
- No file/print/share platform dependencies.
- No provider SDK dependencies.

## Export Risk Controls

- Root barrel remains file-by-file.
- No wildcard exports.
- No directory-wide exports.
- Hidden authority-sensitive surfaces remain unexported.
- Future barrel changes require semantic review.

## Reconnect Risk Controls

- Path dependency first, import migration second.
- Tests before broad app usage.
- Adapter contracts before adapter implementation.
- Runtime bridge review before runtime bridge creation.

## Final Risk Verdict

The first pubspec is low risk only if it remains minimal, private, pure Dart, and dependency-free. The main risk is not the pubspec itself; it is accidental reconnect expansion after the package becomes importable.
