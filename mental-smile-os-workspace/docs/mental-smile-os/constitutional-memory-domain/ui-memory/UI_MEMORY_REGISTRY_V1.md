# UI Memory Registry V1

Status: ACTIVE_MEMORY_REGISTRY
Domain: Constitutional Memory Domain
Memory area: ui-memory

## 1. Purpose

UI Memory Registry tracks purified UI assets after future extraction, purification, reclassification, rebuild, and registration.

It is prepared to track backgrounds, buttons, cards, icons, room visuals, dashboard visuals, and UI components.

## 2. Boundary

This registry does not migrate assets, copy source files, create UI runtime, or approve visual ownership.

No source asset may enter by copy/paste.

## 3. Required UI Asset Record Fields

| Field | Requirement |
| --- | --- |
| Asset ID | Stable identifier for the UI memory asset. |
| Asset Name | Human-readable asset name. |
| Asset Type | Background, button, card, icon, room visual, dashboard visual, component, or other approved type. |
| Source Candidate | Source repository candidate reference, if any. |
| Visual Purpose | Constitutional reason the asset exists. |
| Related Room | Room connected to the asset. |
| Related Domain | Domain connected to the asset. |
| Recreation Prompt | Prompt used or prepared to recreate the asset. |
| Usage Rules | Allowed and forbidden usage rules. |
| Ownership Status | Ownership or rights status. |
| Lineage Status | Lineage completeness state. |
| Validation Status | Memory validation state. |

## 4. Global Import Rule

```text
Extract -> Purify -> Reclassify -> Rebuild -> Register
```

## 5. Registered UI Assets

| Asset ID | Asset Name | Asset Type | Source Candidate | Visual Purpose | Related Room | Related Domain | Recreation Prompt | Usage Rules | Ownership Status | Lineage Status | Validation Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CLIENT_ROOM_BACKGROUND | Client Room Background | Background family | SRC-CLIENT-ROOM-001 | Establish calm responsive Client Room spatial identity. | Future Client Room | Future Residential Domain | RP-CLIENT-ROOM-BACKGROUND | Use as purified identity frame only; do not encode diagnosis, booking, or case states. | OWNERSHIP-CLIENT-ROOM-BACKGROUND | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| CLIENT_TOOL_BOARD | Client Tool Board | Room component | SRC-CLIENT-ROOM-002 | Hold client-chosen tools without prescription language. | Future Client Room | Future Residential Domain | RP-CLIENT-TOOL-BOARD | Use for chosen tools and recommendations only; no clinical command semantics. | OWNERSHIP-CLIENT-TOOL-BOARD | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| CLIENT_TV_PANEL | Client TV Panel | Room component | SRC-CLIENT-ROOM-003 | Present selected content, guidance, stories, and recommendations. | Future Client Room | Future Residential Domain | RP-CLIENT-TV-PANEL | Use as content display area only; content ownership remains separate. | OWNERSHIP-CLIENT-TV-PANEL | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| CLIENT_NOTE_WIDGET | Client Motivational Note Widget | Room component | SRC-CLIENT-ROOM-004 | Provide calm reflective note and encouragement zone. | Future Client Room | Future Residential Domain | RP-CLIENT-NOTE-WIDGET | Use for non-clinical self-expression and gentle motivation only. | OWNERSHIP-CLIENT-NOTE-WIDGET | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| CLIENT_EXIT_CUP | Client Exit Cup | Navigation control | SRC-CLIENT-ROOM-005 | Provide calm recognizable exit control. | Future Client Room | Future Residential Domain | RP-CLIENT-EXIT-CUP | Use as navigation only; no behavioral signal meaning. | OWNERSHIP-CLIENT-EXIT-CUP | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| CLIENT_ROOM_LAYOUT | Client Room Layout | Layout contract | SRC-CLIENT-ROOM-006 | Define spatial relationship between background, tools, TV, note, and exit control. | Future Client Room | Future Residential Domain | RP-CLIENT-ROOM-LAYOUT | Use as layout memory only; no runtime implementation in this step. | OWNERSHIP-CLIENT-ROOM-LAYOUT | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| SPLASH_BACKGROUND_MOBILE | Splash Mobile Background | Splash background image | assets/branding/splash/splash_mobile_v1.jpg | Mobile splash visual source for future App Surface Splash. | Splash | App Surface | RP-SPLASH-BACKGROUND-MOBILE | USE_AFTER_PURIFICATION only; not runtime-ready and not direct import. | OWNERSHIP_SPLASH_BACKGROUND_MOBILE | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| SPLASH_BACKGROUND_TABLET | Splash Tablet Background | Splash background image | assets/branding/splash/splash_tablet_v1.jpg | Tablet splash visual source for future App Surface Splash. | Splash | App Surface | RP-SPLASH-BACKGROUND-TABLET | USE_AFTER_PURIFICATION only; not runtime-ready and not direct import. | OWNERSHIP_SPLASH_BACKGROUND_TABLET | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| SPLASH_BACKGROUND_DESKTOP | Splash Desktop Background | Splash background image | assets/branding/splash/splash_web_v1.jpg | Desktop splash visual source for future App Surface Splash. | Splash | App Surface | RP-SPLASH-BACKGROUND-DESKTOP | USE_AFTER_PURIFICATION only; not runtime-ready and not direct import. | OWNERSHIP_SPLASH_BACKGROUND_DESKTOP | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| SPLASH_LANGUAGE_BUTTON | Splash Language Toggle Button | Language toggle UI element | assets/branding/language/en_gold.png | Arabic / English language selector source for future App Surface Splash. | Splash | App Surface | RP-SPLASH-LANGUAGE-BUTTON | USE_AFTER_PURIFICATION only; no runtime persistence or identity behavior. | OWNERSHIP_SPLASH_LANGUAGE_BUTTON | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
