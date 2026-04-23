import 'package:flutterprojects/core/system/domain_registry.dart';

class DomainGovernanceCapability {
  const DomainGovernanceCapability({
    required this.advisoryOnly,
    required this.maintenanceNotice,
    required this.editorDisable,
    required this.entryPointHide,
    required this.protectedRawWrites,
  });

  final bool advisoryOnly;
  final bool maintenanceNotice;
  final bool editorDisable;
  final bool entryPointHide;
  final bool protectedRawWrites;
}

const Map<DomainKey, DomainGovernanceCapability> domainGovernanceMatrix =
    <DomainKey, DomainGovernanceCapability>{
  DomainKey.chat: DomainGovernanceCapability(
    advisoryOnly: true,
    maintenanceNotice: true,
    editorDisable: false,
    entryPointHide: false,
    protectedRawWrites: true,
  ),
  DomainKey.booking: DomainGovernanceCapability(
    advisoryOnly: true,
    maintenanceNotice: true,
    editorDisable: false,
    entryPointHide: false,
    protectedRawWrites: true,
  ),
  DomainKey.specialistWorkspace: DomainGovernanceCapability(
    advisoryOnly: true,
    maintenanceNotice: true,
    editorDisable: false,
    entryPointHide: false,
    protectedRawWrites: true,
  ),
  DomainKey.aiPolicy: DomainGovernanceCapability(
    advisoryOnly: true,
    maintenanceNotice: true,
    editorDisable: true,
    entryPointHide: true,
    protectedRawWrites: false,
  ),
  DomainKey.adminControl: DomainGovernanceCapability(
    advisoryOnly: true,
    maintenanceNotice: true,
    editorDisable: false,
    entryPointHide: false,
    protectedRawWrites: false,
  ),
  DomainKey.library: DomainGovernanceCapability(
    advisoryOnly: true,
    maintenanceNotice: true,
    editorDisable: true,
    entryPointHide: true,
    protectedRawWrites: false,
  ),
  DomainKey.reportsInsights: DomainGovernanceCapability(
    advisoryOnly: true,
    maintenanceNotice: true,
    editorDisable: true,
    entryPointHide: true,
    protectedRawWrites: false,
  ),
  DomainKey.communication: DomainGovernanceCapability(
    advisoryOnly: true,
    maintenanceNotice: true,
    editorDisable: false,
    entryPointHide: false,
    protectedRawWrites: true,
  ),
  DomainKey.marketing: DomainGovernanceCapability(
    advisoryOnly: true,
    maintenanceNotice: true,
    editorDisable: true,
    entryPointHide: true,
    protectedRawWrites: false,
  ),
  DomainKey.externalSessions: DomainGovernanceCapability(
    advisoryOnly: true,
    maintenanceNotice: true,
    editorDisable: false,
    entryPointHide: false,
    protectedRawWrites: true,
  ),
};

DomainGovernanceCapability governanceCapabilityFor(DomainKey key) {
  return domainGovernanceMatrix[key] ??
      const DomainGovernanceCapability(
        advisoryOnly: true,
        maintenanceNotice: false,
        editorDisable: false,
        entryPointHide: false,
        protectedRawWrites: true,
      );
}

extension DomainGovernanceCapabilityX on DomainKey {
  DomainGovernanceCapability get governanceCapability =>
      governanceCapabilityFor(this);
}
