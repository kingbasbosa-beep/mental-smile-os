# CORE_DEPENDENCY_BOUNDARY_REPORT_V1

## Purpose

Define the boundary between active runtime dependency and source repository evidence.

## Active Dependency Boundary

Active dependency exists because `pubspec.yaml` declares:

```yaml
mental_smile_clean_core:
  path: mental_smile_clean_core
```

This makes the package available to the runtime/test dependency graph.

## Active Import Boundary

Only one active Dart file imports the package:

```dart
import 'package:mental_smile_clean_core/mental_smile_clean_core.dart';
```

File:

`test/mental_smile_clean_core_import_test.dart`

## Source Evidence Boundary

The Construction Workbench references the local folder as a source repository:

```text
C:\mental_smile_workspace\app\mental-smile-app-clean2\mental_smile_clean_core
```

This is source evidence, not active runtime execution.

## Boundary Decision

Dependency removal and folder archival are separate decisions.

The dependency can be extracted after test replacement.

The folder should remain until source repository/archive policy is approved.

