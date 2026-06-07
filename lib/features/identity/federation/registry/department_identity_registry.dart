import '../models/federation_color_token.dart';
import '../models/federation_department_identity.dart';

class DepartmentIdentityRegistry {
  const DepartmentIdentityRegistry._();

  static const String residential = 'residential';
  static const String commercial = 'commercial';
  static const String technical = 'technical';
  static const String support = 'support';
  static const String registry = 'registry';
  static const String declarationReview = 'declaration_review';
  static const String commercialServices = 'commercial_services';
  static const String archive = 'archive';
  static const String monitoring = 'monitoring';
  static const String ownerStrategy = 'owner_strategy';
  static const String owner = 'owner';
  static const String ecosystem = 'ecosystem';

  static const List<FederationDepartmentIdentity> departments =
      <FederationDepartmentIdentity>[
    FederationDepartmentIdentity(
      departmentId: residential,
      displayNameAr: 'المساحة السكنية',
      displayNameEn: 'Residential',
      colorToken: FederationColorToken.turquoise,
      secondaryColorToken: FederationColorToken.gold,
      iconKey: 'home',
      reportPrefix: 'RES',
      stripeColor: FederationColorToken.turquoise,
      identityCode: 'ID-RES',
    ),
    FederationDepartmentIdentity(
      departmentId: commercial,
      displayNameAr: 'الاستخبارات التجارية',
      displayNameEn: 'Commercial',
      colorToken: FederationColorToken.orange,
      secondaryColorToken: FederationColorToken.deepBlue,
      iconKey: 'insights',
      reportPrefix: 'COM',
      stripeColor: FederationColorToken.orange,
      identityCode: 'ID-COM',
    ),
    FederationDepartmentIdentity(
      departmentId: technical,
      displayNameAr: 'القسم التقني',
      displayNameEn: 'Technical',
      colorToken: FederationColorToken.deepBlue,
      secondaryColorToken: FederationColorToken.white,
      iconKey: 'build',
      reportPrefix: 'TEC',
      stripeColor: FederationColorToken.deepBlue,
      identityCode: 'ID-TEC',
    ),
    FederationDepartmentIdentity(
      departmentId: support,
      displayNameAr: 'قسم الدعم',
      displayNameEn: 'Support',
      colorToken: FederationColorToken.green,
      secondaryColorToken: FederationColorToken.gold,
      iconKey: 'support',
      reportPrefix: 'SUP',
      stripeColor: FederationColorToken.green,
      identityCode: 'ID-SUP',
    ),
    FederationDepartmentIdentity(
      departmentId: registry,
      displayNameAr: 'قسم السجل',
      displayNameEn: 'Registry',
      colorToken: FederationColorToken.gold,
      secondaryColorToken: FederationColorToken.black,
      iconKey: 'inventory',
      reportPrefix: 'REG',
      stripeColor: FederationColorToken.gold,
      identityCode: 'ID-REG',
    ),
    FederationDepartmentIdentity(
      departmentId: declarationReview,
      displayNameAr: 'مراجعة الإعلانات',
      displayNameEn: 'Declaration Review',
      colorToken: FederationColorToken.purple,
      secondaryColorToken: FederationColorToken.white,
      iconKey: 'fact_check',
      reportPrefix: 'DEC',
      stripeColor: FederationColorToken.purple,
      identityCode: 'ID-DEC',
    ),
    FederationDepartmentIdentity(
      departmentId: commercialServices,
      displayNameAr: 'الخدمات التجارية',
      displayNameEn: 'Commercial Services',
      colorToken: FederationColorToken.orange,
      secondaryColorToken: FederationColorToken.gold,
      iconKey: 'business_center',
      reportPrefix: 'CSV',
      stripeColor: FederationColorToken.orange,
      identityCode: 'ID-CSV',
    ),
    FederationDepartmentIdentity(
      departmentId: archive,
      displayNameAr: 'الأرشيف',
      displayNameEn: 'Archive',
      colorToken: FederationColorToken.gray,
      secondaryColorToken: FederationColorToken.black,
      iconKey: 'archive',
      reportPrefix: 'ARC',
      stripeColor: FederationColorToken.gray,
      identityCode: 'ID-ARC',
    ),
    FederationDepartmentIdentity(
      departmentId: monitoring,
      displayNameAr: 'المراقبة',
      displayNameEn: 'Monitoring',
      colorToken: FederationColorToken.deepBlue,
      secondaryColorToken: FederationColorToken.turquoise,
      iconKey: 'monitoring',
      reportPrefix: 'MON',
      stripeColor: FederationColorToken.deepBlue,
      identityCode: 'ID-MON',
    ),
    FederationDepartmentIdentity(
      departmentId: ownerStrategy,
      displayNameAr: 'استراتيجية المالك',
      displayNameEn: 'Owner Strategy',
      colorToken: FederationColorToken.black,
      secondaryColorToken: FederationColorToken.gold,
      iconKey: 'strategy',
      reportPrefix: 'STR',
      stripeColor: FederationColorToken.black,
      identityCode: 'ID-STR',
    ),
    FederationDepartmentIdentity(
      departmentId: owner,
      displayNameAr: 'المالك السيادي',
      displayNameEn: 'Owner',
      colorToken: FederationColorToken.black,
      secondaryColorToken: FederationColorToken.white,
      iconKey: 'verified_user',
      reportPrefix: 'OWN',
      stripeColor: FederationColorToken.black,
      identityCode: 'ID-OWN',
    ),
    FederationDepartmentIdentity(
      departmentId: ecosystem,
      displayNameAr: 'النظام البيئي',
      displayNameEn: 'Ecosystem',
      colorToken: FederationColorToken.turquoise,
      secondaryColorToken: FederationColorToken.green,
      iconKey: 'hub',
      reportPrefix: 'ECO',
      stripeColor: FederationColorToken.turquoise,
      identityCode: 'ID-ECO',
    ),
  ];

  static FederationDepartmentIdentity? byId(String departmentId) {
    final normalized = departmentId.trim();
    for (final department in departments) {
      if (department.departmentId == normalized) return department;
    }
    return null;
  }
}
