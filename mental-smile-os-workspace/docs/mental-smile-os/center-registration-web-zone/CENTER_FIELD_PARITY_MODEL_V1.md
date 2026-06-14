# Center Field Parity Model V1

Status: ACTIVE_FIELD_PARITY_MODEL
Scope: Center Registration Web Zone and Center Public Web Zone
Prompt Asset: PROMPT_ASSET_042

## Field Parity Rule

Every public field must have a source field.

Every registration field must be classified as PUBLIC_DISPLAY_FIELD, PRIVATE_REVIEW_FIELD, INTERNAL_STATUS_FIELD, DOCUMENT_FIELD, or NOT_DISPLAYED.

## Field Map

| Registration Field | Public Field | Classification | Privacy Status | Review Status | Owner | Allowed Mutation Source |
| --- | --- | --- | --- | --- | --- | --- |
| center_name | public_center_name | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Center Registration Web Zone | Approved public package |
| center_service_declaration | public_center_services | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Center Registration Web Zone | Approved public package |
| center_description | public_center_description | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Center Registration Web Zone | Approved public package |
| center_location_online_availability | public_center_location_online_availability | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Center Registration Web Zone | Approved public package |
| center_contact_pathway | public_center_contact_pathway | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Center Registration Web Zone | Approved contact package |
| center_images | public_center_images | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Center Registration Web Zone | Approved public package |
| center_documents | none | DOCUMENT_FIELD | PRIVATE | STRICT_REVIEW_REQUIRED | Center Registration Web Zone | Not displayed |
| partnership_request | none | PRIVATE_REVIEW_FIELD | PRIVATE | REVIEW_REQUIRED | Center Registration Web Zone | Not displayed |
| contract_preparation | none | PRIVATE_REVIEW_FIELD | PRIVATE | STRICT_REVIEW_REQUIRED | Center Registration Web Zone | Not displayed |
| center_status | none | INTERNAL_STATUS_FIELD | PRIVATE | INTERNAL | Center Registration Web Zone | Not displayed |
| center_trust_materials | public_center_trust_display | PRIVATE_REVIEW_FIELD / PUBLIC_DISPLAY_FIELD_AFTER_APPROVAL | PRIVATE_UNTIL_APPROVED | STRICT_REVIEW_REQUIRED | Center Registration Web Zone | Approved trust package |

