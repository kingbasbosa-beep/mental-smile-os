class DepartmentRegistry {
  const DepartmentRegistry._();

  static const String technical = 'technical';
  static const String support = 'support';
  static const String registry = 'registry';
  static const String declarationReview = 'declaration_review';
  static const String commercialServices = 'commercial_services';
  static const String archive = 'archive';
  static const String monitoring = 'monitoring';
  static const String ownerStrategy = 'owner_strategy';

  static const List<DepartmentDescriptor> departments =
      <DepartmentDescriptor>[
    DepartmentDescriptor(
      departmentId: technical,
      departmentNameAr: 'القسم التقني',
      departmentNameEn: 'Technical Department',
      colorToken: 'technical_blue',
      iconKey: 'build',
      reportPrefix: 'TECH',
    ),
    DepartmentDescriptor(
      departmentId: support,
      departmentNameAr: 'قسم الدعم',
      departmentNameEn: 'Support Department',
      colorToken: 'support_green',
      iconKey: 'support',
      reportPrefix: 'SUP',
    ),
    DepartmentDescriptor(
      departmentId: registry,
      departmentNameAr: 'قسم السجل',
      departmentNameEn: 'Registry Department',
      colorToken: 'registry_gold',
      iconKey: 'inventory',
      reportPrefix: 'REG',
    ),
    DepartmentDescriptor(
      departmentId: declarationReview,
      departmentNameAr: 'قسم مراجعة الإعلانات',
      departmentNameEn: 'Declaration Review Department',
      colorToken: 'review_purple',
      iconKey: 'fact_check',
      reportPrefix: 'DEC',
    ),
    DepartmentDescriptor(
      departmentId: commercialServices,
      departmentNameAr: 'قسم الخدمات التجارية',
      departmentNameEn: 'Commercial Services Department',
      colorToken: 'commercial_orange',
      iconKey: 'business_center',
      reportPrefix: 'COM',
    ),
    DepartmentDescriptor(
      departmentId: archive,
      departmentNameAr: 'قسم الأرشيف',
      departmentNameEn: 'Archive Department',
      colorToken: 'archive_gray',
      iconKey: 'archive',
      reportPrefix: 'ARC',
    ),
    DepartmentDescriptor(
      departmentId: monitoring,
      departmentNameAr: 'قسم المراقبة',
      departmentNameEn: 'Monitoring Department',
      colorToken: 'monitoring_cyan',
      iconKey: 'monitoring',
      reportPrefix: 'MON',
    ),
    DepartmentDescriptor(
      departmentId: ownerStrategy,
      departmentNameAr: 'استراتيجية المالك',
      departmentNameEn: 'Owner Strategy',
      colorToken: 'strategy_black_gold',
      iconKey: 'strategy',
      reportPrefix: 'STR',
    ),
  ];

  static DepartmentDescriptor? byId(String departmentId) {
    final normalized = departmentId.trim();
    for (final department in departments) {
      if (department.departmentId == normalized) return department;
    }
    return null;
  }
}

class DepartmentDescriptor {
  const DepartmentDescriptor({
    required this.departmentId,
    required this.departmentNameAr,
    required this.departmentNameEn,
    required this.colorToken,
    required this.iconKey,
    required this.reportPrefix,
  });

  final String departmentId;
  final String departmentNameAr;
  final String departmentNameEn;
  final String colorToken;
  final String iconKey;
  final String reportPrefix;
}
