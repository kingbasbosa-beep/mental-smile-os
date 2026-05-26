import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/web_registration/presentation/web_registration_background.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';

class WebRegistrationSuccessPage extends StatelessWidget {
  const WebRegistrationSuccessPage({super.key});

  String _source(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == 'clinician' || args == 'center') return args.toString();
    if (args is Map) {
      final source = args['source']?.toString().trim().toLowerCase();
      if (source == 'clinician' || source == 'center') return source!;
      final role = args['role']?.toString().trim().toLowerCase();
      if (role == 'clinician' || role == 'center') return role!;
    }
    return 'center';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final source = _source(context);
    final isClinician = source == 'clinician';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            webRegistrationBackgroundAsset(
              context,
              roleFolder: isClinician ? 'clinicians' : 'centers',
              fileName: isClinician
                  ? 'clinicians_success.png'
                  : 'centers_success.png',
            ),
            fit: BoxFit.contain,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 60),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isArabic
                          ? (isClinician
                              ? 'تم إرسال طلب تسجيل الأخصائي بنجاح.'
                              : 'تم إرسال طلب تسجيل المركز بنجاح.')
                          : (isClinician
                              ? 'Your clinician registration request has been submitted successfully.'
                              : 'Your center registration request has been submitted successfully.'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFE8C878),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(color: Colors.black, blurRadius: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      isArabic
                          ? (isClinician
                              ? 'سيتم مراجعة بيانات الأخصائي قبل التفعيل.'
                              : 'سيتم مراجعة بيانات المركز قبل التفعيل.')
                          : (isClinician
                              ? 'Your clinician information will be reviewed before activation.'
                              : 'Your center information will be reviewed before activation.'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(color: Colors.black, blurRadius: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
