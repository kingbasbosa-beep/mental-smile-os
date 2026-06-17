# RELEASE_WARNING_REGISTRY_V1

## Purpose

Consolidate warnings carried into Generation 1 release candidate preparation.

## Warning Matrix

| ID | Warning | Area | Risk |
| --- | --- | --- | --- |
| REL_WARN_001 | Runtime host repository remains legacy-named `mental-smile-app-clean2` | Workspace | MEDIUM |
| REL_WARN_002 | Flutter package name remains `flutterprojects` | Identity | HIGH |
| REL_WARN_003 | Dart imports still use `package:flutterprojects` | Identity | HIGH |
| REL_WARN_004 | `mental_smile_clean_core` remains active dependency | Dependency | HIGH |
| REL_WARN_005 | Android namespace/applicationId remains `com.mentalkey.app.flutterprojects` | Android | HIGH |
| REL_WARN_006 | Firebase project identity contains `clean` | Firebase | MEDIUM |
| REL_WARN_007 | Firestore duplicate `isMonitoringOperator()` helper requires cleanup or acceptance | Firebase | MEDIUM |
| REL_WARN_008 | Storage clinician/center Firestore fallback requires Owner decision | Firebase | MEDIUM |
| REL_WARN_009 | `analytics_summaries` function output policy requires decision | Functions | MEDIUM |
| REL_WARN_010 | Gateway runtime is partial | Runtime | MEDIUM |
| REL_WARN_011 | Signal runtime is partial | Runtime | MEDIUM |
| REL_WARN_012 | Owner and monitoring surfaces include placeholder-heavy areas | Product | MEDIUM |
| REL_WARN_013 | `.firebase/` and multiple generated doc directories are untracked | GitHub | MEDIUM |

## Handling Rule

Warnings must be either resolved, explicitly accepted, or deferred with owner approval before production release.

