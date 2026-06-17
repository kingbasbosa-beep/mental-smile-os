# Active Identity Registry V1

Result: ACTIVE_IDENTITY_REGISTRY_CREATED

## Active Operational Identities

| Identity Layer | Active Identity | Status |
| --- | --- | --- |
| Product | Mental Smile OS | ACTIVE |
| Public Brand | Mental Smile | ACTIVE |
| Release Generation | Generation 1 Release Candidate | ACTIVE |
| Dart Package | `mental_smile_os` | ACTIVE |
| Android Namespace | `com.mentalsmile.os` | ACTIVE |
| App Label | Mental Smile | ACTIVE |
| Public GitHub Docs | `mental-smile-os` | ACTIVE |
| Authority Model | Owner Authority / Admin Zero | ACTIVE |
| Documentation Root | `mental-smile-os-workspace` | ACTIVE |

## Conditional Infrastructure Identities

| Identity Layer | Current Identity | Status | Reason |
| --- | --- | --- | --- |
| Android applicationId | `com.mentalkey.app.flutterprojects` | TEMPORARY_CONTINUITY_IDENTITY | Requires Owner decision because changing it affects Android/Firebase continuity. |
| Firebase project | `mental-smile-app-clean` | TEMPORARY_INFRASTRUCTURE_IDENTITY | Requires Owner decision because changing it is a Firebase migration. |
| Firebase hosting URL | `mental-smile-app-clean.web.app` / related Firebase domains | TEMPORARY_HOSTING_IDENTITY | May remain until custom domain or Firebase migration. |
| GitHub Actions Firebase project | `mental-smile-app-clean` | TEMPORARY_DEPLOYMENT_IDENTITY | Must match current Firebase project until migration. |
| Repository host path | `mental-smile-app-clean2` | TEMPORARY_HOST_REPOSITORY_IDENTITY | Current host path only, not product identity. |

## Active Identity Rule

No legacy identity may be used as public product identity, route identity, new package identity, new authority model, or public promise.

Legacy infrastructure identity may remain only when explicitly classified as temporary continuity infrastructure.
