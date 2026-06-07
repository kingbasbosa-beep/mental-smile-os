import '../guards/forbidden_signal_source_guard.dart';
import '../models/signal_package.dart';
import '../registries/signal_category_registry.dart';
import '../registries/signal_type_registry.dart';

class SignalAggregationValidator {
  const SignalAggregationValidator._();

  static const Set<String> eligibleSignalTypes = <String>{
    SignalTypeRegistry.goalSelected,
    SignalTypeRegistry.interestSelected,
    SignalTypeRegistry.accessibilityInterest,
    SignalTypeRegistry.destinationSaved,
    SignalTypeRegistry.providerContactStarted,
    SignalTypeRegistry.centerContactStarted,
    SignalTypeRegistry.libraryCategoryOpened,
  };

  static const Set<String> eligibleCategories = <String>{
    SignalCategoryRegistry.goal,
    SignalCategoryRegistry.interest,
    SignalCategoryRegistry.accessibility,
    SignalCategoryRegistry.destination,
    SignalCategoryRegistry.contact,
    SignalCategoryRegistry.library,
  };

  static bool isAggregationEligible(SignalPackage signal) {
    return eligibleSignalTypes.contains(signal.signalType) &&
        eligibleCategories.contains(signal.signalCategory) &&
        !ForbiddenSignalSourceGuard.isForbidden(signal.signalSource);
  }

  static String? failureReason(SignalPackage signal) {
    if (!eligibleSignalTypes.contains(signal.signalType)) {
      return 'aggregation_ineligible_signal_type';
    }
    if (!eligibleCategories.contains(signal.signalCategory)) {
      return 'aggregation_ineligible_category';
    }
    if (ForbiddenSignalSourceGuard.isForbidden(signal.signalSource)) {
      return 'forbidden_signal_source';
    }
    return null;
  }
}
