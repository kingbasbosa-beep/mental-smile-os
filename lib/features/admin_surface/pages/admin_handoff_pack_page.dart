import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminHandoffPackPage extends StatelessWidget {
  const AdminHandoffPackPage({super.key});

  Widget _buildHandoffCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String supervisionNote,
    String statusLabel = 'ملخص تنفيذي',
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
        title: 'Handoff Pack',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'Handoff Pack',
              summary:
                  'مرجع عربي مختصر وسريع يشرح الحالة الحالية للنظام وما تم بناؤه وما يجب تجنبه وما هي الخطوات التالية المقترحة.',
              boundaryNote:
                  'هذه الصفحة مخصصة للتسليم السريع بين الشاتات أو المراجعات أو جلسات Codex اللاحقة.',
              emphasis:
                  'اقرأ هذه الصفحة أولًا قبل لمس المعمارية أو التفكير في أي activation أعمق أو integration جديدة.',
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'الوضع الحالي للنظام',
              description:
                  'ملخص المرحلة الحالية التي وصل إليها النظام من حيث البناء والإشراف والتفعيل المحدود.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'المرحلة الحالية',
                  summary:
                      'النظام حاليًا في مرحلة Supervised Activation Phase: البناء موجود، والإشراف موجود، وبعض الحدود مفعلة بشكل محدود وآمن، بينما التفعيل العميق ما يزال مشروطًا.',
                  supervisionNote:
                      'الحالة الحالية مستقرة نسبيًا، وهذا هو المسار الصحيح في هذه المرحلة.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ما تم بناؤه',
              description:
                  'العناصر المعمارية والإدارية التي أصبحت موجودة فعليًا داخل المشروع.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'طبقة الإدارة والبوابات',
                  summary:
                      'تم تثبيت هيكل الإدارة، وGateway Layer، وCommunication / Engineering / Device-Storage gateways.',
                  supervisionNote:
                      'هذه الطبقات موجودة كواجهات إشرافية مستقرة نسبيًا.',
                ),
                _buildHandoffCard(
                  context,
                  title: 'طبقة النمو والامتثال',
                  summary:
                      'تمت إضافة Growth & Awareness Layer، وExposure Rules، وCompliance Checkpoints، وSystem Activation Pack.',
                  supervisionNote:
                      'هذه الصفحات مرجعية ومفاهيمية وتخدم قرار التفعيل الآمن.',
                ),
                _buildHandoffCard(
                  context,
                  title: 'حزمة التسليم المعماري',
                  summary:
                      'تم إنشاء Blueprint Handoff وActivation Readiness وصفحات مرجعية عليا تساعد على تسليم الحالة الحالية بوضوح.',
                  supervisionNote:
                      'هذه الحزمة مناسبة جدًا كنقطة دخول لأي مراجعة مستقبلية.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ما هو مفعّل فعليًا',
              description:
                  'العناصر التي تعمل حاليًا بشكل محدود وآمن دون أن تكون integrations تشغيلية عميقة.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'Support Email boundary',
                  summary:
                      'إجراء يدوي آمن عبر mailto مع intent presets للدعم العام والمشكلة التقنية ومساعدة الحساب.',
                  supervisionNote:
                      'مفعّل فعليًا، لكنه ليس inbox sync ولا تكامل بريد حقيقي.',
                  statusLabel: 'مفعّل فعليًا',
                ),
                _buildHandoffCard(
                  context,
                  title: 'حوارات حدود القنوات',
                  summary:
                      'Website Chat وExternal Follow-up وTelegram وFacebook/Messenger وZoom/Meet تعرض boundary dialogs فقط.',
                  supervisionNote:
                      'مفعّلة كشرح حدود وإشراف، لا كقنوات اتصال حقيقية.',
                  statusLabel: 'مفعّل فعليًا',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ما هو conceptual / planned',
              description:
                  'العناصر التي تم تعريفها أو تخطيطها لكن لم تُفعّل تشغيليًا بعد.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'تكاملات القنوات الحقيقية',
                  summary:
                      'لا توجد حتى الآن تكاملات فعلية مع External Follow-up أو Telegram أو Facebook/Messenger أو Website live sync.',
                  supervisionNote: 'ما يزال هذا المسار planned فقط.',
                  statusLabel: 'مفاهيمي / مخطط',
                ),
                _buildHandoffCard(
                  context,
                  title: 'Automation وMonetization',
                  summary:
                      'لا توجد أتمتة حقيقية، ولا monetized placements، ولا channel orchestration، ولا advanced telemetry.',
                  supervisionNote: 'كل ذلك ما يزال مؤجلًا ومشروطًا.',
                  statusLabel: 'مفاهيمي / مخطط',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ما هو monitored only',
              description:
                  'العناصر التي تعطي قيمة إشرافية الآن لكنها لا تمثل أنظمة تشغيلية live.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'Gateway signals',
                  summary:
                      'توجد مؤشرات Gateway صحية ومفيدة إشرافيًا، لكنها ليست telemetry تشغيلية متقدمة.',
                  supervisionNote: 'مفيدة في الوعي والمتابعة فقط.',
                  statusLabel: 'مراقبة فقط',
                ),
                _buildHandoffCard(
                  context,
                  title: 'Engineering وDevice/Storage supervision',
                  summary:
                      'الصفحات التقنية تشرح الحدود والمسؤوليات وتعرض shell monitoring فقط.',
                  supervisionNote:
                      'لا يوجد probing للأجهزة ولا فحص خارجي ولا console تشغيلية.',
                  statusLabel: 'مراقبة فقط',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ما هو frozen / protected',
              description:
                  'مناطق محمية أو مجمّدة ولا يجب التوسع فيها بشكل جانبي.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'clinician-request flow',
                  summary:
                      'هذا المسار مجمّد ويحتاج rebuild مستقل لاحقًا بدل patching المستمر.',
                  supervisionNote: 'ممنوع لمسه في الأعمال الجانبية الحالية.',
                  statusLabel: 'مجمّد / محمي',
                ),
                _buildHandoffCard(
                  context,
                  title: 'التكاملات غير الآمنة',
                  summary:
                      'أي تكامل مباشر غير آمن أو غير مملوك إشرافيًا يبقى محجوبًا حاليًا.',
                  supervisionNote: 'الحظر هنا مقصود لحماية الاستقرار.',
                  statusLabel: 'مجمّد / محمي',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ما الذي لا يجب لمسه',
              description: 'قائمة مختصرة بالأشياء التي يجب تجنب تعديلها الآن.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'لا تلمس المسارات المجمّدة',
                  summary:
                      'لا clinician-request flow، ولا integrations خارجية حقيقية، ولا monetization، ولا automation عميقة.',
                  supervisionNote:
                      'أي كسر لهذا المبدأ سيعيدنا إلى patching مكلف وغير مستقر.',
                  statusLabel: 'تنبيه تنفيذي',
                ),
                _buildHandoffCard(
                  context,
                  title: 'لا تخلط الطبقات معًا',
                  summary:
                      'Operations وCommunications وControl Room وGateway Layer وGrowth يجب أن تبقى منفصلة المعنى.',
                  supervisionNote:
                      'الحفاظ على هذا الفصل هو جزء من نجاح المعمارية الحالية.',
                  statusLabel: 'تنبيه تنفيذي',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'الخطوات التالية المقترحة',
              description:
                  'أقرب خطوات منطقية يمكن متابعتها دون كسر الاستقرار الحالي.',
              children: [
                _buildHandoffCard(
                  context,
                  title: 'تنظيم الصفحات المرجعية',
                  summary:
                      'يمكن لاحقًا ربط صفحات handoff/compliance/exposure/readiness/system activation pack ضمن مسار إداري مرجعي واضح.',
                  supervisionNote: 'خطوة آمنة ومنخفضة المخاطر.',
                  statusLabel: 'الخطوة التالية',
                ),
                _buildHandoffCard(
                  context,
                  title: 'الاستمرار في supervised architecture',
                  summary:
                      'الاستمرار في الإضافات الإشرافية والتنظيمية الصغيرة أفضل من القفز إلى integrations أو monetization أو automation.',
                  supervisionNote: 'هذا هو الاتجاه الأكثر أمانًا حاليًا.',
                  statusLabel: 'الخطوة التالية',
                ),
                _buildHandoffCard(
                  context,
                  title: 'أي تفعيل أعمق لاحقًا',
                  summary:
                      'إذا تقرر تفعيل أي integration أو exposure أو automation لاحقًا، يجب أن يمر أولًا عبر readiness + compliance + exposure rules.',
                  supervisionNote:
                      'لا يوجد activation عميق قبل تحقق الشروط بوضوح.',
                  statusLabel: 'الخطوة التالية',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
