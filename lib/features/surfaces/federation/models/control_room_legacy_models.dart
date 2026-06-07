class ControlRoomLegacyReference {
  const ControlRoomLegacyReference({
    required this.referenceId,
    required this.legacyRoute,
    required this.controlRoomSurface,
    required this.referenceType,
    required this.classification,
  });

  final String referenceId;
  final String legacyRoute;
  final String controlRoomSurface;
  final String referenceType;
  final String classification;
}

class ControlRoomDecouplingAudit {
  const ControlRoomDecouplingAudit({
    required this.auditId,
    required this.references,
    required this.decouplingStatus,
  });

  final String auditId;
  final List<ControlRoomLegacyReference> references;
  final String decouplingStatus;
}
