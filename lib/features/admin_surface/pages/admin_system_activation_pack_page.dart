import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminSystemActivationPackPage extends StatelessWidget {
  const AdminSystemActivationPackPage({super.key});

  Widget _buildPackCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String boundaryNote,
    required String supervisionNote,
    required String route,
    String statusLabel = 'مرجع إشرافي',
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => Navigator.of(context).pushNamed(route),
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
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'فتح الصفحة المرجعية',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF2E5AAC),
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  const Icon(
                    Icons.open_in_new,
                    size: 18,
                    color: Color(0xFF2E5AAC),
                  ),
                ],
              ),
            ],
          ),
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
        title: 'System Activation Pack',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'System Activation Pack',
              summary:
                  'هذه الصفحة تمثل باقة القرار التنفيذي للنظام، والمرجع الموحد لقرارات التفعيل الآمن، والامتثال، والحدود، والجاهزية.',
              boundaryNote:
                  'الهدف منها هو جمع الصفحات المرجعية الأساسية في نقطة واحدة واضحة قبل أي تفعيل أعمق أو أي توسع مستقبلي.',
              emphasis:
                  'النظام حاليًا في مرحلة Supervised Activation Phase، وأي activation أعمق يبقى مشروطًا بالضوابط، والجاهزية، والسلامة، والامتثال.',
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'المرجع التنفيذي الموحد',
              description:
                  'هذه البطاقات تجمع الصفحات المرجعية الأساسية التي يعتمد عليها قرار التفعيل الآمن داخل النظام.',
              children: [
                _buildPackCard(
                  context,
                  title: 'ملف تسليم المخطط العام',
                  summary:
                      'مرجع الحالة الحالية للمشروع: ما بُني، وما هو مفاهيمي، وما هو مراقب، وما هو مجمّد، وما الذي يجب توفره قبل التفعيل.',
                  boundaryNote:
                      'يوحد الرؤية المعمارية الحالية ويمنع فقدان الصورة الكاملة أثناء التطوير.',
                  supervisionNote:
                      'صفحة handoff عليا لربط القرارات المعمارية بالحالة الحالية للنظام.',
                  route: Routes.adminBlueprintHandoff,
                ),
                _buildPackCard(
                  context,
                  title: 'نقاط الامتثال والربط بالكود',
                  summary:
                      'تربط بين المعمارية، والسلامة، والحدود، والتموضع غير الطبي، والنمو، وما يجب أن ينعكس لاحقًا في التنفيذ.',
                  boundaryNote:
                      'تحافظ على اتساق النظام مع قواعد الامتثال وعدم الانزلاق نحو سلوك غير منضبط.',
                  supervisionNote:
                      'مرجع امتثال إشرافي قبل أي integration أو automation أو monetization.',
                  route: Routes.adminComplianceCheckpoints,
                ),
                _buildPackCard(
                  context,
                  title: 'قواعد الظهور والتعرّض',
                  summary:
                      'تحدد متى يمكن التفكير في الظهور التوعوي أو الربحي، ومتى يجب حجبه بالكامل لصالح السلامة والدعم.',
                  boundaryNote:
                      'تفصل بين أسطح الظهور المقبولة وبين السياقات المحظورة أو الحساسة.',
                  supervisionNote:
                      'مرجع سياساتي أساسي قبل أي awareness أو monetization activation.',
                  route: Routes.adminExposureRules,
                ),
                _buildPackCard(
                  context,
                  title: 'مصفوفة جاهزية التفعيل',
                  summary:
                      'توضح ما هو built أو monitored أو conceptual أو activated بشكل محدود، وما هو blocked، وما الذي ينقص كل طبقة قبل التفعيل الحقيقي.',
                  boundaryNote:
                      'تحول قرار التفعيل من انطباع عام إلى readiness decision واضحة.',
                  supervisionNote:
                      'مرجع تشغيلي/إشرافي مباشر لتقييم readiness الحالية للنظام.',
                  route: Routes.adminActivationReadiness,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ملاحظات إشرافية',
              description:
                  'هذه الملاحظات تلخص منطق القرار الحاكم لأي تفعيل مستقبلي داخل النظام.',
              children: const [
                GatewaySupervisionNote(
                  text: 'السلامة أولًا قبل أي تفعيل تقني أو تشغيلي أو ربحي.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text: 'الامتثال أولًا قبل أي integration أو automation أو activation أعمق.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text: 'لا يوجد deep activation بدون safeguards واضحة وmonitoring حقيقية وownership واضحة.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text: 'لا monetization بدون approval واضح لقواعد الظهور والتعرض والقيود الأخلاقية.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
