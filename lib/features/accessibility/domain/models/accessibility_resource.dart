import 'package:cloud_firestore/cloud_firestore.dart';

import 'accessibility_category.dart';
import 'accessibility_disability_type.dart';
import 'accessibility_resource_type.dart';

class AccessibilityResource {
  const AccessibilityResource({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.category,
    required this.disabilityType,
    required this.country,
    required this.language,
    required this.resourceType,
    required this.url,
    required this.tags,
    required this.isVerified,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  static const String collectionName = 'accessibility_resources';

  final String id;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final AccessibilityCategory category;
  final AccessibilityDisabilityType disabilityType;
  final String country;
  final String language;
  final AccessibilityResourceType resourceType;
  final String url;
  final List<String> tags;
  final bool isVerified;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory AccessibilityResource.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};
    return AccessibilityResource.fromMap({...data, 'id': doc.id});
  }

  factory AccessibilityResource.fromMap(Map<String, dynamic> map) {
    return AccessibilityResource(
      id: (map['id'] ?? '').toString(),
      titleAr: (map['titleAr'] ?? '').toString(),
      titleEn: (map['titleEn'] ?? '').toString(),
      descriptionAr: (map['descriptionAr'] ?? '').toString(),
      descriptionEn: (map['descriptionEn'] ?? '').toString(),
      category: AccessibilityCategory.fromValue(
        (map['category'] ?? '').toString(),
      ),
      disabilityType: AccessibilityDisabilityType.fromValue(
        (map['disabilityType'] ?? '').toString(),
      ),
      country: (map['country'] ?? '').toString(),
      language: (map['language'] ?? '').toString(),
      resourceType: AccessibilityResourceType.fromValue(
        (map['resourceType'] ?? '').toString(),
      ),
      url: (map['url'] ?? '').toString(),
      tags: _stringList(map['tags']),
      isVerified: map['isVerified'] == true,
      isActive: map['isActive'] != false,
      createdAt:
          _dateTime(map['createdAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt:
          _dateTime(map['updatedAt']) ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titleAr': titleAr,
      'titleEn': titleEn,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
      'category': category.value,
      'disabilityType': disabilityType.value,
      'country': country,
      'language': language,
      'resourceType': resourceType.value,
      'url': url,
      'tags': tags,
      'isVerified': isVerified,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static List<String> _stringList(Object? value) {
    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }
    return const <String>[];
  }

  static DateTime? _dateTime(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
