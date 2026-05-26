# Owner Admin Bootstrap

This script assigns Firebase Auth custom claims to Mental Smile owner admin accounts and upserts their `admins/{uid}` Firestore documents.

It is intentionally safe to rerun. If an owner email does not exist in Firebase Auth yet, the script prints a warning and continues.

## Owners

- `kingbasbosa@gmail.com`
- `mentalsmile.platform@gmail.com`

## Service Account

Do not commit service account keys to git.

Use one of these local-only options:

1. Set an environment variable:

```bash
GOOGLE_APPLICATION_CREDENTIALS=/absolute/path/to/serviceAccount.local.json node tools/firebase/bootstrap_owner_admins.js
```

2. Or place the key locally at:

```text
tools/firebase/serviceAccount.local.json
```

The key must belong to this Firebase project:

```text
mental-smile-app-clean
```

The script refuses to run if the service account `project_id` does not match.

## Manual Run

From the project root, after installing Firebase Admin SDK dependencies if needed:

```bash
node tools/firebase/bootstrap_owner_admins.js
```

The script does not create missing Auth users automatically. For example, if `mentalsmile.platform@gmail.com` does not exist yet, it will print:

```text
[OWNER_BOOTSTRAP][MISSING_AUTH_USER] mentalsmile.platform@gmail.com
```

After the account is created later, rerun the script.

## After Running

Each owner must sign out and sign in again, or otherwise refresh their ID token, so the new custom claims are included in the client token.

Expected result:

- Firebase Auth custom claims include `{ "role": "admin" }`.
- Firestore has `admins/{uid}` with `active`, `isActive`, `isAdmin`, and `isBlocked` fields aligned for admin access.

## Safety Notes

- This script does not delete users.
- This script does not delete Firestore documents.
- This script does not modify Firebase rules.
- This script does not modify Flutter app code.
- This script only updates existing Auth users that match the configured owner emails.
