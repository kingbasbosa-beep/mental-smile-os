class ControlRoomCleanupProfile {
  const ControlRoomCleanupProfile({
    required this.profileId,
    required this.referenceType,
    required this.oldReference,
    required this.federationReplacement,
    required this.cleanupAction,
  });

  final String profileId;
  final String referenceType;
  final String oldReference;
  final String federationReplacement;
  final String cleanupAction;
}
