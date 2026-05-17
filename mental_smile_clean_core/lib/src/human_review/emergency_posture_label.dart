/// Passive emergency posture vocabulary.
///
/// This label is a negative safety posture only. It does not guarantee
/// emergency response, human availability, queue admission, backend
/// intervention, provider escalation, or service-level timing.
enum EmergencyPostureLabel {
  emergencyCapabilityNotGuaranteed,
}

extension EmergencyPostureLabelKey on EmergencyPostureLabel {
  String get key {
    switch (this) {
      case EmergencyPostureLabel.emergencyCapabilityNotGuaranteed:
        return 'emergency_capability_not_guaranteed';
    }
  }
}
