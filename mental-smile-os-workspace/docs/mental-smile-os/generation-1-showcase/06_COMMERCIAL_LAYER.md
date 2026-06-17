# Commercial Layer

The Commercial Layer separates onboarding from public display.

This is one of the most important design choices in Mental Smile OS.

## Provider Registration Zone

This zone handles:

- Provider onboarding.
- Credential submission.
- Document collection.
- Profile draft creation.
- Review preparation.
- Status tracking.

It does not publicly display providers.

## Provider Public Zone

This zone handles:

- Provider discovery.
- Public profiles.
- Service visibility.
- Contact pathways.
- Trust display.

It does not read private registration documents or mutate onboarding records.

## Center Registration Zone

This zone handles:

- Center onboarding.
- Document submission.
- Service declaration.
- Partnership requests.
- Contract preparation.
- Profile draft creation.
- Status tracking.

## Center Public Zone

This zone handles:

- Center discovery.
- Public profiles.
- Service visibility.
- Trust visibility.
- Contact pathways.
- Public resources.

## Why The Split Exists

Registration and public presentation change at different speeds.

A registration workflow failure should not break public profiles.

A public redesign should not affect private onboarding records.

The split makes the commercial layer safer, cleaner, and easier to evolve.

