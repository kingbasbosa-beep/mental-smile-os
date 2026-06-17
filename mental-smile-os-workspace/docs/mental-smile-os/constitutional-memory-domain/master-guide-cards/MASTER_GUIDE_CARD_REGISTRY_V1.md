# Master Guide Card Registry V1

Status: ACTIVE_MEMORY_REGISTRY
Domain: Constitutional Memory Domain
Memory area: master-guide-cards

## 1. Purpose

Master Guide Card Registry prepares the place where purified cards will be organized before they enter the Master Guide.

No old cards may be copied directly.

## 2. Entry Rule

Every card must enter through:

```text
Extract
-> Purify
-> Reclassify
-> Rebuild
-> Register
```

## 3. Required Registry Fields

| Field | Requirement |
| --- | --- |
| Card ID | Stable card identifier. |
| Card Name | Card name. |
| Parent Guide | Guide reference. |
| Source Candidate | Source evidence reference, if any. |
| Rebuild Prompt | Prompt used to rebuild the card. |
| Classification | Rebuilt card class. |
| Registry Status | Registry state. |
| Lineage Status | Lineage state. |
| Validation Status | Validation state. |

## 4. Boundary

This registry does not import old cards. It prepares future purified card placement.

## 5. Registered Master Guide Candidate Cards

| Card ID | Card Name | Parent Guide | Source Candidate | Rebuild Prompt | Classification | Registry Status | Lineage Status | Validation Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| SPLASH_BACKGROUND_MOBILE_CARD | Splash Mobile Background Card | APP_SPLASH_GUIDE_V1 | assets/branding/splash/splash_mobile_v1.jpg | RP-SPLASH-BACKGROUND-MOBILE | USE_AFTER_PURIFICATION | REGISTERED_NOT_RUNTIME_READY | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| SPLASH_BACKGROUND_TABLET_CARD | Splash Tablet Background Card | APP_SPLASH_GUIDE_V1 | assets/branding/splash/splash_tablet_v1.jpg | RP-SPLASH-BACKGROUND-TABLET | USE_AFTER_PURIFICATION | REGISTERED_NOT_RUNTIME_READY | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| SPLASH_BACKGROUND_DESKTOP_CARD | Splash Desktop Background Card | APP_SPLASH_GUIDE_V1 | assets/branding/splash/splash_web_v1.jpg | RP-SPLASH-BACKGROUND-DESKTOP | USE_AFTER_PURIFICATION | REGISTERED_NOT_RUNTIME_READY | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| SPLASH_LANGUAGE_BUTTON_CARD | Splash Language Button Card | APP_SPLASH_GUIDE_V1 | assets/branding/language/en_gold.png | RP-SPLASH-LANGUAGE-BUTTON | USE_AFTER_PURIFICATION | REGISTERED_NOT_RUNTIME_READY | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
