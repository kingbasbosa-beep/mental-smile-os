import '../guards/forbidden_signal_source_guard.dart';
import '../models/signal_package.dart';
import '../registries/signal_category_registry.dart';
import '../registries/signal_privacy_level.dart';
import '../registries/signal_retention_class.dart';
import '../registries/signal_routing_target.dart';
import '../registries/signal_type_registry.dart';

class SignalPackageFactory {
  const SignalPackageFactory._();

  static SignalPackage goalSelected({
    required String actorRole,
    String targetId = '',
    String signalSource = 'client_room',
    DateTime? timestamp,
  }) {
    return _residential(
      signalType: SignalTypeRegistry.goalSelected,
      signalCategory: SignalCategoryRegistry.goal,
      signalSource: signalSource,
      actorRole: actorRole,
      targetType: 'client_signal',
      targetId: targetId,
      timestamp: timestamp,
    );
  }

  static SignalPackage interestSelected({
    required String actorRole,
    String targetId = '',
    String signalSource = 'client_room',
    DateTime? timestamp,
  }) {
    return _residential(
      signalType: SignalTypeRegistry.interestSelected,
      signalCategory: SignalCategoryRegistry.interest,
      signalSource: signalSource,
      actorRole: actorRole,
      targetType: 'client_signal',
      targetId: targetId,
      timestamp: timestamp,
    );
  }

  static SignalPackage accessibilityInterest({
    required String actorRole,
    String targetId = '',
    String signalSource = 'client_room',
    DateTime? timestamp,
  }) {
    return _residential(
      signalType: SignalTypeRegistry.accessibilityInterest,
      signalCategory: SignalCategoryRegistry.accessibility,
      signalSource: signalSource,
      actorRole: actorRole,
      targetType: 'client_signal',
      targetId: targetId,
      timestamp: timestamp,
    );
  }

  static SignalPackage communicationPreferenceSelected({
    required String actorRole,
    String targetId = '',
    String signalSource = 'client_room',
    DateTime? timestamp,
  }) {
    return _residential(
      signalType: SignalTypeRegistry.communicationPreferenceSelected,
      signalCategory: SignalCategoryRegistry.communication,
      signalSource: signalSource,
      actorRole: actorRole,
      targetType: 'client_signal',
      targetId: targetId,
      timestamp: timestamp,
    );
  }

  static SignalPackage destinationSaved({
    required String actorRole,
    required String targetType,
    required String targetId,
    String signalSource = 'saved_destinations',
    DateTime? timestamp,
  }) {
    return _package(
      signalType: SignalTypeRegistry.destinationSaved,
      signalCategory: SignalCategoryRegistry.destination,
      signalDomain: 'residential',
      signalSource: signalSource,
      actorRole: actorRole,
      targetType: targetType,
      targetId: targetId,
      timestamp: timestamp,
      routingTarget: SignalRoutingTarget.residentialMonitoring,
    );
  }

  static SignalPackage providerContactStarted({
    required String actorRole,
    required String targetId,
    String signalSource = 'provider_contact_requests',
    DateTime? timestamp,
  }) {
    return _commercialContact(
      signalType: SignalTypeRegistry.providerContactStarted,
      signalSource: signalSource,
      actorRole: actorRole,
      targetType: 'provider',
      targetId: targetId,
      timestamp: timestamp,
    );
  }

  static SignalPackage centerContactStarted({
    required String actorRole,
    required String targetId,
    String signalSource = 'center_contact_requests',
    DateTime? timestamp,
  }) {
    return _commercialContact(
      signalType: SignalTypeRegistry.centerContactStarted,
      signalSource: signalSource,
      actorRole: actorRole,
      targetType: 'center',
      targetId: targetId,
      timestamp: timestamp,
    );
  }

  static SignalPackage supportStarted({
    required String actorRole,
    String targetId = '',
    String signalSource = 'support_requests',
    DateTime? timestamp,
  }) {
    return _package(
      signalType: SignalTypeRegistry.supportStarted,
      signalCategory: SignalCategoryRegistry.support,
      signalDomain: 'support',
      signalSource: signalSource,
      actorRole: actorRole,
      targetType: 'support',
      targetId: targetId,
      timestamp: timestamp,
      routingTarget: SignalRoutingTarget.supportMonitoring,
    );
  }

  static SignalPackage libraryCategoryOpened({
    required String actorRole,
    required String targetId,
    String signalSource = 'library',
    DateTime? timestamp,
  }) {
    return _package(
      signalType: SignalTypeRegistry.libraryCategoryOpened,
      signalCategory: SignalCategoryRegistry.library,
      signalDomain: 'residential',
      signalSource: signalSource,
      actorRole: actorRole,
      targetType: 'library_category',
      targetId: targetId,
      timestamp: timestamp,
      routingTarget: SignalRoutingTarget.residentialMonitoring,
    );
  }

  static SignalPackage providerProfileOpened({
    required String actorRole,
    required String targetId,
    String signalSource = 'provider_discovery',
    DateTime? timestamp,
  }) {
    return _package(
      signalType: SignalTypeRegistry.providerProfileOpened,
      signalCategory: SignalCategoryRegistry.capability,
      signalDomain: 'commercial',
      signalSource: signalSource,
      actorRole: actorRole,
      targetType: 'provider',
      targetId: targetId,
      timestamp: timestamp,
      routingTarget: SignalRoutingTarget.commercialMonitoring,
    );
  }

  static SignalPackage _residential({
    required String signalType,
    required String signalCategory,
    required String signalSource,
    required String actorRole,
    required String targetType,
    required String targetId,
    DateTime? timestamp,
  }) {
    return _package(
      signalType: signalType,
      signalCategory: signalCategory,
      signalDomain: 'residential',
      signalSource: signalSource,
      actorRole: actorRole,
      targetType: targetType,
      targetId: targetId,
      timestamp: timestamp,
      routingTarget: SignalRoutingTarget.residentialMonitoring,
    );
  }

  static SignalPackage _commercialContact({
    required String signalType,
    required String signalSource,
    required String actorRole,
    required String targetType,
    required String targetId,
    DateTime? timestamp,
  }) {
    return _package(
      signalType: signalType,
      signalCategory: SignalCategoryRegistry.contact,
      signalDomain: 'commercial',
      signalSource: signalSource,
      actorRole: actorRole,
      targetType: targetType,
      targetId: targetId,
      timestamp: timestamp,
      routingTarget: SignalRoutingTarget.commercialMonitoring,
    );
  }

  static SignalPackage _package({
    required String signalType,
    required String signalCategory,
    required String signalDomain,
    required String signalSource,
    required String actorRole,
    required String targetType,
    required String targetId,
    required String routingTarget,
    DateTime? timestamp,
  }) {
    ForbiddenSignalSourceGuard.ensureAllowed(signalSource);
    final occurredAt = timestamp ?? DateTime.now().toUtc();
    return SignalPackage(
      signalId: _signalId(signalType, occurredAt),
      signalType: signalType,
      signalCategory: signalCategory,
      signalDomain: signalDomain,
      signalSource: signalSource,
      actorRole: actorRole,
      targetType: targetType,
      targetId: targetId,
      timestamp: occurredAt,
      routingTarget: routingTarget,
      retentionClass: SignalRetentionClass.rawShortTerm,
      privacyLevel: SignalPrivacyLevel.internalAggregate,
      signalVersion: SignalPackage.currentVersion,
    );
  }

  static String _signalId(String signalType, DateTime timestamp) {
    return '${signalType}_${timestamp.microsecondsSinceEpoch}';
  }
}
