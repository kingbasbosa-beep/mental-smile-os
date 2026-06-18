import '../models/signal_package.dart';
import '../registries/signal_category_registry.dart';
import '../registries/signal_privacy_level.dart';
import '../registries/signal_retention_class.dart';
import '../registries/signal_routing_target.dart';
import '../registries/signal_type_registry.dart';

class SignalPackageFactory {
  const SignalPackageFactory._();

  static SignalPackage providerContactStarted({
    required String actorId,
    required String actorRole,
    required String targetId,
    String signalSource = 'provider_contact_requests',
    DateTime? timestamp,
  }) {
    return _commercialContact(
      signalType: SignalTypeRegistry.providerContactStarted,
      signalSource: signalSource,
      actorId: actorId,
      actorRole: actorRole,
      targetType: 'provider',
      targetId: targetId,
      timestamp: timestamp,
    );
  }

  static SignalPackage centerContactStarted({
    required String actorId,
    required String actorRole,
    required String targetId,
    String signalSource = 'center_contact_requests',
    DateTime? timestamp,
  }) {
    return _commercialContact(
      signalType: SignalTypeRegistry.centerContactStarted,
      signalSource: signalSource,
      actorId: actorId,
      actorRole: actorRole,
      targetType: 'center',
      targetId: targetId,
      timestamp: timestamp,
    );
  }

  static SignalPackage accessibleContactRequested({
    required String actorId,
    required String actorRole,
    required String targetType,
    required String targetId,
    String signalSource = 'accessible_contact',
    DateTime? timestamp,
  }) {
    return _accessibleContact(
      signalType: SignalTypeRegistry.accessibleContactRequested,
      signalSource: signalSource,
      actorId: actorId,
      actorRole: actorRole,
      targetType: targetType,
      targetId: targetId,
      timestamp: timestamp,
    );
  }

  static SignalPackage accessibleContactCompleted({
    required String actorId,
    required String actorRole,
    required String targetType,
    required String targetId,
    String signalSource = 'accessible_contact',
    DateTime? timestamp,
  }) {
    return _accessibleContact(
      signalType: SignalTypeRegistry.accessibleContactCompleted,
      signalSource: signalSource,
      actorId: actorId,
      actorRole: actorRole,
      targetType: targetType,
      targetId: targetId,
      timestamp: timestamp,
    );
  }

  static SignalPackage accessibleProviderSelected({
    required String actorId,
    required String actorRole,
    required String targetId,
    String signalSource = 'accessible_provider_contact',
    DateTime? timestamp,
  }) {
    return _accessibleContact(
      signalType: SignalTypeRegistry.accessibleProviderSelected,
      signalSource: signalSource,
      actorId: actorId,
      actorRole: actorRole,
      targetType: 'provider',
      targetId: targetId,
      timestamp: timestamp,
    );
  }

  static SignalPackage accessibleCenterSelected({
    required String actorId,
    required String actorRole,
    required String targetId,
    String signalSource = 'accessible_center_contact',
    DateTime? timestamp,
  }) {
    return _accessibleContact(
      signalType: SignalTypeRegistry.accessibleCenterSelected,
      signalSource: signalSource,
      actorId: actorId,
      actorRole: actorRole,
      targetType: 'center',
      targetId: targetId,
      timestamp: timestamp,
    );
  }

  static SignalPackage supportStarted({
    required String actorId,
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
      actorId: actorId,
      actorRole: actorRole,
      targetType: 'support',
      targetId: targetId,
      timestamp: timestamp,
      routingTarget: SignalRoutingTarget.supportMonitoring,
    );
  }

  static SignalPackage libraryCategoryOpened({
    required String actorId,
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
      actorId: actorId,
      actorRole: actorRole,
      targetType: 'library_category',
      targetId: targetId,
      timestamp: timestamp,
      routingTarget: SignalRoutingTarget.residentialMonitoring,
    );
  }

  static SignalPackage providerProfileOpened({
    required String actorId,
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
      actorId: actorId,
      actorRole: actorRole,
      targetType: 'provider',
      targetId: targetId,
      timestamp: timestamp,
      routingTarget: SignalRoutingTarget.commercialMonitoring,
    );
  }

  static SignalPackage centerProfileOpened({
    required String actorId,
    required String actorRole,
    required String targetId,
    String signalSource = 'center_discovery',
    DateTime? timestamp,
  }) {
    return _package(
      signalType: SignalTypeRegistry.centerProfileOpened,
      signalCategory: SignalCategoryRegistry.capability,
      signalDomain: 'commercial',
      signalSource: signalSource,
      actorId: actorId,
      actorRole: actorRole,
      targetType: 'center',
      targetId: targetId,
      timestamp: timestamp,
      routingTarget: SignalRoutingTarget.commercialMonitoring,
    );
  }

  static SignalPackage _commercialContact({
    required String signalType,
    required String signalSource,
    required String actorId,
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
      actorId: actorId,
      actorRole: actorRole,
      targetType: targetType,
      targetId: targetId,
      timestamp: timestamp,
      routingTarget: SignalRoutingTarget.commercialMonitoring,
    );
  }

  static SignalPackage _accessibleContact({
    required String signalType,
    required String signalSource,
    required String actorId,
    required String actorRole,
    required String targetType,
    required String targetId,
    DateTime? timestamp,
  }) {
    return _package(
      signalType: signalType,
      signalCategory: SignalCategoryRegistry.accessibility,
      signalDomain: 'accessibility',
      signalSource: signalSource,
      actorId: actorId,
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
    required String actorId,
    required String actorRole,
    required String targetType,
    required String targetId,
    required String routingTarget,
    DateTime? timestamp,
  }) {
    final occurredAt = timestamp ?? DateTime.now().toUtc();
    return SignalPackage(
      signalId: _signalId(signalType, occurredAt),
      signalType: signalType,
      signalCategory: signalCategory,
      signalDomain: signalDomain,
      signalSource: signalSource,
      actorId: actorId,
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
