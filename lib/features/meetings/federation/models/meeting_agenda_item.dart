class MeetingAgendaItem {
  const MeetingAgendaItem({
    required this.agendaId,
    required this.title,
    required this.description,
    required this.category,
    required this.relatedReportCode,
    required this.relatedPackageCode,
    required this.priority,
  });

  final String agendaId;
  final String title;
  final String description;
  final String category;
  final String relatedReportCode;
  final String relatedPackageCode;
  final String priority;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'agendaId': agendaId,
      'title': title,
      'description': description,
      'category': category,
      'relatedReportCode': relatedReportCode,
      'relatedPackageCode': relatedPackageCode,
      'priority': priority,
    };
  }
}
