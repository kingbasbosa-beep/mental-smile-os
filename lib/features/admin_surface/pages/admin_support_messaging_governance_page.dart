import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminSupportMessagingGovernancePage extends StatefulWidget {
  const AdminSupportMessagingGovernancePage({super.key});

  @override
  State<AdminSupportMessagingGovernancePage> createState() =>
      _AdminSupportMessagingGovernancePageState();
}

class _AdminSupportMessagingGovernancePageState
    extends State<AdminSupportMessagingGovernancePage> {
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
    String statusLabel = 'حوكمة الرسائل الداعمة',
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
        title: 'Support Messaging Governance',
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
              title: 'Support Messaging Governance',
              summary:
                  'صفحة إشرافية مرجعية لحوكمة الرسائل الداعمة داخل التطبيق وحدودها الأخلاقية والتشغيلية، مع تثبيت أنها مملوكة للإدارة فقط.',
              boundaryNote:
                  'هذه الصفحة تنظيمية فقط ولا تضيف أي تكاملات أو منطق إرسال فعلي أو backend.',
              emphasis:
                  'الرسائل الداعمة هنا ليست علاجًا، وليست مسارًا خاصًا بالمراكز أو الأخصائيين، بل طبقة دعم واستمرارية تحت حوكمة الإدارة فقط.',
            ),
            const SizedBox(height: AppSpacing.md),
            _buildAnchorBar(context),
            const SizedBox(height: AppSpacing.md),
            const GatewaySectionCard(
              title: 'Support Messaging Subsystem Definition',
              description:
                  'This compact section defines support messaging as an isolated governed subsystem with clear scope and limits.',
              children: [
                GatewaySupervisionNote(
                  text:
                      'Does: admin-owned support messaging guidance, approved message language, manual support wording, and safe communication boundaries.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Does not do: campaign engine behavior, automated outreach, chat system behavior, or any therapeutic messaging system.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Boundaries: admin-owned only, manual and supervised use only, not during crisis, not during active sessions, and support-first only.',
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
              title: 'نموذج الحوكمة',
              description:
                  'هذا القسم يوضح من يملك الرسائل الداعمة ومن لا يملكها.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'Admin-governed messaging only',
                  summary:
                      'الرسائل الداعمة داخل التطبيق مملوكة للإدارة فقط من حيث الحوكمة والتوجيه والضبط.',
                  boundaryNote:
                      'لا يوجد إرسال مباشر من الأخصائيين أو المراكز ضمن هذه الطبقة.',
                  supervisionNote:
                      'هذا حد حوكمي ثابت في الصفحة الحالية، وليس نظام صلاحيات backend.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'الفئات المستهدفة',
              description:
                  'هذه الفئات تمثل نطاق الرسائل الداعمة داخل التطبيق في حدود الدعم والاستمرارية فقط.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'المتعافين',
                  summary:
                      'يمكن دعمهم برسائل خفيفة تساعد على الاستمرارية والطمأنة وربطهم بالمحتوى المناسب.',
                  boundaryNote:
                      'لا يجب أن تتحول الرسائل إلى متابعة علاجية أو تدخل متخصص.',
                  supervisionNote:
                      'الدعم هنا خفيف واستمراري فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'أسر ذوي الاحتياجات الخاصة',
                  summary:
                      'يمكن توجيه رسائل داعمة وتوعوية خفيفة لهذه الفئة بما يدعم الاستمرارية والمعرفة.',
                  boundaryNote:
                      'الرسائل لا يجب أن تحمل إرشادًا علاجيًا أو ضغطًا عاطفيًا.',
                  supervisionNote:
                      'الفئة تُدعم ضمن إطار توعوي داعم فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'اضطرابات بدون إدمان',
                  summary:
                      'يمكن أن تتلقى هذه الفئة رسائل خفيفة ترتبط بالتوعية والاستقرار وربط المحتوى المناسب.',
                  boundaryNote:
                      'لا تُفهم هذه الرسائل كبديل عن الرعاية المهنية أو كتشخيص ضمني.',
                  supervisionNote:
                      'المتابعة هنا للاستمرارية لا للعلاج.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'أنواع الرسائل',
              description:
                  'هذه الأنواع تمثل الإطار المقبول للرسائل الداعمة داخل التطبيق.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'رسائل دعم',
                  summary:
                      'رسائل قصيرة داعمة وطمأنة عامة تساعد على الإحساس بالاستمرارية.',
                  boundaryNote:
                      'لا تحمل تشخيصًا أو تدخلًا علاجيًا.',
                  supervisionNote:
                      'الغرض هنا الدعم فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'رسائل تفقد',
                  summary:
                      'رسائل خفيفة للتفقد والاهتمام دون الدخول في متابعة علاجية أو حساسة.',
                  boundaryNote:
                      'يجب ألا تتحول إلى ملاحقة أو ضغط أو burden على المستخدم.',
                  supervisionNote:
                      'الرسالة هنا لطيفة ومحدودة.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'رسائل توعية',
                  summary:
                      'رسائل تربط المستخدم بمحتوى معرفي أو توعوي مناسب لفئته العامة.',
                  boundaryNote:
                      'تبقى معلوماتية وغير تشخيصية.',
                  supervisionNote:
                      'التوعية تسبق أي منطق تدخل مباشر.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'رسائل تهنئة',
                  summary:
                      'رسائل بسيطة للمناسبات أو التشجيع الرمزي ضمن حدود آمنة وغير متطفلة.',
                  boundaryNote:
                      'لا يجب أن تستغل الحالة النفسية أو تولّد تعلقًا غير صحي.',
                  supervisionNote:
                      'دورها معنوي خفيف فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'nudges خفيفة',
                  summary:
                      'تنبيهات بسيطة تشجع على العودة للمحتوى أو الاستفادة من مادة داعمة.',
                  boundaryNote:
                      'يجب ألا تتحول إلى pressure flow أو تكرار مزعج.',
                  supervisionNote:
                      'الـ nudge هنا لطيفة وغير متطفلة.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            KeyedSubtree(
              key: _examplesKey,
              child: GatewaySectionCard(
              title: 'أمثلة رسائل يدوية معتمدة',
              description:
                  'هذه الأمثلة ثابتة ومرجعية فقط، ويمكن استخدامها يدويًا خارج النظام دون إنشاء أي تدفق إرسال فعلي داخل التطبيق.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'Check-in',
                  summary:
                      'مرحبًا، نرسل لك هذه الرسالة كتفقد لطيف فقط. إذا كان هذا الوقت مناسبًا لك، يمكنك العودة متى أحببت إلى المحتوى الداعم داخل التطبيق.',
                  boundaryNote:
                      'غير طبي، غير تشخيصي، وغير مناسب لحالات الأزمة أو أثناء الجلسات النشطة.',
                  supervisionNote:
                      'دعم يدوي مملوك للإدارة فقط، بدون ضغط أو إلحاح أو مسار علاجي.',
                  statusLabel: 'مثال رسالة معتمد',
                  enableCopyMessage: true,
                ),
                _buildGovernanceCard(
                  context,
                  title: 'Encouragement',
                  summary:
                      'خطواتك الهادئة لها قيمة، حتى لو كانت بسيطة. يمكنك الاستفادة من المساحة الداعمة داخل التطبيق بالوتيرة التي تناسبك.',
                  boundaryNote:
                      'رسالة داعمة فقط، بلا claims علاجية، وبلا نبرة ذنب أو استعجال.',
                  supervisionNote:
                      'الهدف هنا التشجيع الهادئ family-safe ضمن دعم يدوي خفيف.',
                  statusLabel: 'مثال رسالة معتمد',
                  enableCopyMessage: true,
                ),
                _buildGovernanceCard(
                  context,
                  title: 'Awareness',
                  summary:
                      'قد يفيدك الاطلاع على محتوى توعوي مناسب داخل المكتبة عندما يكون الوقت مناسبًا لك، كجزء من الدعم الخفيف والاستمرارية.',
                  boundaryNote:
                      'إحالة توعوية فقط، لا تتحول إلى تدخل علاجي أو pressure flow أو تشخيص.',
                  supervisionNote:
                      'هذا المثال يربط الرسالة بالمحتوى بشكل داعم فقط وتحت إشراف الإدارة.',
                  statusLabel: 'مثال رسالة معتمد',
                  enableCopyMessage: true,
                ),
                _buildGovernanceCard(
                  context,
                  title: 'Congratulations / Light Nudge',
                  summary:
                      'أحسنت على استمرارك الهادئ. إذا رغبت، يمكنك العودة لاحقًا إلى التطبيق أو إلى مادة داعمة مناسبة لك، دون أي استعجال.',
                  boundaryNote:
                      'رسالة لطيفة وغير متطفلة، وليست مناسبة للأزمة أو للجلسات النشطة أو للحالات الحساسة.',
                  supervisionNote:
                      'نبرة داعمة وغير ضاغطة، بدون إلحاح أو urgency language أو guilt-based nudging.',
                  statusLabel: 'مثال رسالة معتمد',
                  enableCopyMessage: true,
                ),
              ],
            ),
            ),
            const SizedBox(height: AppSpacing.md),
            KeyedSubtree(
              key: _rulesKey,
              child: GatewaySectionCard(
              title: 'قواعد الإرسال',
              description:
                  'الإرسال يجب أن يبقى محدودًا وآمنًا ومنضبطًا بسياقات واضحة.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'frequency limits',
                  summary:
                      'يجب أن تكون هناك حدود واضحة لتكرار الرسائل حتى لا تتحول المتابعة إلى burden.',
                  boundaryNote:
                      'الاستمرارية الهادئة أهم من الكثافة أو الإغراق.',
                  supervisionNote:
                      'هذه الصفحة توثق limits فقط، ولا تنفذها آليًا.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'منع الإزعاج',
                  summary:
                      'يجب أن تُصاغ الرسائل وتوقيتها بما يمنع الإزعاج أو التطفل أو الإرهاق.',
                  boundaryNote:
                      'الدعم يفقد شرعيته إذا أصبح مزعجًا.',
                  supervisionNote:
                      'هذه قاعدة إشرافية ثابتة.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'شروط الإرسال',
                  summary:
                      'الإرسال يجب أن يكون مشروطًا بسياقات مستقرة وآمنة ومناسبة لطبيعة الرسالة.',
                  boundaryNote:
                      'يمنع الإرسال العشوائي أو غير المنضبط.',
                  supervisionNote:
                      'الشروط هنا توصيف حوكمي فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'حالات الإيقاف',
                  summary:
                      'يجب تحديد الحالات التي تتوقف فيها الرسائل بالكامل أو مؤقتًا.',
                  boundaryNote:
                      'الإيقاف قد يكون ضروريًا لحماية راحة المستخدم أو سلامته أو احترام سياق الدعم.',
                  supervisionNote:
                      'هذه الصفحة لا تنفذ الإيقاف آليًا، بل توثقه فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'لا إرسال أثناء crisis',
                  summary:
                      'أي سياق crisis أو هشاشة عالية يجب أن يبقى خاليًا من الرسائل الداعمة الخفيفة.',
                  boundaryNote:
                      'السلامة تتقدم على أي رسالة أو استمرار.',
                  supervisionNote:
                      'هذا حد أخلاقي ثابت.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'لا إرسال أثناء جلسات نشطة',
                  summary:
                      'يجب ألا تتقاطع الرسائل الداعمة مع الجلسات النشطة أو المسارات العلاجية المنظمة.',
                  boundaryNote:
                      'الفصل هنا يحمي تركيز المستخدم ويحافظ على وضوح الأدوار.',
                  supervisionNote:
                  'الرسائل ليست امتدادًا للجلسات.',
                ),
              ],
            ),
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ربط الرسائل بالمحتوى',
              description:
                  'الرسائل يمكن أن تدعم المستخدم عبر الإشارة إلى محتوى مناسب من المكتبة دون أن تتحول إلى intervention flow.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'الإشارة إلى محتوى مناسب من المكتبة',
                  summary:
                      'يمكن أن تحتوي الرسائل على إحالات أو تذكير بمحتوى مناسب من المكتبة بحسب الفئة أو السياق العام.',
                  boundaryNote:
                      'الربط هنا توعوي وداعم فقط، وليس علاجًا أو مسارًا ضاغطًا.',
                  supervisionNote:
                      'المكتبة هنا تُستخدم كامتداد للتوعية لا كضغط سلوكي.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'لا تتحول إلى تدخل علاجي أو pressure flow',
                  summary:
                      'الرسالة يجب أن تبقى خفيفة، ولا تتحول إلى محاولة توجيه علاجي أو إلحاح متكرر.',
                  boundaryNote:
                      'هذا يحفظ الفرق بين الدعم اللطيف وبين التدخل غير المناسب.',
                  supervisionNote:
                      'الرسائل هنا support-first وليست treatment-first.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            KeyedSubtree(
              key: _boundariesKey,
              child: GatewaySectionCard(
              title: 'الحدود الأخلاقية',
              description:
                  'هذه الحدود تحكم tone الرسائل ووظيفتها بحيث تبقى آمنة ومناسبة للمنصة.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'لا تشخيص',
                  summary:
                      'الرسائل لا تشخص، ولا تفسر الحالة نفسيًا أو طبيًا، ولا توحي بأنها تقييم مهني.',
                  boundaryNote:
                      'يحافظ ذلك على التموضع غير الطبي وغير التشخيصي.',
                  supervisionNote:
                      'هذا حد أخلاقي ومعماري ثابت.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'لا تدخل علاجي',
                  summary:
                      'الرسائل لا تقوم مقام العلاج ولا تحاول أداء وظيفة علاجية أو سريرية.',
                  boundaryNote:
                      'الدعم هنا خفيف واستمراري فقط.',
                  supervisionNote:
                      'أي انحراف عن ذلك يخرج الطبقة عن معناها الصحيح.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'لا تضارب مع المختصين',
                  summary:
                      'يجب ألا تتداخل الرسائل مع دور المختصين أو تقدم نفسها كبديل عنهم.',
                  boundaryNote:
                      'تحافظ هذه القاعدة على احترام الرعاية المتخصصة عند الحاجة.',
                  supervisionNote:
                      'الطبقة مملوكة للإدارة فقط، وليست أداة مهنية للمختصين.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'support-first',
                  summary:
                      'الرسائل يجب أن تبقى ضمن منطق دعم خفيف، وليس منطق توجيه ضاغط أو استغلالي.',
                  boundaryNote:
                      'الدعم أولًا، لا التأثير القسري أو الإلحاح.',
                  supervisionNote:
                      'هذا هو المنطق الحاكم لصياغة الرسائل.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'family-safe',
                  summary:
                      'الرسائل يجب أن تبقى آمنة، مناسبة، وغير حادة أو صادمة أو غير لائقة.',
                  boundaryNote:
                      'تحافظ هذه القاعدة على اتساق tone المنصة وثقة المستخدم.',
                  supervisionNote:
                      'السلامة الأسلوبية جزء من الحوكمة.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'no manipulative tone',
                  summary:
                      'يُمنع استخدام نبرة ضغط أو ذنب أو إلحاح أو تعلق عاطفي غير صحي.',
                  boundaryNote:
                      'النبرة يجب أن تبقى محترمة، هادئة، وغير استغلالية.',
                  supervisionNote:
                  'هذا حد أخلاقي مباشر في الرسائل الداعمة.',
                ),
              ],
            ),
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ملاحظات إشرافية',
              description:
                  'تلخص هذه الملاحظات وظيفة الرسائل الداعمة داخل التطبيق وحدودها.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'الرسائل للدعم والاستمرارية فقط',
                  summary:
                      'هذه الرسائل وظيفتها الدعم الخفيف، والاهتمام، والاستمرارية، وربط المستخدم بمحتوى آمن.',
                  boundaryNote:
                      'لا يجب أن تُفهم كمسار علاجي أو كبديل عن الرعاية المهنية.',
                  supervisionNote:
                      'هذا هو التعريف الصحيح للطبقة الحالية.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'لا تحل محل الرعاية المهنية',
                  summary:
                      'أي حاجة إلى رعاية مهنية أو تدخل متخصص يجب أن تبقى خارج هذه الطبقة.',
                  boundaryNote:
                      'الرسائل لا تلغي الحاجة إلى المختص عند اللزوم.',
                  supervisionNote:
                      'هذه قاعدة أساسية في التموضع غير الطبي.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'لا تعمل كمسار علاجي',
                  summary:
                      'الرسائل ليست علاجًا، ولا session، ولا protocol متابعة علاجية.',
                  boundaryNote:
                      'هي طبقة استمرارية وتوعية فقط.',
                  supervisionNote:
                      'هذه الصفحة إشرافية بحتة ولا تضيف أي workflow علاجي.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
