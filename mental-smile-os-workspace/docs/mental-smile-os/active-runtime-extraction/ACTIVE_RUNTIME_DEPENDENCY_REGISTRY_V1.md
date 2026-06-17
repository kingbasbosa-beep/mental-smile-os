# ACTIVE_RUNTIME_DEPENDENCY_REGISTRY_V1

## Purpose

Identify active runtime dependencies and their survival decision.

## Flutter Dependencies

| Dependency | Source | Runtime Use | Classification |
| --- | --- | --- | --- |
| `flutter` | SDK | App runtime | KEEP |
| `flutter_localizations` | SDK | Arabic/English localization | KEEP |
| `cupertino_icons` | Pub | Icons | KEEP |
| `flutter_riverpod` | Pub | State support | KEEP_WITH_REVIEW |
| `firebase_core` | Pub | Firebase initialization | KEEP |
| `cloud_firestore` | Pub | Firestore runtime | KEEP_WITH_REVIEW |
| `firebase_auth` | Pub | Authentication and route protection | KEEP_WITH_REVIEW |
| `shared_preferences` | Pub | Locale/local state | KEEP |
| `url_launcher` | Pub | External links | KEEP_WITH_REVIEW |
| `uuid` | Pub | Signal and record IDs | KEEP_WITH_REVIEW |
| `geolocator` | Pub | Location support | UNKNOWN |
| `geocoding` | Pub | Location support | UNKNOWN |
| `firebase_analytics` | Pub | Analytics events | KEEP_WITH_REVIEW |
| `mental_smile_clean_core` | Local path | Governance and runtime support package | MIGRATE_OR_ARCHIVE; MUST NOT REMAIN HIDDEN_DEPENDENCY |

## Firebase Dependencies

| Component | Classification | Notes |
| --- | --- | --- |
| Firebase Hosting | KEEP_WITH_REVIEW | Uses `build/web`. |
| Firestore Rules | KEEP_WITH_REVIEW | Custom claim authority exists; must align with Generation 1. |
| Storage Rules | KEEP_WITH_REVIEW | Owner claim patch applied; clinician/center fallback still needs review. |
| Functions | MIGRATE_WITH_REVIEW | Analytics summaries function exists. |
| Firestore Indexes | KEEP_WITH_REVIEW | Needs collection alignment. |

## Technical Identity Dependencies

| Identity | Location | Classification |
| --- | --- | --- |
| `flutterprojects` package name | pubspec and imports | KEEP_TEMPORARY_TECHNICAL_IDENTITY |
| `com.mentalkey.app.flutterprojects` | Android namespace/applicationId | KEEP_TEMPORARY_TECHNICAL_IDENTITY |
| `mental_smile_clean_core` | Local package path | SOURCE_REFERENCE_OR_MIGRATION_TARGET |
