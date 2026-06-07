class ReportPeriod {
  const ReportPeriod._();

  static const String daily = 'daily';
  static const String weekly = 'weekly';
  static const String monthly = 'monthly';
  static const String quarterly = 'quarterly';
  static const String annual = 'annual';
  static const String custom = 'custom';

  static const Set<String> values = <String>{
    daily,
    weekly,
    monthly,
    quarterly,
    annual,
    custom,
  };
}
