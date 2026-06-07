import '../models/observatory_snapshot.dart';
import '../reports/operational_observatory_report.dart';

abstract class ObservatorySnapshotBuilder {
  ObservatorySnapshot buildSnapshot();
}

abstract class MonitoringConsumptionPlanner {
  OperationalObservatoryReport buildConsumptionPlan();
}

abstract class MonitoringRoomFoundationPlanner {
  OperationalObservatoryReport buildMonitoringRoomFoundation();
}
