import '../models/cross_surface_reference_models.dart';
import '../models/legacy_navigation_models.dart';

abstract class LegacyNavigationAuditor {
  LegacyNavigationAudit auditLegacyNavigation();
}

abstract class CrossSurfaceReferenceAuditor {
  CrossSurfaceAuditReport auditCrossSurfaceReferences();
}

abstract class ControlRoomDecouplingAuditor {
  Object auditControlRoomDecoupling();
}
