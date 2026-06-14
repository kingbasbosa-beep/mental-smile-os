# Construction Workbench Runtime Surface V1

Status: ACTIVE_RUNTIME_SURFACE
Route: `/owner/os/construction-workbench`
Protection: existing owner-only route guard
Runtime effect: Owner-facing navigation and reference surface only

## 1. Purpose

Sovereign Construction Workbench is the first practical runtime surface that allows Owner to work from inside Mental Smile OS.

It exposes sovereign construction tool shortcuts and references without storing credentials, secrets, private keys, or deployment authority.

## 2. Generated Runtime Files

| File | Purpose |
| --- | --- |
| `lib/features/sovereign_construction/domain/construction_tool_registry.dart` | Constant registry config for workbench entries. |
| `lib/features/sovereign_construction/presentation/pages/sovereign_construction_workbench_page.dart` | Owner-facing workbench UI. |
| `lib/app/router/routes.dart` | Adds `/owner/os/construction-workbench`. |
| `lib/app/router/app_router.dart` | Protects and serves the workbench through existing owner route guard. |
| `lib/features/s_owner/presentation/pages/s_owner_district_page.dart` | Adds Owner navigation entry. |

## 3. Workbench Entries

The workbench shows:

- ChatGPT Strategic Architecture Workspace.
- Codex Construction Workspace.
- Android Studio Runtime Verification.
- GitHub Source Control.
- Firebase Console.
- Google Play Console.
- Local Project Workspace.
- Mental Smile Core Source Repository.
- Current Build Package.
- Current Prompt Memory Registry.

## 4. Shortcut Behavior

External URL entries open through `url_launcher` when a configured URL exists.

Local path and reference entries copy the path or instruction to the clipboard. Direct local application launch is not attempted from the app.

## 5. Safety Boundary

- No hardcoded secrets.
- No stored credentials.
- No private keys.
- No Firebase rule changes.
- No Residential Domain creation.
- No Technical Operations creation.
- No Legal Department creation.
- No deployment.

## 6. Owner Protection

The route is included in the existing owner-only route set.

UI note:

```text
TODO: Replace with Owner claim after authority implementation.
```

The current implementation uses the existing safe Owner route guard and should be replaced with the final Owner claim model when authority implementation is complete.
