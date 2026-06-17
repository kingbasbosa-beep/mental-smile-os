# Workspace Risk Matrix V1

Status: RISK_MATRIX_CREATED
Prompt Asset: PROMPT_ASSET_050

## Purpose

Identify major workspace purification risks before any destructive or migratory operation.

## Risk Matrix

| Risk Type | Description | Severity | Required Guardrail |
| --- | --- | --- | --- |
| Deletion Risk | Active OS docs could be deleted with old source material. | HIGH | No deletion before classification. |
| Archive Risk | Active source-of-truth docs could be moved to archive by mistake. | HIGH | No archive movement before verification. |
| Dependency Risk | Active OS may still depend on host repository paths. | HIGH | Dependency report before runtime migration. |
| Configuration Risk | YAML or Firebase configs may include legacy authority. | HIGH | Purification phases required. |
| Unknown Asset Risk | Old assets may lack ownership or OS names. | MEDIUM | Asset ownership verification required. |
| Unknown Runtime Risk | Old runtime routes may be mistaken for active OS runtime. | HIGH | Target runtime declaration required. |
| Documentation Drift Risk | Showcase, snapshot, and registries may diverge. | MEDIUM | Snapshot patch reports required. |
| Legacy Copy Risk | Useful source artifacts may be copied directly. | HIGH | Extract -> Purify -> Reclassify -> Rebuild -> Register. |

## Risk Response

Purification must pause if a risk cannot be classified.

No unknown item may be deleted, moved, migrated, or activated.

