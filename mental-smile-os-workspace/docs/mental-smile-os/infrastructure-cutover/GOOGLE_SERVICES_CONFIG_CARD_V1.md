# Google Services Config Card V1

## Identity

Card ID: GOOGLE_SERVICES_CONFIG_CARD_V1

Component: `android/app/google-services.json`

## Old Value

Project: `mental-smile-app-clean`

Package: `com.mentalkey.app.flutterprojects`

Path: `android/app/google-services.json`

## New Target Value

Project: `mental-smile-platform` or Owner-approved equivalent.

Package: `com.mentalsmile.app`

Path: `android/app/google-services.json`

## Purpose

Bind Android app to the new clean Firebase project and application ID.

## Files Touched During Cutover

- `android/app/google-services.json`

## Required Backup

Before replacement, copy current file to a timestamped or named backup, for example:

`android/app/google-services.json.backup-before-mental-smile-platform-cutover`

## Rollback Method

Restore the backed-up `google-services.json` and old `applicationId`.

## Validation Status

PENDING_OWNER_ACTION.

## Owner Decision

Required.

## Risk Level

HIGH.
