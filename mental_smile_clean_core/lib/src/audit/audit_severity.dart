enum AuditSeverity {
  info,
  notice,
  warning,
  high,
  critical,
}

extension AuditSeverityKey on AuditSeverity {
  String get key {
    switch (this) {
      case AuditSeverity.info:
        return 'info';
      case AuditSeverity.notice:
        return 'notice';
      case AuditSeverity.warning:
        return 'warning';
      case AuditSeverity.high:
        return 'high';
      case AuditSeverity.critical:
        return 'critical';
    }
  }
}
