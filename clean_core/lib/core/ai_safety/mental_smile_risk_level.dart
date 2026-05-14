enum MentalSmileRiskLevel {
  normal,
  emotionalDistress,
  relapseUrge,
  crisis,
  emergency,
}

extension MentalSmileRiskLevelKey on MentalSmileRiskLevel {
  String get key {
    switch (this) {
      case MentalSmileRiskLevel.normal:
        return 'normal';
      case MentalSmileRiskLevel.emotionalDistress:
        return 'emotional_distress';
      case MentalSmileRiskLevel.relapseUrge:
        return 'relapse_urge';
      case MentalSmileRiskLevel.crisis:
        return 'crisis';
      case MentalSmileRiskLevel.emergency:
        return 'emergency';
    }
  }
}

MentalSmileRiskLevel mentalSmileRiskLevelFromKey(String value) {
  final key = value.trim();
  for (final level in MentalSmileRiskLevel.values) {
    if (level.key == key) return level;
  }
  return MentalSmileRiskLevel.crisis;
}
