# YAML Risk Assessment V1

Status: YAML_RISK_ASSESSMENT_CREATED
Prompt Asset: PROMPT_ASSET_054

## Risks

| Risk | Description | Severity | Guardrail |
| --- | --- | --- | --- |
| Legacy Asset Path Risk | Old paths could become active runtime references. | HIGH | OS rename and registration required. |
| Dead Placeholder Risk | Unused placeholders could remain in YAML. | HIGH | No dead placeholder rule. |
| Duplicate Asset Risk | Old and new paths could both remain active. | HIGH | Keep registered OS path only. |
| Ownership Risk | Asset may lack owner or rights evidence. | HIGH | Ownership card required. |
| Localization Risk | Undefined or legacy keys could enter runtime. | MEDIUM | Localization card required. |
| Font Risk | Unknown font entries may introduce licensing or path issues. | MEDIUM | Font ownership and license status required. |
| Theme Risk | Old theme placeholders could contaminate pure runtime. | MEDIUM | Theme boundary verification required. |
| Clinical Language Risk | Localization may include claims or diagnosis terms. | HIGH | Forbidden language rules. |

## Stop Rule

YAML implementation pauses if asset ownership, localization ownership, font authority, or theme status is unknown.

