class CenterCapabilityFlags {
  final bool supportsAddictionCasesWithHiv;
  final bool acceptsAddictionCases;
  final bool acceptsPsychiatricCasesWithoutAddiction;
  final bool supportsChildren;
  final bool supportsFamilies;
  final bool supportsRecovery;
  final bool supportsHearingSupport;
  final bool supportsSpeechSupport;
  final bool supportsAccessibilitySupport;
  final bool supportsCoachingPrograms;
  final bool supportsEducationPrograms;

  const CenterCapabilityFlags({
    this.supportsAddictionCasesWithHiv = false,
    this.acceptsAddictionCases = false,
    this.acceptsPsychiatricCasesWithoutAddiction = false,
    this.supportsChildren = false,
    this.supportsFamilies = false,
    this.supportsRecovery = false,
    this.supportsHearingSupport = false,
    this.supportsSpeechSupport = false,
    this.supportsAccessibilitySupport = false,
    this.supportsCoachingPrograms = false,
    this.supportsEducationPrograms = false,
  });

  factory CenterCapabilityFlags.fromMap(Map<String, dynamic>? map) {
    final data = map ?? const <String, dynamic>{};
    return CenterCapabilityFlags(
      supportsAddictionCasesWithHiv:
          (data['supportsAddictionCasesWithHiv'] ?? false) == true,
      acceptsAddictionCases: (data['acceptsAddictionCases'] ?? false) == true,
      acceptsPsychiatricCasesWithoutAddiction:
          (data['acceptsPsychiatricCasesWithoutAddiction'] ?? false) == true,
      supportsChildren: (data['supportsChildren'] ?? false) == true,
      supportsFamilies: (data['supportsFamilies'] ?? false) == true,
      supportsRecovery: (data['supportsRecovery'] ?? false) == true,
      supportsHearingSupport: (data['supportsHearingSupport'] ?? false) == true,
      supportsSpeechSupport: (data['supportsSpeechSupport'] ?? false) == true,
      supportsAccessibilitySupport:
          (data['supportsAccessibilitySupport'] ?? false) == true,
      supportsCoachingPrograms:
          (data['supportsCoachingPrograms'] ?? false) == true,
      supportsEducationPrograms:
          (data['supportsEducationPrograms'] ?? false) == true,
    );
  }

  Map<String, dynamic> toMap() => {
        'supportsAddictionCasesWithHiv': supportsAddictionCasesWithHiv,
        'acceptsAddictionCases': acceptsAddictionCases,
        'acceptsPsychiatricCasesWithoutAddiction':
            acceptsPsychiatricCasesWithoutAddiction,
        'supportsChildren': supportsChildren,
        'supportsFamilies': supportsFamilies,
        'supportsRecovery': supportsRecovery,
        'supportsHearingSupport': supportsHearingSupport,
        'supportsSpeechSupport': supportsSpeechSupport,
        'supportsAccessibilitySupport': supportsAccessibilitySupport,
        'supportsCoachingPrograms': supportsCoachingPrograms,
        'supportsEducationPrograms': supportsEducationPrograms,
      };

  CenterCapabilityFlags copyWith({
    bool? supportsAddictionCasesWithHiv,
    bool? acceptsAddictionCases,
    bool? acceptsPsychiatricCasesWithoutAddiction,
    bool? supportsChildren,
    bool? supportsFamilies,
    bool? supportsRecovery,
    bool? supportsHearingSupport,
    bool? supportsSpeechSupport,
    bool? supportsAccessibilitySupport,
    bool? supportsCoachingPrograms,
    bool? supportsEducationPrograms,
  }) {
    return CenterCapabilityFlags(
      supportsAddictionCasesWithHiv:
          supportsAddictionCasesWithHiv ?? this.supportsAddictionCasesWithHiv,
      acceptsAddictionCases:
          acceptsAddictionCases ?? this.acceptsAddictionCases,
      acceptsPsychiatricCasesWithoutAddiction:
          acceptsPsychiatricCasesWithoutAddiction ??
              this.acceptsPsychiatricCasesWithoutAddiction,
      supportsChildren: supportsChildren ?? this.supportsChildren,
      supportsFamilies: supportsFamilies ?? this.supportsFamilies,
      supportsRecovery: supportsRecovery ?? this.supportsRecovery,
      supportsHearingSupport:
          supportsHearingSupport ?? this.supportsHearingSupport,
      supportsSpeechSupport:
          supportsSpeechSupport ?? this.supportsSpeechSupport,
      supportsAccessibilitySupport:
          supportsAccessibilitySupport ?? this.supportsAccessibilitySupport,
      supportsCoachingPrograms:
          supportsCoachingPrograms ?? this.supportsCoachingPrograms,
      supportsEducationPrograms:
          supportsEducationPrograms ?? this.supportsEducationPrograms,
    );
  }
}

