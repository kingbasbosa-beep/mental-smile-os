import '../models/tool_meter_observatory_models.dart';

class ToolMeterObservatoryRegistry {
  const ToolMeterObservatoryRegistry._();

  static const ToolMeterObservatoryProfile profile = ToolMeterObservatoryProfile(
    profileId: 'tool_meter_observatory_v1',
    meterDimensions: <String>{
      'usage',
      'adoption',
      'trust',
      'impact',
    },
    reportTargets: <String>{
      'tool_meter_report',
      'commercial_report',
      'readiness_report',
    },
  );
}
