enum AuditActorType {
  client,
  clinician,
  center,
  admin,
  trustedServer,
  system,
}

extension AuditActorTypeKey on AuditActorType {
  String get key {
    switch (this) {
      case AuditActorType.client:
        return 'client';
      case AuditActorType.clinician:
        return 'clinician';
      case AuditActorType.center:
        return 'center';
      case AuditActorType.admin:
        return 'admin';
      case AuditActorType.trustedServer:
        return 'trusted_server';
      case AuditActorType.system:
        return 'system';
    }
  }
}
