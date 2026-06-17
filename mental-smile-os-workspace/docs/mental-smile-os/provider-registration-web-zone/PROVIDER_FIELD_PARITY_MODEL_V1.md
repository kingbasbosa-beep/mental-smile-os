# Provider Field Parity Model V1

Status: ACTIVE_FIELD_PARITY_MODEL
Scope: Provider Registration Web Zone and Provider Public Web Zone
Prompt Asset: PROMPT_ASSET_041
Parent Prompt: PROMPT_ASSET_040

## 1. Field Parity Rule

Provider Registration fields and Provider Public Profile fields must remain mapped.

Every public display field must have a declared source field.

Every registration field must declare whether it is:

- PUBLIC_DISPLAY_FIELD.
- PRIVATE_REVIEW_FIELD.
- INTERNAL_STATUS_FIELD.
- DOCUMENT_FIELD.
- NOT_DISPLAYED.

## 2. Strict Parity Fields

| Registration Field | Public Profile Field | Display Status | Privacy Status | Review Status | Owner | Allowed Mutation Source |
| --- | --- | --- | --- | --- | --- | --- |
| professional_name | public_professional_name | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Provider Registration Web Zone | Provider Registration Web Zone approved package |
| specialization | public_specialization | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Provider Registration Web Zone | Provider Registration Web Zone approved package |
| service_description | public_service_description | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Provider Registration Web Zone | Provider Registration Web Zone approved package |
| service_type | public_service_type | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Provider Registration Web Zone | Provider Registration Web Zone approved package |
| session_service_format | public_session_service_format | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Provider Registration Web Zone | Provider Registration Web Zone approved package |
| prices_fees | public_prices_fees | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Provider Registration Web Zone | Provider Registration Web Zone approved package |
| provider_images | public_provider_images | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Provider Registration Web Zone | Provider Registration Web Zone approved package |
| contact_pathway | public_contact_pathway | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Provider Registration Web Zone | Provider Registration Web Zone approved package |
| location_online_availability | public_location_online_availability | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Provider Registration Web Zone | Provider Registration Web Zone approved package |
| credentials_licenses | public_trust_credentials | PRIVATE_REVIEW_FIELD / PUBLIC_DISPLAY_FIELD_AFTER_BADGE_APPROVAL | PRIVATE_UNTIL_BADGE_APPROVED | STRICT_REVIEW_REQUIRED | Provider Registration Web Zone | Provider Registration Web Zone approved trust package |
| public_trust_badges | public_trust_badges | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | STRICT_REVIEW_REQUIRED | Provider Public Web Zone consumes approved package | Approved trust package |
| languages | public_languages | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Provider Registration Web Zone | Provider Registration Web Zone approved package |
| accessibility_options | public_accessibility_options | PUBLIC_DISPLAY_FIELD | PUBLIC_AFTER_APPROVAL | REVIEW_REQUIRED | Provider Registration Web Zone | Provider Registration Web Zone approved package |

## 3. Rule

Provider Public Web Zone may display only fields mapped by this model and delivered through approved gateway/card package transfer.

