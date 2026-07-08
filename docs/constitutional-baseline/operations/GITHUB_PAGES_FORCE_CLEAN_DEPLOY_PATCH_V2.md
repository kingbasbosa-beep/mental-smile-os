# GitHub Pages Force Clean Deploy Patch V2

Status: COMPLETED
Date: 2026-07-08
Scope: GitHub Pages workflow only

## Root Cause

GitHub Pages was still serving stale website files because the deployment target branch could retain or serve older published content when the publish process does not explicitly guarantee a clean replacement of the `gh-pages` root.

The current runtime branch is:

- `post-separation-pure-dna-v1`

and the temporary Pages deployment must publish directly from that branch without requiring a pull request or merge into `main`.

## Why Stale Files Happened

Stale files can remain visible when:

- GitHub Pages is configured to serve a branch that still contains older output.
- The deployment process merges or preserves previous `gh-pages` contents.
- The publish destination is not explicitly rooted at the branch root.
- Environment-based Pages deployment is blocked or delayed while an older branch deployment remains active.

## What Changed

Updated only:

- `.github/workflows/github-pages.yml`

The workflow now:

- Runs the job only when `github.ref` is `refs/heads/post-separation-pure-dna-v1`.
- Uses shallow checkout with `fetch-depth: 1`.
- Keeps the required build command unchanged:

```bash
flutter build web --release --base-href /mental-smile-os/
```

- Verifies `build/web/index.html` exists before deployment.
- Deploys only `./build/web`.
- Publishes to the root of `gh-pages` using `destination_dir: .`.
- Uses `force_orphan: true` so the deploy branch is recreated with a fresh orphan history.
- Uses `keep_files: false` so previous files are not preserved.
- Does not use `actions/deploy-pages`.
- Does not create a GitHub Pages deployment through a protected GitHub Environment.

## Why `gh-pages` Will Contain Only The Latest Build

The deploy action now publishes exactly one source directory:

- `./build/web`

to exactly one destination:

- root of `gh-pages`

with:

- `force_orphan: true`
- `keep_files: false`

This means every run behaves like a fresh clean deployment, replacing the previous `gh-pages` tree with the current `build/web` output instead of merging old branch contents.

## Confirmations

- Flutter runtime was not modified.
- UI was not modified.
- Firebase was not modified.
- Firestore was not modified.
- Routes were not modified.
- Assets were not modified.
- Localization was not modified.
- `pubspec.yaml` was not modified.
- Application logic was not modified.

## Files Changed

- `.github/workflows/github-pages.yml`
- `docs/constitutional-baseline/operations/GITHUB_PAGES_FORCE_CLEAN_DEPLOY_PATCH_V2.md`

## Final Verdict

GITHUB_PAGES_FORCE_CLEAN_DEPLOY_READY
