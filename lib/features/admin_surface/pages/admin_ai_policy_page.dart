import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterprojects/core/system/domain_registry.dart';
import 'package:flutterprojects/core/system/domain_status.dart';
import 'package:flutterprojects/core/system/domain_status_service.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/admin_surface/services/ai_policy_health_service.dart';
import 'package:flutterprojects/features/admin_surface/widgets/domain_advisory_banner.dart';
import 'package:flutterprojects/features/chat/data/services/chat_ai_service.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

// ADMIN_SURFACE: SAFE_UI
class AdminAiPolicyPage extends StatefulWidget {
  const AdminAiPolicyPage({super.key});

  @override
  State<AdminAiPolicyPage> createState() => _AdminAiPolicyPageState();
}

class _AdminAiPolicyPageState extends State<AdminAiPolicyPage> {
  static const AiPolicyHealthService _aiPolicyHealthService =
      AiPolicyHealthService();
  static const DomainStatusService _domainStatusService = DomainStatusService();
  final TextEditingController _testMessageController = TextEditingController();
  final ChatAiService _chatAiService = const ChatAiService();
  final TextEditingController _draftNotesController = TextEditingController();
  final TextEditingController _publishNoteController = TextEditingController();
  final Map<String, TextEditingController> _draftTemplateControllers = {
    'critical': TextEditingController(),
    'high': TextEditingController(),
    'medium': TextEditingController(),
    'family_member': TextEditingController(),
    'default': TextEditingController(),
  };

  ChatAiResult? _testResult;
  bool _savingDraft = false;
  bool _publishingDraft = false;
  String? _loadedDraftVersion;

