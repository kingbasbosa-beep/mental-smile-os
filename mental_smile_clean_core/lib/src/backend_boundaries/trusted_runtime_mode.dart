enum TrustedRuntimeMode {
  disabled,
  fallbackOnly,
  serverGoverned,
}

extension TrustedRuntimeModeKey on TrustedRuntimeMode {
  String get key {
    switch (this) {
      case TrustedRuntimeMode.disabled:
        return 'disabled';
      case TrustedRuntimeMode.fallbackOnly:
        return 'fallback_only';
      case TrustedRuntimeMode.serverGoverned:
        return 'server_governed';
    }
  }
}
