import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterprojects/core/visibility/visibility_readiness.dart';
import 'package:flutterprojects/features/centers/data/models/center_pricing.dart';

class CenterDocument {
  final String name;
  final String url;
  final String type;

  const CenterDocument({
    required this.name,
    required this.url,
    required this.type,
  });

  factory CenterDocument.fromMap(Map<String, dynamic> map) {
    return CenterDocument(
      name: (map['name'] ?? map['fileName'] ?? map['originalFileName'] ?? '')
          .toString(),
      url: (map['url'] ?? map['fileUrl'] ?? '').toString(),
      type: (map['type'] ?? map['documentType'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'url': url,
        'type': type,
      };
}

class CenterModel {
  final String id;
  final String name;
  final String category;
  final String centerType;
  final String categoryLabelAr;
  final String categoryLabelEn;
  final String city;
  final String area;
  final String description;
  final String phone;
  final String whatsapp;
  final String address;
  final bool hasDetoxUnit;
  final List<String> services;
  final String visibilityReadiness;
  final int sortOrder;
  final String imageUrl;
  final String coverImageUrl;
  final String coverImageAsset;
  final List<String> galleryImageUrls;
  final List<String> galleryImageAssets;
  final List<CenterDocument> documents;
  final List<AccommodationCostItem> accommodationCosts;
  final List<AutismCareCostItem> autismCareCosts;
  final CenterCapabilityFlags capabilities;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CenterModel({
    required this.id,
    required this.name,
    required this.category,
    required this.centerType,
    required this.categoryLabelAr,
    required this.categoryLabelEn,
    required this.city,
    required this.area,
    required this.description,
    required this.phone,
    required this.whatsapp,
    required this.address,
    required this.hasDetoxUnit,
    required this.services,
    this.visibilityReadiness = VisibilityReadiness.incomplete,
    required this.sortOrder,
    required this.imageUrl,
    required this.coverImageUrl,
    required this.coverImageAsset,
    required this.galleryImageUrls,
    required this.galleryImageAssets,
    required this.documents,
    required this.accommodationCosts,
    required this.autismCareCosts,
    required this.capabilities,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CenterModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};

    String firstNonEmpty(List<dynamic> values) {
      for (final value in values) {
        final text = (value ?? '').toString().trim();
        if (text.isNotEmpty) return text;
      }
      return '';
    }

    DateTime? asDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      return null;
    }

    String inferCenterType() {
      final direct = (data['centerType'] ?? '').toString().trim();
      if (direct.isNotEmpty) return direct;
      switch ((data['category'] ?? '').toString().trim()) {
        case 'detox':
          return 'detox';
        case 'hospital':
        case 'hospitals':
          return 'hospital';
        case 'special_needs':
          return 'special_needs_care';
        case 'recovery':
        default:
          return 'halfway_house';
      }
    }

    List<String> asStringList(dynamic value) {
      if (value is List) {
        return value.map((e) => e.toString()).toList();
      }
      return const <String>[];
    }

    List<CenterDocument> asDocuments(dynamic value) {
      if (value is! List) return const <CenterDocument>[];
      final out = <CenterDocument>[];
      for (final item in value) {
        if (item is Map<String, dynamic>) {
          out.add(CenterDocument.fromMap(item));
        } else if (item is Map) {
          out.add(CenterDocument.fromMap(Map<String, dynamic>.from(item)));
        }
      }
      return out;
    }

    List<Map<String, dynamic>> asMapList(dynamic value) {
      if (value is! List) return const <Map<String, dynamic>>[];
      return value
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }

    List<String> galleryUrls() {
      final direct = asStringList(data['galleryImageUrls'])
          .where((value) => value.trim().isNotEmpty)
          .toList();
      if (direct.isNotEmpty) return direct;

      final items = asMapList(data['galleryItems']);
      if (items.isNotEmpty) {
        const slotOrder = ['front', 'reception', 'inside_1', 'inside_2'];
        final ordered = <String>[];
        for (final slot in slotOrder) {
          final match = items.cast<Map<String, dynamic>?>().firstWhere(
                (item) => (item?['slotKey'] ?? '').toString() == slot,
                orElse: () => null,
              );
          final url = (match?['url'] ?? '').toString().trim();
          if (url.isNotEmpty) ordered.add(url);
        }
        if (ordered.isNotEmpty) return ordered;
      }

      return asStringList(data['galleryImages'])
          .where((value) => value.trim().isNotEmpty)
          .toList();
    }

    List<CenterDocument> allDocuments() {
      final legacyDocs = asDocuments(data['documents']);
      if (legacyDocs.isNotEmpty) return legacyDocs;
      return asDocuments(data['documentItems']);
    }

    int asInt(dynamic value, {int fallback = 0}) {
      if (value is int) return value;
      return int.tryParse('$value') ?? fallback;
    }

    final normalizedGalleryUrls = galleryUrls();
    final primaryImage = firstNonEmpty([
      data['imageUrl'],
      data['coverImageUrl'],
      normalizedGalleryUrls.isNotEmpty ? normalizedGalleryUrls.first : '',
    ]);
    final coverImage = firstNonEmpty([
      data['coverImageUrl'],
      data['imageUrl'],
      normalizedGalleryUrls.isNotEmpty ? normalizedGalleryUrls.first : '',
    ]);

    return CenterModel(
      id: doc.id,
      name: firstNonEmpty([
        data['name'],
        data['centerName'],
        data['displayName'],
      ]),
      category: (data['category'] ?? '').toString(),
      centerType: inferCenterType(),
      categoryLabelAr: (data['categoryLabelAr'] ?? '').toString(),
      categoryLabelEn: (data['categoryLabelEn'] ?? '').toString(),
      city: firstNonEmpty([data['city']]),
      area: (data['area'] ?? '').toString(),
      description: firstNonEmpty([
        data['description'],
        data['summary'],
        data['about'],
        data['bio'],
      ]),
      phone: firstNonEmpty([data['phone'], data['contactPhone']]),
      whatsapp: firstNonEmpty([data['whatsapp'], data['whatsappNumber']]),
      address: firstNonEmpty([data['address']]),
      hasDetoxUnit: ((data['hasDetoxUnit'] ?? false) == true) ||
          inferCenterType() == 'detox',
      services: asStringList(data['services']),
      visibilityReadiness: VisibilityReadiness.resolve(data),
      sortOrder: asInt(data['sortOrder'], fallback: 0),
      imageUrl: primaryImage,
      coverImageUrl: coverImage,
      coverImageAsset: (data['coverImageAsset'] ?? '').toString(),
      galleryImageUrls: normalizedGalleryUrls,
      galleryImageAssets: asStringList(data['galleryImageAssets']),
      documents: allDocuments(),
      accommodationCosts:
          mergeAccommodationCostItems(data['accommodationCosts']),
      autismCareCosts: mergeAutismCareCostItems(data['autismCareCosts']),
      capabilities: CenterCapabilityFlags.fromMap(
        data['centerCapabilities'] is Map
            ? Map<String, dynamic>.from(data['centerCapabilities'])
            : const <String, dynamic>{},
      ),
      createdAt: asDate(data['createdAt']),
      updatedAt: asDate(data['updatedAt']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'category': category,
      'centerType': centerType,
      'categoryLabelAr': categoryLabelAr,
      'categoryLabelEn': categoryLabelEn,
      'city': city,
      'area': area,
      'description': description,
      'phone': phone,
      'whatsapp': whatsapp,
      'address': address,
      'hasDetoxUnit': hasDetoxUnit,
      'services': services,
      'sortOrder': sortOrder,
      'imageUrl': imageUrl,
      'coverImageUrl': coverImageUrl,
      'coverImageAsset': coverImageAsset,
      'galleryImageUrls': galleryImageUrls,
      'galleryImageAssets': galleryImageAssets,
      'documents': documents.map((e) => e.toMap()).toList(),
      'accommodationCosts': accommodationCosts.map((e) => e.toMap()).toList(),
      'autismCareCosts': autismCareCosts.map((e) => e.toMap()).toList(),
      'centerCapabilities': capabilities.toMap(),
      'createdAt': createdAt == null
          ? FieldValue.serverTimestamp()
          : Timestamp.fromDate(createdAt!),
      'updatedAt': updatedAt == null
          ? FieldValue.serverTimestamp()
          : Timestamp.fromDate(updatedAt!),
    };
  }

  CenterModel copyWith({
    String? id,
    String? name,
    String? category,
    String? centerType,
    String? categoryLabelAr,
    String? categoryLabelEn,
    String? city,
    String? area,
    String? description,
    String? phone,
    String? whatsapp,
    String? address,
    bool? hasDetoxUnit,
    List<String>? services,
    String? visibilityReadiness,
    int? sortOrder,
    String? imageUrl,
    String? coverImageUrl,
    String? coverImageAsset,
    List<String>? galleryImageUrls,
    List<String>? galleryImageAssets,
    List<CenterDocument>? documents,
    List<AccommodationCostItem>? accommodationCosts,
    List<AutismCareCostItem>? autismCareCosts,
    CenterCapabilityFlags? capabilities,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CenterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      centerType: centerType ?? this.centerType,
      categoryLabelAr: categoryLabelAr ?? this.categoryLabelAr,
      categoryLabelEn: categoryLabelEn ?? this.categoryLabelEn,
      city: city ?? this.city,
      area: area ?? this.area,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      address: address ?? this.address,
      hasDetoxUnit: hasDetoxUnit ?? this.hasDetoxUnit,
      services: services ?? this.services,
      visibilityReadiness: visibilityReadiness ?? this.visibilityReadiness,
      sortOrder: sortOrder ?? this.sortOrder,
      imageUrl: imageUrl ?? this.imageUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      coverImageAsset: coverImageAsset ?? this.coverImageAsset,
      galleryImageUrls: galleryImageUrls ?? this.galleryImageUrls,
      galleryImageAssets: galleryImageAssets ?? this.galleryImageAssets,
      documents: documents ?? this.documents,
      accommodationCosts: accommodationCosts ?? this.accommodationCosts,
      autismCareCosts: autismCareCosts ?? this.autismCareCosts,
      capabilities: capabilities ?? this.capabilities,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
