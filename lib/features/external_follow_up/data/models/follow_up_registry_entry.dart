import 'package:cloud_firestore/cloud_firestore.dart';

class FollowUpRegistryEntry {
  const FollowUpRegistryEntry({
    required this.id,
    required this.displayName,
    required this.source,
    required this.status,
    required this.followUpTypes,
    this.educationalTopics = const <String>[],
    this.consentAccepted = false,
    this.phoneNumber,
    this.email,
    this.gender,
    this.preferredContactChannel,
    this.createdAt,
    this.updatedAt,
    this.registeredByUid,
    this.birthDate,
    this.birthDay,
    this.birthMonth,
    this.supportFrequency,
    this.recoveryStartDate,
    this.recoveryFrequency,
    this.recoveryStartMonth,
    this.recoveryStartYear,
    this.recoveryStatus,
    this.consentAcceptedAt,
    this.notes,
  });

  final String id;
  final String displayName;
  final String? phoneNumber;
  final String? email;
  final String? gender;
  final String? preferredContactChannel;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? registeredByUid;
  final String source;
  final String status;
  final List<String> followUpTypes;
  final DateTime? birthDate;
  final int? birthDay;
  final int? birthMonth;
  final String? supportFrequency;
  final DateTime? recoveryStartDate;
  final String? recoveryFrequency;
  final int? recoveryStartMonth;
  final int? recoveryStartYear;
  final String? recoveryStatus;
  final List<String> educationalTopics;
  final bool consentAccepted;
  final DateTime? consentAcceptedAt;
  final String? notes;

