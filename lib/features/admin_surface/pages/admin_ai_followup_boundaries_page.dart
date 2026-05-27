import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminAiFollowupBoundariesPage extends StatelessWidget {
  const AdminAiFollowupBoundariesPage({super.key});

  Widget _buildBoundaryCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String boundaryNote,
    required String supervisionNote,
    String statusLabel = 'حدود ذكاء اصطناعي إشرافية',
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppSectionPanel(
        color: const Color(0xFF10161A).withValues(alpha: 0.94),
        borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFC9A75B),
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              statusLabel,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFC9A75B),
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Boundary: $boundaryNote',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF314A5C).withValues(alpha: 0.88),
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            GatewaySupervisionNote(text: supervisionNote),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1316),
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'حدود الذكاء في المتابعة',
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF13191D),
              Color(0xFF0F1316),
              Color(0xFF151B1F),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'حدود الذكاء في المتابعة',
              summary:
                  'هذه الصفحة تحدد الدور المسموح للذكاء الاصطناعي داخل المتابعة المستمرة داخل التطبيق باعتباره مساعدًا خفيفًا فقط، يعمل تحت إشراف الإدارة والسياسات.',
              boundaryNote:
                  'الذكاء هنا لا يشخص، ولا يعالج، ولا يقرر وحده، ولا يفعّل أي متابعة مستقلة خارج الحدود والسياسات المعتمدة.',
              emphasis:
                  'أي دور للذكاء داخل المتابعة يجب أن يبقى support-first وsafety-first، دون أي therapeutic substitution أو قرارات مستقلة.',
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ما الذي يمكن للذكاء المساعدة فيه',
              description:
                  'هذه المساعدات تبقى ضمن دور اقتراحي خفيف لا يتجاوز الحوكمة الإدارية المعتمدة.',
              children: [
                _buildBoundaryCard(
                  context,
                  title: 'اقتراح نوع رسالة مناسبة',
                  summary:
                      'يمكن للذكاء اقتراح ما إذا كانت الرسالة الأنسب هي رسالة دعم أو تفقد أو تهنئة أو nudge خفيفة.',
                  boundaryNote:
                      'الاقتراح لا يتحول إلى إرسال فعلي أو قرار مستقل، بل يبقى مادة مساعدة للإدارة فقط.',
                  supervisionNote:
                      'الذكاء هنا يقترح ضمن الرسائل المعتمدة فقط، ولا ينشئ مسارًا علاجيًا.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'اقتراح توقيت متابعة مناسب',
                  summary:
                      'يمكنه اقتراح توقيت هادئ ومناسب للمتابعة بما يحترم طبيعة الدعم الخفيف والاستمرارية.',
                  boundaryNote:
                      'لا يقرر وحده ولا يفعّل أي schedule تلقائي دون موافقة وإطار حوكمة واضح.',
                  supervisionNote:
                      'التوقيت المقترح يبقى إشرافيًا وليس automation فعليًا.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'اقتراح محتوى داعم مناسب للفئة',
                  summary:
                      'يمكنه ترشيح محتوى مناسب من المكتبة بحسب الفئة العامة أو السياق الداعم العام.',
                  boundaryNote:
                      'الاقتراح يظل داخل المحتوى المعتمد فقط، ولا يمتد إلى أي تخصيص علاجي أو تشخيصي.',
                  supervisionNote:
                      'المكتبة هنا مصدر دعم آمن وليست أداة intervention.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'اقتراح tone مناسب',
                  summary:
                      'يمكنه اقتراح نبرة هادئة وداعمة ومحترمة تتسق مع الحدود الأخلاقية للمتابعة داخل التطبيق.',
                  boundaryNote:
                      'يُمنع أن يقترح tone ضاغطة أو عاطفية بصورة استغلالية أو غير مهنية.',
                  supervisionNote:
                      'الـ tone يجب أن تبقى family-safe وغير متطفلة.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ما الذي لا يمكن للذكاء فعله',
              description:
                  'هذه حدود ثابتة تمنع الذكاء من تجاوز التموضع غير الطبي وغير العلاجي داخل المتابعة.',
              children: [
                _buildBoundaryCard(
                  context,
                  title: 'لا تشخيص',
                  summary:
                      'لا يحق للذكاء تفسير حالة المستخدم أو إعطاء توصيفات تشخيصية أو إيحاءات سريرية.',
                  boundaryNote:
                      'هذا يحافظ على التموضع غير الطبي وغير التشخيصي للمنصة.',
                  supervisionNote:
                      'أي تشخيص يخرج الذكاء عن دوره المسموح بالكامل.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'لا علاج',
                  summary:
                      'لا يجوز للذكاء تقديم توجيه علاجي أو أداء وظيفة علاجية أو محاولة تعويض الرعاية المهنية.',
                  boundaryNote:
                      'المتابعة هنا دعم خفيف فقط وليست treatment flow.',
                  supervisionNote: 'الذكاء لا يعمل كبديل عن الرعاية المتخصصة.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'لا تقييم طبي',
                  summary:
                      'لا يجوز له تقييم المخاطر أو الحالة النفسية أو الطبية بصفته مرجعًا مهنيًا أو حاسمًا.',
                  boundaryNote:
                      'أي تقييم حساس أو طبي يبقى خارج هذه الطبقة وخارج هذا الدور.',
                  supervisionNote: 'الذكاء هنا مساعد إداري محدود لا أكثر.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'لا قرارات escalation مستقلة',
                  summary:
                      'لا يجوز له اتخاذ قرار escalation أو safety intervention من تلقاء نفسه داخل المتابعة.',
                  boundaryNote:
                      'أي تصعيد أو حساسية عالية يبقى تحت قواعد واضحة وقرار إداري/تشغيلي منفصل.',
                  supervisionNote:
                      'الذكاء لا يملك قرارًا سياديًا في هذا المسار.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'لا override للقواعد',
                  summary:
                      'لا يمكنه تجاوز قواعد الحظر أو الإيقاف أو التحايل على boundaries أو checkpoints المعتمدة.',
                  boundaryNote:
                      'القواعد والسياسات تتقدم دائمًا على أي اقتراح ذكي.',
                  supervisionNote:
                      'الحوكمة أولًا، والاقتراح الذكي تابع لها فقط.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'لا ضغط نفسي أو إلحاح',
                  summary:
                      'لا يجوز للذكاء اقتراح أساليب إلحاح أو ضغط أو تعلق عاطفي أو tone استغلالية.',
                  boundaryNote:
                      'الدعم يفقد شرعيته إذا تحوّل إلى ضغط أو burden أو دفع نفسي غير مناسب.',
                  supervisionNote:
                      'هذا حد أخلاقي مباشر داخل أي follow-up assisted by AI.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'حدود القرار',
              description:
                  'هذا القسم يثبت أن القرار النهائي لا ينتقل إلى الذكاء الاصطناعي، بل يبقى تحت الإشراف البشري والسياسات.',
              children: [
                _buildBoundaryCard(
                  context,
                  title: 'القرار النهائي للإدارة',
                  summary:
                      'أي قرار يتعلق بالمتابعة أو الرسائل أو توقيتها أو استمرارها يبقى قرارًا إداريًا خاضعًا للحوكمة.',
                  boundaryNote:
                      'الذكاء لا يملك حق التفعيل أو الإيقاف أو التغيير المستقل.',
                  supervisionNote:
                      'الإدارة هي صاحبة القرار النهائي، والذكاء أداة مساعدة فقط.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'الذكاء يقترح فقط',
                  summary:
                      'وظيفة الذكاء هنا تقديم اقتراحات أو ترشيحات تساعد في الاختيار ولا تستبدل التقييم الإشرافي.',
                  boundaryNote:
                      'أي اقتراح يبقى غير نافذ بذاته وغير ملزم حتى لو بدا مناسبًا.',
                  supervisionNote: 'اقتراح فقط، لا تنفيذ، لا اعتماد ذاتي.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'لا إرسال تلقائي غير معتمد',
                  summary:
                      'لا يجوز أن ينتج عن اقتراح الذكاء إرسال فعلي أو متابعة مفعلة تلقائيًا دون اعتماد واضح.',
                  boundaryNote:
                      'هذا يمنع الانزلاق من assistive mode إلى automation غير منضبطة.',
                  supervisionNote: 'لا automation هنا في المرحلة الحالية.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'لا تفعيل دون checkpoints',
                  summary:
                      'أي توسيع لدور الذكاء يجب أن يمر عبر checkpoints واضحة للسلامة والامتثال والرؤية الإدارية.',
                  boundaryNote: 'التفعيل لا يسبق الضوابط، بل يأتي بعدها فقط.',
                  supervisionNote:
                      'هذا يربط الذكاء مباشرة بمنظومة الحوكمة الحالية.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'حالات الحظر',
              description:
                  'هذه الحالات تمنع أي follow-up assisted by AI حتى لو كان الدور المقترح يبدو خفيفًا.',
              children: [
                _buildBoundaryCard(
                  context,
                  title: 'crisis',
                  summary:
                      'أي حالة crisis أو هشاشة مرتفعة تمنع تمامًا أي متابعة ذكية أو اقتراحات متابعة موازية.',
                  boundaryNote:
                      'السلامة تتقدم على أي رسالة أو محتوى أو pattern متابعة.',
                  supervisionNote: 'هذا حظر ثابت لا ينبغي الالتفاف حوله.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'active support chat',
                  summary:
                      'عند وجود شات دعم نشط، يجب ألا يتدخل الذكاء بمسار متابعة خفيف متوازي يربك المستخدم أو الفريق.',
                  boundaryNote:
                      'مسار الدعم المباشر أولى من الاقتراحات الذكية الموازية.',
                  supervisionNote:
                      'الفصل بين المسارات يحافظ على الوضوح والسلامة.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'جلسات نشطة',
                  summary:
                      'عندما يكون المستخدم داخل جلسات نشطة، لا ينبغي للذكاء اقتراح follow-up pattern قد يتداخل مع هذا السياق.',
                  boundaryNote:
                      'هذا يمنع التضارب مع الرعاية المهنية أو تشويش تجربة المستخدم.',
                  supervisionNote: 'المتابعة الذكية هنا تبقى محجوبة بالكامل.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'حالات حساسة تمنع أي follow-up ذكي',
                  summary:
                      'أي حالة حساسة أو ملتبسة أو ذات هشاشة عاطفية مرتفعة يجب أن تمنع أي follow-up assisted by AI.',
                  boundaryNote:
                      'الحظر هنا احترازي وأخلاقي حتى قبل وجود telemetry أو automation فعلية.',
                  supervisionNote: 'الشك في الحساسية يكفي لإيقاف هذا المسار.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'الربط بالمحتوى والرسائل',
              description:
                  'الذكاء يمكنه المساعدة ضمن المواد والرسائل المعتمدة فقط، دون توليد مسارات خارج الحوكمة.',
              children: [
                _buildBoundaryCard(
                  context,
                  title: 'اقتراح رسالة',
                  summary:
                      'يمكنه اقتراح رسالة مناسبة من الأنماط المعتمدة مسبقًا ضمن الرسائل الداعمة المعروفة.',
                  boundaryNote:
                      'لا يتحول الاقتراح إلى إرسال مستقل، ولا ينشئ من تلقاء نفسه إطارًا علاجيًا جديدًا.',
                  supervisionNote: 'الرسائل المعتمدة فقط هي نطاق العمل هنا.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'اقتراح محتوى',
                  summary:
                      'يمكنه ترشيح محتوى من المكتبة المعتمدة بما يخدم الدعم الخفيف والاستمرارية.',
                  boundaryNote:
                      'لا يجوز له إحالة المستخدم إلى محتوى غير معتمد أو خارج الإطار الآمن للمكتبة.',
                  supervisionNote: 'المكتبة تسبق الاقتراح الذكي، لا العكس.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'اقتراح follow-up pattern',
                  summary:
                      'يمكنه اقتراح نمط متابعة خفيف ومنضبط يراعي الفئة والسياق العام دون أن يصبح protocol علاجيًا.',
                  boundaryNote:
                      'أي pattern يجب أن يبقى محدودًا وخاضعًا للحوكمة ولا يتجاوز boundaries الحالية.',
                  supervisionNote:
                      'النمط المقترح هنا إشرافي فقط وليس engine تشغيليًا.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ملاحظات إشرافية',
              description:
                  'هذه الملاحظات تلخص التموضع الصحيح لدور الذكاء داخل Follow-Up Care Governance في المرحلة الحالية.',
              children: [
                _buildBoundaryCard(
                  context,
                  title: 'AI assist only',
                  summary:
                      'الذكاء داخل المتابعة يعمل كمساعد اقتراحي خفيف فقط، ولا يتحول إلى صاحب قرار أو صاحب سلطة مستقلة.',
                  boundaryNote:
                      'الاقتراح يظل تابعًا للإشراف والسياسات ولا يستبدل الإدارة.',
                  supervisionNote: 'هذا هو الحد المركزي لهذه الصفحة.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'support-first',
                  summary:
                      'كل مساهمة من الذكاء يجب أن تبقى ضمن منطق الدعم اللطيف والاستمرارية لا ضمن منطق الضغط أو الدفع.',
                  boundaryNote:
                      'الدعم يسبق أي رغبة في التوسع أو التفعيل أو التخصيص.',
                  supervisionNote: 'هذا يضمن بقاء المتابعة إنسانية وآمنة.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'safety-first',
                  summary:
                      'السلامة تتقدم على أي اقتراح ذكي، وعلى أي متابعة، وعلى أي محاولة لتحسين engagement أو continuity.',
                  boundaryNote:
                      'أي تعارض بين السلامة والاقتراح يعني إيقاف الاقتراح فورًا من حيث المبدأ.',
                  supervisionNote: 'السلامة هنا مبدأ حاكم لا يُفاوض عليه.',
                ),
                _buildBoundaryCard(
                  context,
                  title: 'no therapeutic substitution',
                  summary:
                      'لا يجوز أن يتحول الذكاء داخل المتابعة إلى بديل علاجي أو إلى impression يوحي بوجود رعاية مهنية تلقائية.',
                  boundaryNote:
                      'هذا يحفظ التموضع غير العلاجي وغير الطبي للمنصة ويحمي المستخدم من الالتباس.',
                  supervisionNote:
                      'هذه الصفحة إشرافية فقط ولا تضيف أي behavior فعلي.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
