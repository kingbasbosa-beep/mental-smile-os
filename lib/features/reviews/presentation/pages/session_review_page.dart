import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/core/ui/app_shell_actions.dart';

class SessionReviewPage extends StatefulWidget {
  const SessionReviewPage({
    super.key,
    required this.requestId,
    required this.reviewerType,
  });

  final String requestId;
  final String reviewerType;

  @override
  State<SessionReviewPage> createState() => _SessionReviewPageState();
}

class _SessionReviewPageState extends State<SessionReviewPage> {
  bool _loading = false;

  final TextEditingController _notesController = TextEditingController();

  final Map<String, int> _answers = {
    'q1': 5,
    'q2': 5,
    'q3': 5,
    'q4': 5,
    'q5': 5,
    'q6': 5,
  };

  bool get _isArabic =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  List<String> _questions() {
    if (widget.reviewerType == 'clinician') {
      return _isArabic
          ? const [
              'مدى التزام الطرف الآخر بموعد الجلسة',
              'وضوح التواصل خلال الجلسة',
              'مدى الاستفادة العلاجية/المهنية من الجلسة',
              'مدى الحاجة إلى متابعة لاحقة',
              'مدى مناسبة الخطة أو التوصيات للحالة',
              'التقييم العام لسير الجلسة',
            ]
          : const [
              'Attendance commitment',
              'Communication clarity during session',
              'Therapeutic/professional usefulness',
              'Need for follow-up',
              'Suitability of plan/recommendations',
              'Overall session flow',
            ];
    }

    return _isArabic
        ? const [
            'مدى سهولة الدخول إلى الجلسة',
            'مدى وضوح وتعاون الأخصائي',
            'مدى شعورك بالاستفادة من الجلسة',
            'مدى مناسبة الموعد والتنظيم',
            'مدى احتمالية تكرار التجربة',
            'التقييم العام للجلسة',
          ]
        : const [
            'Ease of joining the session',
            'Clarity and cooperation of clinician',
            'How useful the session felt',
            'Suitability of timing and organization',
            'Likelihood of repeating the experience',
            'Overall session rating',
          ];
  }

  int get _totalScore {
    return _answers.values.fold(0, (total, value) => total + value);
  }

  double get _percentageScore {
    return (_totalScore / 30) * 100;
  }

  double get _derivedStars {
    return (_totalScore / 30) * 5;
  }

  String get _percentageLabel {
    return _percentageScore.toStringAsFixed(1);
  }

