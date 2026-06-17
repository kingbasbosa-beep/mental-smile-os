# Final Owner Handoff Tools And Testing V1

Status: OWNER_CONFIRMATION_REQUIRED

## What Is Active Now

- Runtime identity: Mental Smile Platform / Mental Smile OS
- Firebase project: `mental-smile-platform`
- Hosting public directory: `public-landing`
- Android app id: `com.mentalsmile.app`
- Android namespace: `com.mentalsmile.os`
- Dart package: `mental_smile_os`
- App exit official website link: `https://mental-smile-platform.web.app`

## What Is Archive

The old workspace host `mental-smile-app-clean2` becomes legacy host archive after the clean copy is created and validated.

`mental_smile_clean_core/` should move to private archive as source evidence, not remain in the active workspace.

## What Can Be Deleted Later

Only after Owner confirms:

- `.firebase/`
- `build/`
- `.dart_tool/`
- `node_modules/`
- temporary screenshots with no design/legal/release value
- duplicate reports with no lesson or rollback value

## What Must Not Be Touched

- Git history
- Firebase projects
- rules files
- `google-services.json` backup evidence
- release cards
- rollback cards
- engineering lessons
- public landing
- useful OS docs

## Close And Reopen Moment

Owner can close Codex and Android Studio only after:

1. Clean workspace is created at `C:\mental_smile_workspace\app\mental-smile-platform`.
2. Active files are copied without cache/build/archive noise.
3. `flutter analyze` passes from the new folder.
4. `flutter build apk --debug` passes from the new folder.
5. `firebase use` shows `mental-smile-platform` from the new folder.
6. `firebase serve --only hosting` serves `public-landing` from the new folder.

Then reopen:

`C:\mental_smile_workspace\app\mental-smile-platform`

## Next Phase

1. Tools polishing
2. AI polish layer
3. Official links final review
4. First account testing
5. First signal testing
6. Owner route testing
7. Monitoring route testing
8. Firebase hosting deploy confirmation

## Validation Commands

Run manually from the current host and then again from the clean workspace:

```powershell
flutter analyze
flutter build apk --debug
firebase use
firebase serve --only hosting
firebase deploy --only hosting --project mental-smile-platform
```

Do not deploy from the old host if the Owner wants the first clean deploy to represent the new workspace era.

Final result: OWNER_CONFIRMATION_REQUIRED
