# Hosting Identity Registry V1

Result: HOSTING_IDENTITY_REGISTRY_CREATED

## Hosting And Public URL Identities

| ID | Surface | Current Identity / URL | Classification | Notes |
| --- | --- | --- | --- | --- |
| HOST-ID-001 | Firebase default project | `mental-smile-app-clean` | OWNER_DECISION_REQUIRED | Active Firebase backend/deploy identity. |
| HOST-ID-002 | Firebase hosting config | `public-landing` | NON_BLOCKING | Correct public landing root. |
| HOST-ID-003 | Firebase hosting generated URL | likely `mental-smile-app-clean.web.app` / `firebaseapp.com` | OWNER_DECISION_REQUIRED | Legacy clean app identity remains in public infrastructure URL. |
| HOST-ID-004 | GitHub Pages OS docs | `https://kingbasbosa-beep.github.io/mental-smile-os/` | NON_BLOCKING | Correct OS public docs identity. |
| HOST-ID-005 | GitHub repository | `kingbasbosa-beep/mental-smile-os` in public links | NON_BLOCKING | Correct public repo identity. |
| HOST-ID-006 | Public website placeholder | `https://mentalsmile.org` | OWNER_DECISION_REQUIRED | Needs owner/domain confirmation. |
| HOST-ID-007 | Public app placeholder | `https://app.mentalsmile.org` | OWNER_DECISION_REQUIRED | Needs owner/domain/Firebase routing confirmation. |
| HOST-ID-008 | Active app exit website URL | `https://mental-smile-app-clean.web.app` if used in runtime links | OWNER_DECISION_REQUIRED | Legacy hosting URL may be acceptable until custom domain cutover. |
| HOST-ID-009 | GitHub Actions live channel | `channelId: live`, project `mental-smile-app-clean` | OWNER_DECISION_REQUIRED | Auto deploy on `ai-lab` merge. |
| HOST-ID-010 | GitHub Actions preview channel | project `mental-smile-app-clean` | OWNER_DECISION_REQUIRED | PR previews use legacy Firebase project. |

## Hosting Identity Notes

- GitHub Pages naming is clean and aligns with Mental Smile OS.
- Firebase hosting is functional but legacy-named.
- Public custom domains are declared as desired/placeholder-style identities and need Owner confirmation.
- The current Firebase Hosting URL should be treated as technical infrastructure, not final brand identity.

## Recommended Hosting Plan

Short term:

- Keep Firebase hosting project as-is for RC only.
- Use GitHub Pages for OS docs/showcase.
- Use public custom domains only after Owner confirms DNS and production status.

Medium term:

- Decide whether `mental-smile-app-clean.web.app` remains a technical backend host or is replaced by a new Firebase project/custom domain.

Strict OS-only:

- Use a final OS-aligned Firebase project or custom domain.
- Update workflows and secrets after migration.
