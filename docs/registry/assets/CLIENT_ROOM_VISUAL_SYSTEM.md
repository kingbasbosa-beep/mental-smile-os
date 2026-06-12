# CLIENT ROOM VISUAL SYSTEM

Constitutional definition for the future Client Room. This is a target contract only.

## Visual Doctrine

The Client Room expresses chosen identity, aspirations, hope, belonging, support preferences, tools, and journey signals. It does not visualize diagnosis, deficiency, booking, sessions, approval, assignment, or case ownership.

Shared controls are owned by ROOM_SYSTEM or ICONS_SYSTEM. Personal scene assets are owned by CLIENT_ROOM.

## Room Background

- Purpose: Establish the room identity and responsive spatial frame.
- Owner: CLIENT_ROOM.
- Signals: chosen theme, comfort preference, accessibility contrast, reduced motion, visual density.
- Asset Dependencies: responsive background family; optional overlay owned by the selected theme.
- Future Variants: default, pharaonic, modern, minimal, recovery, nature, accessibility.

## TV Screen

- Purpose: Present selected content, resources, stories, and signal-attracted recommendations.
- Owner: ROOM_SYSTEM for the frame; content image owner remains CITY_SYSTEM, PROVIDER_ROOM, CENTER_ROOM, or the relevant resource registry.
- Signals: discovery interests, hope signals, learning interests, content format preference.
- Asset Dependencies: neutral screen frame, loading visual, empty-state visual, content thumbnail.
- Future Variants: video, audio, article, story, guidance, high-contrast.

## Tool Board

- Purpose: Hold client-chosen tools and magnet recommendations without implying prescriptions.
- Owner: ROOM_SYSTEM for the board; each tool visual belongs to its tool owner.
- Signals: support style, growth goals, communication preference, accessibility needs.
- Asset Dependencies: board surface, slot states, drag/focus states, tool cards.
- Future Variants: compact, expanded, touch-first, keyboard-first, high-contrast.

## Notebook

- Purpose: Provide a private self-expression and reflection entry point.
- Owner: CLIENT_ROOM.
- Signals: preferred expression mode, reflection interests, privacy preference.
- Asset Dependencies: notebook cover, open state, private/locked state, empty state.
- Future Variants: text, voice, visual, guided prompt, accessible large-type.

## Profile Monitor

- Purpose: Display client-selected identity and journey signals.
- Owner: CLIENT_ROOM.
- Signals: desired identity, aspirations, strengths, belonging, communication preference, privacy visibility.
- Asset Dependencies: monitor frame, avatar/identity visual, privacy state, signal card visuals.
- Future Variants: private, selected sharing, high-contrast, low-stimulation.

## Exit Cup

- Purpose: Provide a calm, recognizable exit or room-leaving control.
- Owner: CLIENT_ROOM if the cup remains unique; otherwise ROOM_SYSTEM if adopted across rooms.
- Signals: none. This is a navigation control, not a behavioral signal.
- Asset Dependencies: idle, hover/focus, pressed, disabled, and accessible-label contract.
- Future Variants: theme-compatible skins preserving the same silhouette and control behavior.

## Navigation Arrows

- Purpose: Navigate room views and return paths.
- Owner: ICONS_SYSTEM.
- Signals: reading direction and accessibility settings only.
- Asset Dependencies: left/right canonical icons, RTL mapping, focus and disabled states.
- Future Variants: standard, high-contrast, large-target. Themes may recolor but cannot change meaning.

## Empty Tool Slot

- Purpose: Show available space without pressure or deficit language.
- Owner: ROOM_SYSTEM.
- Signals: tool capacity and client customization state.
- Asset Dependencies: empty slot, focused slot, suggested slot, unavailable slot.
- Future Variants: compact, board-specific, high-contrast.

## Tool Card

- Purpose: Represent a selectable tool, resource, or recommendation.
- Owner: ROOM_SYSTEM for the frame; visual content remains with the represented tool/resource.
- Signals: linked signals, fingerprint match, client save/dismiss choice, accessibility preference.
- Asset Dependencies: card frame, icon/thumbnail, source mark, optional magnet indicator, focus state.
- Future Variants: tool, content, resource, provider, center, pathway, aspiration.

## Current Asset Dependencies

- Existing client dashboard backgrounds can seed the default responsive Room Background family.
- Existing client avatars can seed identity placeholders only after ownership and representation review.
- Existing navigation arrows are candidates for the canonical ICONS_SYSTEM family.
- No dedicated TV, notebook, cup, profile monitor, empty tool slot, or Client Room placeholder bitmap was found in Phase 1.
- The current tool board is code-rendered; no bitmap migration is required for it.

## Compatibility Rules

1. A theme can change texture, palette, ornament, and framing, but not control meaning.
2. Navigation hit areas, focus order, contrast, and accessible labels remain stable.
3. Content and recommendations are signal-attracted, never diagnostic or prescriptive.
4. Room assets cannot encode extinct operational lifecycle states.
5. Personal identity visuals obey client privacy preferences.
6. Missing visuals use PLACEHOLDER_SYSTEM, never arbitrary feature-local images.
