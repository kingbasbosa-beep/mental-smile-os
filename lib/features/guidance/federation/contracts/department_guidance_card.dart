import 'package:flutterprojects/features/localization/federation/models/federation_localized_text.dart';

class DepartmentGuidanceCard {
  const DepartmentGuidanceCard({
    required this.departmentId,
    required this.workContext,
    required this.instruction,
    required this.easyInstruction,
    required this.screenReaderInstruction,
    required this.relatedReportCode,
  });

  final String departmentId;
  final String workContext;
  final FederationLocalizedText instruction;
  final FederationLocalizedText easyInstruction;
  final FederationLocalizedText screenReaderInstruction;
  final String relatedReportCode;
}
