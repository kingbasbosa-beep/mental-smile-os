import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminLibraryGovernancePage extends StatelessWidget {
  const AdminLibraryGovernancePage({super.key});

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
          children: const [
            GatewayPageIntroCard(
              title: 'Library Governance',
              summary:
                  'صفحة إشرافية مرجعية لحوكمة المكتبة والمحتوى التوعوي داخل النظام.',
              boundaryNote:
                  'هذه الصفحة تنظيمية فقط وتوضح حدود الحوكمة الخاصة بالمحتوى دون أي backend أو منطق تشغيلي.',
              emphasis:
                  'تُستخدم كمرجع إداري بسيط حتى يتم تطوير طبقة الحوكمة المرتبطة بالمكتبة بشكل أوسع لاحقًا.',
            ),
          ],
        ),
      ),
    );
  }
}
