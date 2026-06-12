# Owner Bootstrap

This document describes the temporary manual bootstrap process for Mental Smile owner access.

## Doctrine

Owner access is based only on:

- Firebase Auth user
- Firebase Auth custom claim: `{ "role": "owner" }`

Mental Smile does not use:

- admin role
- admins collection
- owners collection
- email fallback
- Firestore role document authority

## Service Account Safety

Service account files are local-only secrets.

Never commit:

- `tools/firebase/serviceAccountKey.json`
- `tools/firebase/serviceAccount.local.json`
- any `serviceAccount*.json`
- any Firebase Admin SDK private key

These files must remain ignored by git.

## Manual Owner Claim

Use a local-only script or Firebase Admin SDK environment to assign:

```json
{
  "role": "owner"
}

to the intended Firebase Auth user.

The user must sign out and sign in again after the claim is set.

Expected Result

After refresh, the app should route the owner account to:

/s/owner

No Firestore owner/admin document is required.

Safety Notes
This process does not create users.
This process does not create Firestore authority documents.
This process does not modify Firestore rules.
This process does not modify Flutter app code.
Service account credentials must never enter git.
