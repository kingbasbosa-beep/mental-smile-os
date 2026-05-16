enum RuntimePolicyMode {
  disabled,
  fallbackOnly,
  restrictedProvider,
  serverGoverned,
}

extension RuntimePolicyModeKey on RuntimePolicyMode {
  String get key {
    switch (this) {
      case RuntimePolicyMode.disabled:
        return 'disabled';
      case RuntimePolicyMode.fallbackOnly:
        return 'fallback_only';
      case RuntimePolicyMode.restrictedProvider:
        return 'restricted_provider';
      case RuntimePolicyMode.serverGoverned:
        return 'server_governed';
    }
  }
}
