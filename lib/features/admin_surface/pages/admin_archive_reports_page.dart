import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

// ADMIN_SURFACE: SAFE_UI
class AdminArchiveReportsPage extends StatelessWidget {
  const AdminArchiveReportsPage({super.key});

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'أرشيف التقارير' : 'Reports Archive',
          canLogout: false,
        ),
        body: AppPageBackground(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              AppSurfaceCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor:
                          const Color(0xFF6C55B3).withValues(alpha: 0.14),
                      child: const Icon(
                        Icons.assessment_outlined,
                        color: Color(0xFF6C55B3),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      isArabic ? 'أرشيف تقارير محايد' : 'Neutral report archive',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isArabic
                          ? 'تم فصل المخرجات التشغيلية القديمة عن أرشيف التقارير. هذه الصفحة تبقى كمدخل تقارير عام فقط.'
                          : 'Legacy operational output has been removed from the report archive. This page remains a general reports entry only.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.mist,
                          ),
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
