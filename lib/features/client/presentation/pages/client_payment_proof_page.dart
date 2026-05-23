import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';
import 'package:flutterprojects/shared/ui_kit/app_widgets.dart';

class ClientPaymentProofPage extends StatefulWidget {
  const ClientPaymentProofPage({super.key});

  @override
  State<ClientPaymentProofPage> createState() => _ClientPaymentProofPageState();
}

class _ClientPaymentProofPageState extends State<ClientPaymentProofPage> {
  final TextEditingController _receiptFileNameController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  bool _loading = false;
  String? _selectedRequestId;

  bool get _isArabic =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String _backgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
  }

  BoxDecoration _glassDecoration({double alpha = 0.34, double radius = 22}) {
    return BoxDecoration(
      color: Colors.black.withValues(alpha: alpha),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: const Color(0xFFE7C766).withValues(alpha: 0.34),
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFE7C766).withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
    );
  }

  InputDecoration _darkInputDecoration({
    required String label,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFFFFE8A6)),
      prefixIcon:
          icon == null ? null : Icon(icon, color: const Color(0xFFE7C766)),
      filled: true,
      fillColor: Colors.black.withValues(alpha: 0.30),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: const Color(0xFFE7C766).withValues(alpha: 0.28),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFFE7C766)),
      ),
    );
  }

  DateTime _asDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  Map<String, dynamic> _asStringMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return Map<String, dynamic>.from(value);
    }
    if (value is Map) {
      return value.map((key, item) => MapEntry(key.toString(), item));
    }
    return <String, dynamic>{};
  }

  bool _isCenterRequestData(Map<String, dynamic> data) {
    return (data['requestKind'] ?? '').toString() == 'center' ||
        (data['centerId'] ?? '').toString().trim().isNotEmpty;
  }

  bool _contractConfirmed(Map<String, dynamic> data) {
    final contract = _asStringMap(data['contract']);
    return contract['status'] == 'confirmed' &&
        contract['snapshotLocked'] == true &&
        _asStringMap(contract['quoteSnapshot']).isNotEmpty;
  }

  String _displayValue(dynamic value) {
    final text = (value ?? '').toString();
    return text.trim().isEmpty ? '-' : text;
  }

  Map<String, dynamic> _quoteSnapshotFrom(Map<String, dynamic> data) {
    return <String, dynamic>{
      'stayStartDateText': data['stayStartDateText'],
      'stayEndDateText': data['stayEndDateText'],
      'stayDurationDays': data['stayDurationDays'],
      'pricingUnit': data['stayPricingUnit'],
      'baseAmount': data['stayBaseAmount'],
      'taxPercent': data['stayTaxPercent'],
      'taxAmount': data['stayTaxAmount'],
      'totalAmount': data['stayTotalAmount'],
      'grossClientPaidAmount': data['grossClientPaidAmount'],
    };
  }

  Map<String, dynamic> _contractForConfirmation(Map<String, dynamic> data) {
    final contract = _asStringMap(data['contract']);
    final quoteSnapshot = _quoteSnapshotFrom(data);
    return <String, dynamic>{
      ...contract,
      'status': 'confirmed',
      'confirmedAt': FieldValue.serverTimestamp(),
      'confirmedBy': FirebaseAuth.instance.currentUser?.uid ?? '',
      'snapshotLocked': true,
      'quoteSnapshot': quoteSnapshot,
    };
  }

  Future<bool> _confirmCenterContractIfNeeded(
    DocumentReference<Map<String, dynamic>> requestRef,
    Map<String, dynamic> data,
  ) async {
    if (!_isCenterRequestData(data) || _contractConfirmed(data)) {
      return true;
    }

    final quoteSnapshot = _quoteSnapshotFrom(data);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            _isArabic ? 'تأكيد عرض المركز' : 'Confirm center quote',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isArabic
                    ? 'يرجى تأكيد بيانات العرض قبل إرسال إثبات التحويل.'
                    : 'Please confirm the quote details before submitting payment proof.',
              ),
              const SizedBox(height: 12),
              Text(
                _isArabic
                    ? 'بداية الإقامة: ${_displayValue(quoteSnapshot['stayStartDateText'])}'
                    : 'Residency start: ${_displayValue(quoteSnapshot['stayStartDateText'])}',
              ),
              Text(
                _isArabic
                    ? 'نهاية الإقامة: ${_displayValue(quoteSnapshot['stayEndDateText'])}'
                    : 'Residency end: ${_displayValue(quoteSnapshot['stayEndDateText'])}',
              ),
              Text(
                _isArabic
                    ? 'عدد الأيام: ${_displayValue(quoteSnapshot['stayDurationDays'])}'
                    : 'Duration days: ${_displayValue(quoteSnapshot['stayDurationDays'])}',
              ),
              Text(
                _isArabic
                    ? 'وحدة التسعير: ${_displayValue(quoteSnapshot['pricingUnit'])}'
                    : 'Pricing unit: ${_displayValue(quoteSnapshot['pricingUnit'])}',
              ),
              Text(
                _isArabic
                    ? 'الإجمالي: ${_displayValue(quoteSnapshot['totalAmount'])}'
                    : 'Total: ${_displayValue(quoteSnapshot['totalAmount'])}',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(_isArabic ? 'إلغاء' : 'Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(_isArabic ? 'تأكيد' : 'Confirm'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return false;
    }

    if (!mounted) {
      return false;
    }

    await requestRef.update(<String, dynamic>{
      'contract': _contractForConfirmation(data),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return true;
  }

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      _awaitingPaymentRequests(String uid) {
    return FirebaseFirestore.instance
        .collection('booking_requests')
        .where('clientId', isEqualTo: uid)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .where((doc) =>
                  (doc.data()['status'] ?? '').toString() == 'awaiting_payment')
              .toList()
            ..sort((a, b) => _asDateTime(b.data()['createdAt'])
                .compareTo(_asDateTime(a.data()['createdAt']))),
        );
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> _existingRequestDocs(
    String requestId,
  ) async {
    final snap = await FirebaseFirestore.instance
        .collection('booking_requests')
        .doc(requestId)
        .get();
    return snap.exists ? [snap] : [];
  }

  Future<void> _submit(String requestId) async {
    if (_loading) return;

    final receiptFileName = _receiptFileNameController.text.trim();

    if (receiptFileName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic
                ? 'أدخل اسم أو مرجع ملف إثبات التحويل أولًا'
                : 'Enter payment proof file name/reference first',
          ),
        ),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      final requestDocs = await _existingRequestDocs(requestId);
      if (requestDocs.isEmpty) {
        throw Exception(
          _isArabic ? 'لم يتم العثور على الطلب' : 'Request not found',
        );
      }

      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      final eligibleDocs = <DocumentSnapshot<Map<String, dynamic>>>[];
      for (final doc in requestDocs) {
        final data = doc.data() ?? const <String, dynamic>{};
        final status = (data['status'] ?? '').toString();
        final clientId = (data['clientId'] ?? '').toString();
        if (status == 'awaiting_payment' && clientId == uid) {
          eligibleDocs.add(doc);
        }
      }

      if (eligibleDocs.isEmpty) {
        throw Exception(
          _isArabic
              ? 'لا توجد نسخة مؤهلة من الطلب لرفع إثبات الدفع'
              : 'No eligible request copy is ready for payment proof',
        );
      }

      final targetDoc = eligibleDocs.first;
      final targetData = targetDoc.data() ?? const <String, dynamic>{};
      final targetRef = targetDoc.reference;
      final contractConfirmed = await _confirmCenterContractIfNeeded(
        targetRef,
        targetData,
      );
      if (!contractConfirmed) {
        return;
      }

      final dataToUpdate = <String, dynamic>{
        'status': 'payment_review',
        'workflowStage': 'payment_review',
        'paymentStatus': 'submitted_by_client',
        'payment_confirmed': false,
        'paymentReceiptFileName': receiptFileName,
        'paymentReceiptUrl': '',
        'paymentSubmittedAt': FieldValue.serverTimestamp(),
        'paymentClientNote': _noteController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
      await targetRef.update(dataToUpdate);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic
                ? 'تم إرسال إثبات التحويل إلى الإدارة'
                : 'Payment proof sent to admin',
          ),
        ),
      );
      Navigator.of(context).maybePop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic
                ? 'فشل إرسال إثبات التحويل: $e'
                : 'Failed to submit payment proof: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void dispose() {
    _receiptFileNameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return DefaultTextStyle.merge(
              style: const TextStyle(color: Color(0xFFFFF4D4)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _backgroundAsset(constraints.maxWidth),
                    fit: BoxFit.cover,
                    alignment: constraints.maxWidth < 700
                        ? Alignment.topCenter
                        : Alignment.center,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.62),
                          Colors.black.withValues(alpha: 0.38),
                          Colors.black.withValues(alpha: 0.74),
                        ],
                      ),
                    ),
                  ),
                  uid.isEmpty
                      ? Center(
                          child: Text(
                            _isArabic
                                ? 'يجب تسجيل الدخول أولًا'
                                : 'Please sign in first',
                            style: const TextStyle(color: Color(0xFFFFF4D4)),
                          ),
                        )
                      : StreamBuilder<
                          List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                          stream: _awaitingPaymentRequests(uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  _isArabic
                                      ? 'تعذر تحميل الطلبات'
                                      : 'Unable to load requests',
                                ),
                              );
                            }

                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            final docs = snapshot.data ?? const [];
                            if (docs.isEmpty) {
                              _selectedRequestId = null;
                              return SafeArea(
                                bottom: false,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 56),
                                    GoldPageTitle(
                                      title: _isArabic
                                          ? 'إثبات التحويل المالي'
                                          : 'Payment proof',
                                    ),
                                    Expanded(
                                      child: PremiumEmptyState(
                                        title: _isArabic
                                            ? 'لا يوجد طلب بانتظار التحويل المالي حاليًا'
                                            : 'No request currently awaiting payment',
                                        icon: Icons.receipt_long_outlined,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            final hasSelection = docs.any(
                              (doc) => doc.id == _selectedRequestId,
                            );
                            final selectedDoc = hasSelection
                                ? docs.firstWhere(
                                    (doc) => doc.id == _selectedRequestId)
                                : docs.first;
                            _selectedRequestId = selectedDoc.id;
                            final selectedData = selectedDoc.data();
                            final selectedClinicianName =
                                (selectedData['assignedClinicianName'] ??
                                        selectedData['clinicianName'] ??
                                        '')
                                    .toString();
                            final selectedCenterName =
                                (selectedData['centerName'] ?? '').toString();
                            final selectedNote =
                                (selectedData['note'] ?? '').toString();
                            final isCenterRequest =
                                (selectedData['requestKind'] ?? '')
                                            .toString() ==
                                        'center' ||
                                    selectedCenterName.trim().isNotEmpty;
                            final stayStart =
                                (selectedData['stayStartDateText'] ??
                                        selectedData['sessionDateText'] ??
                                        '')
                                    .toString();
                            final stayEnd =
                                (selectedData['stayEndDateText'] ?? '')
                                    .toString();
                            final stayDurationDays =
                                (selectedData['stayDurationDays'] ?? '')
                                    .toString();
                            final stayTotalAmount =
                                (selectedData['stayTotalAmount'] ?? '')
                                    .toString();
                            final paymentBreakdownText =
                                (selectedData['paymentBreakdownText'] ?? '')
                                    .toString();

                            return ListView(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 104, 16, 16),
                              children: [
                                GoldPageTitle(
                                  title: _isArabic
                                      ? 'إثبات التحويل المالي'
                                      : 'Payment proof',
                                  padding: const EdgeInsetsDirectional.only(
                                    bottom: 16,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: _glassDecoration(alpha: 0.34),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _isArabic
                                            ? 'اختر الطلب المطلوب رفع إثباته'
                                            : 'Choose the request to upload proof for',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: const Color(0xFFE7C766),
                                              fontWeight: FontWeight.w900,
                                            ),
                                      ),
                                      const SizedBox(height: 12),
                                      for (final doc in docs) ...[
                                        Builder(
                                          builder: (context) {
                                            final data = doc.data();
                                            final clinicianName =
                                                (data['assignedClinicianName'] ??
                                                        data['clinicianName'] ??
                                                        '')
                                                    .toString();
                                            final centerName =
                                                (data['centerName'] ?? '')
                                                    .toString();
                                            final isCenterRequest =
                                                (data['requestKind'] ?? '')
                                                            .toString() ==
                                                        'center' ||
                                                    centerName
                                                        .trim()
                                                        .isNotEmpty;
                                            final note = (data['note'] ?? '')
                                                .toString()
                                                .trim();
                                            final isSelected =
                                                doc.id == _selectedRequestId;

                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                border: Border.all(
                                                  color: isSelected
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .outline
                                                          .withValues(
                                                              alpha: 0.14),
                                                  width: isSelected ? 1.6 : 1,
                                                ),
                                              ),
                                              child: ListTile(
                                                onTap: _loading
                                                    ? null
                                                    : () {
                                                        setState(() {
                                                          _selectedRequestId =
                                                              doc.id;
                                                        });
                                                      },
                                                leading: Icon(
                                                  isSelected
                                                      ? Icons
                                                          .radio_button_checked
                                                      : Icons.radio_button_off,
                                                  color:
                                                      const Color(0xFFE7C766),
                                                ),
                                                title: Text(
                                                  isCenterRequest
                                                      ? (centerName
                                                              .trim()
                                                              .isNotEmpty
                                                          ? centerName
                                                          : (_isArabic
                                                              ? 'طلب مركز'
                                                              : 'Center request'))
                                                      : (clinicianName
                                                              .trim()
                                                              .isNotEmpty
                                                          ? clinicianName
                                                          : (_isArabic
                                                              ? 'طلب بدون اسم أخصائي'
                                                              : 'Request without clinician name')),
                                                ),
                                                subtitle: note.isNotEmpty
                                                    ? Text(
                                                        _isArabic
                                                            ? 'ملاحظتك: $note'
                                                            : 'Your note: $note',
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFFFFF4D4),
                                                        ),
                                                      )
                                                    : null,
                                                textColor:
                                                    const Color(0xFFFFF4D4),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: _glassDecoration(alpha: 0.34),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _isArabic
                                            ? 'تفاصيل الطلب'
                                            : 'Request details',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              color: const Color(0xFFE7C766),
                                              fontWeight: FontWeight.w900,
                                            ),
                                      ),
                                      const SizedBox(height: 10),
                                      if (selectedClinicianName
                                          .trim()
                                          .isNotEmpty)
                                        Text(
                                          _isArabic
                                              ? 'الأخصائي: $selectedClinicianName'
                                              : 'Clinician: $selectedClinicianName',
                                        ),
                                      if (isCenterRequest &&
                                          selectedCenterName.trim().isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Text(
                                            _isArabic
                                                ? 'المركز: $selectedCenterName'
                                                : 'Center: $selectedCenterName',
                                          ),
                                        ),
                                      if (selectedNote.trim().isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Text(
                                            _isArabic
                                                ? 'ملاحظتك: $selectedNote'
                                                : 'Your note: $selectedNote',
                                          ),
                                        ),
                                      if (isCenterRequest &&
                                          stayStart.trim().isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Text(
                                            _isArabic
                                                ? 'بداية الإقامة: $stayStart'
                                                : 'Residency start: $stayStart',
                                          ),
                                        ),
                                      if (isCenterRequest &&
                                          stayEnd.trim().isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Text(
                                            _isArabic
                                                ? 'نهاية الإقامة المبدئية: $stayEnd'
                                                : 'Preliminary residency end: $stayEnd',
                                          ),
                                        ),
                                      if (isCenterRequest &&
                                          stayDurationDays.trim().isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Text(
                                            _isArabic
                                                ? 'عدد الأيام: $stayDurationDays'
                                                : 'Duration days: $stayDurationDays',
                                          ),
                                        ),
                                      if (isCenterRequest &&
                                          paymentBreakdownText
                                              .trim()
                                              .isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Text(
                                            _isArabic
                                                ? 'بيان الدفع: $paymentBreakdownText'
                                                : 'Payment quote: $paymentBreakdownText',
                                          ),
                                        ),
                                      if (isCenterRequest &&
                                          stayTotalAmount.trim().isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Text(
                                            _isArabic
                                                ? 'الإجمالي المستحق: $stayTotalAmount'
                                                : 'Total due: $stayTotalAmount',
                                          ),
                                        ),
                                      const SizedBox(height: 18),
                                      TextField(
                                        controller: _receiptFileNameController,
                                        style: const TextStyle(
                                          color: Color(0xFFFFF4D4),
                                        ),
                                        cursorColor: const Color(0xFFE7C766),
                                        decoration: _darkInputDecoration(
                                          label: _isArabic
                                              ? 'اسم أو مرجع ملف إثبات التحويل'
                                              : 'Payment proof file name/reference',
                                          icon: Icons.description_outlined,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      TextField(
                                        controller: _noteController,
                                        maxLines: 4,
                                        style: const TextStyle(
                                          color: Color(0xFFFFF4D4),
                                        ),
                                        cursorColor: const Color(0xFFE7C766),
                                        decoration: _darkInputDecoration(
                                          label: _isArabic
                                              ? 'ملاحظة إضافية للإدارة'
                                              : 'Additional note to admin',
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 52,
                                        child: FilledButton.icon(
                                          onPressed: _loading
                                              ? null
                                              : () => _submit(selectedDoc.id),
                                          icon: _loading
                                              ? const SizedBox(
                                                  width: 18,
                                                  height: 18,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                  ),
                                                )
                                              : const Icon(Icons.send_outlined),
                                          label: Text(
                                            _loading
                                                ? (_isArabic
                                                    ? 'جارٍ الإرسال...'
                                                    : 'Submitting...')
                                                : (_isArabic
                                                    ? 'إرسال إثبات التحويل'
                                                    : 'Submit payment proof'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                  AppShellActions.buildOverlayActions(
                    onBack: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).maybePop();
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.menu,
                          (route) => false,
                        );
                      }
                    },
                    showLogout: false,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
