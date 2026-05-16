# clean_core Audit Lane Stop Conditions

Stop any future audit lane extraction if any of the following appears.

## Import Stop Conditions

- Firebase import
- Flutter import
- provider SDK import
- networking import
- app-owned `flutterprojects` import
- generated localization import
- routing import
- asset import

## Semantic Stop Conditions

- audit record treated as backend authority
- runtime marker treated as runtime activation
- provider id treated as provider permission
- visibility scope treated as actual auth enforcement
- redaction bypass
- raw sensitive content persistence
- immutable snapshot created by client authority

## Export Stop Conditions

- whole-directory barrel export
- Firestore-coupled files exported publicly
- runtime/provider markers exported without marker-only documentation
- adapter-boundary contracts exported without adapter review

## Stop Condition Verdict

Current audit lane has active stop conditions for `audit_event.dart`, `audit_trace.dart`, and `audit_snapshot.dart` because they import `cloud_firestore`.
