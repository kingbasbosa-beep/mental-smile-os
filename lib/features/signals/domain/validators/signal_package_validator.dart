import '../models/signal_package.dart';
import '../registries/signal_category_registry.dart';
import '../registries/signal_routing_target.dart';
import '../registries/signal_type_registry.dart';

class SignalPackageValidator {
  const SignalPackageValidator._();

  static bool isValid(SignalPackage signal) {
    return SignalTypeRegistry.values.contains(signal.signalType) &&
        SignalCategoryRegistry.values.contains(signal.signalCategory) &&
        SignalRoutingTarget.values.contains(signal.routingTarget) &&
        signal.signalSource.trim().isNotEmpty &&
        signal.actorId.trim().isNotEmpty;
  }

  static String? failureReason(SignalPackage signal) {
    if (!SignalTypeRegistry.values.contains(signal.signalType)) {
      return 'invalid_signal_type';
    }
    if (!SignalCategoryRegistry.values.contains(signal.signalCategory)) {
      return 'invalid_signal_category';
    }
    if (!SignalRoutingTarget.values.contains(signal.routingTarget)) {
      return 'invalid_routing_target';
    }
    if (signal.signalSource.trim().isEmpty) {
      return 'missing_signal_source';
    }
    if (signal.actorId.trim().isEmpty) {
      return 'missing_actor_id';
    }
    return null;
  }
}
