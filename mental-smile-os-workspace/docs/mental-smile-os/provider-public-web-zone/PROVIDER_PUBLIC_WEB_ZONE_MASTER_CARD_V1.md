# Provider Public Web Zone Master Card V1

Card ID: PROVIDER_PUBLIC_WEB_ZONE_MASTER_CARD_V1
Card Type: ZONE_MASTER_CARD
Zone ID: PROVIDER_PUBLIC_WEB_ZONE
Zone Name: Provider Public Web Zone
Classification: WEB_ZONE
Status: READY
Independent: YES
Federation Compatible: YES
Primary Gateway: PROVIDER_PUBLIC_WEB_ZONE_GATEWAY
Prompt Asset: PROMPT_ASSET_040
Package Closure Prompt: PROMPT_ASSET_043
Field Parity Prompt: PROMPT_ASSET_041
Lineage Status: LINEAGE_ESTABLISHED
Validation Status: MEMORY_VALIDATED

## Zone Purpose

- Provider discovery.
- Provider public profiles.
- Provider service visibility.
- Provider contact pathways.
- Provider trust display.

## May Consume Only

- Approved Provider Public Profile.
- Approved Trust Badge.
- Approved Contact Pathway.
- Approved Public Resource.

## May Not

- Read private registration documents.
- Mutate provider registration.
- Collect registration data.
- Own onboarding records.

## Field Parity Rule

Every public display field must have a declared source field in PROVIDER_FIELD_PARITY_MODEL_V1.

Provider Public Web Zone may consume only approved public display fields, approved trust badges, approved contact pathways, and approved public resources.

## No Dead Placeholder Rule

No deprecated public profile field, duplicate field path, old UI placeholder, or temporary field without expiry may remain active.

## Package Closure

Closed by PROVIDER_PUBLIC_WEB_ZONE_PACKAGE_MASTER_CARD_V1.

ZONE_SIGNAL_001 ZONE_READY emitted.
