class SystemTopologyLock {
  const SystemTopologyLock({
    required this.locked,
    required this.sealed,
    required this.reasonKey,
  });

  static const SystemTopologyLock safeDefault = SystemTopologyLock(
    locked: true,
    sealed: true,
    reasonKey: 'system_topology_locked_by_default',
  );

  final bool locked;
  final bool sealed;
  final String reasonKey;
}
