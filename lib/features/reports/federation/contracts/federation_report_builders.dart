import '../schema/federation_report_schema.dart';
import '../schema/meeting_pack_schema.dart';

abstract class FederationReportBuilder {
  FederationReportSchema buildFederationReport();
}

abstract class ExecutivePackBuilder {
  MeetingPackSchema buildExecutivePack();
}

abstract class StrategicSummaryBuilder {
  FederationReportSchema buildStrategicSummary();
}

abstract class ConstitutionalReportBuilder {
  FederationReportSchema buildConstitutionalReport();
}
