# Client Registration Source Classification V1

Status: SOURCE_CLASSIFICATION_COMPLETE
Screen: CLIENT_REGISTRATION_SCREEN
Prompt Asset: PROMPT_ASSET_022

## Classification

| Source / Concept | Classification | Reason |
| --- | --- | --- |
| Approved registration visual concept | USE_AFTER_PURIFICATION | Approved as visual source concept only. |
| Old Flutter client registration screen | REMOVE | Old code, old layout, Firebase, signals, extra fields, avatar, interests, and runtime behavior are not allowed. |
| Old fields: name, age, gender, avatar, interests, questions | REMOVE | Not in approved form model. |
| Old tool/recommendation/profile data concepts | REMOVE | Belong inside Client Room or later preferences, not registration. |
| Registration background | REBUILD_FROM_APPROVED_CONCEPT | Use approved visual concept, not old screen copy. |
| Form panel | REBUILD_FROM_APPROVED_CONCEPT | Must support only approved fields. |
| CTA `lets_go` | REBUILD_FROM_APPROVED_CONCEPT | Approved visible button language. |
| Language switch | REBUILD_FROM_APPROVED_CONCEPT | Documentation only, no runtime persistence. |
| Client Room feature cards | REBUILD_FROM_APPROVED_CONCEPT | Preview only, no Client Room build. |
