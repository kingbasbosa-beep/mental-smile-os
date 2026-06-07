class ToolMeterCategoryRegistry {
  const ToolMeterCategoryRegistry._();

  static const String healthy = 'healthy';
  static const String growing = 'growing';
  static const String stable = 'stable';
  static const String declining = 'declining';
  static const String inactive = 'inactive';

  static const Set<String> values = <String>{
    healthy,
    growing,
    stable,
    declining,
    inactive,
  };
}
