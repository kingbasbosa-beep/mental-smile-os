# OWNER_RELEASE_GATE_V1

## Purpose

Define the Owner gate for Generation 1 release candidate actions.

## Owner Must Explicitly Confirm Before

- staging release files
- creating release commit
- pushing to GitHub
- creating a tag
- pushing a tag
- triggering GitHub Actions deployment
- Firebase deploy
- Android package/applicationId changes
- Google Play upload or publish
- public web release

## Required Confirmation Format

Owner approval must name the exact action and target.

Examples:

- `Approve staging Generation 1 release candidate docs only.`
- `Approve commit Generation 1 release candidate pack.`
- `Approve push to ai-lab.`
- `Approve tag generation-1-rc-1.`
- `Approve Firebase deploy to project mental-smile-app-clean.`

## Default State

Without explicit Owner confirmation:

Status: RELEASE_READY_WITH_WARNINGS

No irreversible action is authorized.

