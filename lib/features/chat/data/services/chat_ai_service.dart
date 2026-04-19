import 'package:flutterprojects/features/chat/data/services/chat_ai_policy.dart';

class ChatAiResult {
  final String responseText;
  final String roleDetected;
  final List<String> statesDetected;
  final int riskScore;
  final String riskLevel;
  final String strategyMode;
  final String policyVersion;
  final bool safetyTriggered;
  final bool needsHumanSupport;
  final bool containsEscalationSignal;

  const ChatAiResult({
    required this.responseText,
    required this.roleDetected,
    required this.statesDetected,
    required this.riskScore,
    required this.riskLevel,
    required this.strategyMode,
    required this.policyVersion,
    required this.safetyTriggered,
    required this.needsHumanSupport,
    required this.containsEscalationSignal,
  });
}

class ChatAiService {
  const ChatAiService();

  static const ChatAiPolicy _policy = ChatAiPolicyProvider.currentLocal;

  String _responseTemplateOrDefault(String key) {
    return _policy.responseTemplates[key] ??
        _policy.responseTemplates['default']!;
  }

  String _strategyForRiskLevel(String riskLevel) {
    return _policy.strategyByRiskLevel[riskLevel] ??
        _policy.strategyByRiskLevel['low']!;
  }

  bool _needsHumanSupportForRiskLevel(String riskLevel) {
    return _policy.needsHumanSupportLevels.contains(riskLevel);
  }

  bool _containsEscalationSignalForRiskLevel(String riskLevel) {
    return _policy.containsEscalationSignalLevels.contains(riskLevel);
  }

  bool _safetyTriggeredForRiskLevel(String riskLevel) {
    return _policy.safetyTriggeredLevels.contains(riskLevel);
  }

  ChatAiResult processUserMessage(String text) {
    final input = _normalize(text);

    String roleDetected = 'supporter';
    final List<String> states = [];
    int riskScore = 0;
    bool explicitSelfHarmIntent = false;

    bool containsAny(List<String> phrases) {
      return phrases.any((p) => input.contains(_normalize(p)));
    }

    void addState(String state, int score) {
      if (!states.contains(state)) {
        states.add(state);
        riskScore += score;
      }
    }

    if (containsAny(_policy.rolePhrasePacks['addicted_person']!)) {
      roleDetected = 'addicted_person';
    } else if (containsAny(_policy.rolePhrasePacks['family_member']!)) {
      roleDetected = 'family_member';
    }

    if (containsAny(_policy.statePhrasePacks['justification']!)) {
      addState('justification', _policy.stateScores['justification']!);
    }

    if (containsAny(_policy.statePhrasePacks['denial']!)) {
      addState('denial', _policy.stateScores['denial']!);
    }

    if (containsAny(_policy.statePhrasePacks['craving']!)) {
      addState('craving', _policy.stateScores['craving']!);
    }

    if (containsAny(_policy.statePhrasePacks['hopelessness']!)) {
      addState('hopelessness', _policy.stateScores['hopelessness']!);
    }

    if (containsAny(_policy.statePhrasePacks['fear']!)) {
      addState('fear', _policy.stateScores['fear']!);
    }

    if (containsAny(_policy.statePhrasePacks['guilt']!)) {
      addState('guilt', _policy.stateScores['guilt']!);
    }

    if (containsAny(_policy.statePhrasePacks['collapse']!)) {
      addState('collapse', _policy.stateScores['collapse']!);
    }

    if (containsAny(_policy.statePhrasePacks['manipulation']!)) {
      addState('manipulation', _policy.stateScores['manipulation']!);
    }

    if (containsAny(_policy.lossOfControlPhrases)) {
      riskScore += _policy.lossOfControlScore;
    }

    if (containsAny(_policy.selfHarmPhrases)) {
      explicitSelfHarmIntent = true;
      riskScore += _policy.explicitSelfHarmScore;
    }

    final String riskLevel;
    if (explicitSelfHarmIntent || riskScore >= _policy.criticalRiskThreshold) {
      riskLevel = 'critical';
    } else if (riskScore >= _policy.highRiskThreshold) {
      riskLevel = 'high';
    } else if (riskScore >= _policy.mediumRiskThreshold) {
      riskLevel = 'medium';
    } else {
      riskLevel = 'low';
    }

    final String strategyMode = _strategyForRiskLevel(riskLevel);

    final bool safetyTriggered = _safetyTriggeredForRiskLevel(riskLevel);
    final bool needsHumanSupport = _needsHumanSupportForRiskLevel(riskLevel);
    final bool containsEscalationSignal =
        _containsEscalationSignalForRiskLevel(riskLevel);

    final responseText = _buildResponse(
      riskLevel: riskLevel,
      strategyMode: strategyMode,
      states: states,
      roleDetected: roleDetected,
    );

    return ChatAiResult(
      responseText: responseText,
      roleDetected: roleDetected,
      statesDetected: states,
      riskScore: riskScore,
      riskLevel: riskLevel,
      strategyMode: strategyMode,
      policyVersion: _policy.policyVersion,
      safetyTriggered: safetyTriggered,
      needsHumanSupport: needsHumanSupport,
      containsEscalationSignal: containsEscalationSignal,
    );
  }

  String _buildResponse({
    required String riskLevel,
    required String strategyMode,
    required List<String> states,
    required String roleDetected,
  }) {
    if (riskLevel == 'critical') {
      return _responseTemplateOrDefault('critical');
    }

    if (riskLevel == 'high') {
      return _responseTemplateOrDefault('high');
    }

    if (riskLevel == 'medium') {
      return _responseTemplateOrDefault('medium');
    }

    if (roleDetected == 'family_member') {
      return _responseTemplateOrDefault('family_member');
    }

    return _responseTemplateOrDefault('default');
  }

  String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .replaceAll('ؤ', 'و')
        .replaceAll('ئ', 'ي')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}
