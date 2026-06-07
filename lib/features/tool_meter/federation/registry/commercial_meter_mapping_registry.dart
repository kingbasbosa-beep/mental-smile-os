import '../models/commercial_meter_mapping.dart';

class CommercialMeterMappingRegistry {
  const CommercialMeterMappingRegistry._();

  static const String demand = 'demand';
  static const String supply = 'supply';
  static const String gap = 'gap';
  static const String opportunity = 'opportunity';

  static const String usage = 'usage';
  static const String adoption = 'adoption';
  static const String trust = 'trust';
  static const String impact = 'impact';

  static const List<CommercialMeterMapping> mappings =
      <CommercialMeterMapping>[
    CommercialMeterMapping(
      commercialDimension: demand,
      meterDimension: usage,
      description: 'Demand is reflected by views, opens, and engagements.',
    ),
    CommercialMeterMapping(
      commercialDimension: supply,
      meterDimension: adoption,
      description: 'Supply strength is reflected by adoption and retention.',
    ),
    CommercialMeterMapping(
      commercialDimension: gap,
      meterDimension: impact,
      description: 'Gaps are reflected by incomplete or weak follow-through.',
    ),
    CommercialMeterMapping(
      commercialDimension: opportunity,
      meterDimension: trust,
      description: 'Opportunity quality is supported by public reputation.',
    ),
  ];
}
