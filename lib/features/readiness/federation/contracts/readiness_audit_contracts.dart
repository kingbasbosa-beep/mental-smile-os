import '../models/federation_readiness_snapshot.dart';
import '../models/surface_audit_snapshot.dart';
import '../reports/operational_readiness_audit_report.dart';

abstract class SurfaceReadinessAuditor {
  SurfaceAuditSnapshot auditSurface(String surfaceId);
}

abstract class FederationReadinessAuditor {
  FederationReadinessSnapshot auditFederation();
}

abstract class OperationalReadinessAuditReportBuilder {
  OperationalReadinessAuditReport buildOperationalReadinessReport();
}
