class AuditHashPlaceholder {
  const AuditHashPlaceholder._();

  static String fromSeed(String seed) {
    final normalized = seed.trim();
    if (normalized.isEmpty) return 'audit_hash_placeholder_empty';
    return 'audit_hash_placeholder_${normalized.length}';
  }
}
