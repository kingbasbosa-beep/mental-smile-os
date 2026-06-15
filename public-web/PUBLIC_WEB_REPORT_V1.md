# PUBLIC_WEB_REPORT_V1

## Result

```text
PUBLIC_WEB_CONTACT_PAGE_READY
```

## Files Edited

- `public-web/index.html`
- `public-web/showcase.html`
- `public-web/chapter.html`
- `public-web/contact.html`
- `public-web/contact-links.js`
- `public-web/styles.css`
- `public-web/PUBLIC_WEB_REPORT_V1.md`
- `public-web/README.md`

## Localization Update

- Arabic-first default applied.
- Page root is now:

```html
<html lang="ar" dir="rtl">
```

- Arabic is the default visible language.
- English remains available as an optional alternate language in the same static file.
- Navbar language switch added:

```text
عربي | English
```

## JavaScript / Storage Behavior

- Minimal local JavaScript is used only to switch visible language content.
- No tracking is added.
- No external libraries are added.
- No cookies are used.
- `localStorage` is not used.
- No personal data is collected.

## Hero Layout Fix

- Header overlap was addressed with a shared CSS variable:

```css
--header-height
```

- The sticky header now has a declared minimum height.
- The hero now accounts for the header with top padding:

```css
padding-block-start: calc(var(--header-height) + 48px);
```

- The hero title is no longer allowed to start behind the navbar.
- The hero title now uses a no-break phrase span to prevent word-by-word stacking.
- The sun-disc background is positioned relative to the header height.
- The hero was reworked toward the supplied reference layout: large ceremonial logo area, strong title block, side status card, and dark/gold temple atmosphere.
- The logo frame was simplified so the actual logo is much larger and reads as a gold pharaonic seal instead of a small mark inside a large empty ring.
- Decorative side-column treatments were added with CSS only.

## Header Behavior

- Header remains sticky.
- Main hero spacing now reserves room for the sticky navbar.
- Mobile uses a static header at the smallest breakpoint to avoid content overlap and awkward clipping.
- Anchor scrolling uses `scroll-padding-top` with the same header-height variable.

## Title Clamp

- Desktop hero title uses:

```css
font-size: clamp(3.5rem, 6vw, 6.5rem);
```

- Mobile hero title uses:

```css
font-size: clamp(2.8rem, 13vw, 4.2rem);
```

## Responsive Notes

- Desktop keeps a stable three-column hero: logo, title/content, status card.
- Tablet and mobile stack cleanly: logo, title, paragraph, buttons, status.
- RTL/LTR language switching remains supported.
- Logical spacing is used for hero padding and list markers where practical.
- The hero grid uses a stable visual order while preserving RTL text direction inside Arabic content.

## Reference Layout Update

- Header lockup was updated to match the supplied reference more closely:
  - compact sticky black header
  - brand on the left
  - cropped gold logo mark beside the Arabic brand name
  - small gold spark accent
  - center/right navigation
  - pill-shaped Arabic / English switch
- Navigation order now follows the reference direction:
  - لماذا
  - العرض
  - حدود السلامة
  - أساس
- The same header treatment is applied to `index.html` and `showcase.html`.
- Added a foundation rail under the hero, matching the reference-style row of six ceremonial feature blocks.
- Rail items cover:
  - Zones
  - Gateways
  - Signals
  - Registries
  - Owner Governance
  - Admin Zero
- Main sections now sit in constrained framed panels below the full-width hero.
- The page now reads more like a premium public website and less like a documentation wrapper.

## Showcase Web Page

- `public-web/showcase.html` was created.
- The main `Open Showcase` / `افتح العرض العام` button now links to:

```text
showcase.html
```

- The showcase page uses the same public web styling, header, language switch, black/gold identity, and pharaonic visual language.
- It presents 10 styled public story cards instead of exposing a raw markdown directory.
- The card grid was updated toward the reference layout with a five-column desktop grid and compact ceremonial cards.
- A breadcrumb-style line was added to the showcase hero.
- Each card now opens a styled public text page through `chapter.html?chapter=XX`.
- The Release Candidate button now points to the GitHub repository:

```text
https://github.com/kingbasbosa-beep/mental-smile-os
```

## Raw Directory Issue

- The public visitor no longer lands on the raw `generation-1-showcase/` directory from the main page.
- Public entry now feels like a website page first, without sending visitors to raw markdown pages.

## Styled Text Pages

- `public-web/chapter.html` was created as the shared styled reader for all Generation 1 showcase text pages.
- The 10 showcase cards now route to:
  - `chapter.html?chapter=01`
  - `chapter.html?chapter=02`
  - `chapter.html?chapter=03`
  - `chapter.html?chapter=04`
  - `chapter.html?chapter=05`
  - `chapter.html?chapter=06`
  - `chapter.html?chapter=07`
  - `chapter.html?chapter=08`
  - `chapter.html?chapter=09`
  - `chapter.html?chapter=10`
