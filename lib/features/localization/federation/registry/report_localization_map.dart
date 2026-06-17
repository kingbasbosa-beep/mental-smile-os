import '../models/federation_localized_text.dart';

class ReportLocalizationMap {
  const ReportLocalizationMap._();

  static const Map<String, FederationLocalizedText> sections =
      <String, FederationLocalizedText>{
    'executive_summary': FederationLocalizedText(
      ar: 'الملخص التنفيذي',
      en: 'Executive Summary',
      plainText: 'Executive Summary',
      easyReadingText: 'Main summary',
      audioLabel: 'Executive summary section',
      screenReaderLabel: 'Executive summary section',
    ),
    'signals': FederationLocalizedText(
      ar: 'الإشارات',
      en: 'Signals',
      plainText: 'Signals',
      easyReadingText: 'Signals observed',
      audioLabel: 'Signals section',
      screenReaderLabel: 'Signals section',
    ),
    'aggregates': FederationLocalizedText(
      ar: 'التجميعات',
      en: 'Aggregates',
      plainText: 'Aggregates',
      easyReadingText: 'Grouped counts',
      audioLabel: 'Aggregates section',
      screenReaderLabel: 'Aggregates section',
    ),
    'trends': FederationLocalizedText(
      ar: 'الاتجاهات',
      en: 'Trends',
      plainText: 'Trends',
      easyReadingText: 'What is changing',
      audioLabel: 'Trends section',
      screenReaderLabel: 'Trends section',
    ),
    'risks': FederationLocalizedText(
      ar: 'المخاطر',
      en: 'Risks',
      plainText: 'Risks',
      easyReadingText: 'Things to watch',
      audioLabel: 'Risks section',
      screenReaderLabel: 'Risks section',
    ),
    'opportunities': FederationLocalizedText(
      ar: 'الفرص',
      en: 'Opportunities',
      plainText: 'Opportunities',
      easyReadingText: 'Useful chances',
      audioLabel: 'Opportunities section',
      screenReaderLabel: 'Opportunities section',
    ),
    'recommendations': FederationLocalizedText(
      ar: 'توصيات',
      en: 'Recommendations',
      plainText: 'Recommendations',
      easyReadingText: 'Suggested next ideas',
      audioLabel: 'Recommendations section',
      screenReaderLabel: 'Recommendations section',
    ),
    'human_analysis': FederationLocalizedText(
      ar: 'تحليل بشري',
      en: 'Human Analysis',
      plainText: 'Human Analysis',
      easyReadingText: 'Human review',
      audioLabel: 'Human analysis section',
      screenReaderLabel: 'Human analysis section',
    ),
    'ai_analysis': FederationLocalizedText(
      ar: 'تحليل ذكي',
      en: 'AI Analysis',
      plainText: 'AI Analysis',
      easyReadingText: 'AI observation',
      audioLabel: 'AI analysis section',
      screenReaderLabel: 'AI analysis section',
    ),
    'constitutional_alignment': FederationLocalizedText(
      ar: 'التوافق الدستوري',
      en: 'Constitutional Alignment',
      plainText: 'Constitutional Alignment',
      easyReadingText: 'Constitution check',
      audioLabel: 'Constitutional alignment section',
      screenReaderLabel: 'Constitutional alignment section',
    ),
  };
}
