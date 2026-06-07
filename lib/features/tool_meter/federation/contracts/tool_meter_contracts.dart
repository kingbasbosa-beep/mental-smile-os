import '../models/tool_meter_scorecard.dart';
import '../models/tool_meter_snapshot.dart';

abstract class ToolMeterSnapshotBuilder {
  ToolMeterSnapshot buildSnapshot();
}

abstract class ToolMeterScorecardBuilder {
  ToolMeterScorecard buildScorecard();
}

abstract class ToolMeterCategoryResolver {
  String resolveCategory(ToolMeterScorecard scorecard);
}
