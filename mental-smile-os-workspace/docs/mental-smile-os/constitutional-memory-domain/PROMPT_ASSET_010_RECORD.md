# Prompt Asset 010 Record

Prompt ID: PROMPT_ASSET_010
Prompt Name: Mental Smile OS Workspace Separation
Prompt Type: FOUNDATIONAL_SEPARATION_PROMPT
Prompt Version: V1
Creation Date: 2026-06-13
Status: VALIDATED
Strategic Value: Separates the active Mental Smile OS workspace foundation from Mental Smile Core / clean2, which remains source repository only.
Lineage Status: LINEAGE_ESTABLISHED

## 1. Parent Prompt

- PROMPT_ASSET_009 Client Room Visual System Extraction

## 2. Generated Outputs

- New OS workspace foundation.
- Source repository link.
- Workbench placeholder.
- Tool shortcut placeholders.
- Separation report.

## 3. New Workspace Path

```text
C:/mental_smile_workspace/app/mental-smile-app-clean2/mental-smile-os-workspace
```

## 4. Fallback Reason

The preferred sibling path was:

```text
C:/mental_smile_workspace/app/mental-smile-os
```

Current filesystem permissions allow writing inside:

```text
C:/mental_smile_workspace/app/mental-smile-app-clean2
```

Therefore the workspace was created as:

```text
C:/mental_smile_workspace/app/mental-smile-app-clean2/mental-smile-os-workspace
```

## 5. Generated Structure

- `docs/`
- `docs/mental-smile-os/`
- `app/`
- `app/owner/`
- `app/owner/construction-workbench/`
- `source-repository-links/`
- `tool-shortcuts/`
- `memory/`
- `build-packages/`
- `_runtime-placeholder/`

## 6. Memory Signals

Signal ID: MEMORY_SIGNAL_001
Signal name: LINEAGE_ESTABLISHED
Memory ID: PROMPT_ASSET_010
Trigger condition: Prompt record includes parent prompt, generated workspace, source link, workbench placeholder, tool shortcuts, separation report, status, and lineage status.
Continuity finding: Prompt lineage is complete.
Related DNA signal: None. Workspace separation only.
Action boundary: Preserve lineage only.

Signal ID: MEMORY_SIGNAL_005
Signal name: MEMORY_VALIDATED
Memory ID: PROMPT_ASSET_010
Trigger condition: Prompt asset passed custody, registry, lineage, and separation checks.
Continuity finding: Prompt memory is validated.
Related DNA signal: None. Workspace separation only.
Action boundary: Validation only; no runtime authority.
