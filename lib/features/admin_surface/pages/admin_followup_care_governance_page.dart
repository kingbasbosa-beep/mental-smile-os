import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminFollowupCareGovernancePage extends StatefulWidget {
  const AdminFollowupCareGovernancePage({super.key});

  @override
  State<AdminFollowupCareGovernancePage> createState() =>
      _AdminFollowupCareGovernancePageState();
}

class _AdminFollowupCareGovernancePageState
    extends State<AdminFollowupCareGovernancePage> {
  final GlobalKey _rulesKey = GlobalKey();
  final GlobalKey _boundariesKey = GlobalKey();
  final GlobalKey _examplesKey = GlobalKey();

  Future<void> _jumpToSection(GlobalKey key) async {
    final targetContext = key.currentContext;
    if (targetContext == null) return;
    await Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      alignment: 0.08,
    );
  }

  Widget _buildAnchorBar(BuildContext context) {
    Widget buildAnchorButton(String label, GlobalKey key) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
        child: OutlinedButton(
          onPressed: () => _jumpToSection(key),
          child: Text(label),
        ),
      );
    }

    return AppSurfaceCard(
      color: const Color(0xFF10161A).withValues(alpha: 0.94),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الانتقال السريع داخل الصفحة',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFC9A75B),
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildAnchorButton('Rules', _rulesKey),
                buildAnchorButton('Boundaries', _boundariesKey),
                buildAnchorButton('Examples', _examplesKey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGovernanceCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String boundaryNote,
    required String supervisionNote,
    String statusLabel = 'حوكمة إشرافية',
    bool enableCopyMessage = false,
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
            if (enableCopyMessage) ...[
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: summary));
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Copied'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy_outlined, size: 18),
                  label: const Text('Copy Message'),
                ),
              ),
            ],
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
        title: 'Follow-Up Care Governance',
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
              title: 'Follow-Up Care Governance',
              summary:
                  'هذه الصفحة تحدد طبقة الحوكمة الإشرافية للمتابعة داخل التطبيق باعتبارها مسارًا مملوكًا للإدارة فقط، يركز على الدعم الخفيف والاستمرارية والاحتواء.',
              boundaryNote:
                  'هذه الطبقة ليست علاجًا، وليست جلسات، وليست تدخلًا عميقًا، ولا يوجد فيها أي دور للمراكز أو الأخصائيين. هي إطار إداري داعم فقط.',
              emphasis:
                  'أي متابعة هنا يجب أن تبقى غير علاجية، غير تشخيصية، وآمنة أخلاقيًا، مع احترام حدود الدعم وعدم التدخل في سياقات الحساسية أو الأزمة.',
            ),
            const SizedBox(height: AppSpacing.md),
            _buildAnchorBar(context),
            const SizedBox(height: AppSpacing.md),
            const GatewaySectionCard(
              title: 'Follow-Up Care Subsystem Definition',
              description:
                  'This compact section defines follow-up care as an isolated governed subsystem with clear scope and limits.',
              children: [
                GatewaySupervisionNote(
                  text:
                      'Does: admin-owned follow-up guidance, approved continuity language, manual supervised follow-up support, and safe boundaries for light continuity support.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Does not do: therapy engine behavior, live care orchestration, clinician replacement, or any automated follow-up system.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Boundaries: admin-owned only, manual and supervised use only, not during crisis, not during active sessions, and light continuity support only.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Supervision note: non-medical, non-diagnostic, calm, family-aware, and safety-first.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'نموذج المتابعة',
              description:
                  'هذا القسم يثبت من يملك المتابعة داخل التطبيق وما الذي تبقى خارجه.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'Admin-owned follow-up only',
                  summary:
                      'المتابعة داخل التطبيق مملوكة للإدارة فقط من حيث الحوكمة والتوجيه والضبط العام.',
                  boundaryNote:
                      'لا يوجد دور للمراكز أو الأخصائيين داخل هذه الطبقة، ولا تعمل كامتداد للجلسات أو الرعاية المهنية.',
                  supervisionNote:
                      'هذه الصفحة تنظّم الملكية الإشرافية فقط ولا تضيف أي صلاحيات تشغيلية أو backend.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'الفئات المستهدفة',
              description:
                  'هذه الفئات تمثل الجهات التي يمكن التفكير في متابعتها ضمن إطار دعم خفيف واستمرارية فقط.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'المتعافين (post-recovery)',
                  summary:
                      'يمكن دعم هذه الفئة برسائل خفيفة تحفظ الاستمرارية والطمأنة وتساعد على البقاء في مسار داعم وآمن.',
                  boundaryNote:
                      'المتابعة هنا ليست علاجًا مستمرًا ولا بديلاً عن أي رعاية متخصصة إذا كانت مطلوبة.',
                  supervisionNote:
                      'الإدارة فقط تملك هذه الطبقة، ولا يوجد فيها دور للمراكز أو الأخصائيين.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'أسر ذوي الاحتياجات الخاصة',
                  summary:
                      'يمكن توفير متابعة خفيفة للأسر من باب الدعم والتوعية والاستمرارية وربطهم بالمحتوى المناسب.',
                  boundaryNote:
                      'لا يجب أن تتحول المتابعة إلى تدخل علاجي أو إرشاد تشخيصي.',
                  supervisionNote:
                      'الهدف هنا الدعم والاستمرار، لا إدارة حالة علاجية.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'اضطرابات بدون إدمان',
                  summary:
                      'يمكن التفكير في متابعة داعمة لهذه الفئة من زاوية التوعية والاستقرار وربطها بمحتوى مناسب.',
                  boundaryNote:
                      'المتابعة لا يجب أن تُفهم كعلاج أو بديل عن تدخل مختص عند الحاجة.',
                  supervisionNote:
                      'هذه الفئة تبقى ضمن إطار دعم خفيف فقط داخل التطبيق.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'أنواع المتابعة',
              description:
                  'أنواع المتابعة المسموح التفكير فيها هنا يجب أن تبقى خفيفة، إنسانية، وغير تدخلية.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'رسائل دعم',
                  summary:
                      'رسائل قصيرة تعطي دعمًا نفسيًا خفيفًا وطمأنة عامة دون تدخل علاجي.',
                  boundaryNote:
                      'يُمنع أن تحمل وعودًا علاجية أو تشخيصًا أو توجيهًا سريريًا.',
                  supervisionNote:
                      'الرسائل هنا داعمة فقط وليست بديلًا عن الرعاية.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'رسائل تفقد',
                  summary:
                      'رسائل خفيفة للاطمئنان والاستمرارية دون الدخول في تدخل عميق أو متابعة سريرية.',
                  boundaryNote:
                      'يجب ألا تتحول رسائل التفقد إلى ضغط أو إزعاج أو ملاحقة متكررة.',
                  supervisionNote: 'الغرض هو الاستمرارية الرقيقة فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'رسائل تهنئة',
                  summary:
                      'رسائل مناسبة للمناسبات أو للتشجيع الرمزي ضمن حدود داعمة وبسيطة.',
                  boundaryNote:
                      'يجب أن تبقى غير متطفلة وغير مرتبطة باستغلال عاطفي.',
                  supervisionNote:
                      'الهدف تقوية الانتماء والاستمرارية، لا التأثير العلاجي.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'nudges خفيفة',
                  summary:
                      'تنبيهات أو دفعات خفيفة جدًا تشجع على العودة للمحتوى أو الاستفادة من التوعية.',
                  boundaryNote:
                      'يجب ألا تصبح هذه الـ nudges مزعجة أو ضاغطة أو متكررة بصورة مرهقة.',
                  supervisionNote: 'الدفعات هنا لطيفة ومحدودة فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'ربط بالمحتوى',
                  summary:
                      'يمكن أن ترتبط المتابعة بإحالات إلى محتوى مناسب من المكتبة لدعم الاستمرارية والاحتواء.',
                  boundaryNote:
                      'يبقى هذا الربط داعمًا فقط ولا يتحول إلى intervention flow أو برنامج علاجي.',
                  supervisionNote: 'المحتوى هنا امتداد للدعم الخفيف لا أكثر.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            KeyedSubtree(
              key: _examplesKey,
              child: GatewaySectionCard(
                title: 'أمثلة نبرة متابعة معتمدة',
                description:
                    'هذه أمثلة ثابتة ومرجعية فقط لاستخدام يدوي من الإدارة خارج النظام، دون إنشاء أي تدفق متابعة فعلي داخل التطبيق.',
                children: [
                  _buildGovernanceCard(
                    context,
                    title: 'Gentle Check-in',
                    summary:
                        'مرحبًا، هذه رسالة تفقد لطيفة فقط. إذا كان الوقت مناسبًا لك، يمكنك العودة لاحقًا إلى المساحة الداعمة أو إلى محتوى مناسب داخل التطبيق.',
                    boundaryNote:
                        'غير طبي، غير تشخيصي، وغير مناسب للأزمة أو أثناء الجلسات النشطة أو الحالات الحساسة.',
                    supervisionNote:
                        'دعم يدوي مملوك للإدارة فقط، بهدوء وبدون ضغط أو إلحاح أو مسار علاجي.',
                    statusLabel: 'مثال متابعة معتمد',
                    enableCopyMessage: true,
                  ),
                  _buildGovernanceCard(
                    context,
                    title: 'Light Encouragement',
                    summary:
                        'خطواتك الهادئة مهمة، حتى لو بدت بسيطة. خذ وقتك، ويمكنك الاستفادة من الدعم أو المحتوى المناسب عندما يكون ذلك ملائمًا لك.',
                    boundaryNote:
                        'رسالة دعم خفيف فقط، بلا claims علاجية، وبلا نبرة ذنب أو urgency أو دفع نفسي.',
                    supervisionNote:
                        'نبرة مشجعة وfamily-safe ضمن متابعة يدوية غير علاجية.',
                    statusLabel: 'مثال متابعة معتمد',
                    enableCopyMessage: true,
                  ),
                  _buildGovernanceCard(
                    context,
                    title: 'Calm Continuity Reminder',
                    summary:
                        'عندما يكون الوقت مناسبًا لك، يمكنك العودة بهدوء إلى التطبيق أو إلى مادة داعمة مناسبة كجزء من الاستمرارية والاحتواء فقط.',
                    boundaryNote:
                        'تذكير هادئ غير ضاغط، لا يتحول إلى pressure flow أو تدخل علاجي أو تشخيصي.',
                    supervisionNote:
                        'هذا المثال يحافظ على الاستمرارية دون إزعاج أو إلحاح.',
                    statusLabel: 'مثال متابعة معتمد',
                    enableCopyMessage: true,
                  ),
                  _buildGovernanceCard(
                    context,
                    title: 'Pause / Respectful Stop Message',
                    summary:
                        'سنوقف رسائل المتابعة في الوقت الحالي احترامًا لطلبك أو لظروفك الحالية. يمكنك العودة لاحقًا متى رغبت إلى المساحة الداعمة داخل التطبيق.',
                    boundaryNote:
                        'رسالة احترام وإيقاف فقط، ليست للأزمة، وليست للجلسات النشطة، ولا تحمل أي ضغط أو guilt-based nudging.',
                    supervisionNote:
                        'هذا مثال يدعم الاختيار الشخصي والسلامة ويؤكد أن المتابعة تظل يدوية ومملوكة للإدارة فقط.',
                    statusLabel: 'مثال متابعة معتمد',
                    enableCopyMessage: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            KeyedSubtree(
              key: _rulesKey,
              child: GatewaySectionCard(
                title: 'شروط بدء المتابعة',
                description:
                    'المتابعة لا تبدأ إلا داخل سياقات مستقرة وآمنة ومناسبة لوظيفتها الداعمة فقط.',
                children: [
                  _buildGovernanceCard(
                    context,
                    title: 'المستخدم ليس في جلسات نشطة',
                    summary:
                        'لا يجب التفكير في بدء المتابعة عندما يكون المستخدم داخل جلسات نشطة أو مسار جلسات قائم.',
                    boundaryNote:
                        'يفصل ذلك بين المتابعة الإدارية الخفيفة وبين أي مسار جلسات فعلي.',
                    supervisionNote: 'المتابعة هنا ليست امتدادًا للجلسات.',
                  ),
                  _buildGovernanceCard(
                    context,
                    title: 'لا يوجد تدخل علاجي حالي',
                    summary:
                        'تبدأ المتابعة فقط عندما لا يكون هناك تدخل علاجي أو رعاية مهنية جارية يجب احترامها وعدم التشويش عليها.',
                    boundaryNote:
                        'أي رعاية مهنية حالية تتقدم على المتابعة الخفيفة داخل التطبيق.',
                    supervisionNote:
                        'هذا الشرط يحفظ وضوح الأدوار وعدم التضارب.',
                  ),
                  _buildGovernanceCard(
                    context,
                    title: 'لا يوجد crisis active',
                    summary:
                        'لا تبدأ المتابعة أبدًا إذا كان هناك سياق أزمة أو هشاشة أو تصعيد سلامة قائم.',
                    boundaryNote:
                        'السلامة تتقدم على الاستمرارية أو الرسائل أو المحتوى أو أي nudges.',
                    supervisionNote:
                        'هذا شرط أخلاقي ثابت وليس مجرد تفضيل تنظيمي.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'حالات الإيقاف',
              description:
                  'حتى بعد بدء المتابعة، توجد حالات يجب أن توقف هذا المسار فورًا أو مؤقتًا.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'دخول في crisis',
                  summary:
                      'أي دخول في سياق أزمة أو حساسية عالية يعني إيقاف المتابعة الخفيفة مباشرة.',
                  boundaryNote:
                      'مسار السلامة والدعم الحساس يتقدم على المتابعة الخفيفة بالكامل.',
                  supervisionNote:
                      'الإيقاف هنا جزء من الحوكمة لا منطق backend.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'فتح شات دعم',
                  summary:
                      'عند فتح شات دعم مباشر، يجب أن تتوقف المتابعة الخفيفة حتى لا يحدث تضارب أو تشويش.',
                  boundaryNote:
                      'الشات الداعم البشري أو التشغيلي أولى من أي متابعة خفيفة متوازية.',
                  supervisionNote: 'هذا يحافظ على وضوح المسارات داخل التطبيق.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'بدء جلسات مع مختص',
                  summary:
                      'إذا بدأ المستخدم جلسات مع مختص، يجب أن تبقى المتابعة الخفيفة خارج هذا المسار وألا تزاحمه.',
                  boundaryNote:
                      'هذا يمنع التضارب مع الرعاية المهنية أو التشويش على السياق العلاجي.',
                  supervisionNote:
                      'المختص هنا يتقدم على أي follow-up إداري خفيف.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'طلب المستخدم إيقاف المتابعة',
                  summary:
                      'يجب احترام رغبة المستخدم في إيقاف المتابعة فورًا دون ضغط أو محاولات التفاف.',
                  boundaryNote:
                      'احترام الاختيار الشخصي جزء أساسي من شرعية هذا المسار.',
                  supervisionNote:
                      'هذه قاعدة إشرافية واضحة حتى قبل أي automation مستقبلية.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            KeyedSubtree(
              key: _boundariesKey,
              child: GatewaySectionCard(
                title: 'حدود المتابعة',
                description:
                    'هذه الحدود تحفظ الفرق بين المتابعة الداعمة وبين أي تدخل علاجي أو حسّاس أو ضاغط.',
                children: [
                  _buildGovernanceCard(
                    context,
                    title: 'لا تشخيص',
                    summary:
                        'المتابعة لا تفسر الحالة، ولا تصف المستخدم، ولا تعطي أي قراءة تشخيصية مباشرة أو ضمنية.',
                    boundaryNote:
                        'هذا يحافظ على التموضع غير الطبي وغير التشخيصي للتطبيق.',
                    supervisionNote: 'أي تشخيص يخرج الطبقة عن معناها بالكامل.',
                  ),
                  _buildGovernanceCard(
                    context,
                    title: 'لا علاج',
                    summary:
                        'المتابعة لا تحاول أداء وظيفة علاجية أو تقديم intervention أو بديل عن الرعاية المهنية.',
                    boundaryNote:
                        'هذه الطبقة للدعم الخفيف فقط وليست برنامج علاج أو protocol متابعة علاجية.',
                    supervisionNote:
                        'أي انحراف هنا يكسر المعمارية والتموضع معًا.',
                  ),
                  _buildGovernanceCard(
                    context,
                    title: 'لا ضغط',
                    summary:
                        'المتابعة لا يجوز أن تتحول إلى إلحاح أو burden أو نبرة تدفع المستخدم دفعًا لمسار لا يريده.',
                    boundaryNote:
                        'الدعم يفقد شرعيته إذا صار ضاغطًا أو مزعجًا أو متكررًا بصورة مرهقة.',
                    supervisionNote: 'الاحتواء الهادئ أهم من كثافة التدخل.',
                  ),
                  _buildGovernanceCard(
                    context,
                    title: 'لا تدخل عميق',
                    summary:
                        'هذا المسار لا يدخل في متابعة حساسة أو معقّدة أو طويلة الأثر، ولا يحاول إدارة حالة أو تعويض غياب رعاية أعمق.',
                    boundaryNote:
                        'العمق العلاجي أو التشغيلي ليس وظيفة هذه الطبقة.',
                    supervisionNote:
                        'المتابعة هنا خفيفة بطبيعتها ويجب أن تبقى كذلك.',
                  ),
                  _buildGovernanceCard(
                    context,
                    title: 'لا تعارض مع المختصين',
                    summary:
                        'المتابعة لا يجب أن تتداخل مع المختصين أو تقدم نفسها كموازٍ أو بديل عنهم أو عن رعايتهم.',
                    boundaryNote:
                        'تحافظ هذه القاعدة على الفصل الواضح بين الدعم الإداري وبين الرعاية المتخصصة.',
                    supervisionNote:
                        'هذه الطبقة مملوكة للإدارة فقط وليست أداة للمختصين أو المراكز.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ربط المتابعة بالمحتوى والرسائل',
              description:
                  'المتابعة هنا تستخدم الرسائل والمحتوى كامتداد للدعم الخفيف فقط، لا كبرنامج علاجي.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'المتابعة تستخدم الرسائل والمحتوى كدعم فقط',
                  summary:
                      'يمكن للمتابعة أن تستفيد من الرسائل الخفيفة والإحالات إلى المكتبة من أجل الاستمرارية والاحتواء وربط المستخدم بمحتوى نافع.',
                  boundaryNote:
                      'الوظيفة هنا دعمية فقط، وليست workflow علاجية أو pressure flow أو مسار تدخل.',
                  supervisionNote: 'المحتوى والرسائل هنا أدوات دعم خفيف فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'لا تتحول إلى برنامج علاجي',
                  summary:
                      'حتى عند الجمع بين الرسائل والمحتوى، يجب ألا تتشكل بنية علاجية أو برنامج متابعة عميق داخل التطبيق.',
                  boundaryNote:
                      'هذا يحفظ الفرق بين الاستمرارية الخفيفة وبين الرعاية المهنية أو العلاجية.',
                  supervisionNote:
                      'هذه الصفحة تضع الحد الإشرافي فقط ولا تضيف أي workflow فعلي.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ملاحظات إشرافية',
              description:
                  'تلخص هذه الملاحظات طبيعة Follow-Up Care Governance وحدودها الحالية.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'المتابعة هدفها الاستمرارية والاحتواء',
                  summary:
                      'القيمة الأساسية هنا تأتي من الاستمرارية الهادئة والاحتواء وربط المستخدم بدعم خفيف غير متطفل.',
                  boundaryNote:
                      'الدور هنا داعم فقط، وليس دور علاج أو تقييم أو إدارة حالة.',
                  supervisionNote:
                      'هذا التحديد أساسي للحفاظ على سلامة المعمارية والتموضع.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'ليست بديلًا عن الرعاية المهنية',
                  summary:
                      'هذه الطبقة لا تحل محل المختصين ولا الرعاية المهنية ولا أي تدخل متخصص عند الحاجة.',
                  boundaryNote:
                      'أي حاجة إلى رعاية أعمق تبقى خارج هذه الطبقة وبعيدة عن منطق المتابعة الخفيفة.',
                  supervisionNote: 'التموضع غير العلاجي هنا ثابت وواضح.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'safety-first',
                  summary:
                      'السلامة تتقدم على الاستمرارية، وتتقدم على الرسائل، وتتقدم على المحتوى، وتتقدم على أي رغبة في إبقاء المستخدم داخل مسار متابعة.',
                  boundaryNote:
                      'أي سياق حساس أو هش أو متصاعد يوقف منطق المتابعة ويعيد الأولوية إلى السلامة والدعم المناسب.',
                  supervisionNote:
                      'هذا هو المبدأ الحاكم للطبقة الحالية وما بعدها.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
