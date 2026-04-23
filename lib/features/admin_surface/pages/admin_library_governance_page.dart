import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminLibraryGovernancePage extends StatefulWidget {
  const AdminLibraryGovernancePage({super.key});

  @override
  State<AdminLibraryGovernancePage> createState() =>
      _AdminLibraryGovernancePageState();
}

class _AdminLibraryGovernancePageState extends State<AdminLibraryGovernancePage> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الانتقال السريع داخل الصفحة',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
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
    String statusLabel = 'حوكمة المكتبة',
    bool enableCopyMessage = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppSectionPanel(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              statusLabel,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF2E5AAC),
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.obsidian.withValues(alpha: 0.84),
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
                    color: AppColors.obsidian.withValues(alpha: 0.70),
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
      backgroundColor: AppColors.warmIvory,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Library Governance',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'Library Governance',
              summary:
                  'صفحة إشرافية مرجعية لحوكمة المكتبة والمحتوى التوعوي داخل النظام، مع توضيح من يملك النشر، وكيف يتم الاقتراح، وما الشروط اللازمة قبل أي اعتماد.',
              boundaryNote:
                  'هذه الصفحة تنظيمية فقط، وتوضح حدود الحوكمة الخاصة بالمكتبة دون أي backend أو منطق تشغيلي أو نشر فعلي.',
              emphasis:
                  'المكتبة هنا مصدر دعم ومحتوى آمن، وليست نقطة رفع مفتوحة. الإدارة فقط تملك قرار النشر النهائي.',
            ),
            const SizedBox(height: AppSpacing.md),
            _buildAnchorBar(context),
            const SizedBox(height: AppSpacing.md),
            const GatewaySectionCard(
              title: 'Library Subsystem Definition',
              description:
                  'This compact section defines the library as an isolated governed subsystem with clear scope and limits.',
              children: [
                GatewaySupervisionNote(
                  text:
                      'Does: admin-only publishing governance, intake and review guidance, approval and rejection boundaries, and manual decision support.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Does not do: open publishing, user-generated live publishing, auto-approval, or any content automation engine.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Boundaries: admin-owned only, policy-aligned, review-first, quality/rights/safety constrained, and no publishing promise before checks.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Supervision note: safety-first, quality-aware, rights-aware, non-medical, and non-diagnostic.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'نموذج النشر',
              description:
                  'هذا القسم يوضح من يملك صلاحية النشر الفعلي داخل المكتبة.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'Admin-only publishing',
                  summary:
                      'النشر داخل المكتبة مملوك للإدارة فقط، ولا يوجد رفع مباشر من الأخصائيين أو المراكز أو المستخدمين.',
                  boundaryNote:
                      'الإدارة وحدها تتحمل مسؤولية قرار النشر النهائي، بما يشمل الجودة والحقوق والملاءمة.',
                  supervisionNote:
                      'هذا حد حوكمي ثابت في الصفحة الحالية، وليس منطق صلاحيات backend.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'مسار اقتراح المحتوى',
              description:
                  'هذا القسم يوضح كيف يمكن للأطراف الأخرى اقتراح المحتوى دون امتلاك صلاحية النشر.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'الاقتراح عبر الشات الداخلي فقط',
                  summary:
                      'أي اقتراح لمحتوى جديد يجب أن يتم عبر الشات الداخلي فقط، وليس عبر رفع مباشر إلى المكتبة.',
                  boundaryNote:
                      'الفصل بين الاقتراح والنشر يمنع تحويل المكتبة إلى نقطة إدخال مفتوحة أو غير مضبوطة.',
                  supervisionNote:
                      'هذه الصفحة توثق المسار الإشرافي فقط دون تنفيذ workflow فعلي.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'معلومات الاقتراح المطلوبة',
                  summary:
                      'يمكن أن يتضمن الاقتراح: اسم المحتوى، المصدر، الرابط إن وجد، الفئة المستهدفة، وسبب الاقتراح.',
                  boundaryNote:
                      'وجود هذه البيانات يساعد الإدارة على المراجعة المنضبطة قبل أي قرار نشر.',
                  supervisionNote:
                      'هذه قائمة توجيهية داخلية، لا form backend ولا نظام إدخال فعلي.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            KeyedSubtree(
              key: _examplesKey,
              child: GatewaySectionCard(
              title: 'أمثلة قرارات intake معتمدة',
              description:
                  'هذه أمثلة ثابتة ومرجعية فقط لقرارات المراجعة اليدوية، ويمكن استخدامها إداريًا خارج النظام دون إنشاء workflow نشر فعلي.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'Accept for Review',
                  summary:
                      'شكرًا على الاقتراح. تم استلامه وسيدخل في مراجعة داخلية قبل أي قرار لاحق. لا يعني ذلك اعتماد النشر في هذه المرحلة.',
                  boundaryNote:
                      'قرار إداري هادئ ومحترم، بلا وعد بالنشر أو الموافقة قبل اكتمال الفحص والمراجعة.',
                  supervisionNote:
                      'قرار intake يدوي مملوك للإدارة فقط، غير طبي، وغير تشخيصي، وبدون أي publishing promise.',
                  statusLabel: 'مثال قرار معتمد',
                  enableCopyMessage: true,
                ),
                _buildGovernanceCard(
                  context,
                  title: 'Request Clarification',
                  summary:
                      'شكرًا على الاقتراح. نحتاج إلى توضيح إضافي بشأن المصدر أو الرابط أو الفئة المستهدفة قبل استكمال المراجعة الداخلية.',
                  boundaryNote:
                      'طلب توضيح محترم وهادئ، بلا لوم أو ضغط أو افتراض اعتماد مسبق للمحتوى.',
                  supervisionNote:
                      'هذا القرار يساعد الإدارة على استكمال التحقق دون أي وعود بالنشر أو القبول النهائي.',
                  statusLabel: 'مثال قرار معتمد',
                  enableCopyMessage: true,
                ),
                _buildGovernanceCard(
                  context,
                  title: 'Reject for Safety',
                  summary:
                      'شكرًا على الاقتراح. لن نتابع هذا المحتوى في الوقت الحالي لأنه لا ينسجم مع حدود السلامة أو الملاءمة المعتمدة داخل المنصة.',
                  boundaryNote:
                      'رفض محترم وواضح، بلا harsh tone أو claims قانونية أو طبية أو تصعيد غير لازم.',
                  supervisionNote:
                      'قرار إداري يدوي يقدّم السلامة على أي قيمة محتملة للمحتوى.',
                  statusLabel: 'مثال قرار معتمد',
                  enableCopyMessage: true,
                ),
                _buildGovernanceCard(
                  context,
                  title: 'Reject for Quality / Rights',
                  summary:
                      'شكرًا على الاقتراح. لن نتابع هذا المحتوى في الوقت الحالي لعدم كفاية الجودة أو لعدم وضوح الحقوق والاستخدام المسموح.',
                  boundaryNote:
                      'رفض هادئ ومحترم، دون blame أو legal overclaim، ودون أي وعد بإعادة النشر قبل مراجعة مكتملة.',
                  supervisionNote:
                      'هذا القرار يؤكد أن الجودة والحقوق شرط سابق لأي تفكير في الاعتماد أو النشر.',
                  statusLabel: 'مثال قرار معتمد',
                  enableCopyMessage: true,
                ),
              ],
            ),
            ),
            const SizedBox(height: AppSpacing.md),
            KeyedSubtree(
              key: _rulesKey,
              child: GatewaySectionCard(
              title: 'قائمة التحقق قبل النشر',
              description:
                  'هذه هي العناصر التي يجب مراجعتها قبل اعتماد أي محتوى داخل المكتبة.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'سلامة المحتوى',
                  summary:
                      'يجب التأكد من أن المحتوى آمن، غير ضار، وغير متعارض مع طبيعة المنصة الداعمة.',
                  boundaryNote:
                      'السلامة تسبق القيمة المعرفية أو الجاذبية الشكلية للمحتوى.',
                  supervisionNote:
                      'هذه الصفحة توثق checklists فقط، ولا تنفذها آليًا.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'الحقوق والملكية',
                  summary:
                      'يجب التحقق من أن الحقوق والملكية والاستخدام المسموح واضحة قبل أي نشر.',
                  boundaryNote:
                      'المكتبة لا يجب أن تتحمل محتوى بملكية غير مؤكدة أو استخدام غير مشروع.',
                  supervisionNote:
                      'المراجعة هنا إشرافية فقط وليست منظومة تحقق قانوني آلية.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'ملاءمة الفئة',
                  summary:
                      'يجب أن يكون المحتوى مناسبًا للفئة المستهدفة من حيث اللغة، والحساسية، وطبيعة الاستفادة.',
                  boundaryNote:
                      'المحتوى المناسب لفئة قد لا يكون مناسبًا لفئة أخرى.',
                  supervisionNote:
                      'هذا جزء من الحوكمة التحريرية داخل المكتبة.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'جودة المحتوى',
                  summary:
                      'يجب أن يكون المحتوى مفيدًا، واضحًا، ومتزنًا من حيث الصياغة والمعلومة.',
                  boundaryNote:
                      'ضعف الجودة يضر بثقة المستخدم حتى لو لم يكن المحتوى ضارًا.',
                  supervisionNote:
                      'هذا تقييم إشرافي نوعي فقط في المرحلة الحالية.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'التصنيف الصحيح',
                  summary:
                      'يجب وضع المحتوى تحت التصنيف الأنسب داخل المكتبة حتى يسهل الوصول إليه ويُفهم في سياقه الصحيح.',
                  boundaryNote:
                      'التصنيف الخاطئ قد يخلق لبسًا أو يعرض محتوى غير مناسب لفئة غير مقصودة.',
                  supervisionNote:
                      'هذا شرط تنظيمي قبل النشر وليس نظام تصنيف ذكي بعد.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'التوافق مع سياسة المنصة',
                  summary:
                      'يجب التأكد من أن المحتوى منسجم مع سياسة المنصة وتموضعها الداعم وغير الطبي وغير التشخيصي.',
                  boundaryNote:
                      'المحتوى الذي يصطدم مع سياسة المنصة يجب ألا يصل إلى النشر.',
                  supervisionNote:
                  'هذه قاعدة حوكمة مرجعية للموافقة.',
                ),
              ],
            ),
            ),
            const SizedBox(height: AppSpacing.md),
            KeyedSubtree(
              key: _boundariesKey,
              child: GatewaySectionCard(
              title: 'شروط المنع المباشر',
              description:
                  'هذه الحالات تمنع النشر مباشرة حتى قبل أي تفكير في الاعتماد.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'مصدر غير واضح',
                  summary:
                      'أي محتوى بلا مصدر واضح أو موثوق يجب أن يُمنع مباشرة من النشر.',
                  boundaryNote:
                      'غياب المصدر يعني غياب القدرة على التحقق أو المساءلة.',
                  supervisionNote:
                      'هذا منع إشرافي مباشر داخل الحوكمة الحالية.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'حقوق غير مؤكدة',
                  summary:
                      'أي محتوى لا يمكن تأكيد ملكيته أو حق استخدامه يجب أن يُحجب فورًا.',
                  boundaryNote:
                      'حماية الحقوق جزء أساسي من سلامة المكتبة.',
                  supervisionNote:
                      'لا نشر قبل وضوح الحقوق.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'محتوى غير مناسب',
                  summary:
                      'أي محتوى غير مناسب للفئة أو لطبيعة المنصة أو لسياق المكتبة يجب أن يُمنع.',
                  boundaryNote:
                      'الملاءمة شرط أساسي، وليست عنصرًا تجميليًا.',
                  supervisionNote:
                      'هذا منع تحريري/إشرافي داخل الصفحة.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'محتوى جنسي / مسيء / ضار',
                  summary:
                      'أي محتوى يحمل طبيعة جنسية أو مسيئة أو ضارة أو مقلقة يجب أن يُحجب مباشرة.',
                  boundaryNote:
                      'المكتبة يجب أن تبقى مصدرًا آمنًا للمحتوى الداعم.',
                  supervisionNote:
                      'هذا حد سلامة ثابت.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'claims علاجية أو طبية غير مناسبة',
                  summary:
                      'أي محتوى يتضمن ادعاءات علاجية أو طبية غير منضبطة أو توحي بالتشخيص يجب منعه.',
                  boundaryNote:
                      'يحافظ ذلك على التموضع غير الطبي وغير التشخيصي للمنصة.',
                  supervisionNote:
                      'هذا حد حوكمي أساسي داخل المكتبة.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'تعارض مع سياسات المنصة',
                  summary:
                      'أي تعارض واضح مع سياسات المنصة أو قواعد السلامة أو الامتثال يمنع النشر مباشرة.',
                  boundaryNote:
                      'سياسات المنصة تسبق جاذبية المحتوى أو فائدته الجزئية.',
                  supervisionNote:
                  'لا نشر خارج السياسة المعتمدة.',
                ),
              ],
            ),
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'حالات النشر',
              description:
                  'هذه الحالات تصف الدورة الإشرافية المقترحة للمحتوى داخل المكتبة.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'draft',
                  summary:
                      'المحتوى ما يزال في حالة أولية وغير جاهز للنشر أو العرض.',
                  boundaryNote:
                      'هذه الحالة مناسبة للمحتوى الذي لم يكتمل تدقيقه أو تصنيفه.',
                  supervisionNote:
                      'حالة وصفية فقط داخل الحوكمة الحالية.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'under review',
                  summary:
                      'المحتوى دخل مرحلة المراجعة الإشرافية قبل اتخاذ قرار نهائي.',
                  boundaryNote:
                      'هذه المرحلة هي قلب الحوكمة قبل النشر.',
                  supervisionNote:
                      'لا يوجد workflow backend مفعّل، فقط توصيف حوكمي.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'approved',
                  summary:
                      'تمت الموافقة على المحتوى بعد استيفاء الشروط المطلوبة.',
                  boundaryNote:
                      'الموافقة لا تعني النشر التلقائي في هذه المرحلة، بل الجاهزية من ناحية الحوكمة.',
                  supervisionNote:
                      'حالة مرجعية داخل الصفحة فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'hidden',
                  summary:
                      'المحتوى موجود لكن غير ظاهر للمستخدمين في الوقت الحالي.',
                  boundaryNote:
                      'قد تُستخدم هذه الحالة عند الحاجة لحجب مؤقت أو مراجعة إضافية.',
                  supervisionNote:
                      'وصف إشرافي فقط، وليس تنفيذًا فعليًا.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'archived',
                  summary:
                      'المحتوى محفوظ ضمن أرشيف الحوكمة أو المحتوى ولا يُستخدم كنقطة عرض فعالة.',
                  boundaryNote:
                      'الأرشفة تحفظ التاريخ دون إبقاء المحتوى ضمن السطح الحي.',
                  supervisionNote:
                      'حالة مرجعية فقط في هذه الصفحة.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'blocked',
                  summary:
                      'المحتوى محجوب بشكل صريح بسبب مخالفة واضحة أو خطورة أو غياب شروط النشر.',
                  boundaryNote:
                      'الحجب الصريح يقطع أي مسار نحو النشر حتى يتم حل السبب.',
                  supervisionNote:
                      'هذه الحالة تمثل المنع المباشر في نموذج الحوكمة.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ملاحظات إشرافية',
              description:
                  'تلخص هذه الملاحظات دور المكتبة والحوكمة المحيطة بها.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'المكتبة مصدر دعم ومحتوى آمن',
                  summary:
                      'المكتبة يجب أن تبقى مصدرًا للمحتوى الآمن والداعم والتوعوي داخل المنصة.',
                  boundaryNote:
                      'قيمة المكتبة تأتي من الثقة والملاءمة والاستفادة، لا من كثافة النشر فقط.',
                  supervisionNote:
                      'هذا هو التوجيه الأعلى لحوكمة المكتبة.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'لا تُستخدم كنقطة رفع مفتوحة',
                  summary:
                      'المكتبة ليست واجهة رفع مفتوح من أي طرف داخل أو خارج النظام.',
                  boundaryNote:
                      'منع الرفع المباشر يحمي الجودة والحقوق والملاءمة.',
                  supervisionNote:
                      'الاقتراح فقط ممكن، أما النشر فإداري فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'الإدارة مسؤولة عن الجودة والحقوق والملاءمة',
                  summary:
                      'الإدارة تظل هي الجهة المسؤولة عن تدقيق الجودة والحقوق والتصنيف والملاءمة قبل أي نشر.',
                  boundaryNote:
                      'هذا يثبت أن النشر قرار حوكمي مسؤول وليس مجرد إدخال محتوى.',
                  supervisionNote:
                      'المسؤولية النهائية هنا إدارية وإشرافية بالكامل.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
