import 'package:cloud_firestore/cloud_firestore.dart';

class ArchiveAssistantResult {
  const ArchiveAssistantResult({
    required this.lines,
    this.accountingRows = const [],
    this.accountingCsv = '',
  });

  final List<String> lines;
  final List<Map<String, String>> accountingRows;
  final String accountingCsv;
}

class ArchiveAssistantEngine {
  const ArchiveAssistantEngine();

  ArchiveAssistantResult run({
    required List<Map<String, dynamic>> items,
    required String mode,
    String preset = 'none',
    required bool isArabic,
  }) {
    final lines = _assistantLines(
      items: items,
      mode: mode,
      preset: preset,
      isArabic: isArabic,
    );

    if (mode != 'accounting') {
      return ArchiveAssistantResult(lines: lines);
    }

    final rows = _assistantAccountingRows(items);
    return ArchiveAssistantResult(
      lines: lines,
      accountingRows: rows,
      accountingCsv: _assistantAccountingCsv(rows, isArabic: isArabic),
    );
  }

  String resolveCommand(String raw) {
    final text = raw.trim().toLowerCase();
    if (text.isEmpty) return 'none';

    if (text.contains('شهري') || text.contains('monthly')) return 'monthly';
    if (text.contains('مقارنة') ||
        text.contains('compare') ||
        text.contains('الأقسام') ||
        text.contains('sections')) {
      return 'section_compare';
    }
    if (text.contains('أخصائي') ||
        text.contains('الاخصائي') ||
        text.contains('clinician') ||
        text.contains('performance')) {
      return 'clinician_performance';
    }
    if (text.contains('مركز') ||
        text.contains('مراكز') ||
        text.contains('center')) {
      return 'center_ops';
    }
    if (text.contains('محاس') ||
        text.contains('مالي') ||
        text.contains('accounting') ||
        text.contains('csv')) {
      return 'accounting';
    }
    if (text.contains('إحص') || text.contains('stats')) return 'stats';
    if (text.contains('تحليل') || text.contains('analysis')) return 'analysis';
    if (text.contains('ملخص') || text.contains('summary')) return 'summary';

    return 'none';
  }

  List<String> _assistantLines({
    required List<Map<String, dynamic>> items,
    required String mode,
    required String preset,
    required bool isArabic,
  }) {
    if (preset != 'none') {
      switch (preset) {
        case 'monthly':
          return _assistantMonthlyLines(items, isArabic: isArabic);
        case 'section_compare':
          return _assistantSectionCompareLines(items, isArabic: isArabic);
        case 'clinician_performance':
          return _assistantClinicianPerformanceLines(items, isArabic: isArabic);
        case 'center_ops':
          return _assistantCenterOpsLines(items, isArabic: isArabic);
      }
    }
    switch (mode) {
      case 'stats':
        return _assistantStatsLines(items, isArabic: isArabic);
      case 'analysis':
        return _assistantAnalysisLines(items, isArabic: isArabic);
      case 'accounting':
        return _assistantAccountingLines(items, isArabic: isArabic);
      default:
        return _assistantSummaryLines(items, isArabic: isArabic);
    }
  }

  int _countBySection(List<Map<String, dynamic>> items, String section) {
    return items
        .where((item) =>
            (item['archiveSection'] ?? '').toString().trim() == section)
        .length;
  }

  int _countByStatus(List<Map<String, dynamic>> items, String status) {
    return items
        .where((item) => (item['status'] ?? '').toString().trim() == status)
        .length;
  }

  int _countApprovedPayments(List<Map<String, dynamic>> items) {
    return items
        .where((item) =>
            (item['paymentStatus'] ?? '').toString().trim() == 'approved')
        .length;
  }

  int _countPaidPayouts(List<Map<String, dynamic>> items) {
    return items
        .where((item) =>
            (item['payoutStatus'] ?? '').toString().trim() ==
            'paid_to_clinician')
        .length;
  }

  double _avgFinalReview(List<Map<String, dynamic>> items) {
    final values = items
        .map((item) => ((item['finalReviewPercentage'] ?? 0) as num).toDouble())
        .where((value) => value > 0)
        .toList();
    if (values.isEmpty) return 0;
    return values.fold<double>(0, (a, b) => a + b) / values.length;
  }

