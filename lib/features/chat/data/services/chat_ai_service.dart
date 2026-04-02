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

    final addictedPhrases = [
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
    ];

    final familyPhrases = [
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
    ];

    if (containsAny(addictedPhrases)) {
      roleDetected = 'addicted_person';
    } else if (containsAny(familyPhrases)) {
      roleDetected = 'family_member';
    }

    if (containsAny([
      'مش مشكلة',
      'عادي ارجع',
      'عادي ارجع للتعاطي',
      'عادي ارجع اتعاطى',
      'مش غلط',
      'كل الناس بتعمل كده',
      'استاهل ارجع',
      'مفيش مانع ارجع',
    ])) {
      addState('justification', 2);
    }

    if (containsAny([
      'مفيش مشكلة عندي',
      'انا كويس',
      'مش محتاج مساعدة',
      'انا تمام',
      'انا مش محتاج حد',
      'مش محتاج دعم',
      'مفيش حاجة غلط',
    ])) {
      addState('denial', 2);
    }

    if (containsAny([
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
    ])) {
      addState('craving', 3);
    }

    if (containsAny([
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
    ])) {
      addState('hopelessness', 2);
    }

    if (containsAny([
      'خايف',
      'مرعوب',
      'قلقان',
      'متوتر',
      'عندي خوف',
      'حاسس برعب',
      'مش مطمن',
    ])) {
      addState('fear', 0);
    }

    if (containsAny([
      'مذنب',
      'ندمان',
      'حاسس بذنب',
      'انا السبب',
      'حاسس اني وحش',
      'انا وحش',
      'قصرت',
    ])) {
      addState('guilt', 0);
    }

    if (containsAny([
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
    ])) {
      addState('collapse', 0);
    }

    if (containsAny([
      'بتتحكموا فيا',
      'كلكم ضدي',
      'انتوا السبب',
      'هخليكم تندموا',
      'لو سبتوني هعمل حاجة',
      'لو ماعملتوش كذا هعمل كذا',
    ])) {
      addState('manipulation', 2);
    }

    if (containsAny([
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
    ])) {
      riskScore += 3;
    }

    if (containsAny([
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
    ])) {
      explicitSelfHarmIntent = true;
      riskScore += 5;
    }

    final String riskLevel;
    if (explicitSelfHarmIntent || riskScore >= 9) {
      riskLevel = 'critical';
    } else if (riskScore >= 6) {
      riskLevel = 'high';
    } else if (riskScore >= 3) {
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
      return 'أنا سامع إن الخطر هنا مباشر، والأولوية الآن هي الأمان فقط. ابعد حالًا عن أي شيء ممكن تستخدمه لإيذاء نفسك، وخليك في نفس المكان مع شخص موثوق أو اتصل به فورًا، واطلب دعمًا بشريًا مباشرًا الآن. لو أنت وحدك، تحرك فورًا لمكان فيه ناس قريبين منك. أنا معك الآن، ونركز فقط على النجاة من الدقائق الحالية بأمان.';
    }

    if (riskLevel == 'high') {
      return 'واضح إن الضغط عالي جدًا عليك الآن، ومهم ما تفضلش مع ده وحدك. خلينا نهدي الإيقاع ونركز على خطوة آمنة جدًا الآن، ومعها يكون الأفضل التواصل مع شخص موثوق أو دعم بشري قريب.';
    }

    if (riskLevel == 'medium') {
      return 'إحساسك مفهوم، ومش لازم تحل كل شيء الآن. خلينا نبطيء اللحظة ونشوف أول خطوة صغيرة تساعدك تستعيد هدوءك وسيطرتك.';
    }

    if (roleDetected == 'family_member') {
      return 'واضح إنك شايل هم كبير، ووجودك هنا مهم. خلينا نفهم الموقف بهدوء ونركز على خطوة آمنة ومتزنة تساعدك وتساعد الطرف الآخر بدون تصعيد.';
    }

    return 'أنا معك. نقدر نمسك اللي حاصل بهدوء ونفهمه خطوة خطوة، من غير ضغط ومن غير أحكام.';
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
