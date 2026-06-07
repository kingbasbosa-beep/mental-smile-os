import '../models/federation_localized_text.dart';

class ArchiveLocalizationMap {
  const ArchiveLocalizationMap._();

  static const Map<String, FederationLocalizedText> labels =
      <String, FederationLocalizedText>{
    'archiveCode': FederationLocalizedText(
      ar: 'كود الأرشيف',
      en: 'Archive Code',
      plainText: 'Archive Code',
      easyReadingText: 'Archive code',
      audioLabel: 'Archive code',
      screenReaderLabel: 'Archive code',
    ),
    'retentionClass': FederationLocalizedText(
      ar: 'فئة الاحتفاظ',
      en: 'Retention Class',
      plainText: 'Retention Class',
      easyReadingText: 'How long it is kept',
      audioLabel: 'Retention class',
      screenReaderLabel: 'Retention class',
    ),
    'archiveEligibility': FederationLocalizedText(
      ar: 'أهلية الأرشفة',
      en: 'Archive Eligibility',
      plainText: 'Archive Eligibility',
      easyReadingText: 'Archive status',
      audioLabel: 'Archive eligibility',
      screenReaderLabel: 'Archive eligibility',
    ),
    'classification': FederationLocalizedText(
      ar: 'التصنيف',
      en: 'Classification',
      plainText: 'Classification',
      easyReadingText: 'Access level',
      audioLabel: 'Classification',
      screenReaderLabel: 'Classification',
    ),
    'reportVersion': FederationLocalizedText(
      ar: 'إصدار التقرير',
      en: 'Report Version',
      plainText: 'Report Version',
      easyReadingText: 'Report version',
      audioLabel: 'Report version',
      screenReaderLabel: 'Report version',
    ),
    'createdAt': FederationLocalizedText(
      ar: 'تاريخ الإنشاء',
      en: 'Created At',
      plainText: 'Created At',
      easyReadingText: 'Created date',
      audioLabel: 'Created at',
      screenReaderLabel: 'Created at',
    ),
    'period': FederationLocalizedText(
      ar: 'الفترة',
      en: 'Period',
      plainText: 'Period',
      easyReadingText: 'Time period',
      audioLabel: 'Period',
      screenReaderLabel: 'Period',
    ),
    'department': FederationLocalizedText(
      ar: 'القسم',
      en: 'Department',
      plainText: 'Department',
      easyReadingText: 'Department',
      audioLabel: 'Department',
      screenReaderLabel: 'Department',
    ),
  };
}
