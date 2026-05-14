import 'package:cloud_firestore/cloud_firestore.dart';

import 'legal_consent_types.dart';

class LegalConsentRecord {
  const LegalConsentRecord({
    required this.uid,
    required this.consentType,
    required this.accepted,
    required this.version,
    required this.acceptedAt,
    required this.locale,
    required this.policyVersion,
    required this.source,
    required this.createdBy,
    this.ipHashPlaceholder,
    this.userAgentPlaceholder,
  });

  final String uid;
  final LegalConsentType consentType;
  final bool accepted;
  final String version;
  final DateTime? acceptedAt;
  final String locale;
  final String policyVersion;
  final String source;
  final String createdBy;
  final String? ipHashPlaceholder;
  final String? userAgentPlaceholder;

  Map<String, Object?> toMap() {
    return {
      'uid': uid,
      'consentType': consentType.key,
      'accepted': accepted,
      'version': version,
      'acceptedAt': acceptedAt == null ? null : Timestamp.fromDate(acceptedAt!),
      'locale': locale,
      'policyVersion': policyVersion,
      'source': source,
      'createdBy': createdBy,
      'ipHashPlaceholder': ipHashPlaceholder,
      'userAgentPlaceholder': userAgentPlaceholder,
    };
  }

  static LegalConsentRecord? fromMap(Map<String, dynamic> data) {
    final type = legalConsentTypeFromKey(
      (data['consentType'] ?? '').toString(),
    );
    if (type == null) return null;

    return LegalConsentRecord(
      uid: (data['uid'] ?? '').toString(),
      consentType: type,
      accepted: data['accepted'] == true,
      version: (data['version'] ?? '').toString(),
      acceptedAt: _readDateTime(data['acceptedAt']),
      locale: (data['locale'] ?? '').toString(),
      policyVersion: (data['policyVersion'] ?? '').toString(),
      source: (data['source'] ?? '').toString(),
      createdBy: (data['createdBy'] ?? '').toString(),
      ipHashPlaceholder: _readNullableText(data['ipHashPlaceholder']),
      userAgentPlaceholder: _readNullableText(data['userAgentPlaceholder']),
    );
  }

  static DateTime? _readDateTime(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static String? _readNullableText(Object? value) {
    final text = (value ?? '').toString().trim();
    return text.isEmpty ? null : text;
  }
}
