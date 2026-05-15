enum RuntimeWiringOwnerType {
  backend,
  governance,
  runtime,
  provider,
  audit,
  review,
}

extension RuntimeWiringOwnerTypeKey on RuntimeWiringOwnerType {
  String get key {
    switch (this) {
      case RuntimeWiringOwnerType.backend:
        return 'backend';
      case RuntimeWiringOwnerType.governance:
        return 'governance';
      case RuntimeWiringOwnerType.runtime:
        return 'runtime';
      case RuntimeWiringOwnerType.provider:
        return 'provider';
      case RuntimeWiringOwnerType.audit:
        return 'audit';
      case RuntimeWiringOwnerType.review:
        return 'review';
    }
  }
}

class RuntimeWiringOwner {
  const RuntimeWiringOwner({
    required this.ownerId,
    required this.ownerType,
    required this.signedAuthorityPlaceholder,
  });

  final String ownerId;
  final RuntimeWiringOwnerType ownerType;
  final String signedAuthorityPlaceholder;

  bool get isTrusted =>
      ownerId.trim().isNotEmpty &&
      signedAuthorityPlaceholder.trim().isNotEmpty;
}
