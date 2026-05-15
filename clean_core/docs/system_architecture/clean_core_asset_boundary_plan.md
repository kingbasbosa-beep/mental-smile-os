# Clean Core Asset Boundary Plan

Draft asset boundary plan. No asset migration or asset adapter implementation was performed.

## Asset Ownership

Assets remain host-app owned.

Host app owns:

- Image assets.
- Fonts.
- Audio.
- Videos.
- Asset manifests.
- Generated asset references.
- Flutter asset bundle access.

clean_core may define:

- Asset intent identifiers if needed.
- Semantic media references.
- Fallback display markers.
- Asset resolution contract shapes.

## Boundary Rules

- No hardcoded asset assumptions inside pure contracts.
- No direct asset bundle usage in exported contracts.
- No image/font/audio coupling in public core contracts.
- No generated asset imports in clean_core public API.
- Host app resolves assets into actual Flutter resources.

## Future Asset Adapter

Future asset adapter may accept:

- Semantic asset key.
- Asset category.
- Fallback marker.
- Locale/accessibility context.

Host app returns a UI-ready asset reference.

## Failure Expectations

If asset resolution fails:

- Use host-owned placeholder behavior.
- Do not block pure contract logic.
- Do not trigger network fetches from clean_core.
- Do not activate runtime/provider systems.

## Explicit Non-Action

No asset files or pubspec asset declarations were changed.