- Each chapter uses:
  - the same header
  - the same language switch
  - the same black/gold pharaonic styling
  - a framed title area
  - gold-bordered content sections
  - a return button to the showcase
- Raw markdown is no longer the primary public reading experience.
- Raw markdown source buttons are not exposed in the public chapter UI.

## Contact Page

- `public-web/contact.html` was created as the official Mental Smile OS contact gateway.
- The page uses the existing black/gold design system, pharaonic-inspired card language, same header, same localization toggle, same spacing rhythm, and responsive layout.
- Arabic is visible by default and English is available through the same local language toggle.
- The page includes:
  - hero section
  - official channel cards
  - Mental Smile message section
  - quick access section
  - footer
- Contact channels are rendered as premium cards:
  - Website
  - App
  - Facebook
  - LinkedIn
  - Telegram
  - WhatsApp
  - Instagram
  - X
  - TikTok
  - YouTube
  - GitHub
  - Zoom
  - Email
- No contact form was added.
- No personal data collection was added.

## Contact Links

- `public-web/contact-links.js` was created as the centralized URL source.
- The UI uses `data-contact-link` keys and does not hardcode channel URLs in the card markup.
- Current constants:
  - `WEBSITE_URL`
  - `APP_URL`
  - `FACEBOOK_URL`
  - `LINKEDIN_URL`
  - `TELEGRAM_URL`
  - `WHATSAPP_URL`
  - `INSTAGRAM_URL`
  - `X_URL`
  - `TIKTOK_URL`
  - `YOUTUBE_URL`
  - `GITHUB_URL`
  - `ZOOM_URL`
  - `EMAIL_URL`
- Placeholder values remain for owner-provided official channels.

## Sections Localized

All main public sections now have Arabic and English versions:

1. Hero
2. Why This Matters
3. Foundation
4. Safety Position
5. Public Showcase
6. Inquiry
7. Footer

## Content Sources Used

- `README.md`
- `mental-smile-os-workspace/docs/mental-smile-os/generation-1-showcase/`
- `mental-smile-os-workspace/docs/mental-smile-os/release-candidate-v1/`
- WHO Mental Disorders Fact Sheet

## Domain Review

No configured custom domain file was found.

`firebase.json` exists, but no final custom domain was detected in the inspected project configuration.

Placeholder used:

```text
https://mentalsmile.com
```

## Design Choices Preserved

- Black, deep charcoal, gold, and warm ivory palette.
- Egyptian-inspired visual language without costume styling.
- Large hero logo as the central identity element.
- Gold circular emblem frame around the Mental Smile logo.
- Subtle sun-disc, temple-frame, papyrus-panel, and geometric divider feeling.
- Strong ceremonial layout and hierarchy.
- Arabic-first public copy with English secondary copy.
- Simple static HTML/CSS with minimal local JavaScript.
- Existing Mental Smile logo referenced from approved project assets.
- No login, no forms, no data collection.

## Logo Behavior

The hero uses the existing asset:

```text
../assets/branding/shared/logo/logo_primary_dark.png
```

The asset exists in the repository and is reused. No fallback placeholder was needed.

The logo scales down on tablet and mobile through responsive CSS.

## RTL / Accessibility Notes

- Arabic layout uses RTL direction by default.
- English switch updates the page direction to LTR.
- Language buttons use `aria-pressed`.
- Hidden alternate-language blocks use the `hidden` attribute.
- Navigation labels switch with the selected language.
- Button layout and text alignment are adjusted for RTL/LTR readability.

## Safety Boundaries

- No Firebase deploy.
- No GitHub Pages config change.
- No DNS change.
- No secrets.
- No credentials.
- No service accounts.
- No forms collecting personal data.
- No medical claims.
- No therapy promises.
- No diagnosis language.
- No automatic publish.
- No external dependencies.
- No tracking.

## Remaining Owner Decisions

1. Confirm final public domain.
2. Decide whether to host from `public-web/` directly.
3. Decide whether to copy an approved logo into `public-web/` for standalone hosting.
4. Approve any GitHub Pages or Firebase Hosting configuration in a separate step.
5. Perform final browser/device visual QA before public hosting.
6. Decide whether deeper technical source links should exist later in a developer-only documentation path.
7. Provide final official contact URLs for `contact-links.js`.

## Recommended Hosting Path

```text
public-web/
```

## Final Status

The Arabic-first pharaonic-inspired static public web package now includes a styled showcase page and is ready for review and owner approval.

No deployment was performed.
