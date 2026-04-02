import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/chat/data/services/chat_firestore_service.dart';

class ChatEscalationReportPage extends StatefulWidget {
  const ChatEscalationReportPage({
    super.key,
    required this.escalationId,
  });

  final String escalationId;

  @override
  State<ChatEscalationReportPage> createState() =>
      _ChatEscalationReportPageState();
}

class _ChatEscalationReportPageState extends State<ChatEscalationReportPage> {
  final ChatFirestoreService _service = ChatFirestoreService();

  Map<String, dynamic>? _report;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadReport();
  }

  Future<void> _loadReport() async {
    setState(() {
      _loading = true;
      _error = null;
      _report = null;
    });

    try {
      final report =
          await _service.getLatestReportForEscalation(widget.escalationId);

      if (!mounted) {
        return;
      }

      setState(() {
        _report = report;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  String _formatTimestamp(dynamic value) {
    if (value == null) {
      return '—';
    }
    if (value is Timestamp) {
      return _formatDateTime(value.toDate());
    }
    if (value is DateTime) {
      return _formatDateTime(value);
    }
    return value.toString();
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Object? _get(Map<String, dynamic>? map, String key) {
    if (map == null) {
      return null;
    }
    return map[key];
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تقرير التصعيد'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'فشل تحميل التقرير',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                _error!,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _loadReport,
                icon: const Icon(Icons.refresh),
                label: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    if (_report == null || _report!.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.description_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'لا يوجد تقرير لهذه الحالة',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'لم يُنشأ تقرير تصعيد أمان لهذه التصعيد بعد.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: _buildSections(),
    );
  }

  List<Widget> _buildSections() {
    final report = _report!;
    final widgets = <Widget>[];

    void section(String titleAr, Widget content) {
      widgets.add(
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleAr,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                content,
              ],
            ),
          ),
        ),
      );
      widgets.add(const SizedBox(height: 12));
    }

    Widget? textRow(String label, dynamic value) {
      if (value == null) {
        return null;
      }

      final str = value is Map ? value.toString() : value.toString();
      if (str.isEmpty) {
        return null;
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                text: '$label: ',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              TextSpan(text: str),
            ],
          ),
        ),
      );
    }

    section(
      'معلومات التقرير',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textRow('نوع التقرير', _get(report, 'reportType')),
          textRow('الإصدار', _get(report, 'reportVersion')),
          textRow('وقت الإنشاء', _formatTimestamp(_get(report, 'generatedAt'))),
        ].whereType<Widget>().toList(),
      ),
    );

    if (_get(report, 'roleDetected') != null ||
        _get(report, 'roleConfidence') != null) {
      section(
        'الدور المكتشف',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textRow('الدور', _get(report, 'roleDetected')),
            textRow('مستوى الثقة', _get(report, 'roleConfidence')),
          ].whereType<Widget>().toList(),
        ),
      );
    }

    final sessionOverview = _get(report, 'sessionOverview');
    if (sessionOverview is Map<String, dynamic>) {
      section(
        'ملخص الجلسة',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textRow(
              'بداية الجلسة',
              _formatTimestamp(sessionOverview['startedAt']),
            ),
            textRow(
              'آخر رسالة',
              _formatTimestamp(sessionOverview['lastMessageAt']),
            ),
            textRow('مدة (ثانية)', sessionOverview['durationSeconds']),
            textRow('عدد الرسائل', sessionOverview['messageCount']),
          ].whereType<Widget>().toList(),
        ),
      );
    }

    final emotionalTimeline = _get(report, 'emotionalTimeline');
    if (emotionalTimeline is List && emotionalTimeline.isNotEmpty) {
      section(
        'الجدول الزمني العاطفي',
        Text(
          emotionalTimeline.toString(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }

    final riskPath = _get(report, 'riskEscalationPath');
    if (riskPath is Map<String, dynamic>) {
      section(
        'مسار تصعيد الخطر',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textRow('المستوى الأولي', riskPath['initialLevel']),
            textRow('المستوى النهائي', riskPath['finalLevel']),
            textRow('النقاط النهائية', riskPath['finalScore']),
            textRow('وضع الاستراتيجية', riskPath['strategyMode']),
            textRow('حالة الأمان', riskPath['safetyState']),
          ].whereType<Widget>().toList(),
        ),
      );
    }

    final keyIndicators = _get(report, 'keySafetyIndicators');
    if (keyIndicators is List && keyIndicators.isNotEmpty) {
      section(
        'مؤشرات الأمان الرئيسية',
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: keyIndicators
              .map<Widget>((e) => Chip(label: Text(e.toString())))
              .toList(),
        ),
      );
    }

    final triggerFlags = _get(report, 'triggerFlags');
    if (triggerFlags is Map<String, dynamic>) {
      section(
        'أعلام المحفزات',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final e in triggerFlags.entries)
              textRow(
                    e.key,
                    e.value == true
                        ? 'نعم'
                        : (e.value == false ? 'لا' : e.value),
                  ) ??
                  const SizedBox.shrink(),
          ],
        ),
      );
    }

    final aiActions = _get(report, 'aiActionsTaken');
    if (aiActions is List && aiActions.isNotEmpty) {
      section(
        'إجراءات الذكاء الاصطناعي',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: aiActions
              .map<Widget>(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '• ${e.toString()}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
              .toList(),
        ),
      );
    }

    final assessment = _get(report, 'currentSafetyAssessment');
    if (assessment is Map<String, dynamic>) {
      section(
        'تقييم الأمان الحالي',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textRow('المستوى', assessment['level']),
            textRow('الملخص', assessment['summary']),
          ].whereType<Widget>().toList(),
        ),
      );
    }

    final routing = _get(report, 'recommendedSafetyRouting');
    if (routing != null) {
      section(
        'التوجيه الأمني الموصى به',
        Text(
          routing.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    final overrideBasis = _get(report, 'confidentialityOverrideBasis');
    if (overrideBasis is List && overrideBasis.isNotEmpty) {
      section(
        'أساس استثناء السرية',
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: overrideBasis
              .map<Widget>((e) => Chip(label: Text(e.toString())))
              .toList(),
        ),
      );
    }

    final policyMode = _get(report, 'policyMode');
    if (policyMode != null) {
      section(
        'وضع السياسة',
        Text(
          policyMode.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    if (widgets.isNotEmpty && widgets.last is SizedBox) {
      widgets.removeLast();
    }

    return widgets;
  }
}
