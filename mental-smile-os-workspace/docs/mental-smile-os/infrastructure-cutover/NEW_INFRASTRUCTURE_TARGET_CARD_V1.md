# New Infrastructure Target Card V1

## Card Identity

Card ID: NEW_INFRASTRUCTURE_TARGET_CARD_V1

Purpose: Define the target clean Mental Smile infrastructure identity.

Status: OWNER_ACTION_REQUIRED

## Target Values

| Layer | Target |
| --- | --- |
| Product name | Mental Smile |
| Android applicationId | `com.mentalsmile.app` |
| Android namespace | `com.mentalsmile.os` |
| Firebase project target | `mental-smile-platform` or nearest available Owner-approved ID |
| Firebase Android app package | `com.mentalsmile.app` |
| Firebase Hosting | Mental Smile Landing |
| Hosting public directory | `public-landing` |

## Purpose

Create a clean infrastructure identity before real provider onboarding begins.

## Required Owner Manual Actions

1. Create or confirm Firebase project.
2. Create Android app using `com.mentalsmile.app`.
3. Create web app / hosting target for landing.
4. Download new `android/app/google-services.json`.
5. Provide confirmation that new Firebase project is approved for Generation 1 onboarding.

## Risk Level

HIGH.

Reason: this changes backend, Android installed identity, Firebase app identity, and deployment target.
