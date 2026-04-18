class ChatAiResult {
  final String responseText;
  final String roleDetected;
  final List<String> statesDetected;
  final int riskScore;
  final String riskLevel;
  final String strategyMode;
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
    required this.safetyTriggered,
    required this.needsHumanSupport,
    required this.containsEscalationSignal,
  });
}

class ChatAiService {
  const ChatAiService();

  static const Map<String, int> _stateScores = {
    'justification': 2,
    'denial': 2,
    'craving': 3,
    'hopelessness': 2,
    'fear': 0,
    'guilt': 0,
    'collapse': 0,
    'manipulation': 2,
  };

  static const int _lossOfControlScore = 3;
  static const int _explicitSelfHarmScore = 5;

  static const int _mediumRiskThreshold = 3;
  static const int _highRiskThreshold = 6;
  static const int _criticalRiskThreshold = 9;

  static const Map<String, String> _responseTemplates = {
    'critical':
        'أنا سامع إن الخطر هنا مباشر، والأولوية الآن هي الأمان فقط. ابعد حالًا عن أي شيء ممكن تستخدمه لإيذاء نفسك، وخليك في نفس المكان مع شخص موثوق أو اتصل به فورًا، واطلب دعمًا بشريًا مباشرًا الآن. لو أنت وحدك، تحرك فورًا لمكان فيه ناس قريبين منك. أنا معك الآن، ونركز فقط على النجاة من الدقائق الحالية بأمان.',
    'high':
        'واضح إن الضغط عالي جدًا عليك الآن، ومهم ما تفضلش مع ده وحدك. خلينا نهدي الإيقاع ونركز على خطوة آمنة جدًا الآن، ومعها يكون الأفضل التواصل مع شخص موثوق أو دعم بشري قريب.',
    'medium':
        'إحساسك مفهوم، ومش لازم تحل كل شيء الآن. خلينا نبطيء اللحظة ونشوف أول خطوة صغيرة تساعدك تستعيد هدوءك وسيطرتك.',
    'family_member':
        'واضح إنك شايل هم كبير، ووجودك هنا مهم. خلينا نفهم الموقف بهدوء ونركز على خطوة آمنة ومتزنة تساعدك وتساعد الطرف الآخر بدون تصعيد.',
    'default':
        'أنا معك. نقدر نمسك اللي حاصل بهدوء ونفهمه خطوة خطوة، من غير ضغط ومن غير أحكام.',
  };

  static const Map<String, List<String>> _rolePhrasePacks = {
    'addicted_person': [
      'انا بتعاطى',
      'انا بتعاطي',
      'انا مدمن',
      'عايز اتعاطى',
      'عاوز اتعاطى',
      'نفسي اتعاطى',
      'مش قادر ابطل',
      'مش قادر ابطل تعاطي',
      'انتكست',
      'رجعت للتعاطي',
      'رجعت اتعاطى',
      'رجعت اتعاطي',
    ],
    'family_member': [
      'ابني',
      'بنتي',
      'اخويا',
      'اختي',
      'اختى',
      'جوزي',
      'زوجي',
      'مراتي',
      'زوجتي',
      'ابويا',
      'امي',
      'أمي',
      'أبويا',
    ],
  };

  static const Map<String, List<String>> _statePhrasePacks = {
    'justification': [
      'مش مشكلة',
      'عادي ارجع',
      'عادي ارجع للتعاطي',
      'عادي ارجع اتعاطى',
      'مش غلط',
      'كل الناس بتعمل كده',
      'استاهل ارجع',
      'مفيش مانع ارجع',
    ],
    'denial': [
      'مفيش مشكلة عندي',
      'انا كويس',
      'مش محتاج مساعدة',
      'انا تمام',
      'انا مش محتاج حد',
      'مش محتاج دعم',
      'مفيش حاجة غلط',
    ],
    'craving': [
      'نفسي اتعاطى',
      'عايز اتعاطى',
      'عاوز اتعاطى',
      'مشتاق للتعاطي',
      'الرغبة شديدة',
      'رغبة قوية',
      'مش قادر امسك نفسي',
      'حاسس اني هرجع',
      'هرجع اتعاطى',
      'هرجع اتعاطي',
      'نفسي ارجع',
    ],
    'hopelessness': [
      'مفيش امل',
      'مش شايف امل',
      'خلاص ضعت',
      'انتهيت',
      'مفيش فايدة',
      'مش هتغير',
      'مش هعرف اتغير',
      'كل حاجة بايظة',
      'مافيش امل',
      'مافيش فايده',
    ],
    'fear': [
      'خايف',
      'مرعوب',
      'قلقان',
      'متوتر',
      'عندي خوف',
      'حاسس برعب',
      'مش مطمن',
    ],
    'guilt': [
      'مذنب',
      'ندمان',
      'حاسس بذنب',
      'انا السبب',
      'حاسس اني وحش',
      'انا وحش',
      'قصرت',
    ],
    'collapse': [
      'منهار',
      'مش قادر',
      'عايز اعيط',
      'وقعت',
      'تعبان جدا',
      'تعبان جدًا',
      'مكسور',
      'مش قادر اكمل',
      'حاسس اني واقع',
      'تايه جدا',
      'تايه جدًا',
    ],
    'manipulation': [
      'بتتحكموا فيا',
      'كلكم ضدي',
      'انتوا السبب',
      'هخليكم تندموا',
      'لو سبتوني هعمل حاجة',
      'لو ماعملتوش كذا هعمل كذا',
    ],
  };

