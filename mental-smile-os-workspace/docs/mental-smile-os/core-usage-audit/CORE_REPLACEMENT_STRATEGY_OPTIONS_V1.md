# CORE_REPLACEMENT_STRATEGY_OPTIONS_V1

## Option A - Keep Temporary

Decision: KEEP_TEMPORARY

Use when Owner wants to preserve current dependency until after release candidate.

Pros:

- Lowest immediate disruption.
- No dependency graph change.

Cons:

- Legacy/core dependency remains active.
- Technical identity cleanup remains incomplete.

## Option B - Replace Proof Test With OS-Owned Test

Decision: REPLACE_WITH_OS_MODULE

Replace `test/mental_smile_clean_core_import_test.dart` with an OS-owned package identity or simple runtime smoke test.

Pros:

- Removes only active package import.
- Enables dependency removal.

Cons:

- Requires owner-approved test patch.

## Option C - Remove Dependency After Replacement

Decision: REMOVE_AFTER_REPLACEMENT

After replacing the proof test:

- remove dependency from `pubspec.yaml`
- run `flutter pub get`
- verify lockfile removes `mental_smile_clean_core`
- run validation

Pros:

- Clean dependency graph.

Cons:

- Must not remove source repository folder in same wave.

## Recommended Strategy

Use Option B followed by Option C.

Keep the folder as source evidence until archive/source repository policy is explicitly approved.

