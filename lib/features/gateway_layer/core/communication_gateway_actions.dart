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
          subject: '[General Support] Mental Smile Support',
          body: 'Hello Mental Smile Support,\n\n'
              'Name:\n'
              'Contact email:\n'
              'Support topic:\n'
              'Summary:\n'
              'Details:\n\n'
              'Thank you.'
        ),
      SupportEmailIntent.technicalIssue => (
          subject: '[Technical Issue] Mental Smile Support',
          body: 'Hello Mental Smile Support,\n\n'
              'Name:\n'
              'Contact email:\n'
              'Device / Browser:\n'
              'Issue summary:\n'
              'Steps to reproduce:\n'
              'What happened:\n'
              'What you expected:\n\n'
              'Thank you.'
        ),
      SupportEmailIntent.accountHelp => (
          subject: '[Account Help] Mental Smile Support',
          body: 'Hello Mental Smile Support,\n\n'
              'Name:\n'
              'Account email:\n'
              'Account help needed:\n'
              'Summary:\n'
              'Details:\n\n'
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