  static const List<String> _lossOfControlPhrases = [
    'مش قادر اتحكم في نفسي',
    'مش قادر اتحكم بنفسي',
    'مش قادر اسيطر على نفسي',
    'مش قادر اسيطر بنفسي',
    'مش مسيطر على نفسي',
    'خارج عن السيطرة',
    'هفقد السيطرة',
    'مش ماسك نفسي',
    'مش عارف امسك نفسي',
    'مش قادر امسك نفسي',
  ];

  static const List<String> _selfHarmPhrases = [
    'هاذي نفسي',
    'هأذي نفسي',
    'عايز اؤذي نفسي',
    'عايز اوذي نفسي',
    'عاوز اؤذي نفسي',
    'عاوز اوذي نفسي',
    'اؤذي نفسي',
    'اوذي نفسي',
    'اذي نفسي',
    'أذي نفسي',
    'هعمل في نفسي حاجة',
    'اخلص من نفسي',
    'انهي نفسي',
    'انهي حياتي',
    'انتحار',
    'انتحر',
    'اقتل نفسي',
    'اموت نفسي',
    'هموت نفسي',
    'نفسي اموت',
    'نفسي اموت بجد',
    'نفسي اختفي',
    'مش عايز اعيش',
    'مش عاوز اعيش',
    'مش حابب اعيش',
    'ماعدتش عايز اعيش',
    'ماعدتش عاوز اعيش',
    'عايز اموت',
    'عاوز اموت',
  ];

  String _responseTemplateOrDefault(String key) {
    return _responseTemplates[key] ?? _responseTemplates['default']!;
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

    if (containsAny(_rolePhrasePacks['addicted_person']!)) {
      roleDetected = 'addicted_person';
    } else if (containsAny(_rolePhrasePacks['family_member']!)) {
      roleDetected = 'family_member';
    }

    if (containsAny(_statePhrasePacks['justification']!)) {
      addState('justification', _stateScores['justification']!);
    }

    if (containsAny(_statePhrasePacks['denial']!)) {
      addState('denial', _stateScores['denial']!);
    }

    if (containsAny(_statePhrasePacks['craving']!)) {
      addState('craving', _stateScores['craving']!);
    }

    if (containsAny(_statePhrasePacks['hopelessness']!)) {
      addState('hopelessness', _stateScores['hopelessness']!);
    }

    if (containsAny(_statePhrasePacks['fear']!)) {
      addState('fear', _stateScores['fear']!);
    }

    if (containsAny(_statePhrasePacks['guilt']!)) {
      addState('guilt', _stateScores['guilt']!);
    }

    if (containsAny(_statePhrasePacks['collapse']!)) {
      addState('collapse', _stateScores['collapse']!);
    }

    if (containsAny(_statePhrasePacks['manipulation']!)) {
      addState('manipulation', _stateScores['manipulation']!);
    }

    if (containsAny(_lossOfControlPhrases)) {
      riskScore += _lossOfControlScore;
    }

    if (containsAny(_selfHarmPhrases)) {
      explicitSelfHarmIntent = true;
      riskScore += _explicitSelfHarmScore;
    }

    final String riskLevel;
    if (explicitSelfHarmIntent || riskScore >= _criticalRiskThreshold) {
      riskLevel = 'critical';
    } else if (riskScore >= _highRiskThreshold) {
      riskLevel = 'high';
    } else if (riskScore >= _mediumRiskThreshold) {
      riskLevel = 'medium';
    } else {
      riskLevel = 'low';
    }

    final String strategyMode;
    if (riskLevel == 'critical') {
      strategyMode = 'safety_override';
    } else if (riskLevel == 'high') {
      strategyMode = 'reality_linking_boundary';
    } else if (riskLevel == 'medium') {
      strategyMode = 'awareness_disruption';
    } else {
      strategyMode = 'containment';
    }

    final bool safetyTriggered = riskLevel == 'critical';
    final bool needsHumanSupport =
        riskLevel == 'critical' || riskLevel == 'high';
    final bool containsEscalationSignal =
        riskLevel == 'critical' || riskLevel == 'high';

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
