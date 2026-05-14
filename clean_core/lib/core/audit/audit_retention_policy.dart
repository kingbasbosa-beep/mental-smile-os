class AuditRetentionPolicy {
  const AuditRetentionPolicy({
    required this.policyKey,
    required this.retentionDays,
    required this.redactPreview,
    required this.immutableSnapshot,
  });

  static const AuditRetentionPolicy shortTermTrace = AuditRetentionPolicy(
    policyKey: 'short_term_trace',
    retentionDays: 30,
    redactPreview: true,
    immutableSnapshot: false,
  );

  static const AuditRetentionPolicy governanceSnapshot = AuditRetentionPolicy(
    policyKey: 'governance_snapshot',
    retentionDays: 2555,
    redactPreview: true,
    immutableSnapshot: true,
  );

  final String policyKey;
  final int retentionDays;
  final bool redactPreview;
  final bool immutableSnapshot;
}
