# clean_core Host Bridge Boundary Plan

## Host Bridge Purpose

Host bridges reconnect app-owned runtime systems to clean_core contracts without moving runtime ownership into clean_core.

## Bridge Ownership

Host app owns:

- Firebase initialization
- auth/session runtime
- routing/navigation
- localization generation
- assets
- platform setup
- UI rendering

Backend owns:

- trusted operations
- provider execution
- runtime orchestration
- signed authority
- privileged writes
- Cloud Functions

clean_core owns:

- bridge contracts only
- blocked/fallback/review-required shapes
- authority references
- policy/audit markers

## Bridge Rules

Host bridges must:

- be explicit
- be adapter-isolated
- preserve backend authority
- fail closed when unavailable
- avoid hidden runtime activation
- avoid broad import rewrites

## Bridge Stop Conditions

Stop bridge work if:

- clean_core imports host runtime
- Firebase enters clean_core
- provider SDK enters clean_core
- networking enters clean_core
- client gains privileged authority
- backend governance can be bypassed

## Bridge Verdict

Host bridge work is a future phase. It should not begin until package identity and reconnect strategy are approved.
