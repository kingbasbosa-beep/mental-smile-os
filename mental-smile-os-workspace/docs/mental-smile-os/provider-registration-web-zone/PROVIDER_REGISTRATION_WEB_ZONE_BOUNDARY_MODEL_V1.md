# Provider Registration Web Zone Boundary Model V1

Status: ACTIVE_BOUNDARY_MODEL
Zone ID: PROVIDER_REGISTRATION_WEB_ZONE
Prompt Asset: PROMPT_ASSET_040
Field Parity Prompt: PROMPT_ASSET_041

## Does

- Handles provider onboarding constitutionally.
- Owns provider candidate and draft records conceptually.
- Owns registration documents conceptually.
- Prepares review packages.

## Does Not

- Display public providers.
- Control public ranking.
- Publish public profile directly.
- Mutate Provider Public Web Zone.
- Expose private documents to public zone.

## Transfer Rule

All transfer must pass through gateways and approved card packages.

## Field Boundary

Registration fields must be classified as PUBLIC_DISPLAY_FIELD, PRIVATE_REVIEW_FIELD, INTERNAL_STATUS_FIELD, DOCUMENT_FIELD, or NOT_DISPLAYED.

Deprecated or unmapped fields must be removed, replaced, or archived as source evidence outside the active zone.
