class OperationalSignalRegistry {
  const OperationalSignalRegistry._();

  static const String workCardCreated = 'work_card_created';
  static const String workCardReceived = 'work_card_received';
  static const String workCardAcknowledged = 'work_card_acknowledged';
  static const String workCardStarted = 'work_card_started';
  static const String workCardBlocked = 'work_card_blocked';
  static const String workCardResolved = 'work_card_resolved';
  static const String workCardVerified = 'work_card_verified';
  static const String workCardArchived = 'work_card_archived';

  static const String issueDetected = 'issue_detected';
  static const String issueResolved = 'issue_resolved';
  static const String issueReopened = 'issue_reopened';

  static const String complaintReceived = 'complaint_received';
  static const String complaintResolved = 'complaint_resolved';
  static const String complaintEscalated = 'complaint_escalated';

  static const String reportCreated = 'report_created';
  static const String reportReviewed = 'report_reviewed';
  static const String reportArchived = 'report_archived';

  static const String departmentNoteAdded = 'department_note_added';
  static const String departmentDelayDetected = 'department_delay_detected';
  static const String departmentHandoffCreated = 'department_handoff_created';
  static const String departmentHandoffReceived = 'department_handoff_received';

  static const Set<String> workCardSignals = <String>{
    workCardCreated,
    workCardReceived,
    workCardAcknowledged,
    workCardStarted,
    workCardBlocked,
    workCardResolved,
    workCardVerified,
    workCardArchived,
  };

  static const Set<String> issueSignals = <String>{
    issueDetected,
    issueResolved,
    issueReopened,
  };

  static const Set<String> complaintSignals = <String>{
    complaintReceived,
    complaintResolved,
    complaintEscalated,
  };

  static const Set<String> reportActivitySignals = <String>{
    reportCreated,
    reportReviewed,
    reportArchived,
  };

  static const Set<String> departmentPerformanceSignals = <String>{
    departmentNoteAdded,
    departmentDelayDetected,
    departmentHandoffCreated,
    departmentHandoffReceived,
    workCardBlocked,
    workCardResolved,
    workCardVerified,
  };

  static final Set<String> allOperationalSignals = <String>{
    ...workCardSignals,
    ...issueSignals,
    ...complaintSignals,
    ...reportActivitySignals,
    ...departmentPerformanceSignals,
  };
}