  List<MapEntry<String, int>> _topClinicians(List<Map<String, dynamic>> items) {
    final counts = <String, int>{};
    for (final item in items) {
      final name =
          (item['assignedClinicianName'] ?? item['clinicianName'] ?? '')
              .toString()
              .trim();
      if (name.isEmpty) continue;
      counts[name] = (counts[name] ?? 0) + 1;
    }
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(3).toList();
  }

  List<MapEntry<String, int>> _topCenters(List<Map<String, dynamic>> items) {
    final counts = <String, int>{};
    for (final item in items) {
      final name = (item['centerName'] ?? '').toString().trim();
      if (name.isEmpty) continue;
      counts[name] = (counts[name] ?? 0) + 1;
    }
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(3).toList();
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

  String _monthKey(dynamic value) {
    if (value is! Timestamp) return '';
    final d = value.toDate();
    final month = d.month.toString().padLeft(2, '0');
    return '${d.year}-$month';
  }

  List<MapEntry<String, int>> _countByMonth(List<Map<String, dynamic>> items) {
    final counts = <String, int>{};
    for (final item in items) {
      final key = _monthKey(
          item['archivedAt'] ?? item['updatedAt'] ?? item['createdAt']);
      if (key.isEmpty) continue;
      counts[key] = (counts[key] ?? 0) + 1;
    }
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));
    return sorted;
  }

  List<String> _assistantSummaryLines(
    List<Map<String, dynamic>> filtered, {
    required bool isArabic,
  }) {
    return [
      isArabic ? 'ملخص أرشيف سريع' : 'Quick archive summary',
      '----------------------------------------',
      isArabic
          ? 'إجمالي العناصر: ${filtered.length}'
          : 'Total items: ${filtered.length}',
      isArabic
          ? 'جلسات مؤرشفة: ${_countBySection(filtered, 'sessions')}'
          : 'Archived sessions: ${_countBySection(filtered, 'sessions')}',
      isArabic
          ? 'مدفوعات مؤرشفة: ${_countBySection(filtered, 'payments')}'
          : 'Archived payments: ${_countBySection(filtered, 'payments')}',
      isArabic
          ? 'عمليات مكتملة: ${_countByStatus(filtered, 'completed_success')}'
          : 'Completed flows: ${_countByStatus(filtered, 'completed_success')}',
      isArabic
          ? 'بانتظار تحويل المستحق: ${_countByStatus(filtered, 'payout_pending')}'
          : 'Payout pending: ${_countByStatus(filtered, 'payout_pending')}',
    ];
  }

  List<String> _assistantStatsLines(
    List<Map<String, dynamic>> filtered, {
    required bool isArabic,
  }) {
    final topClinicians = _topClinicians(filtered);
    return [
      isArabic ? 'إحصائيات الأرشيف' : 'Archive statistics',
      '----------------------------------------',
      isArabic
          ? 'مدفوعات معتمدة: ${_countApprovedPayments(filtered)}'
          : 'Approved payments: ${_countApprovedPayments(filtered)}',
      isArabic
          ? 'تحويلات مكتملة: ${_countPaidPayouts(filtered)}'
          : 'Completed payouts: ${_countPaidPayouts(filtered)}',
      isArabic
          ? 'متوسط التقييم النهائي: ${_avgFinalReview(filtered).toStringAsFixed(1)}%'
          : 'Average final review: ${_avgFinalReview(filtered).toStringAsFixed(1)}%',
      if (topClinicians.isNotEmpty) '',
      if (topClinicians.isNotEmpty)
        (isArabic
            ? 'أعلى الأخصائيين في النتائج الحالية:'
            : 'Top clinicians in current results:'),
      ...topClinicians.map((entry) => '${entry.key}: ${entry.value}'),
    ];
  }

  List<String> _assistantAnalysisLines(
    List<Map<String, dynamic>> filtered, {
    required bool isArabic,
  }) {
    final payoutPending = _countByStatus(filtered, 'payout_pending');
    final pendingReviews =
        _countByStatus(filtered, 'session_completed_pending_reviews');
    final avgReview = _avgFinalReview(filtered);
    final notes = <String>[];

    if (payoutPending > 0) {
      notes.add(isArabic
          ? 'يوجد $payoutPending عنصر ما زال بانتظار تحويل المستحق، وهذا يشير إلى مهام مالية غير مغلقة بعد.'
          : '$payoutPending items are still waiting for payout, which indicates unresolved finance work.');
    }
    if (pendingReviews > 0) {
      notes.add(isArabic
          ? 'يوجد $pendingReviews عنصر بانتظار التقييمات، وهذا يعني أن بعض الجلسات لم تُغلق تقييمياً بالكامل.'
          : '$pendingReviews items are pending reviews, which means some sessions are not fully closed from a review perspective.');
    }
    if (avgReview > 0) {
      notes.add(isArabic
          ? 'متوسط التقييم النهائي الحالي ${avgReview.toStringAsFixed(1)}%، ويمكن استخدامه كمؤشر جودة أولي داخل النطاق المفلتر.'
          : 'The current average final review is ${avgReview.toStringAsFixed(1)}%, which can serve as a first quality signal within the filtered scope.');
    }
    if (notes.isEmpty) {
      notes.add(isArabic
          ? 'لا توجد مؤشرات تحليلية كافية داخل الفلتر الحالي. جرّب توسيع الفلاتر أو اختيار قسم آخر.'
          : 'There is not enough analytic signal in the current filter. Try widening the filters or selecting another section.');
    }

    return [
      isArabic ? 'تحليل مختصر' : 'Short analysis',
      '----------------------------------------',
      ...notes,
    ];
  }

  List<String> _assistantAccountingLines(
    List<Map<String, dynamic>> filtered, {
    required bool isArabic,
  }) {
    final rows = filtered.map((item) {
      final id = (item['_id'] ?? '').toString();
      final paymentStatus = (item['paymentStatus'] ?? '').toString();
      final payoutStatus = (item['payoutStatus'] ?? '').toString();
      final receipt = (item['paymentReceiptFileName'] ?? '').toString();
      final approvedAt = _dateText(item['paymentApprovedAt']);
      final payoutAt = _dateText(item['payoutTransferredAt']);
      return '$id | $paymentStatus | $payoutStatus | $receipt | $approvedAt | $payoutAt';
    }).toList();

    return [
      isArabic ? 'كشف محاسبي جاهز للتصدير' : 'Export-ready accounting sheet',
      '----------------------------------------',
      isArabic
          ? 'ID | حالة السداد | حالة التحويل | مرجع الإثبات | اعتماد السداد | تحويل المستحق'
          : 'ID | Payment status | Payout status | Receipt ref | Payment approved | Payout transferred',
      ...rows,
    ];
  }

  List<String> _assistantMonthlyLines(
    List<Map<String, dynamic>> filtered, {
    required bool isArabic,
  }) {
    final months = _countByMonth(filtered);
    return [
      isArabic ? 'تقرير شهري سريع' : 'Quick monthly report',
      '----------------------------------------',
      if (months.isEmpty)
        (isArabic
            ? 'لا توجد بيانات شهرية كافية داخل الفلتر الحالي.'
            : 'No monthly data in the current filter.')
      else ...[
        isArabic ? 'عدد العناصر حسب شهر الأرشفة:' : 'Items by archive month:',
        ...months.map((entry) => '${entry.key}: ${entry.value}'),
      ],
    ];
  }

  List<String> _assistantSectionCompareLines(
    List<Map<String, dynamic>> filtered, {
    required bool isArabic,
  }) {
    final sessions = _countBySection(filtered, 'sessions');
    final payments = _countBySection(filtered, 'payments');
    final completed = _countByStatus(filtered, 'completed_success');
    final payoutPending = _countByStatus(filtered, 'payout_pending');
    return [
      isArabic ? 'مقارنة بين الأقسام' : 'Section comparison',
      '----------------------------------------',
      isArabic ? 'الجلسات: $sessions' : 'Sessions: $sessions',
      isArabic ? 'المدفوعات: $payments' : 'Payments: $payments',
      isArabic
          ? 'العمليات المكتملة: $completed'
          : 'Completed flows: $completed',
      isArabic
          ? 'بانتظار تحويل المستحق: $payoutPending'
          : 'Payout pending: $payoutPending',
    ];
  }

  List<String> _assistantClinicianPerformanceLines(
    List<Map<String, dynamic>> filtered, {
    required bool isArabic,
  }) {
    final topClinicians = _topClinicians(filtered);
    return [
      isArabic ? 'تحليل أداء الأخصائيين' : 'Clinician performance analysis',
      '----------------------------------------',
      isArabic
          ? 'متوسط التقييم النهائي: ${_avgFinalReview(filtered).toStringAsFixed(1)}%'
          : 'Average final review: ${_avgFinalReview(filtered).toStringAsFixed(1)}%',
      if (topClinicians.isEmpty)
        (isArabic
            ? 'لا توجد بيانات كافية عن الأخصائيين داخل الفلتر الحالي.'
            : 'No clinician data in the current filter.')
      else ...[
        isArabic ? 'أكثر الأخصائيين ظهورًا:' : 'Most frequent clinicians:',
        ...topClinicians.map((entry) => '${entry.key}: ${entry.value}'),
      ],
    ];
  }

  List<String> _assistantCenterOpsLines(
    List<Map<String, dynamic>> filtered, {
    required bool isArabic,
  }) {
    final centers = _topCenters(filtered);
    final centerRequests = filtered
        .where(
            (item) => (item['requestKind'] ?? '').toString().trim() == 'center')
        .length;
    return [
      isArabic ? 'تحليل عمليات المراكز' : 'Center operations analysis',
      '----------------------------------------',
      isArabic
          ? 'طلبات المراكز داخل النتائج الحالية: $centerRequests'
          : 'Center requests in current results: $centerRequests',
      if (centers.isEmpty)
        (isArabic
            ? 'لا توجد بيانات مراكز كافية داخل الفلتر الحالي.'
            : 'No center data in the current filter.')
      else ...[
        isArabic ? 'أكثر المراكز ظهورًا:' : 'Most frequent centers:',
        ...centers.map((entry) => '${entry.key}: ${entry.value}'),
      ],
    ];
  }

  List<Map<String, String>> _assistantAccountingRows(
    List<Map<String, dynamic>> filtered,
  ) {
    return filtered.map((item) {
      final clinicianId =
          (item['assignedClinicianId'] ?? item['clinicianId'] ?? '')
              .toString()
              .trim();
      return {
        'id': (item['_id'] ?? '').toString(),
        'clientId': (item['clientId'] ?? '').toString().trim(),
        'clinicianId': clinicianId,
        'paymentStatus': (item['paymentStatus'] ?? '').toString().trim(),
        'payoutStatus': (item['payoutStatus'] ?? '').toString().trim(),
        'receiptRef': (item['paymentReceiptFileName'] ?? '').toString().trim(),
        'paymentApprovedAt': _dateText(item['paymentApprovedAt']),
        'payoutTransferredAt': _dateText(item['payoutTransferredAt']),
      };
    }).toList();
  }

  String _csvCell(String value) {
    final escaped = value.replaceAll('"', '""');
    return '"$escaped"';
  }

  String _assistantAccountingCsv(
    List<Map<String, String>> rows, {
    required bool isArabic,
  }) {
    final headers = [
      isArabic ? 'ID' : 'ID',
      isArabic ? 'معرف العميل' : 'Client ID',
      isArabic ? 'معرف الأخصائي' : 'Clinician ID',
      isArabic ? 'حالة السداد' : 'Payment Status',
      isArabic ? 'حالة التحويل' : 'Payout Status',
      isArabic ? 'مرجع الإثبات' : 'Receipt Reference',
      isArabic ? 'اعتماد السداد' : 'Payment Approved At',
      isArabic ? 'تحويل المستحق' : 'Payout Transferred At',
    ];

    final csvLines = <String>[
      headers.map(_csvCell).join(','),
      ...rows.map(
        (row) => [
          row['id'] ?? '',
          row['clientId'] ?? '',
          row['clinicianId'] ?? '',
          row['paymentStatus'] ?? '',
          row['payoutStatus'] ?? '',
          row['receiptRef'] ?? '',
          row['paymentApprovedAt'] ?? '',
          row['payoutTransferredAt'] ?? '',
        ].map(_csvCell).join(','),
      ),
    ];

    return csvLines.join('\n');
  }
}
