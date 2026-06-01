/// Lightweight coordination state model.
///
/// This model represents service coordination only, not booking confirmation,
/// payment, treatment, session ownership, or Firestore data.
class ServiceCoordination {
  const ServiceCoordination({
    required this.coordinationId,
    required this.requestId,
    required this.clientId,
    required this.providerId,
    required this.providerType,
    required this.serviceCategory,
    required this.coordinationStatus,
    required this.coordinationNotes,
    required this.preferredTimeWindow,
    required this.lastActorRole,
    required this.lastActivityAt,
    required this.followUpNeededAt,
    required this.createdAt,
    required this.updatedAt,
    required this.legacyBookingRequestId,
  });

  static const String statusInitiated = 'initiated';
  static const String statusActive = 'active';
  static const String statusAwaitingResponse = 'awaiting_response';
  static const String statusFollowUpNeeded = 'follow_up_needed';
  static const String statusCompleted = 'completed';
  static const String statusCancelled = 'cancelled';

  final String coordinationId;
  final String requestId;
  final String clientId;
  final String providerId;
  final String providerType;
  final String serviceCategory;
  final String coordinationStatus;
  final String? coordinationNotes;
  final String? preferredTimeWindow;
  final String? lastActorRole;
  final DateTime? lastActivityAt;
  final DateTime? followUpNeededAt;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? legacyBookingRequestId;

  factory ServiceCoordination.empty({
    String coordinationId = '',
    String requestId = '',
    String clientId = '',
    String providerId = '',
    String providerType = '',
    String serviceCategory = '',
    DateTime? createdAt,
  }) {
    return ServiceCoordination(
      coordinationId: coordinationId,
      requestId: requestId,
      clientId: clientId,
      providerId: providerId,
      providerType: providerType,
      serviceCategory: serviceCategory,
      coordinationStatus: statusInitiated,
      coordinationNotes: null,
      preferredTimeWindow: null,
      lastActorRole: null,
      lastActivityAt: null,
      followUpNeededAt: null,
      createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: null,
      legacyBookingRequestId: null,
    );
  }

  bool get isActive {
    return coordinationStatus == statusInitiated ||
        coordinationStatus == statusActive ||
        coordinationStatus == statusAwaitingResponse ||
        coordinationStatus == statusFollowUpNeeded;
  }

  bool get isClosed {
    return coordinationStatus == statusCompleted ||
        coordinationStatus == statusCancelled;
  }

  bool get needsFollowUp => coordinationStatus == statusFollowUpNeeded;

  bool get hasLegacyReference {
    return legacyBookingRequestId != null && legacyBookingRequestId!.isNotEmpty;
  }

  ServiceCoordination copyWith({
    String? coordinationId,
    String? requestId,
    String? clientId,
    String? providerId,
    String? providerType,
    String? serviceCategory,
    String? coordinationStatus,
    String? coordinationNotes,
    String? preferredTimeWindow,
    String? lastActorRole,
    DateTime? lastActivityAt,
    DateTime? followUpNeededAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? legacyBookingRequestId,
    bool clearCoordinationNotes = false,
    bool clearPreferredTimeWindow = false,
    bool clearLastActorRole = false,
    bool clearLastActivityAt = false,
    bool clearFollowUpNeededAt = false,
    bool clearUpdatedAt = false,
    bool clearLegacyBookingRequestId = false,
  }) {
    return ServiceCoordination(
      coordinationId: coordinationId ?? this.coordinationId,
      requestId: requestId ?? this.requestId,
      clientId: clientId ?? this.clientId,
      providerId: providerId ?? this.providerId,
      providerType: providerType ?? this.providerType,
      serviceCategory: serviceCategory ?? this.serviceCategory,
      coordinationStatus: coordinationStatus ?? this.coordinationStatus,
      coordinationNotes: clearCoordinationNotes
          ? null
          : coordinationNotes ?? this.coordinationNotes,
      preferredTimeWindow: clearPreferredTimeWindow
          ? null
          : preferredTimeWindow ?? this.preferredTimeWindow,
      lastActorRole:
          clearLastActorRole ? null : lastActorRole ?? this.lastActorRole,
      lastActivityAt:
          clearLastActivityAt ? null : lastActivityAt ?? this.lastActivityAt,
      followUpNeededAt: clearFollowUpNeededAt
          ? null
          : followUpNeededAt ?? this.followUpNeededAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: clearUpdatedAt ? null : updatedAt ?? this.updatedAt,
      legacyBookingRequestId: clearLegacyBookingRequestId
          ? null
          : legacyBookingRequestId ?? this.legacyBookingRequestId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coordinationId': coordinationId,
      'requestId': requestId,
      'clientId': clientId,
      'providerId': providerId,
      'providerType': providerType,
      'serviceCategory': serviceCategory,
      'coordinationStatus': coordinationStatus,
      'coordinationNotes': coordinationNotes,
      'preferredTimeWindow': preferredTimeWindow,
      'lastActorRole': lastActorRole,
      'lastActivityAt': lastActivityAt?.toIso8601String(),
      'followUpNeededAt': followUpNeededAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'legacyBookingRequestId': legacyBookingRequestId,
    };
  }

  factory ServiceCoordination.fromMap(Map<String, dynamic> map) {
    return ServiceCoordination(
      coordinationId: map['coordinationId'] as String? ?? '',
      requestId: map['requestId'] as String? ?? '',
      clientId: map['clientId'] as String? ?? '',
      providerId: map['providerId'] as String? ?? '',
      providerType: map['providerType'] as String? ?? '',
      serviceCategory: map['serviceCategory'] as String? ?? '',
      coordinationStatus:
          map['coordinationStatus'] as String? ?? statusInitiated,
      coordinationNotes: map['coordinationNotes'] as String?,
      preferredTimeWindow: map['preferredTimeWindow'] as String?,
      lastActorRole: map['lastActorRole'] as String?,
      lastActivityAt: _readDateTime(map['lastActivityAt']),
      followUpNeededAt: _readDateTime(map['followUpNeededAt']),
      createdAt: _readDateTime(map['createdAt']) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: _readDateTime(map['updatedAt']),
      legacyBookingRequestId: map['legacyBookingRequestId'] as String?,
    );
  }

  static DateTime? _readDateTime(Object? value) {
    if (value is DateTime) {
      return value;
    }
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}
