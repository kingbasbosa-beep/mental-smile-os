import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminSupportMessagingGovernancePage extends StatelessWidget {
  const AdminSupportMessagingGovernancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Support Messaging Governance',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: const [
            GatewayPageIntroCard(
              title: 'Support Messaging Governance',
              summary:
                  'صفحة إشرافية مرجعية لحوكمة الرسائل الداعمة وحدودها الأخلاقية والتشغيلية داخل النظام.',
              boundaryNote:
                  'هذه الصفحة تنظيمية فقط ولا تضيف أي تكاملات أو منطق رسائل فعلي.',
              emphasis:
                  'تُستخدم كمرجع إداري بسيط إلى أن يتم تطوير طبقة الحوكمة الخاصة بالرسائل الداعمة لاحقًا.',
            ),
          ],
        ),
      ),
    );
  }
}
