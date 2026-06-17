# App Surface Boundary V1

Status: FUTURE_BUILD_BOUNDARY
Surface: APP SURFACE

## 1. Purpose

App Surface is the primary mobile and app experience for Mental Smile OS users.

It is separate from Owner OS, Library Web, Public Profiles Web, and Smart Archive Web.

## 2. Contains Only

- Splash.
- Home / Menu.
- Client Registration.
- Client Room.
- Center Room.
- Provider Room.

## 3. Logic Boundary

App Surface may handle app-first navigation, user-facing room entry, and approved app screen presentation.

App Surface may not:

- Host Owner OS governance.
- Host Smart Archive memory operations.
- Reuse old public home routing.
- Copy old menu structure.
- Create Firebase rules.
- Execute backend logic.

## 4. Build Order

The App Surface build order is:

1. Splash.
2. Home / Menu.
3. Client Registration.
4. Client Room.
5. Center Room.
6. Provider Room.

## 5. First Screen Rule

Splash must be rebuilt cleanly.

Allowed:

- Purified assets.
- Approved localization terms.
- Constitutional welcome language.

Forbidden:

- Direct copy from old splash.
- Legacy overlays.
- Unregistered assets.

## 6. Menu Warning

Home / Menu must be rebuilt cleanly.

Old menu is highly contaminated and may be used only as source evidence.

## 7. Client Room Warning

Client Room must be rebuilt cleanly using only the approved visual concepts:

- TV display.
- Tool board.
- Computer personal image.
- Exit cup.
- Left card navigation plaque.
- Right card navigation plaque.

Forbidden:

- Extra buttons.
- Legacy overlays.
- Old tab layers.
