import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/web_registration/presentation/web_registration_background.dart';

class WebRegistrationSuccessPage extends StatelessWidget {
  const WebRegistrationSuccessPage({super.key});

  bool _isClinicianSource(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == 'clinician') return true;
    if (args is Map) {
      return args['source'] == 'clinician' || args['role'] == 'clinician';
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final isClinician = _isClinicianSource(context);

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
                padding: const EdgeInsets.only(bottom: 28),
                child: TextButton.icon(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Routes.webLibrary),
                  icon: const Icon(Icons.menu_book_outlined, size: 18),
                  label: const Text(
                    'تصفح مكتبة الإرشاد أثناء مراجعة حسابك',
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: webRegistrationTextTurquoise,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      shadows: webRegistrationTextShadows,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
