import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterprojects/features/assistant/domain/archive_assistant_engine.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

// ADMIN_SURFACE: SAFE_UI
class AdminArchiveReportsPage extends StatefulWidget {
  const AdminArchiveReportsPage({super.key});

  @override
  State<AdminArchiveReportsPage> createState() =>
      _AdminArchiveReportsPageState();
}

class _AdminArchiveReportsPageState extends State<AdminArchiveReportsPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _assistantPromptController =
      TextEditingController();
  final ArchiveAssistantEngine _assistantEngine =
      const ArchiveAssistantEngine();

  String _sectionFilter = 'all';
  String _statusFilter = 'all';
  String _clientFilter = 'all';
  String _clinicianFilter = 'all';
  String _search = '';
  String _assistantMode = 'summary';
  String _assistantPreset = 'none';

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  List<Map<String, dynamic>> _normalizeDocs(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
    String source,
  ) {
    return docs
        .map((doc) => {
              ...doc.data(),
              '_id': doc.id,
              '_source': source,
            })
        .toList();
  }

  String _dateText(dynamic value) {
    if (value is Timestamp) {
      final d = value.toDate();
      final day = d.day.toString().padLeft(2, '0');
      final month = d.month.toString().padLeft(2, '0');
      final year = d.year.toString();
      final hour = d.hour.toString().padLeft(2, '0');
      final minute = d.minute.toString().padLeft(2, '0');
      return '$hour:$minute  $day-$month-$year';
    }
    if (value is String && value.trim().isNotEmpty) return value;
    return '';
  }

  String _statusLabel(String status, bool isArabic) {
    switch (status) {
      case 'completed_success':
        return isArabic ? 'مكتمل ومغلق' : 'Completed and closed';
      case 'payout_pending':
        return isArabic ? 'بانتظار تحويل المستحق' : 'Payout pending';
      case 'session_completed_pending_reviews':
        return isArabic ? 'بانتظار التقييمات' : 'Pending reviews';
      case 'session_scheduled':
        return isArabic ? 'جلسة مجدولة' : 'Session scheduled';
      case 'session_in_progress':
        return isArabic ? 'جلسة جارية' : 'Session in progress';
      case 'session_setup_pending':
        return isArabic ? 'بانتظار تجهيز الجلسة' : 'Session setup pending';
      default:
        return status.isEmpty ? (isArabic ? 'غير محدد' : 'Unknown') : status;
    }
  }

  String _sectionLabel(String section, bool isArabic) {
    switch (section) {
      case 'sessions':
        return isArabic ? 'جلسات' : 'Sessions';
      case 'payments':
        return isArabic ? 'مدفوعات' : 'Payments';
      default:
        return section.isEmpty ? (isArabic ? 'غير محدد' : 'Unknown') : section;
    }
  }

  String _assistantPromptHint(bool isArabic) {
    return isArabic
        ? 'مثال: اعمل تقرير شهري أو تحليل أداء الأخصائيين'
        : 'Example: create a monthly report or analyze clinician performance';
  }

  String _resolveAssistantPrompt(String raw) {
    return _assistantEngine.resolveCommand(raw);
  }

  void _runAssistantPrompt(BuildContext context) {
    final isArabic = _isArabic(context);
    final resolved = _resolveAssistantPrompt(_assistantPromptController.text);

    if (resolved == 'none') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'الأمر غير مدعوم حاليًا. استخدم أمرًا مثل: تقرير شهري، مقارنة الأقسام، أداء الأخصائيين، عمليات المراكز، أو كشف محاسبي.'
                : 'This command is not supported yet. Try: monthly report, section compare, clinician performance, center operations, or accounting sheet.',
          ),
        ),
      );
      return;
    }

    setState(() {
      switch (resolved) {
        case 'monthly':
        case 'section_compare':
        case 'clinician_performance':
        case 'center_ops':
          _assistantPreset = resolved;
          break;
        case 'accounting':
        case 'stats':
        case 'analysis':
        case 'summary':
          _assistantPreset = 'none';
          _assistantMode = resolved;
          break;
      }
    });
  }

  Future<void> _copyText(
    BuildContext context,
    String text, {
    required String successAr,
    required String successEn,
  }) async {
    if (text.trim().isEmpty) return;
    final isArabic = _isArabic(context);
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    messenger.showSnackBar(
      SnackBar(content: Text(isArabic ? successAr : successEn)),
    );
  }

  Future<List<Map<String, dynamic>>> _loadSessionRatings(
      String requestId) async {
    final query = await FirebaseFirestore.instance
        .collection('sessionRatings')
        .where('requestId', isEqualTo: requestId)
        .get();

    final items = query.docs
        .map((doc) => {
              '_id': doc.id,
              ...doc.data(),
            })
        .toList();

    items.sort((a, b) {
      final aTs = a['createdAt'];
      final bTs = b['createdAt'];
      DateTime ad = DateTime.fromMillisecondsSinceEpoch(0);
      DateTime bd = DateTime.fromMillisecondsSinceEpoch(0);
      if (aTs is Timestamp) ad = aTs.toDate();
      if (bTs is Timestamp) bd = bTs.toDate();
      return bd.compareTo(ad);
    });

    return items;
  }

  bool _matchesSearch(Map<String, dynamic> item) {
    if (_search.trim().isEmpty) return true;

    final haystack = [
      (item['_id'] ?? '').toString(),
      (item['clientName'] ?? '').toString(),
      (item['clientEmail'] ?? '').toString(),
      (item['clientId'] ?? '').toString(),
      (item['assignedClinicianName'] ?? item['clinicianName'] ?? '').toString(),
      (item['assignedClinicianId'] ?? item['clinicianId'] ?? '').toString(),
      (item['archiveSection'] ?? '').toString(),
      (item['status'] ?? '').toString(),
      (item['sessionDateText'] ?? '').toString(),
      (item['sessionCode'] ?? '').toString(),
      (item['paymentReceiptFileName'] ?? '').toString(),
    ].join(' ').toLowerCase();

    return haystack.contains(_search.toLowerCase());
  }

  bool _matchesFilters(Map<String, dynamic> item) {
    final section = (item['archiveSection'] ?? '').toString().trim();
    final status = (item['status'] ?? '').toString().trim();
    final clientName = (item['clientName'] ?? '').toString().trim();
    final clinicianName =
        (item['assignedClinicianName'] ?? item['clinicianName'] ?? '')
            .toString()
            .trim();

    if (_sectionFilter != 'all' && section != _sectionFilter) return false;
    if (_statusFilter != 'all' && status != _statusFilter) return false;
    if (_clientFilter != 'all' && clientName != _clientFilter) return false;
    if (_clinicianFilter != 'all' && clinicianName != _clinicianFilter) {
      return false;
    }

    return _matchesSearch(item);
  }

  Widget _infoRow(BuildContext context, String title, String value) {
    final isArabic = _isArabic(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              value.isEmpty ? '-' : value,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    final isArabic = _isArabic(context);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _assistantOutput(
    BuildContext context,
    List<Map<String, dynamic>> filtered,
  ) {
    final result = _assistantEngine.run(
      items: filtered,
      mode: _assistantMode,
      preset: _assistantPreset,
      isArabic: _isArabic(context),
    );
    final lines = result.lines;
    if (_assistantMode != 'accounting') {
      final output = lines.join('\n');
      final isArabic = _isArabic(context);
      return Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Align(
            alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
            child: OutlinedButton.icon(
              onPressed: () => _copyText(
                context,
                output,
                successAr: 'تم نسخ المخرج الحالي',
                successEn: 'Current output copied',
              ),
              icon: const Icon(Icons.copy_all_outlined),
              label: Text(isArabic ? 'نسخ المخرج' : 'Copy output'),
            ),
          ),
          const SizedBox(height: 10),
          SelectableText(output),
        ],
      );
    }

    final isArabic = _isArabic(context);
    final rows = result.accountingRows;
    final csv = result.accountingCsv;
    final summaryText = lines.join('\n');

    return Column(
      crossAxisAlignment:
          isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            OutlinedButton.icon(
              onPressed: () => _copyText(
                context,
                summaryText,
                successAr: 'تم نسخ الملخص المحاسبي',
                successEn: 'Accounting summary copied',
              ),
              icon: const Icon(Icons.copy_all_outlined),
              label: Text(isArabic ? 'نسخ الملخص' : 'Copy summary'),
            ),
            OutlinedButton.icon(
              onPressed: () => _copyText(
                context,
                csv,
                successAr: 'تم نسخ CSV المحاسبي',
                successEn: 'Accounting CSV copied',
              ),
              icon: const Icon(Icons.table_view_outlined),
              label: Text(isArabic ? 'نسخ CSV' : 'Copy CSV'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SelectableText(lines.take(2).join('\n')),
        const SizedBox(height: 12),
        if (rows.isEmpty)
          Text(
            isArabic
                ? 'لا توجد صفوف محاسبية داخل الفلتر الحالي.'
                : 'No accounting rows in the current filter.',
          )
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text(isArabic ? 'ID' : 'ID')),
                DataColumn(
                  label: Text(isArabic ? 'معرف العميل' : 'Client ID'),
                ),
                DataColumn(
                  label: Text(isArabic ? 'معرف الأخصائي' : 'Clinician ID'),
                ),
                DataColumn(
                  label: Text(isArabic ? 'حالة السداد' : 'Payment Status'),
                ),
                DataColumn(
                  label: Text(isArabic ? 'حالة التحويل' : 'Payout Status'),
                ),
                DataColumn(
                  label: Text(isArabic ? 'مرجع الإثبات' : 'Receipt Ref'),
                ),
                DataColumn(
                  label: Text(isArabic ? 'اعتماد السداد' : 'Approved At'),
                ),
                DataColumn(
                  label: Text(
                    isArabic ? 'تحويل المستحق' : 'Payout Transferred',
                  ),
                ),
              ],
              rows: rows
                  .map(
                    (row) => DataRow(
                      cells: [
                        DataCell(Text(row['id'] ?? '')),
                        DataCell(Text(row['clientId'] ?? '')),
                        DataCell(Text(row['clinicianId'] ?? '')),
                        DataCell(Text(row['paymentStatus'] ?? '')),
                        DataCell(Text(row['payoutStatus'] ?? '')),
                        DataCell(Text(row['receiptRef'] ?? '')),
                        DataCell(Text(row['paymentApprovedAt'] ?? '')),
                        DataCell(Text(row['payoutTransferredAt'] ?? '')),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        const SizedBox(height: 14),
        Text(
          isArabic ? 'مخرج CSV-ready' : 'CSV-ready output',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        SelectableText(csv),
      ],
    );
  }

  Widget _assistantPanel(
      BuildContext context, List<Map<String, dynamic>> filtered) {
    final isArabic = _isArabic(context);
    final titleStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(fontWeight: FontWeight.w800);
    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFFE7F0FF),
                child: Icon(
                  Icons.smart_toy_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic ? 'المساعد الذكي للأرشيف' : 'Archive Assistant',
                      style: titleStyle,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isArabic
                          ? 'نسخة محصورة بالأرشيف فقط: تلخيص، إحصائيات، تحليل، وكشف محاسبي من النتائج المفلترة الحالية.'
                          : 'Archive-scoped assistant only: summary, stats, analysis, and accounting output from the current filtered results.',
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ChoiceChip(
                selected: _assistantMode == 'summary',
                label: Text(isArabic ? 'ملخص' : 'Summary'),
                onSelected: (_) => setState(() {
                  _assistantMode = 'summary';
                  _assistantPreset = 'none';
                }),
              ),
              ChoiceChip(
                selected: _assistantMode == 'stats',
                label: Text(isArabic ? 'إحصائيات' : 'Stats'),
                onSelected: (_) => setState(() {
                  _assistantMode = 'stats';
                  _assistantPreset = 'none';
                }),
              ),
              ChoiceChip(
                selected: _assistantMode == 'analysis',
                label: Text(isArabic ? 'تحليل' : 'Analysis'),
                onSelected: (_) => setState(() {
                  _assistantMode = 'analysis';
                  _assistantPreset = 'none';
                }),
              ),
              ChoiceChip(
                selected: _assistantMode == 'accounting',
                label: Text(isArabic ? 'كشف محاسبي' : 'Accounting sheet'),
                onSelected: (_) => setState(() {
                  _assistantMode = 'accounting';
                  _assistantPreset = 'none';
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.10),
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? 'أمر سريع للمساعد' : 'Quick assistant command',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _assistantPromptController,
                  onSubmitted: (_) => _runAssistantPrompt(context),
                  decoration: appInputDecoration(
                    context: context,
                    label: isArabic
                        ? 'أدخل أمرًا للمساعد'
                        : 'Enter assistant command',
                    icon: Icons.smart_toy_outlined,
                    hintText: _assistantPromptHint(isArabic),
                  ).copyWith(
                    suffixIcon: IconButton(
                      onPressed: () => _runAssistantPrompt(context),
                      icon: const Icon(Icons.send_outlined),
                      tooltip: isArabic ? 'تشغيل' : 'Run',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ActionChip(
                      avatar:
                          const Icon(Icons.calendar_month_outlined, size: 16),
                      label: Text(isArabic ? 'تقرير شهري' : 'Monthly report'),
                      onPressed: () => setState(
                        () => _assistantPromptController.text = isArabic
                            ? 'اعمل تقرير شهري'
                            : 'create a monthly report',
                      ),
                    ),
                    ActionChip(
                      avatar: const Icon(Icons.insights_outlined, size: 16),
                      label: Text(
                        isArabic
                            ? 'تحليل أداء الأخصائيين'
                            : 'Analyze clinicians',
                      ),
                      onPressed: () => setState(
                        () => _assistantPromptController.text = isArabic
                            ? 'حلل أداء الأخصائيين'
                            : 'analyze clinician performance',
                      ),
                    ),
                    ActionChip(
                      avatar: const Icon(Icons.table_view_outlined, size: 16),
                      label: Text(isArabic ? 'كشف محاسبي' : 'Accounting sheet'),
                      onPressed: () => setState(
                        () => _assistantPromptController.text = isArabic
                            ? 'اعمل كشف محاسبي'
                            : 'create an accounting sheet',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isArabic ? 'أوامر جاهزة' : 'Quick commands',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ActionChip(
                avatar: const Icon(Icons.calendar_month_outlined, size: 18),
                label: Text(isArabic ? 'تقرير شهري' : 'Monthly report'),
                onPressed: () => setState(() => _assistantPreset = 'monthly'),
              ),
              ActionChip(
                avatar: const Icon(Icons.compare_arrows_outlined, size: 18),
                label: Text(isArabic ? 'مقارنة الأقسام' : 'Section compare'),
                onPressed: () => setState(
                  () => _assistantPreset = 'section_compare',
                ),
              ),
              ActionChip(
                avatar: const Icon(Icons.medical_services_outlined, size: 18),
                label: Text(
                  isArabic ? 'أداء الأخصائيين' : 'Clinician performance',
                ),
                onPressed: () => setState(
                  () => _assistantPreset = 'clinician_performance',
                ),
              ),
              ActionChip(
                avatar: const Icon(Icons.apartment_outlined, size: 18),
                label: Text(isArabic ? 'عمليات المراكز' : 'Center operations'),
                onPressed: () =>
                    setState(() => _assistantPreset = 'center_ops'),
              ),
              if (_assistantPreset != 'none')
                ActionChip(
                  avatar: const Icon(Icons.close_outlined, size: 18),
                  label: Text(isArabic ? 'مسح الأمر' : 'Clear command'),
                  onPressed: () => setState(() => _assistantPreset = 'none'),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8FA),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.10),
              ),
            ),
            child: _assistantOutput(context, filtered),
          ),
        ],
      ),
    );
  }

  List<String> _fullReportLines(
    BuildContext context,
    Map<String, dynamic> data,
    List<Map<String, dynamic>> ratings,
  ) {
    final isArabic = _isArabic(context);
    final isCenterRequest =
        (data['requestKind'] ?? '').toString().trim() == 'center';
    final lines = <String>[
      isArabic ? 'التقرير الإداري الموحد' : 'Unified Admin Report',
      '----------------------------------------',
      'ID: ${(data['_id'] ?? '').toString()}',
      if ((data['clientName'] ?? '').toString().trim().isNotEmpty)
        '${isArabic ? 'العميل' : 'Client'}: ${(data['clientName'] ?? '').toString()}',
      if ((data['clientEmail'] ?? '').toString().trim().isNotEmpty)
        '${isArabic ? 'بريد العميل' : 'Client email'}: ${(data['clientEmail'] ?? '').toString()}',
      if ((data['assignedClinicianName'] ?? data['clinicianName'] ?? '')
          .toString()
          .trim()
          .isNotEmpty)
        '${isArabic ? (isCenterRequest ? 'المركز' : 'الأخصائي') : (isCenterRequest ? 'Center' : 'Clinician')}: ${((isCenterRequest ? (data['centerName'] ?? '') : (data['assignedClinicianName'] ?? data['clinicianName'])) ?? '').toString()}',
      '${isArabic ? 'القسم' : 'Section'}: ${_sectionLabel((data['archiveSection'] ?? '').toString(), isArabic)}',
      '${isArabic ? 'الحالة' : 'Status'}: ${_statusLabel((data['status'] ?? '').toString(), isArabic)}',
      if ((data['paymentReceiptFileName'] ?? '').toString().trim().isNotEmpty)
        '${isArabic ? 'مرجع إثبات السداد' : 'Payment proof reference'}: ${(data['paymentReceiptFileName'] ?? '').toString()}',
      if ((data['paymentClientNote'] ?? '').toString().trim().isNotEmpty)
        '${isArabic ? 'ملاحظة الدفع' : 'Payment note'}: ${(data['paymentClientNote'] ?? '').toString()}',
      if ((data['sessionDateText'] ?? '').toString().trim().isNotEmpty)
        '${isArabic ? (isCenterRequest ? 'موعد بداية الإقامة' : 'موعد الجلسة') : (isCenterRequest ? 'Residency start' : 'Session date')}: ${(data['sessionDateText'] ?? '').toString()}',
      if ((data['sessionCode'] ?? '').toString().trim().isNotEmpty)
        '${isArabic ? (isCenterRequest ? 'كود الإقامة' : 'كود الجلسة') : (isCenterRequest ? 'Residency code' : 'Session code')}: ${(data['sessionCode'] ?? '').toString()}',
      if ((data['sessionLink'] ?? '').toString().trim().isNotEmpty)
        '${isArabic ? (isCenterRequest ? 'رابط المتابعة' : 'رابط الجلسة') : (isCenterRequest ? 'Follow-up link' : 'Session link')}: ${(data['sessionLink'] ?? '').toString()}',
      if (_dateText(data['archivedAt']).isNotEmpty)
        '${isArabic ? 'تاريخ الأرشفة' : 'Archived at'}: ${_dateText(data['archivedAt'])}',
      if (ratings.isNotEmpty) '',
      if (ratings.isNotEmpty)
        (isArabic ? 'التقييمات المحفوظة:' : 'Saved ratings:'),
      ...ratings.map((rating) {
        final reviewerType = (rating['reviewerType'] ?? '').toString();
        final percentage = ((rating['percentageScore'] ?? 0) as num)
            .toDouble()
            .toStringAsFixed(1);
        final label = reviewerType == 'clinician'
            ? (isArabic ? 'تقييم الأخصائي' : 'Clinician review')
            : reviewerType == 'center'
                ? (isArabic ? 'تقرير خروج المركز' : 'Center discharge report')
                : (isArabic ? 'تقييم العميل' : 'Client review');
        return '$label: $percentage%';
      }),
    ];

    return lines;
  }

  List<String> _financialPrintLines(
      BuildContext context, Map<String, dynamic> data) {
    final isArabic = _isArabic(context);
    final isCenterRequest =
        (data['requestKind'] ?? '').toString().trim() == 'center';
    final id = (data['_id'] ?? '').toString();
    final clientId = (data['clientId'] ?? '').toString();
    final clinicianId = ((isCenterRequest
                ? (data['centerId'] ?? '')
                : (data['assignedClinicianId'] ?? data['clinicianId'])) ??
            '')
        .toString();

    return [
      isArabic ? 'تقرير مالي مختصر' : 'Accounting Summary',
      '----------------------------------------',
      'ID: $id',
      if (clientId.trim().isNotEmpty)
        '${isArabic ? 'معرف العميل' : 'Client ID'}: $clientId',
      if (clinicianId.trim().isNotEmpty)
        '${isArabic ? (isCenterRequest ? 'معرف المركز' : 'معرف الأخصائي') : (isCenterRequest ? 'Center ID' : 'Clinician ID')}: $clinicianId',
      '${isArabic ? 'حالة السداد' : 'Payment status'}: ${(data['paymentStatus'] ?? '').toString()}',
      '${isArabic ? 'حالة التحويل' : 'Payout status'}: ${(data['payoutStatus'] ?? '').toString()}',
      if ((data['paymentReceiptFileName'] ?? '').toString().trim().isNotEmpty)
        '${isArabic ? 'مرجع الإثبات' : 'Receipt reference'}: ${(data['paymentReceiptFileName'] ?? '').toString()}',
      if (_dateText(data['paymentSubmittedAt']).isNotEmpty)
        '${isArabic ? 'تاريخ رفع الإثبات' : 'Proof submitted at'}: ${_dateText(data['paymentSubmittedAt'])}',
      if (_dateText(data['paymentApprovedAt']).isNotEmpty)
        '${isArabic ? 'تاريخ اعتماد السداد' : 'Payment approved at'}: ${_dateText(data['paymentApprovedAt'])}',
      if (_dateText(data['payoutTransferredAt']).isNotEmpty)
        '${isArabic ? 'تاريخ تحويل المستحق' : 'Payout transferred at'}: ${_dateText(data['payoutTransferredAt'])}',
      if (_dateText(data['archivedAt']).isNotEmpty)
        '${isArabic ? 'تاريخ الأرشفة' : 'Archived at'}: ${_dateText(data['archivedAt'])}',
    ];
  }

  void _showPrintPreview(
      BuildContext context, String title, List<String> lines) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: 720,
          child: SingleChildScrollView(
            child: SelectableText(lines.join('\n')),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(_isArabic(context) ? 'إغلاق' : 'Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _assistantPromptController.dispose();
    super.dispose();
  }

  Widget _buildReportCard(BuildContext context, Map<String, dynamic> item) {
    final isArabic = _isArabic(context);
    final id = (item['_id'] ?? '').toString();
    final clientName = (item['clientName'] ?? '').toString().trim();
    final isCenterRequest =
        (item['requestKind'] ?? '').toString().trim() == 'center';
    final clinicianName = ((isCenterRequest
                ? (item['centerName'] ?? '')
                : (item['assignedClinicianName'] ?? item['clinicianName'])) ??
            '')
        .toString()
        .trim();
    final archiveSection = (item['archiveSection'] ?? '').toString().trim();
    final status = (item['status'] ?? '').toString();
    final createdAt = _dateText(item['createdAt']);
    final archivedAt = _dateText(item['archivedAt']);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: AppSurfaceCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          title: Text(
            clientName.isNotEmpty ? clientName : (isArabic ? 'عميل' : 'Client'),
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              [
                if (clinicianName.isNotEmpty)
                  (isArabic
                      ? '${isCenterRequest ? 'المركز' : 'الأخصائي'}: $clinicianName'
                      : '${isCenterRequest ? 'Center' : 'Clinician'}: $clinicianName'),
                if (archiveSection.isNotEmpty)
                  (isArabic
                      ? 'القسم: ${_sectionLabel(archiveSection, isArabic)}'
                      : 'Section: ${_sectionLabel(archiveSection, isArabic)}'),
              ].join('  •  '),
            ),
          ),
          trailing: AppStatusBadge(
            label: _statusLabel(status, isArabic),
            color: const Color(0xFF6C55B3),
          ),
          children: [
            const SizedBox(height: 8),
            _sectionCard(
              context,
              title: isArabic ? 'ملخص سريع' : 'Quick summary',
              children: [
                _infoRow(context, 'ID', id),
                _infoRow(
                  context,
                  isArabic ? 'تاريخ الإنشاء' : 'Created at',
                  createdAt,
                ),
                _infoRow(
                  context,
                  isArabic ? 'تاريخ الأرشفة' : 'Archived at',
                  archivedAt,
                ),
              ],
            ),
            _sectionCard(
              context,
              title: isArabic ? 'بيانات الأطراف' : 'Participants',
              children: [
                _infoRow(
                  context,
                  isArabic ? 'العميل' : 'Client',
                  clientName,
                ),
                _infoRow(
                  context,
                  isArabic ? 'بريد العميل' : 'Client email',
                  (item['clientEmail'] ?? '').toString().trim(),
                ),
                _infoRow(
                  context,
                  isCenterRequest
                      ? (isArabic ? 'المركز' : 'Center')
                      : (isArabic ? 'الأخصائي' : 'Clinician'),
                  clinicianName,
                ),
              ],
            ),
            _sectionCard(
              context,
              title: isArabic ? 'الحالات' : 'Statuses',
              children: [
                _infoRow(
                  context,
                  isArabic ? 'الحالة العامة' : 'General status',
                  status,
                ),
                _infoRow(
                  context,
                  isArabic ? 'حالة السداد' : 'Payment status',
                  (item['paymentStatus'] ?? '').toString().trim(),
                ),
                _infoRow(
                  context,
                  isArabic ? 'حالة الجلسة' : 'Session status',
                  (item['sessionStatus'] ?? '').toString().trim(),
                ),
                _infoRow(
                  context,
                  isArabic ? 'حالة التقييم' : 'Review status',
                  (item['reviewStatus'] ?? '').toString().trim(),
                ),
                _infoRow(
                  context,
                  isArabic ? 'حالة التحويل' : 'Payout status',
                  (item['payoutStatus'] ?? '').toString().trim(),
                ),
              ],
            ),
            _sectionCard(
              context,
              title: isArabic ? 'بيانات الدفع' : 'Payment data',
              children: [
                _infoRow(
                  context,
                  isArabic ? 'مرجع إثبات السداد' : 'Payment proof reference',
                  (item['paymentReceiptFileName'] ?? '').toString().trim(),
                ),
                _infoRow(
                  context,
                  isArabic ? 'ملاحظة الدفع' : 'Payment note',
                  (item['paymentClientNote'] ?? '').toString().trim(),
                ),
                _infoRow(
                  context,
                  isArabic ? 'رفع الإثبات' : 'Proof submitted',
                  _dateText(item['paymentSubmittedAt']),
                ),
                _infoRow(
                  context,
                  isArabic ? 'اعتماد السداد' : 'Payment approved',
                  _dateText(item['paymentApprovedAt']),
                ),
                _infoRow(
                  context,
                  isArabic ? 'تحويل المستحق' : 'Payout transferred',
                  _dateText(item['payoutTransferredAt']),
                ),
              ],
            ),
            _sectionCard(
              context,
              title: isCenterRequest
                  ? (isArabic ? 'بيانات الإقامة' : 'Residency data')
                  : (isArabic ? 'بيانات الجلسة' : 'Session data'),
              children: [
                _infoRow(
                  context,
                  isCenterRequest
                      ? (isArabic ? 'موعد بداية الإقامة' : 'Residency start')
                      : (isArabic ? 'موعد الجلسة' : 'Session date'),
                  (item['sessionDateText'] ?? '').toString().trim(),
                ),
                _infoRow(
                  context,
                  isCenterRequest
                      ? (isArabic ? 'كود الإقامة' : 'Residency code')
                      : (isArabic ? 'كود الجلسة' : 'Session code'),
                  (item['sessionCode'] ?? '').toString().trim(),
                ),
                _infoRow(
                  context,
                  isCenterRequest
                      ? (isArabic ? 'رابط المتابعة' : 'Follow-up link')
                      : (isArabic ? 'رابط الجلسة' : 'Session link'),
                  (item['sessionLink'] ?? '').toString().trim(),
                ),
                _infoRow(
                  context,
                  isCenterRequest
                      ? (isArabic
                          ? 'ملاحظات الإدارة على الإقامة'
                          : 'Admin residency notes')
                      : (isArabic ? 'ملاحظات الإدارة' : 'Admin notes'),
                  (item['sessionAdminNotes'] ?? '').toString().trim(),
                ),
              ],
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _loadSessionRatings(id),
              builder: (context, ratingsSnapshot) {
                final ratings = ratingsSnapshot.data ?? const [];
                return Column(
                  children: [
                    _sectionCard(
                      context,
                      title: isArabic ? 'التقييمات' : 'Reviews',
                      children: [
                        _infoRow(
                          context,
                          isArabic ? 'النسبة النهائية' : 'Final percentage',
                          ((item['finalReviewPercentage'] ?? 0) as num)
                                      .toDouble() >
                                  0
                              ? '${((item['finalReviewPercentage'] ?? 0) as num).toDouble().toStringAsFixed(1)}%'
                              : '',
                        ),
                        _infoRow(
                          context,
                          isArabic
                              ? 'عدد التقييمات المحفوظة'
                              : 'Saved ratings count',
                          '${ratings.length}',
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        FilledButton.tonalIcon(
                          onPressed: () => _showPrintPreview(
                            context,
                            isArabic
                                ? 'طباعة التقرير الكامل'
                                : 'Print full report',
                            _fullReportLines(context, item, ratings),
                          ),
                          icon: const Icon(Icons.print_outlined),
                          label: Text(
                            isArabic ? 'طباعة كاملة' : 'Full print',
                          ),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _showPrintPreview(
                            context,
                            isArabic
                                ? 'طباعة مالية مختصرة'
                                : 'Print accounting summary',
                            _financialPrintLines(context, item),
                          ),
                          icon: const Icon(Icons.receipt_long_outlined),
                          label: Text(
                            isArabic ? 'طباعة مالية' : 'Accounting print',
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
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
          title: isArabic ? 'أرشيف التقارير' : 'Reports Archive',
          canLogout: false,
        ),
        body: AppPageBackground(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('booking_requests')
                .where('archived', isEqualTo: true)
                .snapshots(),
            builder: (context, snap) {
              if (snap.hasError) {
                return AppEmptyState(
                  message: isArabic
                      ? 'تعذر تحميل أرشيف التقارير'
                      : 'Unable to load reports archive',
                  icon: Icons.error_outline,
                );
              }

              if (!snap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final items = _normalizeDocs(snap.data!.docs, 'booking_requests')
                  .where((item) => (item['archived'] ?? false) == true)
                  .toList()
                ..sort((a, b) {
                  final aTs =
                      a['archivedAt'] ?? a['updatedAt'] ?? a['createdAt'];
                  final bTs =
                      b['archivedAt'] ?? b['updatedAt'] ?? b['createdAt'];
                  DateTime ad = DateTime.fromMillisecondsSinceEpoch(0);
                  DateTime bd = DateTime.fromMillisecondsSinceEpoch(0);
                  if (aTs is Timestamp) ad = aTs.toDate();
                  if (bTs is Timestamp) bd = bTs.toDate();
                  return bd.compareTo(ad);
                });

              final clientNames = items
                  .map((e) => (e['clientName'] ?? '').toString().trim())
                  .where((e) => e.isNotEmpty)
                  .toSet()
                  .toList()
                ..sort();
              final clinicianNames = items
                  .map((e) =>
                      (e['assignedClinicianName'] ?? e['clinicianName'] ?? '')
                          .toString()
                          .trim())
                  .where((e) => e.isNotEmpty)
                  .toSet()
                  .toList()
                ..sort();

              final filtered = items.where(_matchesFilters).toList();

              return ListView(
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
                              ? 'أرشيف التقارير الشامل'
                              : 'Comprehensive Reports Archive',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isArabic
                              ? 'هذا القسم فقط يعرض التقرير الكامل الشامل. الطباعة المالية هنا مختصرة لحماية خصوصية العميل والأخصائي.'
                              : 'Only this section shows the complete report. Accounting print here is intentionally limited for privacy.',
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _searchController,
                          onChanged: (value) =>
                              setState(() => _search = value.trim()),
                          decoration: appInputDecoration(
                            context: context,
                            label: isArabic ? 'بحث' : 'Search',
                            icon: Icons.search,
                          ),
                        ),
                        const SizedBox(height: 14),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final filterFieldWidth = constraints.maxWidth < 240
                                ? constraints.maxWidth
                                : 220.0;
                            return Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                SizedBox(
                                  width: filterFieldWidth,
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    initialValue: _sectionFilter,
                                    decoration: appInputDecoration(
                                      context: context,
                                      label: isArabic ? 'القسم' : 'Section',
                                      icon: Icons.category_outlined,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'all',
                                        child: Text(isArabic ? 'الكل' : 'All'),
                                      ),
                                      ...['sessions', 'payments'].map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            _sectionLabel(e, isArabic),
                                          ),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) => setState(
                                      () => _sectionFilter = value ?? 'all',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: filterFieldWidth,
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    initialValue: _statusFilter,
                                    decoration: appInputDecoration(
                                      context: context,
                                      label: isArabic ? 'الحالة' : 'Status',
                                      icon: Icons.filter_alt_outlined,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'all',
                                        child: Text(isArabic ? 'الكل' : 'All'),
                                      ),
                                      ...[
                                        'completed_success',
                                        'payout_pending',
                                        'session_completed_pending_reviews',
                                        'session_scheduled',
                                        'session_in_progress',
                                        'session_setup_pending',
                                      ].map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            _statusLabel(e, isArabic),
                                          ),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) => setState(
                                      () => _statusFilter = value ?? 'all',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: filterFieldWidth,
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    initialValue: _clientFilter,
                                    decoration: appInputDecoration(
                                      context: context,
                                      label: isArabic ? 'العميل' : 'Client',
                                      icon: Icons.person_outline,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'all',
                                        child: Text(isArabic ? 'الكل' : 'All'),
                                      ),
                                      ...clientNames.map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) => setState(
                                      () => _clientFilter = value ?? 'all',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: filterFieldWidth,
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    initialValue: _clinicianFilter,
                                    decoration: appInputDecoration(
                                      context: context,
                                      label:
                                          isArabic ? 'الأخصائي' : 'Clinician',
                                      icon: Icons.medical_services_outlined,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'all',
                                        child: Text(isArabic ? 'الكل' : 'All'),
                                      ),
                                      ...clinicianNames.map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) => setState(
                                      () => _clinicianFilter = value ?? 'all',
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppSectionPanel(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      isArabic
                          ? 'عدد النتائج بعد الفلترة: ${filtered.length}'
                          : 'Filtered results: ${filtered.length}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _assistantPanel(context, filtered),
                  const SizedBox(height: 16),
                  if (filtered.isEmpty)
                    AppEmptyState(
                      message: isArabic
                          ? 'لا توجد نتائج مطابقة'
                          : 'No matching results',
                      icon: Icons.search_off_rounded,
                    )
                  else
                    ...filtered.map((item) => _buildReportCard(context, item)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