class AccommodationCostItem {
  final String key;
  final String labelAr;
  final String labelEn;
  final bool enabled;
  final double price;
  final String pricingUnit;
  final String acMode;
  final bool includesMedication;
  final bool includesMeals;
  final bool includesOutdoorActivities;
  final bool includesRequiredTests;
  final bool includesAirportPickup;
  final bool includesTourismOrExternalOutings;
  final bool taxIncluded;

  const AccommodationCostItem({
    required this.key,
    required this.labelAr,
    required this.labelEn,
    this.enabled = false,
    this.price = 0,
    this.pricingUnit = '',
    this.acMode = '',
    this.includesMedication = false,
    this.includesMeals = false,
    this.includesOutdoorActivities = false,
    this.includesRequiredTests = false,
    this.includesAirportPickup = false,
    this.includesTourismOrExternalOutings = false,
    this.taxIncluded = false,
  });

  factory AccommodationCostItem.fromMap(
    Map<String, dynamic> map, {
    AccommodationCostItem? fallback,
  }) {
    double asDouble(dynamic value) {
      if (value is num) return value.toDouble();
      return double.tryParse('$value') ?? 0;
    }

    return AccommodationCostItem(
      key: (map['key'] ?? fallback?.key ?? '').toString(),
      labelAr: (map['labelAr'] ?? fallback?.labelAr ?? '').toString(),
      labelEn: (map['labelEn'] ?? fallback?.labelEn ?? '').toString(),
      enabled: (map['enabled'] ?? fallback?.enabled ?? false) == true,
      price: asDouble(map['price'] ?? fallback?.price ?? 0),
      pricingUnit:
          (map['pricingUnit'] ?? fallback?.pricingUnit ?? '').toString(),
      acMode: (map['acMode'] ?? fallback?.acMode ?? '').toString(),
      includesMedication: (map['includesMedication'] ??
              fallback?.includesMedication ??
              false) ==
          true,
      includesMeals:
          (map['includesMeals'] ?? fallback?.includesMeals ?? false) == true,
      includesOutdoorActivities: (map['includesOutdoorActivities'] ??
              fallback?.includesOutdoorActivities ??
              false) ==
          true,
      includesRequiredTests: (map['includesRequiredTests'] ??
              fallback?.includesRequiredTests ??
              false) ==
          true,
      includesAirportPickup: (map['includesAirportPickup'] ??
              fallback?.includesAirportPickup ??
              false) ==
          true,
      includesTourismOrExternalOutings:
          (map['includesTourismOrExternalOutings'] ??
                  fallback?.includesTourismOrExternalOutings ??
                  false) ==
              true,
      taxIncluded:
          (map['taxIncluded'] ?? fallback?.taxIncluded ?? false) == true,
    );
  }

  Map<String, dynamic> toMap() => {
        'key': key,
        'labelAr': labelAr,
        'labelEn': labelEn,
        'enabled': enabled,
        'price': price,
        'pricingUnit': pricingUnit,
        'acMode': acMode,
        'includesMedication': includesMedication,
        'includesMeals': includesMeals,
        'includesOutdoorActivities': includesOutdoorActivities,
        'includesRequiredTests': includesRequiredTests,
        'includesAirportPickup': includesAirportPickup,
        'includesTourismOrExternalOutings': includesTourismOrExternalOutings,
        'taxIncluded': taxIncluded,
      };

  AccommodationCostItem copyWith({
    String? key,
    String? labelAr,
    String? labelEn,
    bool? enabled,
    double? price,
    String? pricingUnit,
    String? acMode,
    bool? includesMedication,
    bool? includesMeals,
    bool? includesOutdoorActivities,
    bool? includesRequiredTests,
    bool? includesAirportPickup,
    bool? includesTourismOrExternalOutings,
    bool? taxIncluded,
  }) {
    return AccommodationCostItem(
      key: key ?? this.key,
      labelAr: labelAr ?? this.labelAr,
      labelEn: labelEn ?? this.labelEn,
      enabled: enabled ?? this.enabled,
      price: price ?? this.price,
      pricingUnit: pricingUnit ?? this.pricingUnit,
      acMode: acMode ?? this.acMode,
      includesMedication: includesMedication ?? this.includesMedication,
      includesMeals: includesMeals ?? this.includesMeals,
      includesOutdoorActivities:
          includesOutdoorActivities ?? this.includesOutdoorActivities,
      includesRequiredTests:
          includesRequiredTests ?? this.includesRequiredTests,
      includesAirportPickup:
          includesAirportPickup ?? this.includesAirportPickup,
      includesTourismOrExternalOutings: includesTourismOrExternalOutings ??
          this.includesTourismOrExternalOutings,
      taxIncluded: taxIncluded ?? this.taxIncluded,
    );
  }
}

