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
    required String boundaryNote,
    required String route,
    String statusLabel = 'مدخل حوكمة',
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
                      color: AppColors.obsidian.withValues(alpha: 0.82),
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
              const GatewaySupervisionNote(
                text:
                    'مدخل إشرافي فقط لفتح صفحة الحوكمة أو الحدود المرتبطة، بدون أي تفعيل تشغيلي مباشر.',
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'فتح الصفحة',
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
                  boundaryNote:
                      'مرجع نشر ومراجعة ومنع مباشر للمحتوى داخل المكتبة، مع تثبيت أن النشر مملوك للإدارة فقط.',
                  route: Routes.adminLibraryGovernance,
                ),
                _buildEntryCard(
                  context,
                  title: 'Support Messaging Governance',
                  summary:
                      'حوكمة الرسائل الداعمة وحدود استخدامها بما لا يتعارض مع الدعم أو السلامة.',
                  boundaryNote:
                      'مرجع يضبط الرسائل الداعمة باعتبارها Admin-governed only وبعيدة عن أي تدخل علاجي.',
                  route: Routes.adminSupportMessagingGovernance,
                ),
                _buildEntryCard(
                  context,
                  title: 'Follow-Up Care Governance',
                  summary:
                      'حوكمة المتابعة الداعمة الخفيفة داخل التطبيق كطبقة مملوكة للإدارة فقط.',
                  boundaryNote:
                      'مرجع يحدد أن المتابعة داخل التطبيق دعم خفيف واستمرارية فقط وليست علاجًا أو جلسات.',
                  route: Routes.adminFollowupCareGovernance,
                ),
                _buildEntryCard(
                  context,
                  title: 'AI Follow-Up Boundaries',
                  summary:
                      'حدود دور الذكاء الاصطناعي داخل المتابعة المستمرة باعتباره مساعدًا اقتراحيًا فقط تحت إشراف الإدارة.',
                  boundaryNote:
                      'مرجع يحدد ما يمكن للذكاء اقتراحه وما لا يمكنه فعله داخل المتابعة، مع بقاء القرار النهائي للإدارة.',
                  route: Routes.adminAiFollowupBoundaries,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
