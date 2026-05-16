# clean_core Wave 2 Host Ownership Review

This review identifies host-owned systems that must not move in Wave 2.

## Host-Owned Areas

- `features/**`
- `shared/ui_kit/**`
- `shared/analytics/**`
- `app/**`
- `l10n/**`
- `firebase_options.dart`
- `core/auth/**`
- `core/storage/**`

## Host-Owned Responsibilities

The host app owns:

- Flutter UI
- app shell
- routing/navigation
- generated localization
- assets
- Firebase initialization
- Auth runtime
- Firestore runtime
- local storage
- analytics SDK/runtime
- platform behavior
- print/PDF/export runtime

## Host Contamination Signals

Wave 2 must stop if candidates include:

- `package:flutter/...`
- `package:cloud_firestore/...`
- `package:firebase_auth/...`
- `package:flutterprojects/app/...`
- generated l10n imports
- asset path utilities
- app UI kit imports
- shared preferences runtime access

## Host Ownership Verdict

Host-owned systems are not Wave 2 extraction candidates. They may later connect through adapters, not movement.
