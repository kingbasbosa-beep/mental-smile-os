# FUTURE THEME SYSTEM

Target design contract for future room themes. No theme asset is created or activated by this document.

## Shared Theme Contract

Every theme is a registered concept under `FUTURE_CONCEPTS/theme_prototypes` until it has a card, complete asset family, accessibility review, and an active consumer. Graduation moves its personal scene assets to CLIENT_ROOM and shared primitives to ROOM_SYSTEM.

All themes must preserve:

- Identical control meaning and navigation order.
- Minimum contrast and readable focus states.
- Responsive desktop, tablet, and mobile composition.
- Reduced-motion behavior.
- RTL and LTR directionality.
- Stable TV, board, notebook, profile, exit, and navigation zones.
- No diagnostic, approval, assignment, booking, session, or ownership symbolism.

## Pharaonic Room

- Purpose: Offer an Egyptian heritage-inspired room without turning culture into decoration-only spectacle.
- Compatible Controls: Gold/stone treatments on canonical controls; silhouettes and labels remain unchanged.
- Compatible Board: Carved-panel visual frame with plain, readable tool slots.
- Compatible TV: Architectural frame with a neutral content viewport.
- Compatible Notebook: Papyrus-inspired cover with modern readable interaction states.
- Compatible Profile Screen: Framed identity panel using client-selected symbols only.
- Compatibility Rules: Avoid sacred/funerary misuse; maintain contrast; no hieroglyphs as unlabeled functional icons.

## Modern Room

- Purpose: Provide a clean contemporary environment with clear hierarchy.
- Compatible Controls: Canonical icons with restrained material treatments.
- Compatible Board: Modular grid with visible focus and selection states.
- Compatible TV: Edge-light display frame with neutral content presentation.
- Compatible Notebook: Digital notebook surface with tactile visual cues.
- Compatible Profile Screen: Clear identity and signal cards with moderate density.
- Compatibility Rules: No decorative controls that resemble unavailable actions; motion remains optional.

## Minimal Room

- Purpose: Reduce visual load and prioritize essential personal choices.
- Compatible Controls: High-clarity canonical icons with generous spacing.
- Compatible Board: Small set of visible slots; overflow remains discoverable.
- Compatible TV: Border-light content area with strong empty state.
- Compatible Notebook: Plain cover and distraction-free open state.
- Compatible Profile Screen: Essential identity and privacy-selected signals only.
- Compatibility Rules: Minimal does not mean low contrast or hidden navigation; all functions remain discoverable.

## Recovery Room

- Purpose: Support hope, continuity, and self-directed growth without clinical or deficit framing.
- Compatible Controls: Warm canonical controls without progress-pressure symbolism.
- Compatible Board: Tools grouped by client-chosen support and growth interests.
- Compatible TV: Hope, guidance, story, and resource presentation.
- Compatible Notebook: Reflection and aspiration prompts chosen by the client.
- Compatible Profile Screen: Strengths, aspirations, and support preferences.
- Compatibility Rules: No streak pressure, relapse labels, compliance meters, or treatment ownership imagery.

## Nature Room

- Purpose: Offer a calm nature-oriented setting.
- Compatible Controls: Canonical controls with restrained natural material skins.
- Compatible Board: Organic texture frame with geometrically stable slots.
- Compatible TV: Window-like frame that remains visibly a content surface.
- Compatible Notebook: Natural fiber or botanical cover treatment.
- Compatible Profile Screen: Calm framing with readable signal cards.
- Compatibility Rules: Nature imagery cannot reduce text contrast or obscure control boundaries; animation is optional and reducible.

## Accessibility Room

- Purpose: Make access preferences the primary visual design input.
- Compatible Controls: Large targets, strong focus, high contrast, text alternatives, switch/keyboard compatibility.
- Compatible Board: Adjustable density and linear navigation mode.
- Compatible TV: Captions-first, transcript-ready, reduced-motion content frame.
- Compatible Notebook: Large type, voice, visual, and simplified interaction modes.
- Compatible Profile Screen: Communication and accessibility preferences surfaced with privacy control.
- Compatibility Rules: This is a complete theme, not an overlay. It must support screen readers, RTL, zoom, contrast modes, and reduced motion.

## Theme Compatibility Matrix

| Theme | Canonical Controls | Tool Board | TV | Notebook | Profile Screen |
|---|---|---|---|---|---|
| Pharaonic | Required | Compatible | Compatible | Compatible | Compatible |
| Modern | Required | Compatible | Compatible | Compatible | Compatible |
| Minimal | Required | Reduced density | Compatible | Distraction-free | Essential signals |
| Recovery | Required | Hope/growth grouping | Hope/resources | Reflection | Strengths/aspirations |
| Nature | Required | Compatible | Compatible | Compatible | Compatible |
| Accessibility | Enhanced canonical | Adaptive | Captions/transcript | Multi-modal | Access preferences |

## Asset Family Requirements

Before activation, each theme must declare:

- `themeId` and sponsor registry.
- Desktop, tablet, and mobile Room Background.
- TV frame and empty state.
- Tool Board and Empty Tool Slot.
- Notebook closed/open/private states.
- Profile Monitor frame and privacy states.
- Exit Cup skin if used.
- Navigation recolor tokens or approved variants.
- Contrast, reduced-motion, RTL, and large-text evidence.
- Fallback to the default Client Room family.

## Theme Lifecycle

```text
CONCEPT
-> ACCESSIBILITY_REVIEW
-> COMPLETE_FAMILY
-> CLIENT_PREVIEW
-> REGISTERED_DORMANT
-> ACTIVE
-> RETIRED
```

A concept may sleep only after the complete family and fallback are known. Partial anonymous art does not qualify as a dormant theme.
