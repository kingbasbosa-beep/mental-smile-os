/// Passive review visibility vocabulary.
///
/// Visibility labels are metadata only. They do not enforce access control,
/// authorize disclosure, prove backend filtering, or guarantee restricted
/// access. `backendOnly` is passive visibility metadata only.
enum ReviewVisibilityScope {
  restricted,
  safetyTeam,
  auditOnly,
  backendOnly,
}

extension ReviewVisibilityScopeKey on ReviewVisibilityScope {
  String get key {
    switch (this) {
      case ReviewVisibilityScope.restricted:
        return 'restricted';
      case ReviewVisibilityScope.safetyTeam:
        return 'safety_team';
      case ReviewVisibilityScope.auditOnly:
        return 'audit_only';
      case ReviewVisibilityScope.backendOnly:
        return 'backend_only';
    }
  }
}
