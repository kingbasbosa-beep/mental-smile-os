enum MentalSmileResponseMode {
  support,
  deEscalation,
  relapsePrevention,
  crisisSupport,
  emergencyEscalation,
  blocked,
  failSafe,
}

extension MentalSmileResponseModeKey on MentalSmileResponseMode {
  String get key {
    switch (this) {
      case MentalSmileResponseMode.support:
        return 'support';
      case MentalSmileResponseMode.deEscalation:
        return 'de_escalation';
      case MentalSmileResponseMode.relapsePrevention:
        return 'relapse_prevention';
      case MentalSmileResponseMode.crisisSupport:
        return 'crisis_support';
      case MentalSmileResponseMode.emergencyEscalation:
        return 'emergency_escalation';
      case MentalSmileResponseMode.blocked:
        return 'blocked';
      case MentalSmileResponseMode.failSafe:
        return 'fail_safe';
    }
  }
}