  bool _isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emitAiPolicyHealth();
    });
  }

  Future<void> _emitAiPolicyHealth() async {
    try {
      await _aiPolicyHealthService.emitHealthSnapshot();
    } catch (_) {
      // Health reporting must stay quiet and never block the admin surface.
    }
  }

  void _runTestConsole() {
    final input = _testMessageController.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _testResult = _chatAiService.processUserMessage(input);
    });
  }

  String _timestampText(dynamic value) {
    if (value is Timestamp) {
      return value.toDate().toIso8601String();
    }
    return value?.toString().trim() ?? '—';
  }

  String _advisoryTitle(bool isArabic, String status) {
    switch (status) {
      case 'disabled':
        return isArabic ? 'تنبيه: النطاق معطل' : 'Advisory: Domain disabled';
      case 'maintenance':
        return isArabic
            ? 'تنبيه: النطاق تحت صيانة مخططة'
            : 'Advisory: Planned maintenance';
      default:
        return isArabic
            ? 'تنبيه: النطاق في حالة degraded'
            : 'Advisory: Domain degraded';
    }
  }

  String _advisoryBody(bool isArabic, DomainStatus status) {
    final reason = (status.statusReason ?? status.note ?? '').trim();
    final source = DomainAdvisoryBanner.statusSourceLabel(status.statusSource);

    final intro = switch (status.status) {
      'disabled' => isArabic
          ? 'هذه الصفحة تعرض حالة نطاق AI Policy على أنها معطلة حاليًا.'
          : 'This page is showing the AI Policy domain as currently disabled.',
      'maintenance' => isArabic
          ? 'هذه الصفحة تعرض أن نطاق AI Policy تحت صيانة مخططة.'
          : 'This page is showing the AI Policy domain as under planned maintenance.',
      _ => isArabic
          ? 'هذه الصفحة تعرض أن نطاق AI Policy في حالة degraded ويجب التعامل مع بياناته بحذر.'
          : 'This page is showing the AI Policy domain as degraded and its signals should be treated with reduced trust.',
    };

    if (reason.isEmpty) {
      return '$intro ${isArabic ? 'المصدر' : 'Source'}: $source.';
    }

    return '$intro ${isArabic ? 'المصدر' : 'Source'}: $source. ${isArabic ? 'الملاحظة' : 'Note'}: $reason';
  }

  Widget _buildDomainAdvisoryBanner(BuildContext context, bool isArabic) {
    return StreamBuilder<DomainStatus>(
      stream: _domainStatusService.watchDomainStatus(DomainKey.aiPolicy),
      builder: (context, snapshot) {
        final status = snapshot.data;
        if (status == null || status.status == 'active' || status.isUnknown) {
          return const SizedBox.shrink();
        }

        return DomainAdvisoryBanner(
          status: status,
          domainDisplayName: 'AI Policy',
          title: _advisoryTitle(isArabic, status.status),
          body: _advisoryBody(isArabic, status),
          nonBlockingMessage: isArabic
              ? 'هذا تنبيه معلوماتي فقط. Runtime policy الحالية لم تتغير.'
              : 'This is informational only. Policy runtime is unchanged.',
          isArabic: isArabic,
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
        );
      },
    );
  }

  String _stringValue(Map<String, dynamic> data, String key) {
    final value = data[key];
    final text = value?.toString().trim() ?? '';
    return text.isEmpty ? '—' : text;
  }

  int _mapCount(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is Map) return value.length;
    return 0;
  }

  int _listCount(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is List) return value.length;
    return 0;
  }

  Map<String, dynamic> _thresholds(Map<String, dynamic> data) {
    final raw = data['thresholds'];
    if (raw is Map<String, dynamic>) return raw;
    if (raw is Map) return Map<String, dynamic>.from(raw);
    return const <String, dynamic>{};
  }

  Map<String, dynamic> _strategyMap(Map<String, dynamic> data) {
    final raw = data['strategyByRiskLevel'];
    if (raw is Map<String, dynamic>) return raw;
    if (raw is Map) return Map<String, dynamic>.from(raw);
    return const <String, dynamic>{};
  }

  List<String> _stringList(Map<String, dynamic> data, String key) {
    final raw = data[key];
    if (raw is List) {
      return raw.map((item) => item.toString()).toList();
    }
    return const <String>[];
  }

  String _listSummary(List<String> values) {
    if (values.isEmpty) return '[]';
    return values.join(', ');
  }

  String _thresholdValue(Map<String, dynamic> thresholds, String key) {
    return '${thresholds[key] ?? '—'}';
  }

  void _syncDraftEditors(Map<String, dynamic> data) {
    final version = _stringValue(data, 'policyVersion');
    if (_loadedDraftVersion == version) return;

    _loadedDraftVersion = version;
    _draftNotesController.text = _stringValue(data, 'notes') == '—'
        ? ''
        : _stringValue(data, 'notes');

    final templatesRaw = data['responseTemplates'];
    final templates = templatesRaw is Map
        ? Map<String, dynamic>.from(templatesRaw)
        : const <String, dynamic>{};

    for (final entry in _draftTemplateControllers.entries) {
      final value = templates[entry.key]?.toString() ?? '';
      entry.value.text = value;
    }
  }

  Future<void> _saveDraftPolicy(BuildContext context, bool isArabic) async {
    setState(() {
      _savingDraft = true;
    });

    try {
      final responseTemplates = <String, String>{};
      for (final entry in _draftTemplateControllers.entries) {
        responseTemplates[entry.key] = entry.value.text.trim();
      }

      await FirebaseFirestore.instance
          .collection('ai_policies')
          .doc('draft')
          .set({
        'notes': _draftNotesController.text.trim(),
        'responseTemplates': responseTemplates,
        'updatedAt': FieldValue.serverTimestamp(),
        'updatedBy': 'admin_ui',
      }, SetOptions(merge: true));

      await _emitAiPolicyHealth();

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم حفظ مسودة السياسة بنجاح'
                : 'Draft policy saved successfully',
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'فشل حفظ مسودة السياسة: $e'
                : 'Failed to save draft policy: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _savingDraft = false;
        });
      }
    }
  }

  Future<bool> _confirmPublishDraft(BuildContext context, bool isArabic) async {
    _publishNoteController.text = '';
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            isArabic ? 'نشر المسودة' : 'Publish Draft',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
          content: Text(
            isArabic
                ? 'سيتم نسخ القيم الإدارية الحالية من المسودة إلى الوثيقة المنشورة. هذا لا يغيّر runtime الشات الحية.'
                : 'This will copy the current admin-managed draft values into the published document. It does not change the live chatbot runtime.',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          scrollable: true,
          actionsOverflowAlignment: OverflowBarAlignment.end,
          contentTextStyle: Theme.of(dialogContext).textTheme.bodyMedium,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: TextField(
                controller: _publishNoteController,
                minLines: 2,
                maxLines: 4,
                textDirection:
                    isArabic ? TextDirection.rtl : TextDirection.ltr,
                decoration: InputDecoration(
                  labelText: isArabic ? 'ملاحظة النشر' : 'Publish note',
                  hintText: isArabic
                      ? 'اكتب سبب النشر أو ملخص التغيير'
                      : 'Add a short reason or release note',
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(isArabic ? 'إلغاء' : 'Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(isArabic ? 'نشر' : 'Publish'),
            ),
          ],
        );
      },
    );

    return result == true;
  }

  Future<void> _publishDraftPolicy(BuildContext context, bool isArabic) async {
    final confirmed = await _confirmPublishDraft(context, isArabic);
    if (!confirmed) return;

    setState(() {
      _publishingDraft = true;
    });

    try {
      final draftSnapshot = await FirebaseFirestore.instance
          .collection('ai_policies')
          .doc('draft')
          .get();

      final draftData = draftSnapshot.data();
      if (!draftSnapshot.exists || draftData == null) {
        throw Exception(
          isArabic ? 'وثيقة المسودة غير موجودة' : 'Draft document is missing',
        );
      }

      final responseTemplatesRaw = draftData['responseTemplates'];
      final responseTemplates = responseTemplatesRaw is Map
          ? Map<String, dynamic>.from(responseTemplatesRaw)
          : <String, dynamic>{};

      final draftVersion = _stringValue(draftData, 'policyVersion');

      await FirebaseFirestore.instance
          .collection('ai_policies')
          .doc('published')
          .set({
        'responseTemplates': responseTemplates,
        'notes': _stringValue(draftData, 'notes') == '—'
            ? ''
            : _stringValue(draftData, 'notes'),
        'status': 'published',
        'basedOnVersion': draftVersion,
        'updatedAt': FieldValue.serverTimestamp(),
        'updatedBy': 'admin_ui_publish',
        'publishedAt': FieldValue.serverTimestamp(),
        'publishedBy': 'admin_ui_publish',
        'publishNote': _publishNoteController.text.trim(),
        'lastPublishedFromVersion': draftVersion,
      }, SetOptions(merge: true));

      await _emitAiPolicyHealth();

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم نشر المسودة إلى الوثيقة المنشورة بنجاح'
                : 'Draft published to the published document successfully',
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'فشل نشر المسودة: $e'
                : 'Failed to publish draft: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _publishingDraft = false;
        });
      }
    }
  }

  Widget _buildDocumentLoadingState(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.lg),
        const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  Widget _buildDocumentErrorState(
    BuildContext context,
    bool isArabic,
    String title,
    Object? error,
  ) {
    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        Text(
          isArabic
              ? 'تعذر تحميل وثيقة السياسة'
              : 'Unable to load policy document',
        ),
        if (error != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            error.toString(),
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.obsidian.withValues(alpha: 0.72),
                ),
          ),
        ],
      ],
    );
  }

  Widget _buildDocumentEmptyState(
    BuildContext context,
    bool isArabic,
    String title,
  ) {
    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        Text(
          isArabic ? 'لا توجد وثيقة بعد' : 'No document yet',
        ),
      ],
    );
  }

  Widget _buildMetaChip(String label, String value, Color color) {
    return AppStatusBadge(
      label: '$label: $value',
      color: color,
    );
  }

  Widget _buildDraftEditingSection(BuildContext context, bool isArabic) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F0FF),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: AppColors.accentLavender.withValues(alpha: 0.32),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'Editing Draft Only' : 'Editing Draft Only',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isArabic
                ? 'يمكن تعديل الملاحظات وقوالب الرد في المسودة فقط. المستند المنشور والحقول الحساسة تظل للقراءة فقط.'
                : 'Only draft notes and response templates can be edited here. The published document and safety-critical fields remain read-only.',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _draftNotesController,
            minLines: 2,
            maxLines: 4,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            decoration: InputDecoration(
              labelText: isArabic ? 'ملاحظات المسودة' : 'Draft notes',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ..._draftTemplateControllers.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: TextField(
                controller: entry.value,
                minLines: 2,
                maxLines: 5,
                textDirection:
                    isArabic ? TextDirection.rtl : TextDirection.ltr,
                decoration: InputDecoration(
                  labelText: 'responseTemplates.${entry.key}',
                ),
              ),
            ),
          ),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            alignment: WrapAlignment.end,
            children: [
              FilledButton.icon(
                onPressed: _savingDraft
                    ? null
                    : () => _saveDraftPolicy(context, isArabic),
                icon: _savingDraft
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save_outlined),
                label: Text(isArabic ? 'حفظ المسودة' : 'Save Draft'),
              ),
              OutlinedButton.icon(
                onPressed: _publishingDraft
                    ? null
                    : () => _publishDraftPolicy(context, isArabic),
                icon: _publishingDraft
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.publish_outlined),
                label: Text(isArabic ? 'نشر المسودة' : 'Publish Draft'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestConsoleCard(BuildContext context, bool isArabic) {
    final result = _testResult;

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic ? 'وحدة اختبار محلية' : 'Local Test Console',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isArabic
                ? 'تستخدم هذه الوحدة نفس محرك الذكاء الاصطناعي المحلي الحالي، بدون حفظ وبدون ربط مع محادثات حية.'
                : 'This console uses the current local AI runtime only, with no saving and no connection to live chat threads.',
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _testMessageController,
            minLines: 4,
            maxLines: 8,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            decoration: InputDecoration(
              hintText: isArabic
                  ? 'اكتب رسالة تجريبية لتحليلها محليًا...'
                  : 'Enter a sample message to evaluate locally...',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Align(
            alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
            child: FilledButton.icon(
              onPressed: _runTestConsole,
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(isArabic ? 'تشغيل الاختبار' : 'Run Test'),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (result == null)
            Text(
              isArabic
                  ? 'أدخل رسالة ثم شغّل الاختبار لعرض النتيجة.'
                  : 'Enter a message and run the test to inspect the result.',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
            )
          else ...[
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                _buildMetaChip(
                  isArabic ? 'الدور' : 'Role',
                  result.roleDetected,
                  AppColors.deepTeal,
                ),
                _buildMetaChip(
                  isArabic ? 'الخطر' : 'Risk level',
                  result.riskLevel,
                  AppColors.info,
                ),
                _buildMetaChip(
                  isArabic ? 'الاستراتيجية' : 'Strategy',
                  result.strategyMode,
                  AppColors.accentLavender,
                ),
                _buildMetaChip(
                  isArabic ? 'الإصدار' : 'Policy',
                  result.policyVersion,
                  AppColors.mist,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _KeyValueBlock(
              title: isArabic ? 'Analysis Result' : 'Analysis Result',
              entries: [
                MapEntry(
                  isArabic ? 'Detected role' : 'Detected role',
                  result.roleDetected,
                ),
                MapEntry(
                  isArabic ? 'Detected states' : 'Detected states',
                  result.statesDetected.isEmpty
                      ? '[]'
                      : result.statesDetected.join(', '),
                ),
                MapEntry(
                  isArabic ? 'Risk score' : 'Risk score',
                  '${result.riskScore}',
                ),
                MapEntry(
                  isArabic ? 'Risk level' : 'Risk level',
                  result.riskLevel,
                ),
                MapEntry(
                  isArabic ? 'Strategy mode' : 'Strategy mode',
                  result.strategyMode,
                ),
                MapEntry(
                  isArabic ? 'Safety triggered' : 'Safety triggered',
                  '${result.safetyTriggered}',
                ),
                MapEntry(
                  isArabic ? 'Needs human support' : 'Needs human support',
                  '${result.needsHumanSupport}',
                ),
                MapEntry(
                  isArabic
                      ? 'Contains escalation signal'
                      : 'Contains escalation signal',
                  '${result.containsEscalationSignal}',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(AppRadii.lg),
                border: Border.all(
                  color: AppColors.mist.withValues(alpha: 0.55),
                ),
              ),
              child: Column(
                crossAxisAlignment: isArabic
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? 'Response Preview' : 'Response Preview',
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    result.responseText,
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPolicyDocumentCard({
    required BuildContext context,
    required bool isArabic,
    required String title,
    required String documentId,
    required Color accent,
  }) {
    final isDraft = documentId == 'draft';
    final stream = FirebaseFirestore.instance
        .collection('ai_policies')
        .doc(documentId)
        .snapshots();

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return _buildDocumentLoadingState(context, title);
          }

          if (snapshot.hasError) {
            return _buildDocumentErrorState(
              context,
              isArabic,
              title,
              snapshot.error,
            );
          }

          if (!snapshot.hasData) {
            return _buildDocumentEmptyState(
              context,
              isArabic,
              title,
            );
          }

          final doc = snapshot.data!;
          final data = doc.data();

          if (!doc.exists || data == null) {
            return _buildDocumentEmptyState(
              context,
              isArabic,
              title,
            );
          }

          final thresholds = _thresholds(data);
          final strategyMap = _strategyMap(data);
          if (isDraft) {
            _syncDraftEditors(data);
          }
          final publishNote = _stringValue(data, 'publishNote');
          final publishedBy = _stringValue(data, 'publishedBy');
          final lastPublishedFromVersion =
              _stringValue(data, 'lastPublishedFromVersion');

          return Column(
            crossAxisAlignment:
                isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  AppStatusBadge(
                    label: _stringValue(data, 'status'),
                    color: accent,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                alignment: WrapAlignment.end,
                children: [
                  _buildMetaChip(
                    isArabic ? 'الإصدار' : 'Version',
                    _stringValue(data, 'policyVersion'),
                    AppColors.deepTeal,
                  ),
                  _buildMetaChip(
                    isArabic ? 'مبني على' : 'Based on',
                    _stringValue(data, 'basedOnVersion'),
                    AppColors.info,
                  ),
                  _buildMetaChip(
                    isArabic ? 'آخر تحديث' : 'Updated by',
                    _stringValue(data, 'updatedBy'),
                    AppColors.mist,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${isArabic ? 'وقت التحديث' : 'Updated at'}: ${_timestampText(data['updatedAt'])}',
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${isArabic ? 'ملاحظات' : 'Notes'}: ${_stringValue(data, 'notes')}',
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (!isDraft) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${isArabic ? 'نُشرت بواسطة' : 'Published by'}: $publishedBy',
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${isArabic ? 'وقت النشر' : 'Published at'}: ${_timestampText(data['publishedAt'])}',
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${isArabic ? 'آخر نشر من إصدار' : 'Last published from version'}: $lastPublishedFromVersion',
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${isArabic ? 'ملاحظة النشر' : 'Publish note'}: $publishNote',
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              if (isDraft) ...[
                const SizedBox(height: AppSpacing.md),
                _buildDraftEditingSection(context, isArabic),
              ],
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: [
                  _SummaryChip(
                    label: isArabic
                        ? 'مفاتيح القوالب'
                        : 'Response template keys',
                    count: _mapCount(data, 'responseTemplates'),
                  ),
                  _SummaryChip(
                    label: isArabic ? 'حقائب الأدوار' : 'Role phrase packs',
                    count: _mapCount(data, 'rolePhrasePacks'),
                  ),
                  _SummaryChip(
                    label: isArabic ? 'حقائب الحالات' : 'State phrase packs',
                    count: _mapCount(data, 'statePhrasePacks'),
                  ),
                  _SummaryChip(
                    label: isArabic ? 'العتبات' : 'Threshold keys',
                    count: thresholds.length,
                  ),
                  _SummaryChip(
                    label: isArabic ? 'الاستراتيجيات' : 'Strategy rules',
                    count: strategyMap.length,
                  ),
                  _SummaryChip(
                    label: isArabic
                        ? 'مستويات التصعيد البشري'
                        : 'Human-support levels',
                    count: _listCount(data, 'needsHumanSupportLevels'),
                  ),
                  _SummaryChip(
                    label: isArabic
                        ? 'إشارات التصعيد'
                        : 'Escalation-signal levels',
                    count: _listCount(data, 'containsEscalationSignalLevels'),
                  ),
                  _SummaryChip(
                    label: isArabic ? 'مستويات الأمان' : 'Safety levels',
                    count: _listCount(data, 'safetyTriggeredLevels'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _KeyValueBlock(
                title: isArabic ? 'Thresholds / Weights' : 'Thresholds / Weights',
                entries: [
                  MapEntry(
                    'mediumRiskThreshold',
                    '${thresholds['mediumRiskThreshold'] ?? '—'}',
                  ),
                  MapEntry(
                    'highRiskThreshold',
                    '${thresholds['highRiskThreshold'] ?? '—'}',
                  ),
                  MapEntry(
                    'criticalRiskThreshold',
                    '${thresholds['criticalRiskThreshold'] ?? '—'}',
                  ),
                  MapEntry(
                    'lossOfControlScore',
                    '${data['lossOfControlScore'] ?? '—'}',
                  ),
                  MapEntry(
                    'explicitSelfHarmScore',
                    '${data['explicitSelfHarmScore'] ?? '—'}',
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _KeyValueBlock(
                title: isArabic ? 'Strategy Mapping' : 'Strategy Mapping',
                entries: strategyMap.entries
                    .map((entry) => MapEntry(entry.key.toString(),
                        entry.value?.toString() ?? '—'))
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildComparisonSection(BuildContext context, bool isArabic) {
    final draftStream = FirebaseFirestore.instance
        .collection('ai_policies')
        .doc('draft')
        .snapshots();
    final publishedStream = FirebaseFirestore.instance
        .collection('ai_policies')
        .doc('published')
        .snapshots();

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: draftStream,
        builder: (context, draftSnapshot) {
          if (draftSnapshot.connectionState == ConnectionState.waiting &&
              !draftSnapshot.hasData) {
            return _buildDocumentLoadingState(
              context,
              isArabic
                  ? 'مقارنة المسودة والمنشور'
                  : 'Draft vs Published Comparison',
            );
          }

          if (draftSnapshot.hasError) {
            return _buildDocumentErrorState(
              context,
              isArabic,
              isArabic
                  ? 'مقارنة المسودة والمنشور'
                  : 'Draft vs Published Comparison',
              draftSnapshot.error,
            );
          }

          return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: publishedStream,
            builder: (context, publishedSnapshot) {
              if (publishedSnapshot.connectionState == ConnectionState.waiting &&
                  !publishedSnapshot.hasData) {
                return _buildDocumentLoadingState(
                  context,
                  isArabic
                      ? 'مقارنة المسودة والمنشور'
                      : 'Draft vs Published Comparison',
                );
              }

              if (publishedSnapshot.hasError) {
                return _buildDocumentErrorState(
                  context,
                  isArabic,
                  isArabic
                      ? 'مقارنة المسودة والمنشور'
                      : 'Draft vs Published Comparison',
                  publishedSnapshot.error,
                );
              }

              if (!draftSnapshot.hasData ||
                  !publishedSnapshot.hasData ||
                  !draftSnapshot.data!.exists ||
                  !publishedSnapshot.data!.exists ||
                  draftSnapshot.data!.data() == null ||
                  publishedSnapshot.data!.data() == null) {
                return _buildDocumentEmptyState(
                  context,
                  isArabic,
                  isArabic
                      ? 'مقارنة المسودة والمنشور'
                      : 'Draft vs Published Comparison',
                );
              }

              final draft = draftSnapshot.data!.data()!;
              final published = publishedSnapshot.data!.data()!;
              final draftThresholds = _thresholds(draft);
              final publishedThresholds = _thresholds(published);
              final draftStrategy = _strategyMap(draft);
              final publishedStrategy = _strategyMap(published);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic
                        ? 'مقارنة المسودة والمنشور'
                        : 'Draft vs Published Comparison',
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    isArabic
                        ? 'عرض مقارن read-only بين القيم الحالية في draft و published.'
                        : 'Read-only comparison of the current draft and published values.',
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _ComparisonTable(
                    title: isArabic ? 'Thresholds' : 'Thresholds',
                    rows: [
                      _ComparisonRowData(
                        label: 'mediumRiskThreshold',
                        draftValue:
                            _thresholdValue(draftThresholds, 'mediumRiskThreshold'),
                        publishedValue: _thresholdValue(
                          publishedThresholds,
                          'mediumRiskThreshold',
                        ),
                      ),
                      _ComparisonRowData(
                        label: 'highRiskThreshold',
                        draftValue:
                            _thresholdValue(draftThresholds, 'highRiskThreshold'),
                        publishedValue: _thresholdValue(
                          publishedThresholds,
                          'highRiskThreshold',
                        ),
                      ),
                      _ComparisonRowData(
                        label: 'criticalRiskThreshold',
                        draftValue: _thresholdValue(
                          draftThresholds,
                          'criticalRiskThreshold',
                        ),
                        publishedValue: _thresholdValue(
                          publishedThresholds,
                          'criticalRiskThreshold',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _ComparisonTable(
                    title: isArabic ? 'Strategy Mapping' : 'Strategy Mapping',
                    rows: [
                      _ComparisonRowData(
                        label: 'low',
                        draftValue: '${draftStrategy['low'] ?? '—'}',
                        publishedValue: '${publishedStrategy['low'] ?? '—'}',
                      ),
                      _ComparisonRowData(
                        label: 'medium',
                        draftValue: '${draftStrategy['medium'] ?? '—'}',
                        publishedValue:
                            '${publishedStrategy['medium'] ?? '—'}',
                      ),
                      _ComparisonRowData(
                        label: 'high',
                        draftValue: '${draftStrategy['high'] ?? '—'}',
                        publishedValue: '${publishedStrategy['high'] ?? '—'}',
                      ),
                      _ComparisonRowData(
                        label: 'critical',
                        draftValue: '${draftStrategy['critical'] ?? '—'}',
                        publishedValue:
                            '${publishedStrategy['critical'] ?? '—'}',
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _ComparisonTable(
                    title: isArabic ? 'Escalation Flags' : 'Escalation Flags',
                    rows: [
                      _ComparisonRowData(
                        label: 'needsHumanSupportLevels',
                        draftValue:
                            _listSummary(_stringList(draft, 'needsHumanSupportLevels')),
                        publishedValue: _listSummary(
                          _stringList(published, 'needsHumanSupportLevels'),
                        ),
                      ),
                      _ComparisonRowData(
                        label: 'containsEscalationSignalLevels',
                        draftValue: _listSummary(
                          _stringList(draft, 'containsEscalationSignalLevels'),
                        ),
                        publishedValue: _listSummary(
                          _stringList(
                            published,
                            'containsEscalationSignalLevels',
                          ),
                        ),
                      ),
                      _ComparisonRowData(
                        label: 'safetyTriggeredLevels',
                        draftValue:
                            _listSummary(_stringList(draft, 'safetyTriggeredLevels')),
                        publishedValue: _listSummary(
                          _stringList(published, 'safetyTriggeredLevels'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _ComparisonTable(
                    title: isArabic
                        ? 'Phrase Pack Summaries'
                        : 'Phrase Pack Summaries',
                    rows: [
                      _ComparisonRowData(
                        label: 'rolePhrasePacks',
                        draftValue: '${_mapCount(draft, 'rolePhrasePacks')}',
                        publishedValue:
                            '${_mapCount(published, 'rolePhrasePacks')}',
                      ),
                      _ComparisonRowData(
                        label: 'statePhrasePacks',
                        draftValue: '${_mapCount(draft, 'statePhrasePacks')}',
                        publishedValue:
                            '${_mapCount(published, 'statePhrasePacks')}',
                      ),
                      _ComparisonRowData(
                        label: 'lossOfControlPhrases',
                        draftValue: '${_listCount(draft, 'lossOfControlPhrases')}',
                        publishedValue:
                            '${_listCount(published, 'lossOfControlPhrases')}',
                      ),
                      _ComparisonRowData(
                        label: 'selfHarmPhrases',
                        draftValue: '${_listCount(draft, 'selfHarmPhrases')}',
                        publishedValue:
                            '${_listCount(published, 'selfHarmPhrases')}',
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'سياسات الذكاء الاصطناعي' : 'AI Policies',
          canLogout: false,
        ),
        body: AppPageBackground(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              _buildDomainAdvisoryBanner(context, isArabic),
              AppSurfaceCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic
                          ? 'لوحة فحص سياسات الذكاء الاصطناعي'
                          : 'AI Policy Inspection Panel',
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      isArabic
                          ? 'هذه الصفحة للعرض فقط. يتم هنا فحص نسختي draft و published بدون أي تعديل أو ربط مباشر بسلوك الشات الحي.'
                          : 'This page is read-only. It inspects the draft and published policy documents without editing or affecting the live chatbot.',
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _buildPolicyDocumentCard(
                context: context,
                isArabic: isArabic,
                title: isArabic ? 'السياسة المنشورة' : 'Published Policy',
                documentId: 'published',
                accent: const Color(0xFF4D7C6A),
              ),
              const SizedBox(height: AppSpacing.md),
              _buildPolicyDocumentCard(
                context: context,
                isArabic: isArabic,
                title: isArabic ? 'مسودة السياسة' : 'Draft Policy',
                documentId: 'draft',
                accent: AppColors.accentLavender,
              ),
              const SizedBox(height: AppSpacing.md),
              _buildComparisonSection(context, isArabic),
              const SizedBox(height: AppSpacing.md),
              _buildTestConsoleCard(context, isArabic),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _testMessageController.dispose();
    _draftNotesController.dispose();
    _publishNoteController.dispose();
    for (final controller in _draftTemplateControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.label,
    required this.count,
  });

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.mist,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: AppColors.info.withValues(alpha: 0.16),
        ),
      ),
      child: Text(
        '$label: $count',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _KeyValueBlock extends StatelessWidget {
  const _KeyValueBlock({
    required this.title,
    required this.entries,
  });

  final String title;
  final List<MapEntry<String, String>> entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: AppColors.mist.withValues(alpha: 0.55),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(
                '${entry.key}: ${entry.value}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonRowData {
  const _ComparisonRowData({
    required this.label,
    required this.draftValue,
    required this.publishedValue,
  });

  final String label;
  final String draftValue;
  final String publishedValue;

  bool get isDifferent => draftValue != publishedValue;
}

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable({
    required this.title,
    required this.rows,
  });

  final String title;
  final List<_ComparisonRowData> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(
          color: AppColors.mist.withValues(alpha: 0.55),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ...rows.map(
            (row) => Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.xs),
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: row.isDifferent
                    ? const Color(0xFFFFF4DD)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      row.label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Draft: ${row.draftValue}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Published: ${row.publishedValue}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  if (row.isDifferent)
                    AppStatusBadge(
                      label: 'Different',
                      color: const Color(0xFFE39B2E),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
