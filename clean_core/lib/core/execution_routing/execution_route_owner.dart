enum ExecutionRouteOwnerType {
  backend,
  governance,
  provider,
  audit,
  review,
  fallback,
}

extension ExecutionRouteOwnerTypeKey on ExecutionRouteOwnerType {
  String get key {
    switch (this) {
      case ExecutionRouteOwnerType.backend:
        return 'backend';
      case ExecutionRouteOwnerType.governance:
        return 'governance';
      case ExecutionRouteOwnerType.provider:
        return 'provider';
      case ExecutionRouteOwnerType.audit:
        return 'audit';
      case ExecutionRouteOwnerType.review:
        return 'review';
      case ExecutionRouteOwnerType.fallback:
        return 'fallback';
    }
  }
}

class ExecutionRouteOwner {
  const ExecutionRouteOwner({
    required this.ownerId,
    required this.ownerType,
    required this.signedAuthorityPlaceholder,
  });

  final String ownerId;
  final ExecutionRouteOwnerType ownerType;
  final String signedAuthorityPlaceholder;

  bool get isTrusted =>
      ownerId.trim().isNotEmpty &&
      signedAuthorityPlaceholder.trim().isNotEmpty;
}
