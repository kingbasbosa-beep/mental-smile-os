# clean_core Future Reconnect Strategy

## Current Reconnect Status

Reconnect remains minimal and temporary. Some affected tests may use relative imports into the package shell until package identity exists.

## Future Reconnect Flow

Recommended order:

1. introduce package identity
2. add host path dependency
3. convert scoped tests to package imports
4. convert limited host contract imports
5. introduce adapter contracts where needed
6. defer runtime bridges until separate approval

## Temporary Path Dependency

Future host app dependency should be local path based at first:

```yaml
mental_smile_clean_core:
  path: ./mental_smile_clean_core
```

This is conceptual only. No pubspec is created now.

## Scoped Reconnect Rules

Reconnect must:

- be file-scoped
- be review-backed
- avoid broad rewrites
- preserve rollback
- avoid app-owned migration
- keep runtime disabled
- keep provider execution blocked

## Adapter-Only Reconnect

External systems reconnect through adapters only:

- Firebase bridge adapter
- auth/session adapter
- routing intent adapter
- localization/text adapter
- environment/config adapter
- provider bridge adapter
- backend bridge adapter
- observability adapter

## Reconnect Verdict

Reconnect should proceed only after package identity exists and should remain contract-first, adapter-isolated, and fail-closed.
