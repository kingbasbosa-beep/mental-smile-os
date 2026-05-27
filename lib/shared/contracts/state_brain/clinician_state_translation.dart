class ClinicianStateTranslation {
  final String progress;
  final String? ownership;
  final String? operationalSignal;
  final String? ambiguity;

  const ClinicianStateTranslation({
    required this.progress,
    required this.ownership,
    required this.operationalSignal,
    required this.ambiguity,
  });
}

ClinicianStateTranslation translateClinicianState(String rawState) {
  switch (rawState) {
    case 'assigned_clinician':
      return const ClinicianStateTranslation(
        progress: 'in clinician-assigned phase',
        ownership: 'clinician-related',
        operationalSignal: 'assignment indicator present',
        ambiguity: 'used in both booking flow and chat lifecycle',
      );
    case 'awaiting_payment':
      return const ClinicianStateTranslation(
        progress: 'in payment-waiting phase after clinician decision',
        ownership: 'non-clinician primary',
        operationalSignal: 'payment dependency indicator present',
        ambiguity: null,
      );
    case 'clinician_rejected':
      return const ClinicianStateTranslation(
        progress: 'terminal rejected outcome after clinician decision',
        ownership: 'clinician-owned',
        operationalSignal: 'clinician rejection recorded',
        ambiguity: null,
      );
    case 'forwarded_to_clinician':
      return const ClinicianStateTranslation(
        progress: 'in transfer-to-clinician phase',
        ownership: 'clinician-related',
        operationalSignal: 'forward event recorded',
        ambiguity: null,
      );
    case 'clinician_review':
      return const ClinicianStateTranslation(
        progress: 'in active clinician review phase',
        ownership: 'clinician-related',
        operationalSignal: 'clinician review indicator present',
        ambiguity: null,
      );
    case 'resolved':
      return const ClinicianStateTranslation(
        progress: 'terminal handled/closed phase in escalation flow',
        ownership: 'non-clinician or mixed',
        operationalSignal: 'resolution recorded',
        ambiguity: 'resolution may be done by different actors',
      );
    case 'pending_clinician':
      return const ClinicianStateTranslation(
        progress: 'in waiting-for-clinician phase',
        ownership: 'clinician-related',
        operationalSignal: 'clinician action pending indicator present',
        ambiguity: 'current runtime use is unconfirmed',
      );
    case 'accepted':
      return const ClinicianStateTranslation(
        progress: 'terminal accepted outcome after clinician decision',
        ownership: 'clinician-owned if used in clinician flow',
        operationalSignal: 'approval recorded',
        ambiguity:
            'current runtime use is unconfirmed and newer code uses different names',
      );
    case 'approved':
      return const ClinicianStateTranslation(
        progress: 'terminal approved outcome',
        ownership: 'mixed',
        operationalSignal: 'approval recorded',
        ambiguity: 'appears in multiple domains, not only clinician flow',
      );
    case 'rejected':
      return const ClinicianStateTranslation(
        progress: 'terminal rejected outcome',
        ownership: 'mixed',
        operationalSignal: 'rejection recorded',
        ambiguity: 'appears in multiple domains, not only clinician flow',
      );
    case 'open':
      return const ClinicianStateTranslation(
        progress: 'in active unresolved escalation phase',
        ownership: 'non-clinician primary',
        operationalSignal: 'unresolved indicator present',
        ambiguity: 'can exist before clinician involvement',
      );
    case 'rejected_admin':
      return const ClinicianStateTranslation(
        progress: 'terminal rejected outcome by admin decision',
        ownership: 'non-clinician',
        operationalSignal: 'admin rejection recorded',
        ambiguity: null,
      );
    default:
      return const ClinicianStateTranslation(
        progress: 'unknown',
        ownership: null,
        operationalSignal: null,
        ambiguity: null,
      );
  }
}
