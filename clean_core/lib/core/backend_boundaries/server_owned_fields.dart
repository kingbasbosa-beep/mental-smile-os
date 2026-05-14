class ServerOwnedFields {
  const ServerOwnedFields._();

  static const Set<String> admin = {
    'adminDecision',
    'adminDecisionType',
    'adminDecisionBy',
    'adminDecisionAt',
    'adminApproved',
    'adminRejected',
    'adminForwarded',
    'reviewedByAdmin',
  };

  static const Set<String> bookingLifecycle = {
    'workflowStage',
    'sessionStatus',
    'reviewStatus',
    'payoutStatus',
    'paymentStatus',
    'payment_confirmed',
    'adminAssignedBy',
    'adminAssignedAt',
  };

  static const Set<String> escalation = {
    'escalationStatus',
    'escalationSuggested',
    'escalationCreatedAt',
    'escalationResolvedAt',
    'safetyLocked',
    'crisisSeverity',
  };

  static const Set<String> aiGovernance = {
    'runtimeMode',
    'moderationOutcome',
    'policyPublished',
    'policyVersion',
    'policySnapshotId',
    'outputValidated',
    'incidentCreated',
  };

  static const Set<String> all = {
    ...admin,
    ...bookingLifecycle,
    ...escalation,
    ...aiGovernance,
  };
}
