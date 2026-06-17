# Workspace Dependency Report V1

Status: DEPENDENCY_REVIEW_PREPARED
Prompt Asset: PROMPT_ASSET_050

## Purpose

Identify dependencies, shared assets, shared configs, shared documentation, and migration risks before purification.

## Known Dependency Areas

| Area | Current Relationship | Risk |
| --- | --- | --- |
| Active OS documentation | Lives inside mental-smile-os-workspace | Must remain active and protected. |
| Host repository | mental-smile-app-clean2 hosts current workspace | Archive decisions must not break active docs. |
| Legacy runtime | mental-smile-app-clean2 contains old app runtime | Runtime migration must wait for inventory completion. |
| Source assets | Old app assets may exist in host repository | Must be extracted and purified, not copied directly. |
| Firebase configs/rules | Old repository may contain legacy Firebase material | Must wait for Firebase purification phase. |
| YAML configs | Old repository may contain active or legacy YAML | Must wait for YAML purification phase. |
| Documentation roots | Old docs and OS docs may coexist | Must classify before archive movement. |

## Shared Asset Risks

- Asset paths may still reference old names.
- Old source images may be useful as evidence but not active OS assets.
- Purified OS assets require asset card, ownership card, recreation prompt, zone, screen or district, and status.

## Runtime Risks

- Legacy routes may still exist in host app.
- Old public home may not represent Mental Smile OS.
- Runtime migration before classification could reintroduce legacy dependency.

## Configuration Risks

- YAML may contain unused paths.
- Firebase rules may contain legacy authority.
- Environment files may contain sensitive or operational assumptions.

## Boundary

This report identifies risks only. It does not inspect secrets, edit configs, move files, or run migrations.

