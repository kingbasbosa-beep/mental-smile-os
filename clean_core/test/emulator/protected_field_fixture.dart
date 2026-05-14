class ProtectedFieldFixture {
  const ProtectedFieldFixture._();

  static const Map<String, Object?> protectedClientPayload = {
    'clientId': 'client_001',
    'note': 'safe booking note',
    'workflowStage': 'approved',
    'paymentStatus': 'paid',
    'adminDecision': 'approved',
    'runtimeMode': 'server_governed',
    'moderationOutcome': 'allowed',
    'escalationStatus': 'open',
  };

  static const Set<String> expectedProtectedFields = {
    'workflowStage',
    'paymentStatus',
    'adminDecision',
    'runtimeMode',
    'moderationOutcome',
    'escalationStatus',
  };
}
