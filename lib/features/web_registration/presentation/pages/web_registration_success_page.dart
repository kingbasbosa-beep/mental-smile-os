import 'package:flutter/material.dart';
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
        ],
      ),
    );
  }
}
