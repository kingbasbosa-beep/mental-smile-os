import '../guards/forbidden_signal_source_guard.dart';
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
        !ForbiddenSignalSourceGuard.isForbidden(signal.signalSource);
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
    if (ForbiddenSignalSourceGuard.isForbidden(signal.signalSource)) {
      return 'forbidden_signal_source';
    }
    return null;
  }
}
