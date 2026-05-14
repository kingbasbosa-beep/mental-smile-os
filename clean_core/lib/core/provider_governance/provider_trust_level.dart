enum ProviderTrustLevel {
  blocked,
  restricted,
  limited,
  reviewed,
  approved,
}

extension ProviderTrustLevelKey on ProviderTrustLevel {
  String get key {
    switch (this) {
      case ProviderTrustLevel.blocked:
        return 'blocked';
      case ProviderTrustLevel.restricted:
        return 'restricted';
      case ProviderTrustLevel.limited:
        return 'limited';
      case ProviderTrustLevel.reviewed:
        return 'reviewed';
      case ProviderTrustLevel.approved:
        return 'approved';
    }
  }
}
