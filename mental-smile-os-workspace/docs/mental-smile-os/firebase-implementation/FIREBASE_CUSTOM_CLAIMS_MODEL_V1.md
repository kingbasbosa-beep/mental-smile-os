# Firebase Custom Claims Model V1

Status: CLAIMS_MODEL_CREATED
Prompt Asset: PROMPT_ASSET_053

## Purpose

Define Generation 1 Firebase custom claim families conceptually.

No custom claims are set by this document.

## Approved Claims

| Claim | Purpose | Boundary |
| --- | --- | --- |
| owner | Owner constitutional authority paths. | Audited authority only. |
| provider | Provider actor identity. | Does not grant private registration document access without zone authority. |
| center | Center actor identity. | Does not grant direct public publishing. |
| client | Client app identity. | App zone only. |
| monitoring | Monitoring observer identity. | Observe/report only. |
| archive | Smart Archive identity. | Store/retrieve/archive only. |
| strategic | Strategic Intelligence identity. | Analyze/recommend only. |

## Forbidden Claims

- admin.
- super_admin.
- god_mode.
- root.
- hidden_owner.
- wildcard_admin.

## Claim Rule

Claims identify actor class.

Claims do not bypass zone authority, gateway routing, registry lifecycle, or archive policy.

