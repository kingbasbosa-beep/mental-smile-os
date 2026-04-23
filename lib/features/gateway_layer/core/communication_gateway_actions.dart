import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

enum SupportEmailIntent {
  generalSupport,
  technicalIssue,
  accountHelp,
}

class CommunicationGatewayActions {
  const CommunicationGatewayActions._();

  static const String supportEmailAddress = 'support@mentalsmile.app';

  static String _intentDebugValue(SupportEmailIntent intent) {
    return switch (intent) {
      SupportEmailIntent.generalSupport => 'general_support',
      SupportEmailIntent.technicalIssue => 'technical_issue',
      SupportEmailIntent.accountHelp => 'account_help',
    };
  }

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

    if (kDebugMode) {
      debugPrint(
        'COMM_GATEWAY support_email_prepared '
        'selectedIntent=${_intentDebugValue(intent)} '
        'subject="${emailTemplate.subject}"',
      );
    }

    final uri = Uri(
      scheme: 'mailto',
      path: supportEmailAddress,
      queryParameters: {
        'subject': emailTemplate.subject,
        'body': emailTemplate.body,
      },
    );

    final ok = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (kDebugMode) {
      debugPrint(
        'COMM_GATEWAY support_email_launch_result success=$ok',
      );
    }
    if (!context.mounted) return;
    if (ok) return;

    if (kDebugMode) {
      debugPrint('COMM_GATEWAY support_email_fallback_opened=true');
    }
    await _showEmailFallbackDialog(
      context,
      subject: emailTemplate.subject,
      body: emailTemplate.body,
    );
  }

  static Future<void> _showEmailFallbackDialog(
    BuildContext context, {
    required String subject,
    required String body,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        Future<void> copyText(String value, String label) async {
          await Clipboard.setData(ClipboardData(text: value));
          if (!dialogContext.mounted) return;
          ScaffoldMessenger.of(dialogContext).showSnackBar(
            SnackBar(
              content: Text('$label copied.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }

        Widget buildReadOnlyField(String label, String value, {int maxLines = 6}) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(dialogContext).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.08),
                  ),
                ),
                child: Text(
                  value,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        }

        return AlertDialog(
          title: const Text('Email fallback'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Unable to open the default email client. You can still copy the support details below.',
                ),
                const SizedBox(height: 16),
                buildReadOnlyField('Support email', supportEmailAddress, maxLines: 2),
                const SizedBox(height: 12),
                buildReadOnlyField('Subject', subject, maxLines: 3),
                const SizedBox(height: 12),
                buildReadOnlyField('Message', body, maxLines: 10),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => copyText(supportEmailAddress, 'Email'),
              child: const Text('Copy email'),
            ),
            TextButton(
              onPressed: () => copyText(subject, 'Subject'),
              child: const Text('Copy subject'),
            ),
            TextButton(
              onPressed: () => copyText(body, 'Message'),
              child: const Text('Copy message'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
