# TOOL_CENTER_INVENTORY_V1

## Runtime Routes

| Route | File | Status | Notes |
| --- | --- | --- | --- |
| `/s/city/tools` | `lib/app/router/routes.dart` / `lib/app/router/app_router.dart` | PLACEHOLDER | Uses `SWebSurfacePage` with static labels: Support Tools, Learning Tools, Family Tools, Provider Tools, Center Tools. |
| Client Dashboard tools area | `lib/features/client/presentation/pages/client_dashboard_page.dart` | PARTIAL | Displays six slots from `enabledToolKeys`; no real launch. |
| Owner construction workbench | `Routes.ownerConstructionWorkbench` | PARTIAL_INTERNAL | Displays construction tool registry; useful for Owner/build work, not public Tool Center. |

## Client Tool Specs

Source: `lib/features/client/presentation/pages/client_dashboard_page.dart`

| Key | Title | Status | Launch Flow |
| --- | --- | --- | --- |
| `library` | Content Resources | PLACEHOLDER | `_showSoon` |
| `saved_items` | Save Resources | PLACEHOLDER | `_showSoon` |
| `provider_finder` | Provider Discovery | PLACEHOLDER | `_showSoon` |
| `center_finder` | Center Discovery | PLACEHOLDER | `_showSoon` |
| `family_resources` | Family Resources | PLACEHOLDER | `_showSoon` |
| `recovery_resources` | Recovery Resources | PLACEHOLDER | `_showSoon` |
| `learning` | Learning | PLACEHOLDER | `_showSoon` |
| `support` | Support Tool | PLACEHOLDER | `_showSoon` |

Client display capacity is six visible slots. Unknown `enabledToolKeys` fall back to generic `_ToolSpec` display, also without real launch.

## Owner Construction Tool Registry

Source: `lib/features/sovereign_construction/domain/construction_tool_registry.dart`

| ID | Name | Type | Launch Type | Status | Working? |
| --- | --- | --- | --- | --- | --- |
| `CONSTRUCTION_TOOL_CHATGPT_V1` | ChatGPT Strategic Architecture Workspace | externalUrl | Open URL | CONFIGURED | YES |
| `CONSTRUCTION_TOOL_CODEX_V1` | Codex Construction Workspace | reference | Copy instruction | REFERENCE_ONLY | PARTIAL |
| `CONSTRUCTION_TOOL_ANDROID_STUDIO_V1` | Android Studio Runtime Verification | localPath | Copy path | LOCAL_PLACEHOLDER | PARTIAL |
| `CONSTRUCTION_TOOL_GITHUB_V1` | GitHub Source Control | externalUrl | Open URL | CONFIGURED | YES |
| `CONSTRUCTION_TOOL_FIREBASE_V1` | Firebase Console | externalUrl | Open URL | CONFIGURED | YES |
| `CONSTRUCTION_TOOL_GOOGLE_PLAY_CONSOLE_V1` | Google Play Console Publishing | externalUrl | Open URL | CONFIGURED | YES |
| `CONSTRUCTION_TOOL_LOCAL_PROJECT_V1` | Local Project Workspace | localPath | Copy path | CONFIGURED | PARTIAL |
| `CONSTRUCTION_TOOL_MENTAL_SMILE_CORE_SOURCE_V1` | Mental Smile Core Source Repository | localPath | Copy path | CONFIGURED | PARTIAL |
| `CURRENT_BUILD_PACKAGE_V1` | Current Build Package | localPath | Copy path | REFERENCE_ONLY | PARTIAL |
| `CURRENT_PROMPT_MEMORY_REGISTRY_V1` | Current Prompt Memory Registry | localPath | Copy path | REFERENCE_ONLY | PARTIAL |

Note: command output counted 11 constructor occurrences because the class constructor itself is named `ConstructionToolEntry`. Registry entries are 10 active list items.

## Signals And Monitoring

| Area | File | Status |
| --- | --- | --- |
| Client signals model | `lib/features/signals/domain/models/client_signals.dart` | Stores `enabledTools`; no launch event. |
| Residential monitoring | `lib/features/monitoring/residential/domain/residential_monitoring_registry.dart` | Defines `tool_added`, `tool_removed`, `tool_opened`. |
| Commercial monitoring | `lib/features/monitoring/commercial/registry/commercial_monitoring_registry.dart` | Defines `tool_opened`, `tool_saved`, `tool_requested`, `tool_added`, `tool_removed`, `tool_replaced`, `tool_requested_without_availability`. |

## Provider Integration

No active provider tool board or provider tool launch implementation was found.

Provider room currently focuses on room actions such as chat inbox, support request, and profile edit.

## Center Integration

No active center tool board or center tool launch implementation was found.

Center room currently focuses on profile/data/media/pricing/document update workflows.

## Library Integration

Library has a `tools` category and tool metadata, but it is content/category level, not a working Tool Center.

