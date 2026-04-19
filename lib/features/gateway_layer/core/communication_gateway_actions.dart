import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunicationGatewayActions {
  const CommunicationGatewayActions._();

  static const String supportEmailAddress = 'support@mentalsmile.app';

  static Future<void> openSupportEmail(BuildContext context) async {
    final uri = Uri(
      scheme: 'mailto',
      path: supportEmailAddress,
      queryParameters: const {
        'subject': 'Mental Smile Support',
        'body': 'Hello Mental Smile Support,\n\n'
            'Name:\n'
            'Contact email:\n'
            'Issue type:\n'
            'Summary:\n'
            'Details:\n\n'
            'Thank you.',
      },
    );

    final ok = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (!context.mounted || ok) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Unable to open the default email client.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
