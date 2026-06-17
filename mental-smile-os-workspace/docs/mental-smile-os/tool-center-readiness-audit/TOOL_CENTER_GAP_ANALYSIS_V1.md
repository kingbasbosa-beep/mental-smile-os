# TOOL_CENTER_GAP_ANALYSIS_V1

## Critical Gaps

| Gap | Severity | Evidence | Impact |
| --- | --- | --- | --- |
| No Tool Center shell | HIGH | No dedicated `/tools` or app Tool Center route beyond `/s/city/tools` placeholder. | Users cannot browse or launch tools from a central place. |
| Client tools are private widget specs | HIGH | `_ToolSpec` is embedded inside `client_dashboard_page.dart`. | No reusable registry, no governance, no provider/center sharing. |
| Client cards do not launch tools | HIGH | `_ToolCard.onTap` calls `_showSoon`. | Working tools count for clients is 0. |
| No tool selection runtime | HIGH | `enabledToolKeys` is read, not actively managed from Tool Center UI. | Users cannot reliably add/remove/replace tools. |
| Tool signal emitters missing | HIGH | Monitoring registries define tool signals, but active emitters were not found. | Tool activity cannot feed monitoring or federation reliably. |
| Provider tool board missing | MEDIUM | Provider room runtime has no implemented tool board. | Provider tools remain constitutional/conceptual only. |
| Center tool board missing | MEDIUM | Center room runtime has no implemented tool board. | Center tools remain constitutional/conceptual only. |
| Library tools category is content-only | MEDIUM | Library category exists but does not launch tools. | Discovery is not connected to tool runtime. |
| Owner construction tools mixed with user tool concept | MEDIUM | Construction workbench has real internal tools. | Risk of confusing internal owner tools with public/user tools. |
| Legacy/source references inside Owner tools | LOW | `Mental Smile Core Source Repository` remains a configured construction reference. | Acceptable as source evidence, but not public Tool Center material. |

## Missing Critical Tools

This audit does not prescribe exact clinical/support tools, but the runtime lacks these critical Tool Center components:

- Tool Center route/shell.
- Runtime Tool Registry.
- Tool Card model shared across client/provider/center/library.
- Tool launch contract.
- Tool disabled/coming-soon state contract.
- Tool selection assignment flow.
- Tool open/request/save signal emitters.
- Tool monitoring event adapter.
- Provider Tool Board runtime.
- Center Tool Board runtime.

## Broken Routes

No broken tool route was proven, but `/s/city/tools` is a placeholder route, not a Tool Center.

## Dead Tools

No dead production tools were found because no production user tools exist yet.

## Placeholder Tools

- 8 client tool specs.
- 5 public City Tools labels in `/s/city/tools`.
- 7 Owner construction references/path-copy tools are partial/reference-only.

## Legacy Tool References

Legacy/source tool references exist mainly in documentation and the Owner Construction Workbench. They are not public client/provider/center tools.

## Readiness Score

22 / 100

Scoring basis:

- Route presence: 10 / 20
- Registry presence: 8 / 20
- Launch flow: 4 / 20
- User integration: 0 / 15
- Provider/Center integration: 0 / 10
- Signal/monitoring wiring: 0 / 10
- Safety boundaries: 5 / 5

