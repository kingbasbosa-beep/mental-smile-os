import 'package:mental_smile_os/features/signals/signals.dart';

import '../models/accessibility_category.dart';
import '../models/accessibility_disability_type.dart';
import '../models/accessibility_signal_type.dart';
import '../registries/accessibility_signal_registry.dart';

class AccessibilitySignalFactory {
  const AccessibilitySignalFactory._();

  static const String anonymousActorId = 'anonymous_accessibility_user';
  static const String actorRole = 'visitor';

  static SignalPackage package({
    required AccessibilitySignalType signalType,
    AccessibilityCategory? category,
    AccessibilityDisabilityType? disabilityType,
    String? resourceId,
    String? userId,
    DateTime? timestamp,
  }) {
    final occurredAt = timestamp ?? DateTime.now().toUtc();
    return SignalPackage(
      signalId: '${signalType.value}_${occurredAt.microsecondsSinceEpoch}',
      signalType: signalType.value,
      signalCategory: SignalCategoryRegistry.accessibility,
      signalDomain: AccessibilitySignalRegistry.signalDomain,
      signalSource: AccessibilitySignalRegistry.sourceSurface,
      actorId: _actorId(userId),
      actorRole: actorRole,
      targetType: _targetType(signalType),
      targetId: _targetId(
        signalType: signalType,
        category: category,
        resourceId: resourceId,
      ),
      timestamp: occurredAt,
      routingTarget: SignalRoutingTarget.residentialMonitoring,
      retentionClass: SignalRetentionClass.rawShortTerm,
      privacyLevel: SignalPrivacyLevel.internalAggregate,
      signalVersion: SignalPackage.currentVersion,
    );
  }

  static Map<String, dynamic> payload({
    required AccessibilitySignalType signalType,
    AccessibilityCategory? category,
    AccessibilityDisabilityType? disabilityType,
    String? resourceId,
    String? userId,
    DateTime? timestamp,
  }) {
    final occurredAt = timestamp ?? DateTime.now().toUtc();
    return <String, dynamic>{
      'signalType': signalType.value,
      'sourceSurface': AccessibilitySignalRegistry.sourceSurface,
      'category': category?.value,
      'disabilityType': disabilityType?.value,
      'resourceId': resourceId,
      'userId': userId,
      'timestamp': occurredAt.toIso8601String(),
      'privacyLevel': SignalPrivacyLevel.internalAggregate,
      'retentionClass': SignalRetentionClass.rawShortTerm,
    };
  }

  static String _actorId(String? userId) {
    final value = userId?.trim() ?? '';
    return value.isEmpty ? anonymousActorId : value;
  }

  static String _targetType(AccessibilitySignalType signalType) {
    switch (signalType) {
      case AccessibilitySignalType.hubOpened:
        return AccessibilitySignalRegistry.targetHub;
      case AccessibilitySignalType.categoryOpened:
        return AccessibilitySignalRegistry.targetCategory;
      case AccessibilitySignalType.resourceOpened:
      case AccessibilitySignalType.resourceSaved:
      case AccessibilitySignalType.resourceBrokenLinkReported:
        return AccessibilitySignalRegistry.targetResource;
      case AccessibilitySignalType.modeSelected:
        return AccessibilitySignalRegistry.targetMode;
    }
  }

  static String _targetId({
    required AccessibilitySignalType signalType,
    AccessibilityCategory? category,
    String? resourceId,
  }) {
    final resource = resourceId?.trim() ?? '';
    if (resource.isNotEmpty) return resource;
    if (category != null) return category.value;
    return signalType.value;
  }
}
