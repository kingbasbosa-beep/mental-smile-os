# TOOL_CENTER_EXECUTION_PLAN_V1

## Recommended Next Execution Wave

TOOL_CENTER_FOUNDATION_WAVE_1

## Objective

Create the minimum runtime foundation for a real Tool Center without creating complex tools yet.

## Wave 1 Scope

1. Create a runtime Tool Registry model.
2. Move current client `_ToolSpec` keys into registered tool definitions.
3. Add a Tool Center route and page shell.
4. Keep all unimplemented tools visibly disabled or coming soon.
5. Wire safe navigation for tools that already map to existing routes:
   - Library.
   - Saved destinations if route exists.
   - Provider discovery if route exists.
   - Center discovery if route exists.
6. Add a narrow tool launch adapter.
7. Add signal emission points for:
   - `tool_opened`
   - `tool_requested`
   - `tool_added`
   - `tool_removed`
8. Keep Provider and Center tool boards deferred.

## Non-Goals

- Do not create clinical tools.
- Do not create AI tools.
- Do not create recommendation logic.
- Do not create Firebase schema changes in the same wave.
- Do not mix Owner Construction Workbench tools with user Tool Center tools.

## Suggested Runtime Files

Proposed only, not created in this audit:

- `lib/features/tools/domain/tool_definition.dart`
- `lib/features/tools/domain/tool_registry.dart`
- `lib/features/tools/presentation/pages/tool_center_page.dart`
- `lib/features/tools/application/tool_launch_service.dart`
- `lib/features/tools/application/tool_signal_service.dart`

## Validation Targets

- `flutter analyze`
- Route smoke test for Tool Center.
- Client Dashboard tool card navigation smoke test.
- Signal event creation smoke test if signal service exists.

## Release Gate

Tool Center is not release-ready until at least these are true:

- Dedicated route exists.
- At least four user tools route to real existing surfaces.
- Tool cards do not all call `_showSoon`.
- Tool signals are emitted or explicitly deferred.
- Client Room/Client Dashboard can add/remove or at least open tools from `enabledToolKeys`.

