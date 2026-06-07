class FederationDepartmentIdentity {
  const FederationDepartmentIdentity({
    required this.departmentId,
    required this.displayNameAr,
    required this.displayNameEn,
    required this.colorToken,
    required this.secondaryColorToken,
    required this.iconKey,
    required this.reportPrefix,
    required this.stripeColor,
    required this.identityCode,
  });

  final String departmentId;
  final String displayNameAr;
  final String displayNameEn;
  final String colorToken;
  final String secondaryColorToken;
  final String iconKey;
  final String reportPrefix;
  final String stripeColor;
  final String identityCode;
}