  String get _derivedStarsLabel {
    return _derivedStars.toStringAsFixed(1);
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>>
      _existingRequestDocs() async {
    final db = FirebaseFirestore.instance;
    final refs = [
      db.collection('booking_requests').doc(widget.requestId),
      db.collection('bookingRequests').doc(widget.requestId),
    ];

    final existing = <DocumentSnapshot<Map<String, dynamic>>>[];
    for (final ref in refs) {
      final snap = await ref.get();
      if (snap.exists) {
        existing.add(snap);
      }
    }
    return existing;
  }

  Future<Map<String, dynamic>?> _readRequest() async {
    final db = FirebaseFirestore.instance;
    final refs = [
      db.collection('booking_requests').doc(widget.requestId),
      db.collection('bookingRequests').doc(widget.requestId),
    ];

    for (final ref in refs) {
      final snap = await ref.get();
      if (snap.exists) return snap.data();
    }
    return null;
  }

  Future<void> _submit() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || uid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic ? 'يجب تسجيل الدخول أولًا' : 'Please sign in first',
          ),
        ),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      final requestData = await _readRequest();
      if (requestData == null) {
        throw Exception(
          _isArabic ? 'لم يتم العثور على الطلب' : 'Request not found',
        );
      }

      final alreadySubmitted = widget.reviewerType == 'client'
          ? (requestData['clientReviewSubmitted'] ?? false) == true
          : (requestData['clinicianReviewSubmitted'] ?? false) == true;
      if (alreadySubmitted) {
        throw Exception(
          _isArabic ? 'تم إرسال التقييم مسبقًا' : 'Review already submitted',
        );
      }

      final totalScore = _totalScore;
      final percentageScore = _percentageScore;
      final derivedStars = _derivedStars;

      final ratingRef = FirebaseFirestore.instance
          .collection('sessionRatings')
          .doc('${widget.requestId}_${widget.reviewerType}');

      final reviewPayload = {
        'requestId': widget.requestId,
        'reviewerUid': uid,
        'reviewerType': widget.reviewerType,
        'clientId': (requestData['clientId'] ?? '').toString(),
        'clinicianId': (requestData['assignedClinicianId'] ??
                requestData['clinicianId'] ??
                '')
            .toString(),
        'clientName': (requestData['clientName'] ?? '').toString(),
        'clinicianName': (requestData['assignedClinicianName'] ??
                requestData['clinicianName'] ??
                '')
            .toString(),
        'answers': _answers,
        'totalScore': totalScore,
        'percentageScore': percentageScore,
        'derivedStars': derivedStars,
        'notes': _notesController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      };

      final updates = <String, dynamic>{};

      if (widget.reviewerType == 'client') {
        updates['clientReviewSubmitted'] = true;
        updates['clientReviewSubmittedAt'] = FieldValue.serverTimestamp();
        updates['clientReviewTotalScore'] = totalScore;
        updates['clientReviewPercentage'] = percentageScore;
        updates['clientReviewDerivedStars'] = derivedStars;
      } else {
        updates['clinicianReviewSubmitted'] = true;
        updates['clinicianReviewSubmittedAt'] = FieldValue.serverTimestamp();
        updates['clinicianReviewTotalScore'] = totalScore;
        updates['clinicianReviewPercentage'] = percentageScore;
        updates['clinicianReviewDerivedStars'] = derivedStars;
      }

      final alreadyClient = widget.reviewerType == 'client'
          ? true
          : (requestData['clientReviewSubmitted'] ?? false) == true;

      final alreadyClinician = widget.reviewerType == 'clinician'
          ? true
          : (requestData['clinicianReviewSubmitted'] ?? false) == true;

      final clientPercentage = widget.reviewerType == 'client'
          ? percentageScore
          : ((requestData['clientReviewPercentage'] ?? 0) as num).toDouble();

      final clinicianPercentage = widget.reviewerType == 'clinician'
          ? percentageScore
          : ((requestData['clinicianReviewPercentage'] ?? 0) as num).toDouble();

      if (alreadyClient && alreadyClinician) {
        updates['status'] = 'payout_pending';
        updates['reviewStatus'] = 'completed';
        updates['sessionStatus'] = 'completed';
        updates['finalReviewPercentage'] =
            ((clientPercentage + clinicianPercentage) / 2);
      } else {
        updates['status'] = 'session_completed_pending_reviews';
        updates['reviewStatus'] = 'partial';
        updates['sessionStatus'] = 'completed';
        updates['finalReviewPercentage'] =
            alreadyClient ? clientPercentage : clinicianPercentage;
      }

      final requestDocs = await _existingRequestDocs();
      if (requestDocs.isEmpty) {
        throw Exception(
          _isArabic ? 'تعذر العثور على الطلب' : 'Request not found',
        );
      }

      requestDocs.sort((a, b) {
        final aPrimary = a.reference.parent.id == 'booking_requests' ? 0 : 1;
        final bPrimary = b.reference.parent.id == 'booking_requests' ? 0 : 1;
        return aPrimary.compareTo(bPrimary);
      });
      final targetRef = requestDocs.first.reference;

      final payload = {
        ...updates,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      await ratingRef.set(reviewPayload);
      await targetRef.update(payload);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic
                ? 'تم إرسال التقييم وإنهاء الجلسة'
                : 'Review submitted and session closed',
          ),
        ),
      );
      Navigator.of(context).maybePop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic ? 'فشل إرسال التقييم: $e' : 'Failed to submit review: $e',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Widget _scoreRow(String key, String label) {
    final current = _answers[key] ?? 5;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.14),
        ),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment:
            _isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: _isArabic ? TextAlign.right : TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(5, (index) {
              final value = index + 1;
              final selected = current == value;
              return ChoiceChip(
                label: Text('$value'),
                selected: selected,
                onSelected: (_) {
                  setState(() => _answers[key] = value);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _summaryBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.14),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            _isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            _isArabic ? 'النتيجة المحسوبة تلقائيًا' : 'Calculated result',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            _isArabic
                ? 'المجموع: $_totalScore من 30'
                : 'Score: $_totalScore out of 30',
          ),
          const SizedBox(height: 4),
          Text(
            _isArabic
                ? 'النسبة: %$_percentageLabel'
                : 'Percentage: $_percentageLabel%',
          ),
          const SizedBox(height: 4),
          Text(
            _isArabic
                ? 'النجوم المشتقة تلقائيًا: $_derivedStarsLabel / 5'
                : 'Derived stars: $_derivedStarsLabel / 5',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questions = _questions();

    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: _isArabic ? 'تقييم الجلسة' : 'Session Review',
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              _isArabic
                  ? 'أجب عن الأسئلة التالية ثم أرسل التقييم لإنهاء الجلسة.'
                  : 'Answer the questions below then submit the review to close the session.',
            ),
            const SizedBox(height: 16),
            _scoreRow('q1', questions[0]),
            _scoreRow('q2', questions[1]),
            _scoreRow('q3', questions[2]),
            _scoreRow('q4', questions[3]),
            _scoreRow('q5', questions[4]),
            _scoreRow('q6', questions[5]),
            const SizedBox(height: 8),
            _summaryBox(),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: _isArabic ? 'ملاحظات إضافية' : 'Additional notes',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton.icon(
                onPressed: _loading ? null : _submit,
                icon: _loading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.task_alt_outlined),
                label: Text(
                  _loading
                      ? (_isArabic ? 'جارٍ الإرسال...' : 'Submitting...')
                      : (_isArabic
                          ? 'إرسال وإنهاء الجلسة'
                          : 'Submit & Close Session'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
