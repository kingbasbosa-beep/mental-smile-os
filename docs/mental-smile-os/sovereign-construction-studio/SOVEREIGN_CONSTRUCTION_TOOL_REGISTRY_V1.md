# Sovereign Construction Tool Registry V1

Status: ACTIVE_ROOM_REGISTRY
Room: Sovereign Construction Studio
Registry purpose: construction tool shortcut and boundary records
Runtime effect: none

## 1. Registry Boundary

This registry records approved sovereign construction tool references only. It does not create a Tool Center, Technical Operations, Maintenance Department, deployment authority, or runtime authority.

## 2. Tool Records

| Tool ID | Tool Name | Tool Purpose | Tool Owner | Allowed Use | Forbidden Use | Required Input | Expected Output | Related Room | Access Boundary | Shortcut / Reference Placeholder |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CONSTRUCTION_TOOL_CHATGPT_V1 | Owner / ChatGPT strategic architecture workspace | Shape constitutional architecture, prompts, strategy, and decision language. | Owner | Strategic architecture, prompt design, doctrine drafting, Owner review preparation. | Runtime execution, legal approval, technical deployment, replacing DNA/Owner authority. | Owner vision, approved context, constitutional memory records. | Architecture prompt, doctrine draft, review package, decision notes. | Owner Domain, Strategic Planning Room, Sovereign Construction Studio | Owner-controlled strategic workspace. | PLACEHOLDER_CHATGPT_WORKSPACE |
| CONSTRUCTION_TOOL_CODEX_V1 | Codex construction workspace | Edit project files and construct approved packages inside the local workspace. | Owner / Construction Steward | Implement approved package artifacts, docs, code changes when authorized, verification commands. | Acting without package approval, legal approval, maintenance authority, uncontrolled refactors. | Approved construction package, scope, files, acceptance checks. | Constructed artifact, diff, verification summary. | Sovereign Construction Studio | Workspace-bound construction agent. | PLACEHOLDER_CODEX_WORKSPACE |
| CONSTRUCTION_TOOL_ANDROID_STUDIO_V1 | Android Studio runtime verification workspace | Inspect, run, and verify app behavior locally when runtime verification is required. | Owner / Construction Steward | Local app verification, emulator/device review, build inspection. | Becoming Technical Operations, deployment ownership, maintenance monitoring. | Constructed app package, verification checklist. | Runtime verification findings and screenshots/logs if required. | Sovereign Construction Studio | Local verification workspace only. | PLACEHOLDER_ANDROID_STUDIO_WORKSPACE |
| CONSTRUCTION_TOOL_GITHUB_V1 | GitHub source control workspace | Preserve source control history, branches, reviews, and pull requests. | Owner | Branch, commit, pull request, review package when authorized. | Unapproved deployment, authority decisions, legal approval, runtime maintenance. | Approved diff, commit scope, review notes. | Branch, commit, pull request, source history. | Sovereign Construction Studio | Source control boundary. | PLACEHOLDER_GITHUB_REPOSITORY |
| CONSTRUCTION_TOOL_FIREBASE_V1 | Firebase console workspace | Inspect and later configure Firebase only under approved construction package. | Owner | Console inspection, rules/data review, controlled configuration when separately approved. | Changing Firebase in this step, creating runtime authority, legal approval, monitoring. | Approved Firebase package, rule/data change authorization. | Firebase configuration evidence or requested change report. | Sovereign Construction Studio | Console reference; no change authority in Step 004. | PLACEHOLDER_FIREBASE_CONSOLE |
| CONSTRUCTION_TOOL_GOOGLE_PLAY_CONSOLE_V1 | Google Play Console publishing workspace | Prepare future publishing boundary after build approval. | Owner | Publishing readiness reference, release checklist source, package metadata review when authorized. | Publishing without Owner approval, legal approval, technical operations. | Approved release package, Owner approval, compliance checklist. | Publishing readiness package or release submission evidence. | Sovereign Construction Studio | Publishing console reference only. | PLACEHOLDER_GOOGLE_PLAY_CONSOLE |
| CONSTRUCTION_TOOL_LOCAL_PROJECT_V1 | Local project workspace | Hold the active project files and generated construction artifacts. | Owner | Local file review, package construction, verification within workspace. | Unbounded edits, unrelated cleanup, runtime maintenance authority. | Approved construction package, target paths, acceptance checks. | Local artifacts, docs, code diffs when authorized. | Sovereign Construction Studio | Local workspace boundary. | `C:\mental_smile_workspace\app\mental-smile-app-clean2` |
| CONSTRUCTION_TOOL_MENTAL_SMILE_CORE_SOURCE_V1 | Mental Smile Core source repository reference | Provide source repository material for extraction, purification, reclassification, and rebuild. | Owner / DNA Vault Source Authority | Source lookup, inventory, extraction request, evidence reference. | Copying as-is, active OS authority, direct migration, runtime execution. | Source inventory request, classification need, extraction criteria. | Source candidate evidence and extraction notes. | DNA Vault, Strategic Planning Room, Sovereign Construction Studio | Source repository reference only. | PLACEHOLDER_MENTAL_SMILE_CORE_SOURCE |

## 3. Registration Signal

Every tool record emits:

```text
SC_SIGNAL_001 CONSTRUCTION_TOOL_REGISTERED
```

The signal records registration only. It does not grant technical operations authority.
