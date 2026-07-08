# GitHub Pages Current Branch Deployment Workflow Patch V1

Status: COMPLETED_PENDING_GITHUB_PAGES_BRANCH_SETTING
Date: 2026-07-08
Scope: GitHub Pages workflow only

## Problem

The GitHub Pages workflow built successfully, but deployment failed because the current working branch:

- `post-separation-pure-dna-v1`

has unrelated Git history from `main`.

The deployment must work directly from the current branch without requiring a pull request or merge into `main`.

## What Changed

Updated:

- `.github/workflows/github-pages.yml`

The workflow now:

- Still runs from `post-separation-pure-dna-v1`.
- Still supports manual `workflow_dispatch`.
- Still uses Flutter stable.
- Still builds with:

```bash
flutter build web --release --base-href /mental-smile-os/
```

- Publishes `build/web` directly to a dedicated `gh-pages` branch.
- Uses an orphan `gh-pages` history via `force_orphan: true`.
- Avoids requiring the current branch to share history with `main`.
- Avoids the `actions/deploy-pages` environment path that can be blocked by GitHub Pages environment protection rules.

## Deployment Method

The workflow now uses:

- `peaceiris/actions-gh-pages@v3`

with:

- `publish_dir`: `./build/web`
- `publish_branch`: `gh-pages`
- `force_orphan`: `true`
- `enable_jekyll`: `false`

## Required GitHub Settings

Inside GitHub:

1. Open `kingbasbosa-beep/mental-smile-os`.
2. Go to `Settings > Pages`.
3. Set `Build and deployment > Source` to `Deploy from a branch`.
4. Select branch:
   - `gh-pages`
5. Select folder:
   - `/root`

Expected temporary URL:

- `https://kingbasbosa-beep.github.io/mental-smile-os/`

## What Was Not Changed

- No Flutter code changed.
- No UI changed.
- No Firebase config changed.
- No Firestore Rules changed.
- No Routes changed.
- No assets changed.
- No application logic changed.
- No new features added.
- No local deploy command was run.

## Files Changed

- `.github/workflows/github-pages.yml`
- `docs/constitutional-baseline/operations/GITHUB_PAGES_CURRENT_BRANCH_DEPLOYMENT_WORKFLOW_PATCH_V1.md`

## Final Verdict

GITHUB_PAGES_CURRENT_BRANCH_DEPLOYMENT_READY
