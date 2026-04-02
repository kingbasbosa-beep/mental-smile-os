import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicianOptionModel {
  final String id;
  final String displayName;
  final String specialty;
  final String photoUrl;
  final String photoAsset;
  final bool isActive;
  final bool isAdmin;

  const ClinicianOptionModel({
    required this.id,
    required this.displayName,
    required this.specialty,
    required this.photoUrl,
    required this.photoAsset,
    required this.isActive,
    required this.isAdmin,
  });

  factory ClinicianOptionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};

    return ClinicianOptionModel(
      id: doc.id,
      displayName: (data['displayName'] ?? 'أخصائي').toString(),
      specialty: (data['specialty'] ?? '').toString(),
      photoUrl: (data['photoUrl'] ?? data['photo_url'] ?? '').toString(),
      photoAsset: (data['photoAsset'] ?? '').toString(),
      isActive: (data['isActive'] ?? true) == true,
      isAdmin: (data['isAdmin'] ?? false) == true,
    );
  }

  String get label {
    if (specialty.trim().isEmpty) return displayName;
    return '$displayName — $specialty';
  }
}
