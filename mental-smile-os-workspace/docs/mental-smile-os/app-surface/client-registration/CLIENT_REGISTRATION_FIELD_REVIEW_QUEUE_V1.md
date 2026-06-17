# Client Registration Field Review Queue V1

Status: REVIEW_QUEUE_READY
Prompt Asset: PROMPT_ASSET_021

## 1. Purpose

Queue client registration fields for Owner review before final field selection.

## 2. Keep Candidates

| Field / Concept | Reason | Review Question |
| --- | --- | --- |
| Email | Required for current auth account creation. | Keep email as registration credential? |
| Password | Required for current auth account creation. | Keep password auth or future auth method? |
| Confirm Password | Prevents credential mismatch. | Keep if password auth remains. |
| Accessibility preferences | User-choice support preferences. | Registration or later preferences? |
| Communication preferences | Non-clinical communication preferences. | Registration or later preferences? |
| Keep support preferences private | Privacy-positive default. | Keep as default true? |
| Use preferences for recommendations | Consent-based preference use. | Keep at registration or later? |
| Signal schema version | Internal versioning. | Keep as internal metadata? |
| Created / updated timestamps | Standard metadata. | Keep with privacy notice? |

## 3. Change Language Candidates

| Field / Label | Reason | Owner Review Question |
| --- | --- | --- |
| Name / الاسم | Should support chosen name. | Rename to preferred name? |
| Create client account | "Client" term may need OS language. | Use "Create my space" or similar? |
| Avatar options | Current options include role/gender-coded images. | Replace with neutral avatar set? |
| Need specialist / Need center | May imply routing or urgency. | Replace with "Explore providers/centers"? |
| Addiction | Sensitive label. | Move to later interests with softer wording? |
| Special needs | Dignity language concern. | Replace with accessibility/support language? |
| Speech/hearing support | Sensitive access needs. | Keep under accessibility only? |
| Family guidance | Advisory tone. | Replace with family support? |

## 4. Remove Candidates

| Field / Action | Reason | Owner Review Question |
| --- | --- | --- |
| Logout icon on registration page | Not a registration field; legacy session behavior. | Remove from future registration screen? |
| Old route to client dashboard after submit | Runtime behavior, not field requirement. | Future target should be OS topology decision. |
| Old Firebase role shortcuts | Not in client registration field set. | Exclude from OS registration package? |

## 5. Unknown Needs Owner Review

| Field / Concept | Reason | Review Question |
| --- | --- | --- |
| Goal signals at registration | Useful but may be too much too early. | Capture now or after entry? |
| Interest signals at registration | Sensitive and broad. | Move to client preferences? |
| Role field | System metadata tied to authority model. | Keep in future runtime model? |
| Visual background | Source asset only. | Rebuild or purify later? |

## 6. Stop Rule

This queue does not approve, remove, or finalize any field. Owner review comes next.
