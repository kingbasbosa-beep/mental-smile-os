class DeploymentStage {
  const DeploymentStage({
    required this.stageId,
    required this.description,
    required this.requiredGates,
  });

  final String stageId;
  final String description;
  final Set<String> requiredGates;
}

class DeploymentGate {
  const DeploymentGate({
    required this.gateId,
    required this.description,
    required this.required,
  });

  final String gateId;
  final String description;
  final bool required;
}

class DeploymentRisk {
  const DeploymentRisk({
    required this.riskId,
    required this.severity,
    required this.description,
  });

  final String riskId;
  final String severity;
  final String description;
}

class DeploymentReadiness {
  const DeploymentReadiness({
    required this.stage,
    required this.gates,
    required this.risks,
    required this.status,
  });

  final String stage;
  final List<DeploymentGate> gates;
  final List<DeploymentRisk> risks;
  final String status;
}