class AutismCareCostItem {
  final String key;
  final String labelAr;
  final String labelEn;
  final bool enabled;
  final double price;
  final String pricingUnit;
  final bool taxIncluded;

  const AutismCareCostItem({
    required this.key,
    required this.labelAr,
    required this.labelEn,
    this.enabled = false,
    this.price = 0,
    this.pricingUnit = '',
    this.taxIncluded = false,
  });

  factory AutismCareCostItem.fromMap(
    Map<String, dynamic> map, {
    AutismCareCostItem? fallback,
  }) {
    double asDouble(dynamic value) {
      if (value is num) return value.toDouble();
      return double.tryParse('$value') ?? 0;
    }

    return AutismCareCostItem(
      key: (map['key'] ?? fallback?.key ?? '').toString(),
      labelAr: (map['labelAr'] ?? fallback?.labelAr ?? '').toString(),
      labelEn: (map['labelEn'] ?? fallback?.labelEn ?? '').toString(),
      enabled: (map['enabled'] ?? fallback?.enabled ?? false) == true,
      price: asDouble(map['price'] ?? fallback?.price ?? 0),
      pricingUnit:
          (map['pricingUnit'] ?? fallback?.pricingUnit ?? '').toString(),
      taxIncluded:
          (map['taxIncluded'] ?? fallback?.taxIncluded ?? false) == true,
    );
  }

  Map<String, dynamic> toMap() => {
        'key': key,
        'labelAr': labelAr,
        'labelEn': labelEn,
        'enabled': enabled,
        'price': price,
        'pricingUnit': pricingUnit,
        'taxIncluded': taxIncluded,
      };

  AutismCareCostItem copyWith({
    String? key,
    String? labelAr,
    String? labelEn,
    bool? enabled,
    double? price,
    String? pricingUnit,
    bool? taxIncluded,
  }) {
    return AutismCareCostItem(
      key: key ?? this.key,
      labelAr: labelAr ?? this.labelAr,
      labelEn: labelEn ?? this.labelEn,
      enabled: enabled ?? this.enabled,
      price: price ?? this.price,
      pricingUnit: pricingUnit ?? this.pricingUnit,
      taxIncluded: taxIncluded ?? this.taxIncluded,
    );
  }
}

bool usesAutismCarePricing(String categoryKey) {
  return categoryKey.trim() == 'special_needs';
}

List<AccommodationCostItem> defaultAccommodationCostItems() {
  return const <AccommodationCostItem>[
    AccommodationCostItem(
      key: 'shared_room',
      labelAr: 'غرفة مشتركة',
      labelEn: 'Shared room',
    ),
    AccommodationCostItem(
      key: 'standard_room',
      labelAr: 'غرفة استاندرد',
      labelEn: 'Standard room',
    ),
    AccommodationCostItem(
      key: 'first_class_room',
      labelAr: 'غرفة فرست كلاس',
      labelEn: 'First class room',
    ),
    AccommodationCostItem(
      key: 'vip_suite',
      labelAr: 'جناح VIP',
      labelEn: 'VIP suite',
    ),
  ];
}

List<AutismCareCostItem> defaultAutismCareCostItems() {
  return const <AutismCareCostItem>[
    AutismCareCostItem(
      key: 'daily_hosting_at_center',
      labelAr: 'الاستضافة اليومية داخل المركز',
      labelEn: 'Daily hosting at center',
    ),
    AutismCareCostItem(
      key: 'home_visit_sessions',
      labelAr: 'جلسات الزيارة المنزلية',
      labelEn: 'Home visit sessions',
    ),
  ];
}

List<AccommodationCostItem> mergeAccommodationCostItems(dynamic raw) {
  final defaults = defaultAccommodationCostItems();
  if (raw is! List) return defaults;

  final byKey = <String, Map<String, dynamic>>{};
  for (final item in raw) {
    if (item is Map) {
      final map = Map<String, dynamic>.from(item);
      final key = (map['key'] ?? '').toString().trim();
      if (key.isNotEmpty) {
        byKey[key] = map;
      }
    }
  }

  return defaults
      .map((item) => AccommodationCostItem.fromMap(
            byKey[item.key] ?? const <String, dynamic>{},
            fallback: item,
          ))
      .toList();
}

List<AutismCareCostItem> mergeAutismCareCostItems(dynamic raw) {
  final defaults = defaultAutismCareCostItems();
  if (raw is! List) return defaults;

  final byKey = <String, Map<String, dynamic>>{};
  for (final item in raw) {
    if (item is Map) {
      final map = Map<String, dynamic>.from(item);
      final key = (map['key'] ?? '').toString().trim();
      if (key.isNotEmpty) {
        byKey[key] = map;
      }
    }
  }

  return defaults
      .map((item) => AutismCareCostItem.fromMap(
            byKey[item.key] ?? const <String, dynamic>{},
            fallback: item,
          ))
      .toList();
}
