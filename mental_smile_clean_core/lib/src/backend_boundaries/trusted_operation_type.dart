enum TrustedOperationType {
  bookingOrchestration,
  escalationCreation,
  chatThreadCreation,
  aiSafetyEventCreation,
  aggregateRatingUpdate,
  legalConsentRecording,
  policySnapshotPublishing,
  notificationDispatch,
}

extension TrustedOperationTypeKey on TrustedOperationType {
  String get key {
    switch (this) {
      case TrustedOperationType.bookingOrchestration:
        return 'booking_orchestration';
      case TrustedOperationType.escalationCreation:
        return 'escalation_creation';
      case TrustedOperationType.chatThreadCreation:
        return 'chat_thread_creation';
      case TrustedOperationType.aiSafetyEventCreation:
        return 'ai_safety_event_creation';
      case TrustedOperationType.aggregateRatingUpdate:
        return 'aggregate_rating_update';
      case TrustedOperationType.legalConsentRecording:
        return 'legal_consent_recording';
      case TrustedOperationType.policySnapshotPublishing:
        return 'policy_snapshot_publishing';
      case TrustedOperationType.notificationDispatch:
        return 'notification_dispatch';
    }
  }
}
