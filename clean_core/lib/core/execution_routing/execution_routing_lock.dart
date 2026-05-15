class ExecutionRoutingLock {
  const ExecutionRoutingLock({
    required this.locked,
    required this.sealed,
    required this.routingBlocked,
    required this.reasonKey,
  });

  final bool locked;
  final bool sealed;
  final bool routingBlocked;
  final String reasonKey;

  static const safeDefault = ExecutionRoutingLock(
    locked: true,
    sealed: true,
    routingBlocked: true,
    reasonKey: 'execution_routing_locked_by_default',
  );
}
