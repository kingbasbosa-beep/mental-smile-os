import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum SupportEmailIntent {
  generalSupport,
  technicalIssue,
  accountHelp,
}

class CommunicationGatewayActions {
  const CommunicationGatewayActions._();

  static const String supportEmailAddress = 'support@mentalsmile.app';

  static Future<void> openSupportEmail(
    BuildContext context, {
    SupportEmailIntent intent = SupportEmailIntent.generalSupport,
  }) async {
    final emailTemplate = switch (intent) {
      SupportEmailIntent.generalSupport => (
          subject: 'Mental Smile Support | General Support',
          body: 'Hello Mental Smile Support team,\n\n'
              'I would like help with the following:\n\n'
              'Name:\n'
              'Preferred contact email:\n'
              'Support topic:\n'
              'Short summary:\n'
              'Details:\n\n'
              'This request is for support only and does not include medical or diagnostic evaluation.\n\n'
              'Thank you.'
        ),
      SupportEmailIntent.technicalIssue => (
          subject: 'Mental Smile Support | Technical Issue',
          body: 'Hello Mental Smile Support team,\n\n'
              'I would like to report a technical issue:\n\n'
              'Name:\n'
              'Preferred contact email:\n'
              'Device / Browser:\n'
              'Issue summary:\n'
              'Steps to reproduce:\n'
              'What happened:\n'
              'What I expected:\n'
              'When this happened:\n\n'
              'This request is for technical support only and does not include medical or diagnostic evaluation.\n\n'
              'Thank you.'
        ),
      SupportEmailIntent.accountHelp => (
          subject: 'Mental Smile Support | Account Help',
          body: 'Hello Mental Smile Support team,\n\n'
              'I would like help with my account:\n\n'
              'Name:\n'
              'Account email:\n'
              'Account help needed:\n'
              'Short summary:\n'
              'Details:\n\n'
              'This request is for account support only and does not include medical or diagnostic evaluation.\n\n'
              'Thank you.'
        ),
    };

    final uri = Uri(
      scheme: 'mailto',
      path: supportEmailAddress,
      queryParameters: {
        'subject': emailTemplate.subject,
        'body': emailTemplate.body,
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
