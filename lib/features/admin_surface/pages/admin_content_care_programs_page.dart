import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminContentCareProgramsPage extends StatelessWidget {
  const AdminContentCareProgramsPage({super.key});

  Widget _buildEntryCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String route,
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
              const SizedBox(height: AppSpacing.sm),
              Text(
                summary,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.obsidian.withValues(alpha: 0.82),
                    ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const GatewaySupervisionNote(
                text: 'مدخل إشرافي فقط لفتح صفحة الحوكمة المرتبطة.',
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
        title: 'Content & Care Programs',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'Content & Care Programs',
              summary:
                  'سطح إشرافي يجمع مسارات الحوكمة المتعلقة بالمحتوى، ورسائل الدعم، والمتابعة الداعمة داخل التطبيق.',
              boundaryNote:
                  'هذه الصفحة تنظّم الدخول إلى صفحات الحوكمة فقط، ولا تضيف أي منطق تشغيلي أو backend.',
              emphasis:
                  'استخدم هذه الصفحة كطبقة تنظيمية تربط بين الحوكمة المرتبطة بالمحتوى والرعاية الداعمة.',
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'مداخل الحوكمة',
              description:
                  'هذه البطاقات تفتح صفحات الحوكمة المرجعية المرتبطة بالمحتوى والرعاية الداعمة.',
              children: [
                _buildEntryCard(
                  context,
                  title: 'Library Governance',
                  summary:
                      'حوكمة المكتبة والمحتوى التوعوي والحدود المتعلقة باستخدامه داخل النظام.',
                  route: Routes.adminLibraryGovernance,
                ),
                _buildEntryCard(
                  context,
                  title: 'Support Messaging Governance',
                  summary:
                      'حوكمة الرسائل الداعمة وحدود استخدامها بما لا يتعارض مع الدعم أو السلامة.',
                  route: Routes.adminSupportMessagingGovernance,
                ),
                _buildEntryCard(
                  context,
                  title: 'Follow-Up Care Governance',
                  summary:
                      'حوكمة المتابعة الداعمة الخفيفة داخل التطبيق كطبقة مملوكة للإدارة فقط.',
                  route: Routes.adminFollowupCareGovernance,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
