import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminActivationReadinessPage extends StatelessWidget {
  const AdminActivationReadinessPage({super.key});

  Widget _buildReadinessCard(
    BuildContext context, {
    required String title,
    required String readinessLabel,
    required String summary,
    required String currentState,
    required String availableNow,
    required String supervisionNote,
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
              readinessLabel,
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
            const SizedBox(height: AppSpacing.sm),
            Text(
              'الحالة الحالية: $currentState',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.obsidian.withValues(alpha: 0.72),
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'المتاح الآن: $availableNow',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.obsidian.withValues(alpha: 0.72),
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

  Widget _buildCheckpointLine(
    BuildContext context, {
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        '- $text',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.obsidian.withValues(alpha: 0.82),
              height: 1.4,
            ),
      ),
    );
  }

  Widget _buildPreconditionBlock(
    BuildContext context, {
    required String title,
    required List<String> items,
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
            const SizedBox(height: AppSpacing.sm),
            ...items.map((item) => _buildCheckpointLine(context, text: item)),
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
        title: 'مصفوفة جاهزية التفعيل',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'مصفوفة جاهزية التفعيل',
              summary:
                  'هذه الصفحة ليست لتفعيل الخصائص مباشرة، بل لتحديد مستوى الجاهزية قبل أي تفعيل مستقبلي على مستوى الإدارة أو البوابات أو النمو أو التعرض.',
              boundaryNote:
                  'السلامة والامتثال والوضوح المعماري تسبق دائمًا أي activation، سواء كان تقنيًا أو تشغيليًا أو مرتبطًا بالانتشار.',
              emphasis:
                  'اعتبر هذه الصفحة لوحة قرار: ما الذي يمكن الإبقاء عليه تحت الإشراف، وما الذي يمكن تفعيله يدويًا بشكل محدود، وما الذي يجب أن يبقى محجوبًا حتى تتحقق الشروط.',
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'عناصر جاهزة للتفعيل الإداري',
              description:
                  'هذه العناصر مبنية بالفعل ويمكن تشغيلها أو استخدامها إداريًا ضمن الإطار الإشرافي الحالي.',
              children: [
                _buildReadinessCard(
                  context,
                  title: 'الصفحة الرئيسية للإدارة',
                  readinessLabel: 'جاهز إداريًا',
                  summary:
                      'تم تثبيت الصفحة الرئيسية كمنصة إطلاق واضحة بدل كونها مساحة عمل مزدحمة.',
                  currentState: 'Built',
                  availableNow:
                      'واجهة مستقرة، launchpad واضحة، counters مستقرة، وControl Room منفصلة.',
                  supervisionNote:
                      'جاهزة إداريًا ضمن الهيكل الحالي دون الحاجة لأي تفعيل backend إضافي.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'غرفة التحكم',
                  readinessLabel: 'جاهز إداريًا',
                  summary:
                      'غرفة التحكم تعمل كمساحة وعي ومراقبة وليست مساحة تنفيذ مباشر.',
                  currentState: 'Built / Monitored',
                  availableNow:
                      'عرض صحة النظام، التنبيهات، وإشارات البوابات بشكل إشرافي.',
                  supervisionNote:
                      'جاهزة كطبقة awareness only ضمن الحدود الحالية.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'طبقة البوابات',
                  readinessLabel: 'جاهز إداريًا',
                  summary:
                      'طبقة البوابات موجودة كطبقة تقنية عليا للإشراف على القنوات، والأدوات، والأجهزة، والتخزين.',
                  currentState: 'Built / Monitored',
                  availableNow:
                      'صفحة هبوط واضحة، عائلات بوابات منفصلة، ومؤشرات إشرافية مستقرة.',
                  supervisionNote:
                      'جاهزة إداريًا، لكن ما تزال ضمن supervised shell وليست integrations فعلية.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'Communication Gateway v1',
                  readinessLabel: 'جاهز إداريًا',
                  summary:
                      'Communication Gateway مكتملة كحدود إشرافية للقنوات ونقاط الاستقبال.',
                  currentState: 'Built / Monitored',
                  availableNow:
                      'بطاقات قنوات، حوارات boundary، وبريد دعم يدوي آمن عبر mailto.',
                  supervisionNote:
                      'جاهزة للاستخدام الإداري كحدود supervised فقط، لا كمنظومة اتصالات حقيقية.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'Engineering Gateway v1',
                  readinessLabel: 'جاهز إداريًا',
                  summary:
                      'صفحة الإشراف الهندسي واضحة وتغطي الأدوات التقنية وحدودها.',
                  currentState: 'Built / Monitored',
                  availableNow:
                      'حدود AI/workspace وbackend/source control وdiagnostics بشكل إشرافي.',
                  supervisionNote: 'جاهزة إداريًا كلوحة إشراف تقني فقط.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'Device / Storage Gateway v1',
                  readinessLabel: 'جاهز إداريًا',
                  summary:
                      'صفحة الأجهزة والتخزين واضحة وتعرض حدود البنية المادية والمزامنة.',
                  currentState: 'Built / Monitored',
                  availableNow:
                      'تقسيم Primary Devices وStorage Units وSync Boundaries بشكل إشرافي.',
                  supervisionNote:
                      'جاهزة إداريًا كطبقة وصف ومراقبة، لا كطبقة تحكم فعلي.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'طبقة النمو والانتشار',
                  readinessLabel: 'جاهز إداريًا',
                  summary:
                      'طبقة مفاهيمية واضحة لتخطيط النمو والانتشار والاستفادة المحتملة تحت إشراف مضبوط.',
                  currentState: 'Built / Conceptual',
                  availableNow:
                      'مخططات Sections واضحة وحدود أخلاقية وتشغيلية موثقة.',
                  supervisionNote:
                      'جاهزة كمساحة قرار وإشراف، لا كتفعيل تسويقي أو ربحي.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'قواعد الظهور والتعرض',
                  readinessLabel: 'جاهز إداريًا',
                  summary:
                      'تم تعريف القواعد التي تحدد متى يُسمح بالظهور ومتى يجب حجبه.',
                  currentState: 'Built / Conceptual',
                  availableNow:
                      'قيود واضحة للحالات المحجوبة، والأسطح المسموح بها، والأولوية الأخلاقية.',
                  supervisionNote: 'جاهزة كمرجع سياساتي قبل أي تفعيل مستقبلي.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'نقاط الامتثال المرتبطة بالكود',
                  readinessLabel: 'جاهز إداريًا',
                  summary:
                      'يوجد الآن ربط واضح بين المعمارية، والسلامة، والبوابات، والنمو، والتموضع غير الطبي.',
                  currentState: 'Built / Conceptual',
                  availableNow:
                      'صفحة checkpoint واضحة تربط التنفيذ المستقبلي بالحدود المعتمدة.',
                  supervisionNote: 'جاهزة كمصفوفة مراجعة قبل أي توسع جديد.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'ملف تسليم المخطط العام',
                  readinessLabel: 'جاهز إداريًا',
                  summary:
                      'يوجد الآن مرجع handoff واضح يصف ما بُني، وما هو مراقب، وما هو مجمّد، وما هو مخطط فقط.',
                  currentState: 'Built / Documentation',
                  availableNow:
                      'صفحة handoff معمارية واضحة تدعم الانتقال المنظم بين مراحل المشروع.',
                  supervisionNote: 'جاهزة كمرجع تنفيذي/معماري للحالة الحالية.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'عناصر مفعلة بشكل محدود وآمن',
              description:
                  'هذه العناصر مفعلة فعليًا، لكن كتفعيل يدوي محدود وآمن ضمن حدود واضحة، وليست تكاملات حقيقية.',
              children: [
                _buildReadinessCard(
                  context,
                  title: 'Support Email boundary',
                  readinessLabel: 'مفعّل يدويًا بشكل آمن',
                  summary: 'بريد الدعم يعمل كإجراء يدوي آمن عبر mailto فقط.',
                  currentState: 'Activated in safe manual form',
                  availableNow:
                      'فتح عميل البريد الافتراضي مع subject/body مجهزين مسبقًا.',
                  supervisionNote:
                      'مفعّل كحد boundary فقط، بلا sync أو backend أو automation.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'Support Email intent presets',
                  readinessLabel: 'مفعّل يدويًا بشكل آمن',
                  summary: 'توجد presets لتحديد نية الرسالة قبل فتح البريد.',
                  currentState: 'Activated in safe manual form',
                  availableNow:
                      'General Support / Technical Issue / Account Help كقوالب فقط.',
                  supervisionNote:
                      'تفعيل محدود داخل الواجهة فقط، بلا منطق تشغيلي خارجي.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'حوارات حدود القنوات',
                  readinessLabel: 'مفعّل يدويًا بشكل آمن',
                  summary:
                      'توجد حوارات boundary لـ Website Chat وExternal Follow-up وTelegram وFacebook/Messenger وZoom/Meet.',
                  currentState: 'Activated in safe manual form',
                  availableNow:
                      'توضيح status والحدود والفصل عن Communications وsupport handling.',
                  supervisionNote:
                      'هذه الحوارات مفعّلة كشرح حدود فقط، وليست integrations حقيقية.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'عناصر تحت المراقبة فقط',
              description:
                  'هذه العناصر مفيدة إشرافيًا الآن، لكنها ليست أنظمة تشغيلية live بعد.',
              children: [
                _buildReadinessCard(
                  context,
                  title: 'أسطح النمو والانتشار',
                  readinessLabel: 'مراقبة فقط',
                  summary:
                      'طبقة النمو والانتشار تقدم رؤية تخطيطية مفيدة، لكنها لا تدير حملات أو ظهورًا فعليًا.',
                  currentState: 'Monitored / Conceptual',
                  availableNow:
                      'طبقة قرار وحدود واضحة للنمو والتعرض والضوابط الأخلاقية.',
                  supervisionNote:
                      'مفيدة إشرافيًا فقط، وليست نظامًا تشغيليًا مباشرًا.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'أدوات الإشراف الهندسي',
                  readinessLabel: 'مراقبة فقط',
                  summary:
                      'حدود الأدوات الهندسية واضحة، لكن الصفحات لا تقوم بتنفيذ أو probing فعلي.',
                  currentState: 'Monitored / Shell',
                  availableNow: 'رؤية واضحة للأدوات التقنية وحدودها ومجالاتها.',
                  supervisionNote:
                      'مفيدة كإشراف تقني فقط وليست console تشغيلية.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'إشراف الأجهزة والتخزين',
                  readinessLabel: 'مراقبة فقط',
                  summary:
                      'توجد رؤية منظمة لحدود الأجهزة والتخزين والمزامنة دون تكاملات أو فحص فعلي.',
                  currentState: 'Monitored / Shell',
                  availableNow:
                      'تعريف compartments واضح حول laptop/tablet/drives/backup/sync.',
                  supervisionNote:
                      'مفيد إشرافيًا فقط، وليس live device system.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'Gateway Signals',
                  readinessLabel: 'مراقبة فقط',
                  summary:
                      'توجد إشارات gateway داخل الإدارة، لكنها لا تمثل telemetry عميقة بعد.',
                  currentState: 'Monitored / Placeholder-aware',
                  availableNow:
                      'ملخصات health واتجاهات إشرافية على مستوى الأسرة الواحدة.',
                  supervisionNote:
                      'مفيدة للمتابعة، لكنها لا تعني وجود مراقبة تشغيلية متقدمة بعد.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'عناصر مفاهيمية / مخطط لها فقط',
              description:
                  'هذه العناصر ما تزال ضمن التخطيط فقط، وغير جاهزة للتشغيل الفعلي الآن.',
              children: [
                _buildReadinessCard(
                  context,
                  title: 'real external follow-up integration',
                  readinessLabel: 'مفاهيمي / مخطط فقط',
                  summary: 'لا يوجد تكامل واتساب حقيقي حتى الآن.',
                  currentState: 'Conceptual',
                  availableNow:
                      'فقط boundary dialog داخل Communication Gateway.',
                  supervisionNote: 'غير جاهز للتشغيل الآن.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'Telegram integration',
                  readinessLabel: 'مفاهيمي / مخطط فقط',
                  summary: 'لا يوجد تكامل Telegram حقيقي حتى الآن.',
                  currentState: 'Conceptual',
                  availableNow: 'فقط boundary dialog إشرافية.',
                  supervisionNote: 'غير جاهز للتشغيل الآن.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'Facebook / Messenger integration',
                  readinessLabel: 'مفاهيمي / مخطط فقط',
                  summary: 'لا يوجد تكامل Facebook / Messenger حقيقي حتى الآن.',
                  currentState: 'Conceptual',
                  availableNow: 'فقط boundary dialog إشرافية.',
                  supervisionNote: 'غير جاهز للتشغيل الآن.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'Website live intake sync',
                  readinessLabel: 'مفاهيمي / مخطط فقط',
                  summary: 'لا توجد مزامنة حية فعلية لاستقبال Website Chat.',
                  currentState: 'Conceptual',
                  availableNow: 'فقط شرح boundary والحالة الحالية.',
                  supervisionNote: 'غير جاهز للتشغيل الآن.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'Campaign automation',
                  readinessLabel: 'مفاهيمي / مخطط فقط',
                  summary: 'لا توجد أي أتمتة للحملات أو التوزيع أو الظهور.',
                  currentState: 'Conceptual',
                  availableNow: 'فقط تخطيط مفاهيمي داخل Growth & Awareness.',
                  supervisionNote: 'غير جاهز للتشغيل الآن.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'Monetized placements',
                  readinessLabel: 'مفاهيمي / مخطط فقط',
                  summary: 'لا توجد أماكن ربحية مفعلة فعليًا داخل المنتج.',
                  currentState: 'Conceptual / Blocked from activation',
                  availableNow:
                      'فقط تعريف أسطح محتملة ضمن قيود Exposure Rules.',
                  supervisionNote: 'غير جاهز للتشغيل الآن.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'Advanced telemetry',
                  readinessLabel: 'مفاهيمي / مخطط فقط',
                  summary:
                      'لا توجد telemetry متقدمة للأجهزة أو القنوات أو الأدوات أو الظهور.',
                  currentState: 'Conceptual',
                  availableNow: 'فقط health summaries إشرافية مبسطة.',
                  supervisionNote: 'غير جاهز للتشغيل الآن.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'Channel orchestration',
                  readinessLabel: 'مفاهيمي / مخطط فقط',
                  summary:
                      'لا توجد orchestration حقيقية بين القنوات المختلفة حتى الآن.',
                  currentState: 'Conceptual',
                  availableNow:
                      'فقط حدود channel boundaries وتعريفات supervision.',
                  supervisionNote: 'غير جاهز للتشغيل الآن.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'عناصر محجوبة / غير مسموح تفعيلها الآن',
              description:
                  'هذه العناصر إما محجوبة مؤقتًا حتى تتحقق الشروط، أو محجوبة بقواعد ثابتة تتعلق بالسلامة والامتثال.',
              children: [
                _buildReadinessCard(
                  context,
                  title: 'الإعلانات داخل سياقات الأزمة أو الدعم الحساس',
                  readinessLabel: 'محجوب',
                  summary:
                      'أي ظهور إعلاني أو توعوي داخل سياقات الأزمة أو الحساسية العالية غير مسموح به.',
                  currentState: 'Blocked by fixed safety rule',
                  availableNow: 'غير مسموح بالتفعيل إطلاقًا ضمن هذه السياقات.',
                  supervisionNote:
                      'المنع مرتبط بضوابط سلامة ثابتة، وليس مجرد تأجيل مؤقت.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'الاستهداف بناءً على الهشاشة أو الضعف',
                  readinessLabel: 'محجوب',
                  summary:
                      'أي targeting يعتمد على الهشاشة أو القابلية النفسية أو الاعتمادية غير مسموح به.',
                  currentState: 'Blocked by fixed ethical rule',
                  availableNow: 'غير مسموح بالتفعيل إطلاقًا.',
                  supervisionNote:
                      'المنع هنا ثابت وأخلاقي، وليس مجرد تجميد مرحلي.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'الاستفادة المالية المزعجة أو المتطفلة',
                  readinessLabel: 'محجوب',
                  summary:
                      'أي monetization intrusive أو تقاطع الدعم أو السلامة محجوب حاليًا.',
                  currentState: 'Blocked pending safeguards',
                  availableNow:
                      'غير مسموح بالتفعيل قبل وجود قواعد ومراجعات صريحة.',
                  supervisionNote:
                      'المنع حاليًا لأسباب سلامة وتجربة مستخدم وقد يبقى دائمًا في بعض الأسطح.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'الأتمتة غير الآمنة',
                  readinessLabel: 'محجوب',
                  summary:
                      'أي أتمتة لا تمتلك logs وrollback وmanual override وhuman supervision تبقى محجوبة.',
                  currentState: 'Blocked pending safeguards',
                  availableNow: 'غير مسموح بالتفعيل الآن.',
                  supervisionNote:
                      'المنع مؤقت حتى تكتمل متطلبات الجاهزية الحقيقية.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'clinician-request frozen flow',
                  readinessLabel: 'مجمّد / محجوب',
                  summary:
                      'هذا المسار مجمّد ومحمي ولا يُسمح بتفعيله أو إعادة هيكلته عبر خطوات جانبية.',
                  currentState: 'Blocked / Frozen',
                  availableNow: 'يُترك كما هو حتى يبدأ له مسار rebuild مستقل.',
                  supervisionNote: 'المنع هنا تجميد معماري مقصود.',
                ),
                _buildReadinessCard(
                  context,
                  title: 'أي direct unsafe integration',
                  readinessLabel: 'محجوب',
                  summary:
                      'أي integration مباشرة غير آمنة أو بلا ownership أو safeguards تبقى غير مسموح بها.',
                  currentState: 'Blocked pending readiness',
                  availableNow: 'غير مسموح بالتفعيل الآن.',
                  supervisionNote: 'المنع مؤقت ومشروط بتحقق readiness حقيقية.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'شروط التفعيل قبل المرحلة التالية',
              description:
                  'هذه الشروط تمثل الحد الأدنى المطلوب قبل الانتقال من الإشراف إلى التفعيل الحقيقي.',
              children: [
                _buildPreconditionBlock(
                  context,
                  title: 'أ) قبل تفعيل Channel Integrations',
                  items: const [
                    'policy واضحة ومعتمدة',
                    'owner واضح ومسؤول',
                    'escalation path واضح',
                    'manual fallback متاح',
                    'compliance review معتمدة',
                  ],
                ),
                _buildPreconditionBlock(
                  context,
                  title: 'ب) قبل تفعيل Monetization',
                  items: const [
                    'Exposure Rules معتمدة',
                    'Blocked states enforced بوضوح',
                    'منع الاستهداف عبر الهشاشة',
                    'family-safe review معتمدة',
                    'آلية placement review واضحة',
                  ],
                ),
                _buildPreconditionBlock(
                  context,
                  title: 'ج) قبل تفعيل Automation',
                  items: const [
                    'logs واضحة',
                    'rollback path جاهز',
                    'manual override متاح',
                    'alerting واضح',
                    'human supervision موجودة',
                  ],
                ),
                _buildPreconditionBlock(
                  context,
                  title: 'د) قبل تفعيل AI behaviors أوسع',
                  items: const [
                    'scope واضح ومحدود',
                    'non-medical positioning محفوظة',
                    'non-diagnostic behavior واضح',
                    'escalation rules معروفة',
                    'admin visibility كاملة',
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'المرحلة الحالية للنظام',
              description:
                  'هذا القسم يحدد المرحلة الحالية للنظام وكيف يجب فهم مستوى التفعيل الحالي.',
              children: [
                _buildReadinessCard(
                  context,
                  title: 'Supervised Activation Phase',
                  readinessLabel: 'المرحلة الحالية',
                  summary:
                      'النظام حاليًا في مرحلة Supervised Activation Phase: البناء موجود، والإشراف موجود، وبعض boundaries مفعلة، لكن التفعيل العميق ما زال محدودًا ومشروطًا.',
                  currentState:
                      'Built + Supervised + Partially activated at boundary level',
                  availableNow:
                      'يمكن استخدام الطبقات الإشرافية، والصفحات التوثيقية، وبعض الحدود اليدوية الآمنة مثل Support Email.',
                  supervisionNote:
                      'هذا هو المسار الصحيح حاليًا: بناء منظم، إشراف واضح، وتفعيل محدود فقط عندما يكون آمنًا ومفهومًا ومراجَعًا.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
