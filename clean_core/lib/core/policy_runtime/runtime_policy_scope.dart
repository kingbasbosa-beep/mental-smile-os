enum RuntimePolicyScope {
  global,
  aiSupport,
  bookingSafety,
  crisisSupport,
  complianceReview,
}

extension RuntimePolicyScopeKey on RuntimePolicyScope {
  String get key {
    switch (this) {
      case RuntimePolicyScope.global:
        return 'global';
      case RuntimePolicyScope.aiSupport:
        return 'ai_support';
      case RuntimePolicyScope.bookingSafety:
        return 'booking_safety';
      case RuntimePolicyScope.crisisSupport:
        return 'crisis_support';
      case RuntimePolicyScope.complianceReview:
        return 'compliance_review';
    }
  }
}
