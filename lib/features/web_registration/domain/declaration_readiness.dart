import 'package:cloud_firestore/cloud_firestore.dart';

class DeclarationReadiness {
  DeclarationReadiness._();

  static const String incomplete = 'incomplete';
  static const String ready = 'ready';
  static const String webRegistrationSource = 'web_registration_signals_v1';

  static const List<String> clinicianRequiredSignals = <String>[
    'clinician.identity.role_declared',
    'clinician.identity.display_name',
    'clinician.identity.email',
    'clinician.identity.professional_title',
    'clinician.identity.specialty',
    'clinician.documents.submitted',
    'clinician.documents.identity_file',
    'clinician.documents.certificate_file',
  ];

  static const List<String> centerRequiredSignals = <String>[
    'center.identity.role_declared',
    'center.identity.name',
    'center.identity.email',
    'center.identity.category',
    'center.identity.center_type',
    'center.profile.manager_name',
    'center.profile.phone',
    'center.location.city',
    'center.location.address',
    'center.profile.description',
    'center.media.front_image',
    'center.media.reception_image',
    'center.media.inside_image_1',
    'center.media.inside_image_2',
    'center.pricing.ready',
    'center.documents.identity_proof',
    'center.documents.center_license',
    'center.documents.location_proof',
    'center.documents.ready',
  ];

  static Map<String, dynamic> clinicianPayload({
    required Map<String, dynamic> currentData,
    Map<String, dynamic> changes = const <String, dynamic>{},
  }) {
    final merged = <String, dynamic>{...currentData, ...changes};
    final signals = _clinicianSignals(merged);
    return <String, dynamic>{
      ...changes,
      ..._readinessFields(
        signals: signals,
        requiredSignals: clinicianRequiredSignals,
      ),
    };
  }

  static Map<String, dynamic> centerPayload({
    required Map<String, dynamic> currentData,
    Map<String, dynamic> changes = const <String, dynamic>{},
  }) {
    final merged = <String, dynamic>{...currentData, ...changes};
    final signals = _centerSignals(merged);
    return <String, dynamic>{
      ...changes,
      ..._readinessFields(
        signals: signals,
        requiredSignals: centerRequiredSignals,
      ),
    };
  }

  static Map<String, dynamic> _readinessFields({
    required Map<String, bool> signals,
    required List<String> requiredSignals,
  }) {
    final completedSignals = signals.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList(growable: false)
      ..sort();
    final missingSignals = requiredSignals
        .where((signalId) => signals[signalId] != true)
        .toList(growable: false)
      ..sort();

    return <String, dynamic>{
      'declarationSignals': signals,
      'visibilityReadiness':
          missingSignals.isEmpty
              ? DeclarationReadiness.ready
              : DeclarationReadiness.incomplete,
      'missingSignals': missingSignals,
      'completedSignals': completedSignals,
      'readinessUpdatedAt': FieldValue.serverTimestamp(),
      'readinessSource': webRegistrationSource,
    };
  }

  static Map<String, bool> _clinicianSignals(Map<String, dynamic> data) {
    final providerSignals = _map(data['providerSignals']);
    return <String, bool>{
      'clinician.identity.role_declared': _text(data['role']) == 'clinician',
      'clinician.identity.display_name': _hasText(data['displayName']),
      'clinician.identity.email': _hasText(data['email']),
      'clinician.identity.professional_title':
          _hasText(data['professionalTitleKey']),
      'clinician.identity.specialty': _hasText(data['specialtyKey']),
      'clinician.profile.photo': _hasText(data['photoUrl']),
      'clinician.profile.bio': _hasText(data['bio']),
      'clinician.signals.capability':
          _hasItems(providerSignals['capabilitySignals']),
      'clinician.signals.accessibility':
          _hasItems(providerSignals['accessibilitySignals']),
      'clinician.signals.communication':
          _hasItems(providerSignals['communicationSignals']),
      'clinician.signals.learning':
          _hasItems(providerSignals['learningSignals']),
      'clinician.documents.submitted': data['documentsSubmitted'] == true,
      'clinician.documents.identity_file':
          _hasText(data['identityFileName']),
      'clinician.documents.certificate_file':
          _hasText(data['certificateFileName']),
      'clinician.documents.extra_file': _hasText(data['extraFileName']),
      'clinician.safety.not_blocked': data['isBlocked'] != true,
    };
  }

  static Map<String, bool> _centerSignals(Map<String, dynamic> data) {
    final galleryBySlot = <String, Map<String, dynamic>>{
      for (final item in _mapList(data['galleryItems']))
        _text(item['slotKey']): item,
    };
    final documentsByType = <String, Map<String, dynamic>>{
      for (final item in _mapList(data['documentItems']))
        _text(item['documentType']): item,
    };

    bool galleryReady(String slotKey) =>
        _hasText(galleryBySlot[slotKey]?['url']);
    bool documentReady(String documentType) =>
        _hasText(documentsByType[documentType]?['fileName']);

    return <String, bool>{
      'center.identity.role_declared': _text(data['role']) == 'center',
      'center.identity.name':
          _hasText(data['centerName']) || _hasText(data['displayName']),
      'center.identity.email': _hasText(data['email']),
      'center.identity.category': _hasText(data['category']),
      'center.identity.center_type': _hasText(data['centerType']),
      'center.profile.manager_name': _hasText(data['managerName']),
      'center.profile.phone':
          _hasText(data['phone']) || _hasText(data['phoneNumber']),
      'center.profile.whatsapp':
          _hasText(data['whatsapp']) || _hasText(data['whatsappNumber']),
      'center.location.city': _hasText(data['city']),
      'center.location.area': _hasText(data['area']),
      'center.location.address': _hasText(data['address']),
      'center.profile.description': _hasText(data['description']),
      'center.capability.detox_unit': data['hasDetoxUnit'] == true,
      'center.signals.capabilities': _map(data['centerCapabilities']).isNotEmpty,
      'center.media.front_image': galleryReady('front'),
      'center.media.reception_image': galleryReady('reception'),
      'center.media.inside_image_1': galleryReady('inside_1'),
      'center.media.inside_image_2': galleryReady('inside_2'),
      'center.pricing.ready': data['pricingReady'] == true,
      'center.documents.identity_proof': documentReady('identity_proof'),
      'center.documents.center_license': documentReady('center_license'),
      'center.documents.location_proof': documentReady('location_proof'),
      'center.documents.ready': data['documentsReady'] == true,
      'center.safety.not_blocked': data['isBlocked'] != true,
    };
  }

  static bool _hasText(dynamic value) => _text(value).isNotEmpty;

  static String _text(dynamic value) => (value ?? '').toString().trim();

  static bool _hasItems(dynamic value) => value is Iterable && value.isNotEmpty;

  static Map<String, dynamic> _map(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, item) => MapEntry('$key', item));
    }
    return const <String, dynamic>{};
  }

  static List<Map<String, dynamic>> _mapList(dynamic value) {
    if (value is! Iterable) return const <Map<String, dynamic>>[];
    return value
        .whereType<Map>()
        .map((item) => item.map((key, entry) => MapEntry('$key', entry)))
        .toList(growable: false);
  }
}
