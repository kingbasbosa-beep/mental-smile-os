import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/gateway_layer/core/communication_gateway_actions.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_entry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_registry.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_health_level.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_status.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminCommunicationGatewayPage extends StatefulWidget {
  const AdminCommunicationGatewayPage({super.key});

  @override
  State<AdminCommunicationGatewayPage> createState() =>
      _AdminCommunicationGatewayPageState();
}

class _AdminCommunicationGatewayPageState
    extends State<AdminCommunicationGatewayPage> {
  static const String _whatsAppSupportNumber = '201014116531';
  static const List<String> _signalTypes = [
    'Support',
    'Urgent',
    'Follow-up',
  ];
  static const List<String> _signalActions = [
    'Follow-up',
    'Assign to Content',
    'Assign to Support',
    'Needs QA Review',
    'Escalated',
  ];
  static const List<String> _signalPriorities = [
    'Low',
    'Medium',
    'High',
  ];
  SupportEmailIntent _selectedIntent = SupportEmailIntent.generalSupport;
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  String _selectedSignalType = _signalTypes.first;
  String _selectedSignalPriority = _signalPriorities[1];
  final List<_ManualSupportSignal> _manualSignals = [];

  @override
  void dispose() {
    _messageController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  String _intentLabel(SupportEmailIntent intent) {
    return switch (intent) {
      SupportEmailIntent.generalSupport => 'General Support',
      SupportEmailIntent.technicalIssue => 'Technical Issue',
      SupportEmailIntent.accountHelp => 'Account Help',
    };
  }

  String _intentDebugValue(SupportEmailIntent intent) {
    return switch (intent) {
      SupportEmailIntent.generalSupport => 'general_support',
      SupportEmailIntent.technicalIssue => 'technical_issue',
      SupportEmailIntent.accountHelp => 'account_help',
    };
  }

  Future<void> _showBoundaryDialog(
    BuildContext context, {
    required String title,
    required String boundaryType,
    required String separationNote,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                boundaryType,
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Current status: Planned / supervised / not integrated yet.',
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                separationNote,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showWebsiteChatBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'Website Chat Boundary',
      boundaryType:
          'This boundary is reserved for website-origin intake and routing awareness.',
      separationNote:
          'It is separate from direct human support handling, which remains in the Communications workspace.',
    );
  }

  Future<void> _showWhatsAppBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'WhatsApp Boundary',
      boundaryType:
          'This boundary is reserved for messaging-channel intake and routing awareness.',
      separationNote:
          'It remains separate from direct human support handling and does not replace the Communications workspace or escalations.',
    );
  }

  String _buildWhatsAppMessage() {
    return 'Mental Smile Support Request\n'
        'Source: Communication Gateway\n'
        'Timestamp: ${DateTime.now().toIso8601String()}\n'
        'Notes: ...';
  }

  Future<void> _showWhatsAppFallbackDialog(
    BuildContext context, {
    required String number,
    required String message,
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
                const SizedBox(height: AppSpacing.md),
                SelectableText('Number: $number'),
                const SizedBox(height: AppSpacing.sm),
                SelectableText(message),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => copyText(number, 'Number'),
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

  Future<void> _openWhatsAppSupport(BuildContext context) async {
    final message = _buildWhatsAppMessage();
    final uri = Uri.parse(
      'https://wa.me/$_whatsAppSupportNumber?text=${Uri.encodeComponent(message)}',
    );
    final ok = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (!context.mounted) return;
    if (ok) return;
    await _showWhatsAppFallbackDialog(
      context,
      number: _whatsAppSupportNumber,
      message: message,
    );
  }

  Future<void> _showTelegramBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'Telegram Boundary',
      boundaryType:
          'This boundary is reserved for Telegram messaging-channel intake and routing awareness.',
      separationNote:
          'It remains separate from direct human support handling and does not replace the Communications workspace or escalations.',
    );
  }

  Future<void> _showFacebookMessengerBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'Facebook / Messenger Boundary',
      boundaryType:
          'This boundary is reserved for Facebook or Messenger intake and routing awareness.',
      separationNote:
          'It remains separate from direct human support handling and does not replace the Communications workspace or escalations.',
    );
  }

  Future<void> _showZoomMeetBoundary(BuildContext context) {
    return _showBoundaryDialog(
      context,
      title: 'Zoom / Google Meet Coordination Boundary',
      boundaryType:
          'This boundary is reserved for meeting-link coordination and external channel routing awareness.',
      separationNote:
          'It remains separate from direct human support handling, Communications workspace case handling, and Operations-owned session scheduling.',
    );
  }

  void _createSupportSignal() {
    final message = _messageController.text.trim();
    final userName = _userNameController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add a message before creating a support signal.'),
        ),
      );
      return;
    }

    setState(() {
      _manualSignals.insert(
        0,
        _ManualSupportSignal(
          source: 'WhatsApp',
          type: _selectedSignalType,
          message: message,
          userName: userName,
          priority: _selectedSignalPriority,
          status: 'Pending',
          actionLabel: 'Not assigned',
        ),
      );
      _messageController.clear();
      _userNameController.clear();
      _selectedSignalType = _signalTypes.first;
      _selectedSignalPriority = _signalPriorities[1];
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Support signal created')),
    );
  }

  void _advanceSignalStatus(int index) {
    const statusFlow = ['Pending', 'In Progress', 'Closed'];
    final current = _manualSignals[index];
    final nextIndex = (statusFlow.indexOf(current.status) + 1) % statusFlow.length;
    setState(() {
      _manualSignals[index] = current.copyWith(status: statusFlow[nextIndex]);
    });
  }

  Future<void> _setSignalAction(int index) async {
    final selectedAction = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Set Action'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _signalActions
                .map(
                  (action) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(action),
                    onTap: () => Navigator.of(dialogContext).pop(action),
                  ),
                )
                .toList(),
          ),
        );
      },
    );

    if (selectedAction == null) return;
    setState(() {
      _manualSignals[index] = _manualSignals[index].copyWith(
        actionLabel: selectedAction,
      );
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Action updated')),
    );
  }

  String? _routeForSignalAction(String actionLabel) {
    switch (actionLabel) {
      case 'Assign to Content':
        return Routes.contentWorkspace;
      case 'Assign to Support':
        return Routes.adminCommunicationGateway;
      case 'Needs QA Review':
        return Routes.adminEmployeeSystem;
      case 'Escalated':
        return Routes.adminMaintenanceSystem;
      case 'Follow-up':
      case 'Not assigned':
      default:
        return null;
    }
  }

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'High':
        return const Color(0xFFC66A4A);
      case 'Medium':
        return const Color(0xFFD8B26A);
      case 'Low':
      default:
        return const Color(0xFF3E9B90);
    }
  }

  Widget _buildWhatsAppSignalIntakeCard(BuildContext context) {
    return AppSurfaceCard(
      color: const Color(0xFF10161A).withValues(alpha: 0.94),
      borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WhatsApp Manual Signal Intake',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFC9A75B),
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Create local support signals from WhatsApp messages without backend integration or automation.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFEAEAEA),
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            initialValue: 'WhatsApp',
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Source',
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedSignalType,
                  decoration: const InputDecoration(
                    labelText: 'Type',
                  ),
                  items: _signalTypes
                      .map(
                        (type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedSignalType = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedSignalPriority,
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                  ),
                  items: _signalPriorities
                      .map(
                        (priority) => DropdownMenuItem<String>(
                          value: priority,
                          child: Text(priority),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedSignalPriority = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            controller: _userNameController,
            decoration: const InputDecoration(
              labelText: 'User name (optional)',
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            controller: _messageController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Message',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          FilledButton.icon(
            onPressed: _createSupportSignal,
            icon: const Icon(Icons.add_comment_outlined),
            label: const Text('Create Support Signal'),
          ),
        ],
      ),
    );
  }

  Widget _buildSignalCard(BuildContext context, _ManualSupportSignal signal, int index) {
    final priorityColor = _priorityColor(signal.priority);
    return AppSurfaceCard(
      color: const Color(0xFF10161A).withValues(alpha: 0.94),
      borderColor: priorityColor.withValues(alpha: 0.24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            signal.message,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF1E5C8),
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _SignalInfoChip(label: 'Source', value: signal.source),
              _SignalInfoChip(label: 'Type', value: signal.type),
              _SignalInfoChip(label: 'Priority', value: signal.priority, color: priorityColor),
              _SignalInfoChip(label: 'Status', value: signal.status),
              _SignalInfoChip(
                label: 'Action',
                value: signal.actionLabel,
                color: const Color(0xFF3E9B90),
              ),
            ],
          ),
          if (signal.userName.trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              'User: ${signal.userName}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFEAEAEA),
                  ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Action / Next Step',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFC9A75B),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            signal.actionLabel,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFFEAEAEA),
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              OutlinedButton.icon(
                onPressed: () => _advanceSignalStatus(index),
                icon: const Icon(Icons.sync_alt_outlined, size: 18),
                label: const Text('Advance Status'),
              ),
              OutlinedButton.icon(
                onPressed: () => _setSignalAction(index),
                icon: const Icon(Icons.playlist_add_check_circle_outlined, size: 18),
                label: const Text('Set Action'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  final route = _routeForSignalAction(signal.actionLabel);
                  if (route == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          signal.actionLabel == 'Not assigned'
                              ? 'No action selected'
                              : 'No related workspace for this action',
                        ),
                      ),
                    );
                    return;
                  }
                  Navigator.of(context).pushNamed(route);
                },
                icon: const Icon(Icons.open_in_new_outlined, size: 18),
                label: const Text('Open Related Workspace'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGatewayGroup(
    BuildContext context, {
    required String title,
    String? description,
    required List<GatewayEntry> entries,
  }) {
    return GatewaySectionCard(
      title: title,
      description: description,
      children: entries
          .map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _buildGatewayEntryCard(context, entry),
            ),
          )
          .toList(),
    );
  }

  Widget _buildGatewayEntryCard(BuildContext context, GatewayEntry entry) {
    if (entry.id == 'support_email') {
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () {
          if (kDebugMode) {
            debugPrint(
              'COMM_GATEWAY support_email_tap '
              'selectedIntent=${_intentDebugValue(_selectedIntent)}',
            );
          }
          CommunicationGatewayActions.openSupportEmail(
            context,
            intent: _selectedIntent,
          );
        },
        child: GatewayEntryCard(entry: entry),
      );
    }

    if (entry.id == 'website_chat') {
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => _showWebsiteChatBoundary(context),
        child: GatewayEntryCard(entry: entry),
      );
    }

    if (entry.id == 'whatsapp') {
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => _openWhatsAppSupport(context),
        child: GatewayEntryCard(entry: entry),
      );
    }

    if (entry.id == 'telegram') {
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => _showTelegramBoundary(context),
        child: GatewayEntryCard(entry: entry),
      );
    }

    if (entry.id == 'facebook_messenger') {
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => _showFacebookMessengerBoundary(context),
        child: GatewayEntryCard(entry: entry),
      );
    }

    if (entry.id == 'zoom_meet') {
      return InkWell(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        onTap: () => _showZoomMeetBoundary(context),
        child: GatewayEntryCard(entry: entry),
      );
    }

    return GatewayEntryCard(entry: entry);
  }

  @override
  Widget build(BuildContext context) {
    const activeWhatsAppEntry = GatewayEntry(
      id: 'whatsapp',
      title: 'WhatsApp Support',
      boundary: 'WhatsApp external support launch tool.',
      status: GatewayStatus(
        level: GatewayHealthLevel.healthy,
        summary: 'Active external WhatsApp launch tool.',
        boundaryNote:
            'Opens WhatsApp Web as an external support tool without backend integration.',
        monitoredNote: 'No backend or API integration yet.',
        attentionLabel: 'Active',
      ),
    );
    final intakeEntries = communicationGatewayEntries
        .where((entry) => entry.id == 'website_chat' || entry.id == 'support_email')
        .toList();
    final messagingEntries = communicationGatewayEntries
        .where((entry) =>
            entry.id == 'whatsapp' ||
            entry.id == 'telegram' ||
            entry.id == 'facebook_messenger')
        .map((entry) => entry.id == 'whatsapp' ? activeWhatsAppEntry : entry)
        .toList();
    final coordinationEntries = communicationGatewayEntries
        .where((entry) =>
            entry.id == 'zoom_meet' || entry.id == 'external_intake')
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F1316),
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Communication Gateway',
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF13191D),
              Color(0xFF0F1316),
              Color(0xFF151B1F),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'Communication Gateway',
              summary:
                  'Supervise channel intake boundaries and routing readiness without turning this page into a live communications workspace.',
              boundaryNote:
                  'Human case handling remains in Communications. This page stays focused on supervised connector boundaries only.',
              emphasis:
                  'No external channel integrations are active yet. This gateway remains a monitored shell.',
            ),
            const SizedBox(height: AppSpacing.md),
            const GatewaySectionCard(
              title: 'Gateway Boundary Definition',
              description:
                  'This compact section defines what the Communication Gateway is responsible for and where its boundaries stop.',
              children: [
                GatewaySupervisionNote(
                  text:
                      'Does: manual support initiation, email-based communication, and intent-based contact preparation.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Does not do: messaging system behavior, live chat handling, automation, or follow-up execution.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Boundaries: admin-triggered only, requires an external email client, and does not store internal messages.',
                ),
                SizedBox(height: AppSpacing.sm),
                GatewaySupervisionNote(
                  text:
                      'Supervision note: non-medical, non-diagnostic, support-first, and not a crisis-handling layer.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            AppSurfaceCard(
              color: const Color(0xFF10161A).withValues(alpha: 0.94),
              borderColor: const Color(0xFFD8B26A).withValues(alpha: 0.18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Support Email intent',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFC9A75B),
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: SupportEmailIntent.values.map((intent) {
                      return ChoiceChip(
                        label: Text(_intentLabel(intent)),
                        labelStyle: const TextStyle(
                          color: Color(0xFFC9A75B),
                          fontWeight: FontWeight.w700,
                        ),
                        backgroundColor:
                            const Color(0xFF12181D).withValues(alpha: 0.88),
                        selectedColor:
                            const Color(0xFFD8B26A).withValues(alpha: 0.14),
                        side: BorderSide(
                          color:
                              const Color(0xFFD8B26A).withValues(alpha: 0.18),
                        ),
                        showCheckmark: true,
                        selected: _selectedIntent == intent,
                        onSelected: (_) {
                          if (kDebugMode) {
                            debugPrint(
                              'COMM_GATEWAY intent_selected='
                              '${_intentDebugValue(intent)}',
                            );
                          }
                          setState(() {
                            _selectedIntent = intent;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Selected: ${_intentLabel(_selectedIntent)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFFC9A75B),
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildGatewayGroup(
              context,
              title: 'Intake Channels',
              description:
                  'Entry boundaries for web and email-origin support intake before any human handling begins.',
              entries: intakeEntries,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildGatewayGroup(
              context,
              title: 'Messaging Channels',
              description:
                  'Messaging-boundary placeholders that remain supervised and separate from direct support handling.',
              entries: messagingEntries,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildWhatsAppSignalIntakeCard(context),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'Control Room Signals',
              description:
                  'Local advisory signals created manually from WhatsApp intake messages.',
              children: _manualSignals.isEmpty
                  ? [
                      const GatewaySupervisionNote(
                        text:
                            'No support signals created yet. Use the intake form above to stage WhatsApp messages locally.',
                      ),
                    ]
                  : _manualSignals
                      .asMap()
                      .entries
                      .map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: _buildSignalCard(
                            context,
                            entry.value,
                            entry.key,
                          ),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildGatewayGroup(
              context,
              title: 'Meeting / Coordination',
              description:
                  'Coordination boundaries for meetings and external intake routing, kept separate from Operations scheduling.',
              entries: coordinationEntries,
            ),
          ],
        ),
      ),
    );
  }
}

class _ManualSupportSignal {
  final String source;
  final String type;
  final String message;
  final String userName;
  final String priority;
  final String status;
  final String actionLabel;

  const _ManualSupportSignal({
    required this.source,
    required this.type,
    required this.message,
    required this.userName,
    required this.priority,
    required this.status,
    required this.actionLabel,
  });

  _ManualSupportSignal copyWith({
    String? source,
    String? type,
    String? message,
    String? userName,
    String? priority,
    String? status,
    String? actionLabel,
  }) {
    return _ManualSupportSignal(
      source: source ?? this.source,
      type: type ?? this.type,
      message: message ?? this.message,
      userName: userName ?? this.userName,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      actionLabel: actionLabel ?? this.actionLabel,
    );
  }
}

class _SignalInfoChip extends StatelessWidget {
  const _SignalInfoChip({
    required this.label,
    required this.value,
    this.color,
  });

  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? const Color(0xFFD8B26A);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(
          color: chipColor.withValues(alpha: 0.24),
        ),
      ),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: chipColor,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
