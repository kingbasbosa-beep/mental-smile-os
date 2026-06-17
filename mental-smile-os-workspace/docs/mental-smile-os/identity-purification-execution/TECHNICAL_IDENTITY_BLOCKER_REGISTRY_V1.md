# TECHNICAL_IDENTITY_BLOCKER_REGISTRY_V1

## Purpose

Register blockers that must be handled before clean production identity.

## Blockers

| ID | Blocker | Severity | Required Action |
| --- | --- | --- | --- |
| ID_BLOCKER_001 | `flutterprojects` package name | HIGH | Rename to `mental_smile_os`. |
| ID_BLOCKER_002 | 74 `package:flutterprojects` imports | HIGH | Rewrite imports after package rename. |
| ID_BLOCKER_003 | `mental_smile_clean_core` active dependency | HIGH | Extract/replace/remove with expiry. |
| ID_BLOCKER_004 | Android namespace `com.mentalkey.app.flutterprojects` | HIGH | Rename namespace to `com.mentalsmile.os`. |
| ID_BLOCKER_005 | Android applicationId decision pending | HIGH | Owner decision required. |
| ID_BLOCKER_006 | Windows metadata residue | MEDIUM | Rename if Windows target survives. |
| ID_BLOCKER_007 | Firebase Android app mapping may depend on applicationId | HIGH | Validate after applicationId decision. |

## Candidate Status

These block clean production identity, not runtime candidacy.