  factory FollowUpRegistryEntry.fromMap(Map<String, dynamic> map) {
    return FollowUpRegistryEntry(
      id: _stringValue(map['id']),
      displayName: _stringValue(map['displayName']),
      phoneNumber: _nullableStringValue(map['phoneNumber']),
      email: _nullableStringValue(map['email']),
      gender: _nullableStringValue(map['gender']),
      preferredContactChannel:
          _nullableStringValue(map['preferredContactChannel']),
      createdAt: _nullableDateTimeValue(map['createdAt']),
      updatedAt: _nullableDateTimeValue(map['updatedAt']),
      registeredByUid: _nullableStringValue(map['registeredByUid']),
      source: _stringValue(map['source']),
      status: _stringValue(map['status']),
      followUpTypes: _stringListValue(map['followUpTypes']),
      birthDate: _nullableDateTimeValue(map['birthDate']),
      birthDay: _nullableIntValue(map['birthDay']),
      birthMonth: _nullableIntValue(map['birthMonth']),
      supportFrequency: _nullableStringValue(map['supportFrequency']),
      recoveryStartDate: _nullableDateTimeValue(map['recoveryStartDate']),
      recoveryFrequency: _nullableStringValue(map['recoveryFrequency']),
      recoveryStartMonth: _nullableIntValue(map['recoveryStartMonth']),
      recoveryStartYear: _nullableIntValue(map['recoveryStartYear']),
      recoveryStatus: _nullableStringValue(map['recoveryStatus']),
      educationalTopics: _stringListValue(map['educationalTopics']),
      consentAccepted: _boolValue(map['consentAccepted']),
      consentAcceptedAt: _nullableDateTimeValue(map['consentAcceptedAt']),
      notes: _nullableStringValue(map['notes']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'email': email,
      'gender': gender,
      'preferredContactChannel': preferredContactChannel,
      'createdAt': _timestampOrNull(createdAt),
      'updatedAt': _timestampOrNull(updatedAt),
      'registeredByUid': registeredByUid,
      'source': source,
      'status': status,
      'followUpTypes': followUpTypes,
      'birthDate': _timestampOrNull(birthDate),
      'birthDay': birthDay,
      'birthMonth': birthMonth,
      'supportFrequency': supportFrequency,
      'recoveryStartDate': _timestampOrNull(recoveryStartDate),
      'recoveryFrequency': recoveryFrequency,
      'recoveryStartMonth': recoveryStartMonth,
      'recoveryStartYear': recoveryStartYear,
      'recoveryStatus': recoveryStatus,
      'educationalTopics': educationalTopics,
      'consentAccepted': consentAccepted,
      'consentAcceptedAt': _timestampOrNull(consentAcceptedAt),
      'notes': notes,
    };
  }

  FollowUpRegistryEntry copyWith({
    String? id,
    String? displayName,
    String? phoneNumber,
    bool clearPhoneNumber = false,
    String? email,
    bool clearEmail = false,
    String? gender,
    bool clearGender = false,
    String? preferredContactChannel,
    bool clearPreferredContactChannel = false,
    DateTime? createdAt,
    bool clearCreatedAt = false,
    DateTime? updatedAt,
    bool clearUpdatedAt = false,
    String? registeredByUid,
    bool clearRegisteredByUid = false,
    String? source,
    String? status,
    List<String>? followUpTypes,
    DateTime? birthDate,
    bool clearBirthDate = false,
    int? birthDay,
    bool clearBirthDay = false,
    int? birthMonth,
    bool clearBirthMonth = false,
    String? supportFrequency,
    bool clearSupportFrequency = false,
    DateTime? recoveryStartDate,
    bool clearRecoveryStartDate = false,
    String? recoveryFrequency,
    bool clearRecoveryFrequency = false,
    int? recoveryStartMonth,
    bool clearRecoveryStartMonth = false,
    int? recoveryStartYear,
    bool clearRecoveryStartYear = false,
    String? recoveryStatus,
    bool clearRecoveryStatus = false,
    List<String>? educationalTopics,
    bool? consentAccepted,
    DateTime? consentAcceptedAt,
    bool clearConsentAcceptedAt = false,
    String? notes,
    bool clearNotes = false,
  }) {
    return FollowUpRegistryEntry(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      phoneNumber: clearPhoneNumber ? null : (phoneNumber ?? this.phoneNumber),
      email: clearEmail ? null : (email ?? this.email),
      gender: clearGender ? null : (gender ?? this.gender),
      preferredContactChannel: clearPreferredContactChannel
          ? null
          : (preferredContactChannel ?? this.preferredContactChannel),
      createdAt: clearCreatedAt ? null : (createdAt ?? this.createdAt),
      updatedAt: clearUpdatedAt ? null : (updatedAt ?? this.updatedAt),
      registeredByUid: clearRegisteredByUid
          ? null
          : (registeredByUid ?? this.registeredByUid),
      source: source ?? this.source,
      status: status ?? this.status,
      followUpTypes: followUpTypes ?? this.followUpTypes,
      birthDate: clearBirthDate ? null : (birthDate ?? this.birthDate),
      birthDay: clearBirthDay ? null : (birthDay ?? this.birthDay),
      birthMonth: clearBirthMonth ? null : (birthMonth ?? this.birthMonth),
      supportFrequency: clearSupportFrequency
          ? null
          : (supportFrequency ?? this.supportFrequency),
      recoveryStartDate: clearRecoveryStartDate
          ? null
          : (recoveryStartDate ?? this.recoveryStartDate),
      recoveryFrequency: clearRecoveryFrequency
          ? null
          : (recoveryFrequency ?? this.recoveryFrequency),
      recoveryStartMonth: clearRecoveryStartMonth
          ? null
          : (recoveryStartMonth ?? this.recoveryStartMonth),
      recoveryStartYear: clearRecoveryStartYear
          ? null
          : (recoveryStartYear ?? this.recoveryStartYear),
      recoveryStatus: clearRecoveryStatus
          ? null
          : (recoveryStatus ?? this.recoveryStatus),
      educationalTopics: educationalTopics ?? this.educationalTopics,
      consentAccepted: consentAccepted ?? this.consentAccepted,
      consentAcceptedAt: clearConsentAcceptedAt
          ? null
          : (consentAcceptedAt ?? this.consentAcceptedAt),
      notes: clearNotes ? null : (notes ?? this.notes),
    );
  }

  static String _stringValue(dynamic value) {
    return (value ?? '').toString().trim();
  }

  static String? _nullableStringValue(dynamic value) {
    final text = (value ?? '').toString().trim();
    return text.isEmpty ? null : text;
  }

  static List<String> _stringListValue(dynamic value) {
    if (value is Iterable) {
      return value
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .toList();
    }
    return const <String>[];
  }

  static int? _nullableIntValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value.trim());
    return null;
  }

  static DateTime? _nullableDateTimeValue(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static bool _boolValue(dynamic value) {
    if (value is bool) return value;
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      return normalized == 'true' || normalized == '1';
    }
    if (value is num) return value != 0;
    return false;
  }

  static Timestamp? _timestampOrNull(DateTime? value) {
    if (value == null) return null;
    return Timestamp.fromDate(value);
  }
}
