/// Contact-intent model for Provider Contact.
///
/// This is not a booking, payment, session, treatment, or Firestore model. It
/// only represents: "I want this provider to contact me regarding this service."
class ProviderContactRequest {
  const ProviderContactRequest({
    required this.requestId,
    required this.clientId,
    required this.providerId,
    required this.providerType,
    required this.serviceCategory,
    required this.serviceId,
    required this.requestMessage,
    required this.preferredContactMethod,
    required this.preferredContactWindow,
    required this.status,
    required this.lastActorRole,
    required this.lastActivityAt,
    required this.createdAt,
    required this.updatedAt,
    required this.legacyBookingRequestId,
  });

  static const String statusSubmitted = 'submitted';
  static const String statusViewed = 'viewed';
  static const String statusProviderContacted = 'provider_contacted';
  static const String statusCoordinationPending = 'coordination_pending';
  static const String statusCompleted = 'completed';
  static const String statusCancelled = 'cancelled';

  final String requestId;
  final String clientId;
  final String providerId;
  final String providerType;
  final String serviceCategory;
  final String? serviceId;
  final String requestMessage;
  final String preferredContactMethod;
  final String? preferredContactWindow;
  final String status;
  final String? lastActorRole;
  final DateTime? lastActivityAt;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? legacyBookingRequestId;

  factory ProviderContactRequest.empty({
    String requestId = '',
    String clientId = '',
    String providerId = '',
    String providerType = '',
    String serviceCategory = '',
    DateTime? createdAt,
  }) {
    return ProviderContactRequest(
      requestId: requestId,
      clientId: clientId,
      providerId: providerId,
      providerType: providerType,
      serviceCategory: serviceCategory,
      serviceId: null,
      requestMessage: '',
      preferredContactMethod: '',
      preferredContactWindow: null,
      status: statusSubmitted,
      lastActorRole: null,
      lastActivityAt: null,
      createdAt: createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: null,
      legacyBookingRequestId: null,
    );
  }

  bool get isActive {
    return status == statusSubmitted ||
        status == statusViewed ||
        status == statusProviderContacted ||
        status == statusCoordinationPending;
  }

  bool get isClosed {
    return status == statusCompleted || status == statusCancelled;
  }

  bool get hasLegacyReference {
    return legacyBookingRequestId != null && legacyBookingRequestId!.isNotEmpty;
  }

  ProviderContactRequest copyWith({
    String? requestId,
    String? clientId,
    String? providerId,
    String? providerType,
    String? serviceCategory,
    String? serviceId,
    String? requestMessage,
    String? preferredContactMethod,
    String? preferredContactWindow,
    String? status,
    String? lastActorRole,
    DateTime? lastActivityAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? legacyBookingRequestId,
    bool clearServiceId = false,
    bool clearPreferredContactWindow = false,
    bool clearLastActorRole = false,
    bool clearLastActivityAt = false,
    bool clearUpdatedAt = false,
    bool clearLegacyBookingRequestId = false,
  }) {
    return ProviderContactRequest(
      requestId: requestId ?? this.requestId,
      clientId: clientId ?? this.clientId,
      providerId: providerId ?? this.providerId,
      providerType: providerType ?? this.providerType,
      serviceCategory: serviceCategory ?? this.serviceCategory,
      serviceId: clearServiceId ? null : serviceId ?? this.serviceId,
      requestMessage: requestMessage ?? this.requestMessage,
      preferredContactMethod:
          preferredContactMethod ?? this.preferredContactMethod,
      preferredContactWindow: clearPreferredContactWindow
          ? null
          : preferredContactWindow ?? this.preferredContactWindow,
      status: status ?? this.status,
      lastActorRole:
          clearLastActorRole ? null : lastActorRole ?? this.lastActorRole,
      lastActivityAt:
          clearLastActivityAt ? null : lastActivityAt ?? this.lastActivityAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: clearUpdatedAt ? null : updatedAt ?? this.updatedAt,
      legacyBookingRequestId: clearLegacyBookingRequestId
          ? null
          : legacyBookingRequestId ?? this.legacyBookingRequestId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestId': requestId,
      'clientId': clientId,
      'providerId': providerId,
      'providerType': providerType,
      'serviceCategory': serviceCategory,
      'serviceId': serviceId,
      'requestMessage': requestMessage,
      'preferredContactMethod': preferredContactMethod,
      'preferredContactWindow': preferredContactWindow,
      'status': status,
      'lastActorRole': lastActorRole,
      'lastActivityAt': lastActivityAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'legacyBookingRequestId': legacyBookingRequestId,
    };
  }

  factory ProviderContactRequest.fromMap(Map<String, dynamic> map) {
    return ProviderContactRequest(
      requestId: map['requestId'] as String? ?? '',
      clientId: map['clientId'] as String? ?? '',
      providerId: map['providerId'] as String? ?? '',
      providerType: map['providerType'] as String? ?? '',
      serviceCategory: map['serviceCategory'] as String? ?? '',
      serviceId: map['serviceId'] as String?,
      requestMessage: map['requestMessage'] as String? ?? '',
      preferredContactMethod: map['preferredContactMethod'] as String? ?? '',
      preferredContactWindow: map['preferredContactWindow'] as String?,
      status: map['status'] as String? ?? statusSubmitted,
      lastActorRole: map['lastActorRole'] as String?,
      lastActivityAt: _readDateTime(map['lastActivityAt']),
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
