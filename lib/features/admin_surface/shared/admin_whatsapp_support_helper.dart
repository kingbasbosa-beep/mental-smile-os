import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

const String kAdminWhatsAppSupportNumber = '201014116531';

Future<void> openAdminWhatsAppSupport(
  BuildContext context, {
  required String type,
  required String source,
  String? referenceId,
  String? notes,
}) async {
  final message = '[TEST] Mental Smile Support Alert\n'
      'Type: $type\n'
      'Source: $source\n'
      'Reference: ${referenceId?.trim().isNotEmpty == true ? referenceId!.trim() : 'none'}\n'
      'Timestamp: ${DateTime.now().toIso8601String()}\n'
      'Notes: ${notes?.trim().isNotEmpty == true ? notes!.trim() : '...'}';

  final uri = Uri.parse(
    'https://wa.me/$kAdminWhatsAppSupportNumber?text=${Uri.encodeComponent(message)}',
  );

  final ok = await launchUrl(uri, mode: LaunchMode.platformDefault);
  if (!context.mounted) return;
  if (ok) return;

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

      return AlertDialog(
        title: const Text('WhatsApp fallback'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Unable to open WhatsApp. You can still copy the number and prepared message below.',
              ),
              const SizedBox(height: 16),
              SelectableText('Number: $kAdminWhatsAppSupportNumber'),
              const SizedBox(height: 12),
              SelectableText(message),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                copyText(kAdminWhatsAppSupportNumber, 'Number'),
            child: const Text('Copy number'),
          ),
          TextButton(
            onPressed: () => copyText(message, 'Message'),
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
