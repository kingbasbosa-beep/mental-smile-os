# clean_core Wave 1 Next Phase Readiness

## Readiness Areas

Wave 1 is ready to support planning for:

- Wave 2 candidate review
- future standalone `pubspec.yaml` introduction
- future package registration
- future host reconnect strategy
- future adapter layer introduction
- future runtime bridge architecture planning
- future print/PDF/report recovery audit
- future host-app reintegration planning

## Required Before Wave 2

Before Wave 2:

- confirm Wave 1 docs and moved files are committed
- review remaining `clean_core/lib/core` directories
- classify Wave 2 candidates separately
- preserve the extraction freeze
- avoid app-owned migration
- avoid runtime/provider activation
- preserve rollback checkpoints

## Required Before Pubspec Introduction

Before adding package identity:

- decide package name and versioning
- define pure Dart dependencies only
- avoid Flutter/Firebase/provider/networking dependencies
- decide temporary path dependency strategy for host reconnect
- convert temporary test reconnects only after package identity exists

## Required Before Runtime Bridge Work

Before runtime bridge architecture:

- complete adapter contract review
- keep implementations host/backend owned
- preserve backend authority
- preserve fail-closed behavior
- keep provider execution blocked

## Next-Phase Verdict

Wave 1 is complete and ready for the next planning checkpoint. It is not approval for runtime activation, provider execution, Firebase integration, broad host migration, or Wave 2 movement without a separate review.
