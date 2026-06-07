import '../models/monitoring_meter_mapping.dart';
import 'commercial_meter_mapping_registry.dart';

class MonitoringMeterMappingRegistry {
  const MonitoringMeterMappingRegistry._();

  static const String residentialMonitoring = 'residential_monitoring';
  static const String commercialMonitoring = 'commercial_monitoring';
  static const String operationalMonitoring = 'operational_monitoring';

  static const List<MonitoringMeterMapping> mappings =
      <MonitoringMeterMapping>[
    MonitoringMeterMapping(
      monitoringDomain: residentialMonitoring,
      meterDimensions: <String>{
        CommercialMeterMappingRegistry.usage,
        CommercialMeterMappingRegistry.impact,
      },
      description: 'Residential monitoring reads aggregate usage and impact.',
    ),
    MonitoringMeterMapping(
      monitoringDomain: commercialMonitoring,
      meterDimensions: <String>{
        CommercialMeterMappingRegistry.usage,
        CommercialMeterMappingRegistry.adoption,
        CommercialMeterMappingRegistry.trust,
      },
      description: 'Commercial monitoring reads value and trust indicators.',
    ),
    MonitoringMeterMapping(
      monitoringDomain: operationalMonitoring,
      meterDimensions: <String>{
        CommercialMeterMappingRegistry.adoption,
        CommercialMeterMappingRegistry.impact,
      },
      description: 'Operational monitoring reads adoption and follow-through.',
    ),
  ];
}
