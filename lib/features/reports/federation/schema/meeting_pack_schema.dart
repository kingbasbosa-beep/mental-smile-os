import 'federation_report_schema.dart';

class MeetingPackSchema {
  const MeetingPackSchema({
    required this.packId,
    required this.meetingDate,
    required this.reports,
    required this.executiveSummary,
    required this.strategicNotes,
  });

  final String packId;
  final DateTime meetingDate;
  final List<FederationReportSchema> reports;
  final String executiveSummary;
  final List<String> strategicNotes;
}
