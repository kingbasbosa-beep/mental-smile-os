enum AuditVisibilityScope {
  privateUser,
  adminReview,
  complianceReview,
  trustedServerOnly,
}

extension AuditVisibilityScopeKey on AuditVisibilityScope {
  String get key {
    switch (this) {
      case AuditVisibilityScope.privateUser:
        return 'private_user';
      case AuditVisibilityScope.adminReview:
        return 'admin_review';
      case AuditVisibilityScope.complianceReview:
        return 'compliance_review';
      case AuditVisibilityScope.trustedServerOnly:
        return 'trusted_server_only';
    }
  }
}
