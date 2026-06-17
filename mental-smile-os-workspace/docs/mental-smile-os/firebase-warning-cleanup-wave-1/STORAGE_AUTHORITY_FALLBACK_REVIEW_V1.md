# STORAGE_AUTHORITY_FALLBACK_REVIEW_V1

## Purpose

Review Storage clinician/center Firestore fallback authority during Firebase Warning Cleanup Wave 1.

## Current Clinician Helper Behavior

`storage.rules` allows clinician upload/update when:

```rules
request.auth.token.role == 'clinician'
```

or when a Firestore document fallback exists:

```rules
firestore.exists(/databases/(default)/documents/clinicians/$(request.auth.uid))
&& firestore.get(/databases/(default)/documents/clinicians/$(request.auth.uid)).data.role == 'clinician'
```

## Current Center Helper Behavior

`storage.rules` allows center upload/update when:

```rules
request.auth.token.role == 'center'
```

or when a Firestore document fallback exists:

```rules
firestore.exists(/databases/(default)/documents/centers/$(request.auth.uid))
&& firestore.get(/databases/(default)/documents/centers/$(request.auth.uid)).data.role == 'center'
```

## Firestore Document Fallback Status

Firestore document fallback remains present for:

- clinicians
- centers

## Admin Zero Review

The fallback does not reference:

- `admin`
- `admins`
- administrator authority
- legacy admin collection authority

Admin Zero status: PRESERVED

## Owner Authority Review

Owner authority remains custom-claim based through:

```rules
request.auth.token.role == 'owner'
```

Owner authority status: PRESERVED

## Decision

Storage clinician/center fallback was reviewed but not changed in this wave.

Reason:

Removing it may affect active clinician/center uploads if existing users rely on Firestore role documents instead of custom claims.

## Recommended Next Action

Defer removal until Owner confirms all active clinician and center accounts have correct custom claims.

Suggested fate:

DEFER_UNTIL_CLAIMS_AUDIT

