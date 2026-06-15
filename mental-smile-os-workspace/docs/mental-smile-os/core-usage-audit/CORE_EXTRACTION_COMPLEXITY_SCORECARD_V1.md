# CORE_EXTRACTION_COMPLEXITY_SCORECARD_V1

## Scorecard

| Area | Score | Reason |
| --- | --- | --- |
| Direct runtime imports | LOW | No direct `lib/` import of the package was found |
| Test imports | LOW | One proof test imports one enum/extension |
| Dependency graph | LOW | Direct path dependency only |
| Lockfile update | LOW | Expected after `flutter pub get` once dependency is removed |
| Runtime behavior risk | LOW | No active runtime symbols imported from package |
| Owner Workbench path reference | MEDIUM | Source repository reference should remain or be retargeted before folder archive |
| Folder removal risk | MEDIUM | The folder is still source evidence and should not be deleted during dependency extraction |

## Overall Complexity

MEDIUM

## Why Not LOW Overall

Runtime dependency extraction is low risk, but source repository handling raises the overall score to medium.

## Why Not HIGH

No broad runtime dependency, shared service, shared widget, or active model import was discovered.

