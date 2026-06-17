# Guide and Card Relationship Model V1

Status: ACTIVE_MEMORY_MODEL
Domain: Constitutional Memory Domain
Relationship: guide-to-card constitutional parentage

## 1. Purpose

Guide and Card Relationship Model defines how guides become constitutional parent objects for future cards.

## 2. Parentage Rule

```text
Guide
-> Creates Cards

Cards
-> Reference Parent Guide
```

A card cannot survive without parent guide lineage.

## 3. Guide Responsibilities

A parent guide must provide:

- Constitutional meaning boundary.
- Allowed card type or card family.
- Birth authority context.
- Registry relationship.
- Validation expectation.
- Supersession effect on dependent cards.

## 4. Card Responsibilities

A child card must preserve:

- Parent Guide.
- Parent guide lineage status.
- Card birth prompt.
- Card birth signal.
- Card birth authority.
- Card registry entry.
- Card validation status.

## 5. Relationship Status Values

| Status | Meaning |
| --- | --- |
| PARENT_LINK_ESTABLISHED | Card references a valid parent guide. |
| PARENT_GUIDE_SUPERSEDED | Parent guide was replaced and card must review lineage. |
| PARENT_GUIDE_RETIRED | Parent guide is inactive and card must be retired, replaced, or revalidated. |
| PARENT_LINK_BROKEN | Card references missing, invalid, or unvalidated guide lineage. |
| RELATIONSHIP_VALIDATED | Guide-card relationship passed memory validation. |

## 6. Survival Rule

If a parent guide is missing, unregistered, unvalidated, retired without replacement, or lineage-broken, dependent cards may not remain validated until relationship validation passes again.

## 7. Boundary

This model defines memory relationship integrity only. It does not create cards, guides, domains, or authorization authority.
