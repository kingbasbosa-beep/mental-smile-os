# WEB_BUILD_VALIDATION_SEQUENCE_V1

## Objective

Validate the web production build path without deploying.

## Exact Sequence

1. Confirm `firebase.json` hosting public target remains `build/web`.
2. Confirm `web/index.html` and `web/manifest.json` production identity metadata has been cleaned.
3. Run:

```powershell
flutter build web
```

4. Confirm `build/web` is generated.
5. Confirm generated web output includes expected assets.
6. Confirm no Firebase deploy is executed.
7. Optionally inspect locally with a static server in a later owner-approved validation pass.

## Pass Criteria

- Web build completes successfully.
- No missing asset error.
- No missing localization error.
- No route import compile failure.
- Build output remains `build/web`.

## Failure Handling

If build fails, record:

- failing import
- missing asset
- missing localization key
- Firebase initialization error
- route compile error

Then stop before any deploy.

