import 'package:flutterprojects/features/identity/federation/registry/department_identity_registry.dart';
import 'package:flutterprojects/features/identity/federation/registry/report_code_convention_registry.dart';

import '../models/report_prefix_alignment.dart';

class ReportPrefixAlignmentRegistry {
  const ReportPrefixAlignmentRegistry._();

  static const List<ReportPrefixAlignment> alignments =
      <ReportPrefixAlignment>[
    ReportPrefixAlignment(
      department: DepartmentIdentityRegistry.residential,
      prefix: 'RES',
      reportCodeConvention: ReportCodeConventionRegistry.weekly,
    ),
    ReportPrefixAlignment(
      department: DepartmentIdentityRegistry.commercial,
      prefix: 'COM',
      reportCodeConvention: ReportCodeConventionRegistry.weekly,
    ),
    ReportPrefixAlignment(
      department: DepartmentIdentityRegistry.technical,
      prefix: 'TEC',
      reportCodeConvention: ReportCodeConventionRegistry.weekly,
    ),
    ReportPrefixAlignment(
      department: DepartmentIdentityRegistry.support,
      prefix: 'SUP',
      reportCodeConvention: ReportCodeConventionRegistry.weekly,
    ),
    ReportPrefixAlignment(
      department: DepartmentIdentityRegistry.monitoring,
      prefix: 'MON',
      reportCodeConvention: ReportCodeConventionRegistry.weekly,
    ),
    ReportPrefixAlignment(
      department: DepartmentIdentityRegistry.ownerStrategy,
      prefix: 'STR',
      reportCodeConvention: ReportCodeConventionRegistry.monthly,
    ),
    ReportPrefixAlignment(
      department: DepartmentIdentityRegistry.archive,
      prefix: 'ARC',
      reportCodeConvention: ReportCodeConventionRegistry.monthly,
    ),
    ReportPrefixAlignment(
      department: DepartmentIdentityRegistry.declarationReview,
      prefix: 'DEC',
      reportCodeConvention: ReportCodeConventionRegistry.quarterly,
    ),
  ];

  static ReportPrefixAlignment? byDepartment(String department) {
    final normalized = department.trim();
    for (final alignment in alignments) {
      if (alignment.department == normalized) return alignment;
    }
    return null;
  }

  static bool isAligned({
    required String department,
    required String prefix,
    required String reportCodeConvention,
  }) {
    final alignment = byDepartment(department);
    if (alignment == null) return false;
    return alignment.prefix == prefix &&
        alignment.reportCodeConvention == reportCodeConvention;
  }
}
