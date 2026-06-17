# Delete Candidate Final Registry V1

Status: DELETE_CANDIDATES_IDENTIFIED

No source code, rules, documentation, rollback evidence, or Firebase project is approved for deletion in this step.

## Safe Delete Candidates

| Path | Classification | Value | Action |
| --- | --- | --- | --- |
| `.firebase/` | DELETE_SAFE | Local Firebase hosting cache only | Deletion attempted; Windows access denied; manual cleanup allowed. |

## Do Not Delete Without Owner Confirmation

| Path / Area | Reason |
| --- | --- |
| `android/app/google-services.json.backup-before-mental-smile-platform-cutover` | Rollback evidence |
| `mental-smile-os-workspace/docs/mental-smile-os/infrastructure-cutover/` | Infrastructure cards and reports |
| `public-landing/` | Active hosting public directory |
| Firebase rules files | Active security source |
| GitHub Actions workflows | Active CI/CD source |
| Git history | Historical and rollback source |
| Firebase projects | External infrastructure |

## Manual Cleanup Note

If Owner wants to clear local deploy cache manually:

```powershell
Remove-Item -LiteralPath .firebase -Recurse -Force
```

Only do this for local cache. Do not delete Firebase projects, rules, hosting sites, or rollback evidence.

Result: DELETE_SAFE_CACHE_PENDING
