# Active Workspace Big Boss Card V1

Status: BIG_BOSS_HANDOFF_PREPARED

## Big Boss Active Workspace

Recommended active project root:

`C:\mental_smile_workspace\app\mental-smile-platform`

## Why This Name

Mental Smile Platform is the production/runtime infrastructure identity:

- Firebase project: `mental-smile-platform`
- Hosting URL: `https://mental-smile-platform.web.app`
- Android applicationId: `com.mentalsmile.app`
- Public product: Mental Smile

Mental Smile OS remains the internal operating system, governance, signal federation, and documentation identity inside the platform.

## What Becomes Active

The clean workspace should include:

- `lib/`
- `android/`
- `assets/`
- `public-landing/`
- `.github/` workflows aligned to `mental-smile-platform`
- `.firebaserc`
- `firebase.json`
- `firestore.rules`
- `storage.rules`
- `pubspec.yaml`
- `pubspec.lock`
- `analysis_options.yaml`
- `README.md`
- useful `mental-smile-os-workspace/` documentation only
- release cards and owner bootstrap documents

## What Must Not Be Active

- `mental_smile_clean_core/`
- `.firebase/`
- `.dart_tool/`
- `build/`
- `node_modules/`
- temporary screenshots
- obsolete generated reports with no lesson, rollback, compliance, or release value

## Big Boss Rule

One active workspace. Useful history goes to private archive. Cache and build output stay out.

Result: ACTIVE_WORKSPACE_READY_FOR_OWNER_COPY
