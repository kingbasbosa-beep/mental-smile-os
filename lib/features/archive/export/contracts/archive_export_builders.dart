import '../models/archive_export_package.dart';

abstract class ReportExportBuilder {
  ArchiveExportPackage buildReportPack();
}

abstract class DepartmentExportBuilder {
  ArchiveExportPackage buildDepartmentPack();
}

abstract class StrategicExportBuilder {
  ArchiveExportPackage buildStrategicPack();
}

abstract class ConstitutionalExportBuilder {
  ArchiveExportPackage buildConstitutionalPack();
}

abstract class ArchiveExportBuilder {
  ArchiveExportPackage buildArchivePack();
}
