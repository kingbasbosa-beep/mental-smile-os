import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/dev/ai_policy_seeder.dart';
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
  final TextEditingController _testMessageController = TextEditingController();
  final ChatAiService _chatAiService = const ChatAiService();

  ChatAiResult? _testResult;

  bool _isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
  }

  void _runTestConsole() {
    final input = _testMessageController.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _testResult = _chatAiService.processUserMessage(input);
    });
  }

  Future<void> _seedPolicyDebug(BuildContext context, bool isArabic) async {
    try {
      await seedAiPolicyToFirestoreDebug();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تمت زراعة سياسة الذكاء الاصطناعي بنجاح'
                : 'AI policy seeded successfully',
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'فشل زرع سياسة الذكاء الاصطناعي: $e'
                : 'Failed to seed AI policy: $e',
          ),
        ),
      );
    }
  }

  String _timestampText(dynamic value) {
    if (value is Timestamp) {
      return value.toDate().toIso8601String();
    }
    return value?.toString().trim() ?? '—';
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

  Widget _buildMetaChip(String label, String value, Color color) {
    return AppStatusBadge(
      label: '$label: $value',
      color: color,
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
    final stream = FirebaseFirestore.instance
        .collection('ai_policies')
        .doc(documentId)
        .snapshots();

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
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
              ],
            );
          }

          if (!snapshot.hasData) {
            return Column(
              crossAxisAlignment:
                  isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.lg),
                const Center(child: CircularProgressIndicator()),
              ],
            );
          }

          final doc = snapshot.data!;
          final data = doc.data();

          if (!doc.exists || data == null) {
            return Column(
              crossAxisAlignment:
                  isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  isArabic ? 'الوثيقة غير موجودة بعد' : 'Document not seeded yet',
                ),
              ],
            );
          }

          final thresholds = _thresholds(data);
          final strategyMap = _strategyMap(data);

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
                    if (kDebugMode) ...[
                      const SizedBox(height: AppSpacing.md),
                      Align(
                        alignment: isArabic
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: OutlinedButton.icon(
                          onPressed: () => _seedPolicyDebug(context, isArabic),
                          icon: const Icon(Icons.bug_report_outlined),
                          label: Text(
                            isArabic
                                ? 'زرع سياسة الذكاء الاصطناعي (Debug)'
                                : 'Seed AI Policy (Debug)',
                          ),
                        ),
                      ),
                    ],
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
