# Firebase Hosting Card V1

## Identity

Card ID: FIREBASE_HOSTING_CARD_V1

Component: Firebase Hosting

## Old Value

Project: `mental-smile-app-clean`

Hosting directory: `public-landing`

## New Target Value

Project: `mental-smile-platform` or Owner-approved equivalent.

Hosting: Mental Smile Landing.

Hosting directory: `public-landing`.

## Purpose

Deploy the public Mental Smile landing to clean Firebase infrastructure.

## Files Touched During Cutover

- `.firebaserc`
- `firebase.json`

## Rollback Method

Restore old Firebase project target and redeploy only if Owner confirms.

## Validation Status

PENDING_OWNER_ACTION.

## Owner Decision

Required before deploy.

## Risk Level

HIGH.

Deploying hosting publishes public content and must be Owner-confirmed.
