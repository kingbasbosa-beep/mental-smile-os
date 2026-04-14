import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/core/auth/account_access_service.dart';
import 'package:flutterprojects/features/centers/presentation/center_document_requirements.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminCentersPage extends StatefulWidget {
  const AdminCentersPage({super.key});

  @override
  State<AdminCentersPage> createState() => _AdminCentersPageState();
}

class _AdminCentersPageState extends State<AdminCentersPage> {
  String _tab = 'pending';
  final _blockingService = AccountBlockingService();

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String _effectiveApprovalStatus(Map<String, dynamic> data) {
    final rawStatus = (data['approvalStatus'] ?? 'pending_admin').toString();
    final isActive = (data['isActive'] ?? false) == true;
    if (isActive) return 'approved';
    return rawStatus;
  }

  Future<void> _moveToFollowUp(String id) async {
    await FirebaseFirestore.instance.collection('centers').doc(id).update({
      'approvalStatus': 'center_follow_up',
      'isActive': false,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    if (!mounted) return;
    setState(() => _tab = 'follow_up');
  }

  Future<void> _approve(String id) async {
    await FirebaseFirestore.instance.collection('centers').doc(id).update({
      'approvalStatus': 'approved',
      'isActive': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _reject(String id) async {
    await FirebaseFirestore.instance.collection('centers').doc(id).update({
      'approvalStatus': 'rejected_admin',
      'isActive': false,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<String?> _askBlockReason(BuildContext context) async {
    final isArabic = _isArabic(context);
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(isArabic ? 'سبب الحظر' : 'Block reason'),
          content: TextField(
            controller: controller,
            maxLines: 3,
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            decoration: InputDecoration(
              hintText: isArabic
                  ? 'اكتب سبب حظر المركز'
                  : 'Enter the reason for blocking this center',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(isArabic ? 'إلغاء' : 'Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final value = controller.text.trim();
                if (value.isEmpty) return;
                Navigator.of(dialogContext).pop(value);
              },
              child: Text(isArabic ? 'تأكيد الحظر' : 'Confirm block'),
            ),
          ],
        );
      },
    );
    controller.dispose();
    return result;
  }

  Future<void> _toggleBlock({
    required BuildContext context,
    required String centerId,
    required bool currentlyBlocked,
  }) async {
    final isArabic = _isArabic(context);
    try {
      if (currentlyBlocked) {
        await _blockingService.unblockAccount(
          collection: 'centers',
          docId: centerId,
        );
      } else {
        final reason = await _askBlockReason(context);
        if (reason == null || reason.trim().isEmpty) return;
        await _blockingService.blockAccount(
          collection: 'centers',
          docId: centerId,
          adminUid: FirebaseAuth.instance.currentUser?.uid ?? '',
          reason: reason,
        );
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            currentlyBlocked
                ? (isArabic
                    ? 'تم إلغاء حظر المركز'
                    : 'Center unblocked successfully')
                : (isArabic ? 'تم حظر المركز' : 'Center blocked successfully'),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تعذر تحديث حالة الحظر: $e'
                : 'Unable to update block state: $e',
          ),
        ),
      );
    }
  }

  List<Map<String, dynamic>> _readDocs(Map<String, dynamic> data) {
    final raw = data['documentItems'];
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((e) => e.map((k, v) => MapEntry('$k', v)))
          .toList();
    }
    return const [];
  }

  String _documentStatusLabel(String status, bool isArabic) {
    switch (status) {
      case 'approved':
        return isArabic ? 'مقبول' : 'Approved';
      case 'rejected':
        return isArabic ? 'مرفوض' : 'Rejected';
      case 'needs_update':
        return isArabic ? 'يحتاج تحديث' : 'Needs update';
      case 'uploaded':
      case 'pending':
      default:
        return isArabic ? 'بانتظار المراجعة' : 'Pending review';
    }
  }

  Color _documentStatusColor(String status) {
    switch (status) {
      case 'approved':
        return const Color(0xFF1F9D63);
      case 'rejected':
        return const Color(0xFFD84B4B);
      case 'needs_update':
        return const Color(0xFFE39B2E);
      case 'uploaded':
      case 'pending':
      default:
        return const Color(0xFF6C55B3);
    }
  }

  String _dateText(dynamic value) {
    if (value is Timestamp) {
      return value.toDate().toLocal().toString().split('.').first;
    }
    final text = (value ?? '').toString().trim();
    if (text.isEmpty) return '';
    return text;
  }

  int _sortOrderValue(Map<String, dynamic> data) {
    final raw = data['sortOrder'];
    if (raw is int) return raw;
    return int.tryParse('${raw ?? ''}') ?? 999999;
  }

  DateTime _moment(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime(1970);
    return DateTime(1970);
  }

  Future<void> _openDocumentUrl(String rawUrl) async {
    final url = rawUrl.trim();
    if (url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) return;
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  Future<void> _updateDocumentStatus({
    required String centerId,
    required List<Map<String, dynamic>> currentDocs,
    required int index,
    required String nextStatus,
  }) async {
    final updated = currentDocs
        .map((item) => Map<String, dynamic>.from(item))
        .toList(growable: false);
    if (index < 0 || index >= updated.length) return;

    updated[index]['status'] = nextStatus;
    updated[index]['adminReviewedBy'] =
        FirebaseAuth.instance.currentUser?.uid ?? '';
    updated[index]['adminReviewedAt'] = DateTime.now().toIso8601String();

    await FirebaseFirestore.instance
        .collection('centers')
        .doc(centerId)
        .update({
      'documentItems': updated,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Map<String, Map<String, dynamic>> _latestRequiredDocuments(
    List<Map<String, dynamic>> docs,
  ) {
    final latest = <String, Map<String, dynamic>>{};
    for (final item in docs) {
      final type = (item['documentType'] ?? '').toString().trim();
      if (!isRequiredCenterDocumentType(type)) continue;
      latest[type] = item;
    }
    return latest;
  }

  Map<String, int> _requiredDocumentReviewSummary(
      List<Map<String, dynamic>> docs) {
    final latest = _latestRequiredDocuments(docs);
    var approved = 0;
    var pending = 0;
    var rejected = 0;
    var needsUpdate = 0;
    var missing = 0;

    for (final requirement in kRequiredCenterDocumentTypes) {
      final key = (requirement['key'] ?? '').trim();
      final item = latest[key];
      if (item == null) {
        missing++;
        continue;
      }

      final status = (item['status'] ?? 'pending').toString().trim();
      switch (status) {
        case 'approved':
          approved++;
          break;
        case 'rejected':
          rejected++;
          break;
        case 'needs_update':
          needsUpdate++;
          break;
        case 'uploaded':
        case 'pending':
        default:
          pending++;
          break;
      }
    }

    return {
      'required': kRequiredCenterDocumentTypes.length,
      'approved': approved,
      'pending': pending,
      'rejected': rejected,
      'needsUpdate': needsUpdate,
      'missing': missing,
    };
  }

  bool _canFinalApproveCenter(List<Map<String, dynamic>> docs) {
    final summary = _requiredDocumentReviewSummary(docs);
    return summary['required'] == summary['approved'] &&
        summary['missing'] == 0 &&
        summary['pending'] == 0 &&
        summary['rejected'] == 0 &&
        summary['needsUpdate'] == 0;
  }

  String _approvalBlockReason({
    required List<Map<String, dynamic>> docs,
    required bool isArabic,
  }) {
    final summary = _requiredDocumentReviewSummary(docs);
    if ((summary['missing'] ?? 0) > 0) {
      return isArabic
          ? 'لا يمكن اعتماد المركز قبل رفع جميع الوثائق المطلوبة.'
          : 'The center cannot be approved until all required documents are uploaded.';
    }
    if ((summary['pending'] ?? 0) > 0) {
      return isArabic
          ? 'لا يمكن اعتماد المركز بينما توجد وثائق ما زالت بانتظار المراجعة.'
          : 'The center cannot be approved while some documents are still pending review.';
    }
    if ((summary['needsUpdate'] ?? 0) > 0) {
      return isArabic
          ? 'لا يمكن اعتماد المركز لأن بعض الوثائق تحتاج إلى تحديث من المركز.'
          : 'The center cannot be approved because some documents still need updates from the center.';
    }
    if ((summary['rejected'] ?? 0) > 0) {
      return isArabic
          ? 'لا يمكن اعتماد المركز لأن بعض الوثائق مرفوضة ويجب استبدالها.'
          : 'The center cannot be approved because some documents are rejected and must be replaced.';
    }
    return isArabic
        ? 'يجب اعتماد جميع الوثائق المطلوبة أولًا.'
        : 'All required documents must be approved first.';
  }

  String _statusLabel(String status, bool isArabic) {
    switch (status) {
      case 'approved':
        return isArabic ? 'مقبول' : 'Approved';
      case 'center_follow_up':
        return isArabic ? 'متابعة التحقق' : 'Follow-up';
      case 'rejected_admin':
      case 'rejected':
        return isArabic ? 'مرفوض' : 'Rejected';
      default:
        return isArabic ? 'بانتظار الإدارة' : 'Pending';
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'approved':
        return const Color(0xFF1F9D63);
      case 'center_follow_up':
        return const Color(0xFFE39B2E);
      case 'rejected_admin':
      case 'rejected':
        return const Color(0xFFD84B4B);
      default:
        return const Color(0xFF6C55B3);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final scheme = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isArabic ? 'إدارة المراكز' : 'Centers Management'),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('centers').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  isArabic ? 'فشل تحميل المراكز' : 'Failed to load centers',
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final allDocs = snapshot.data!.docs.toList()
              ..sort((a, b) {
                final sortCompare = _sortOrderValue(a.data())
                    .compareTo(_sortOrderValue(b.data()));
                if (sortCompare != 0) return sortCompare;

                final aCreated = _moment(a.data()['createdAt']);
                final bCreated = _moment(b.data()['createdAt']);
                return bCreated.compareTo(aCreated);
              });
            final pendingCount = allDocs.where((doc) {
              final data = doc.data();
              final isBlocked = (data['isBlocked'] ?? false) == true;
              if (isBlocked) return false;
              final status = _effectiveApprovalStatus(data);
              return status == 'pending_admin' || status == 'pending_review';
            }).length;
            final followUpCount = allDocs.where((doc) {
              final data = doc.data();
              final isBlocked = (data['isBlocked'] ?? false) == true;
              if (isBlocked) return false;
              final status = _effectiveApprovalStatus(data);
              return status == 'center_follow_up';
            }).length;
            final approvedCount = allDocs.where((doc) {
              final data = doc.data();
              final isBlocked = (data['isBlocked'] ?? false) == true;
              if (isBlocked) return false;
              final status = _effectiveApprovalStatus(data);
              return status == 'approved';
            }).length;
            final rejectedCount = allDocs.where((doc) {
              final data = doc.data();
              final isBlocked = (data['isBlocked'] ?? false) == true;
              if (isBlocked) return false;
              final status = _effectiveApprovalStatus(data);
              return status == 'rejected_admin' || status == 'rejected';
            }).length;
            final blockedCount = allDocs.where((doc) {
              final data = doc.data();
              return (data['isBlocked'] ?? false) == true;
            }).length;

            final docs = allDocs.where((doc) {
              final data = doc.data();
              final isBlocked = (data['isBlocked'] ?? false) == true;
              if (_tab == 'blocked') return isBlocked;
              if (isBlocked) return false;
              final status = _effectiveApprovalStatus(data);

              if (_tab == 'pending') {
                return status == 'pending_admin' || status == 'pending_review';
              }
              if (_tab == 'follow_up') return status == 'center_follow_up';
              if (_tab == 'approved') return status == 'approved';
              return status == 'rejected_admin' || status == 'rejected';
            }).toList();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ChoiceChip(
                      selected: _tab == 'pending',
                      label: Text(
                        isArabic
                            ? 'بانتظار الإدارة ($pendingCount)'
                            : 'Pending ($pendingCount)',
                      ),
                      onSelected: (_) => setState(() => _tab = 'pending'),
                    ),
                    ChoiceChip(
                      selected: _tab == 'follow_up',
                      label: Text(
                        isArabic
                            ? 'متابعة التحقق ($followUpCount)'
                            : 'Follow-up ($followUpCount)',
                      ),
                      onSelected: (_) => setState(() => _tab = 'follow_up'),
                    ),
                    ChoiceChip(
                      selected: _tab == 'approved',
                      label: Text(
                        isArabic
                            ? 'مراكز مقبولة ($approvedCount)'
                            : 'Approved ($approvedCount)',
                      ),
                      onSelected: (_) => setState(() => _tab = 'approved'),
                    ),
                    ChoiceChip(
                      selected: _tab == 'rejected',
                      label: Text(
                        isArabic
                            ? 'مراكز مرفوضة ($rejectedCount)'
                            : 'Rejected ($rejectedCount)',
                      ),
                      onSelected: (_) => setState(() => _tab = 'rejected'),
                    ),
                    ChoiceChip(
                      selected: _tab == 'blocked',
                      label: Text(
                        isArabic
                            ? 'مراكز محظورة ($blockedCount)'
                            : 'Blocked ($blockedCount)',
                      ),
                      onSelected: (_) => setState(() => _tab = 'blocked'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (docs.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        isArabic
                            ? 'لا توجد مراكز في هذا القسم'
                            : 'No centers in this section',
                      ),
                    ),
                  )
                else
                  ...docs.map((doc) {
                    final data = doc.data();
                    final id = doc.id;
                    final name = (data['centerName'] ??
                            data['displayName'] ??
                            data['name'] ??
                            'Center')
                        .toString();
                    final category = (data['category'] ?? '').toString();
                    final email = (data['email'] ?? '').toString();
                    final city = (data['city'] ?? '').toString();
                    final area = (data['area'] ?? '').toString();
                    final status = _effectiveApprovalStatus(data);
                    final isBlocked = (data['isBlocked'] ?? false) == true;
                    final blockReason =
                        (data['blockReason'] ?? '').toString().trim();
                    final blockedAt = _dateText(data['blockedAt']);
                    final sortOrder = (data['sortOrder'] ?? '').toString();
                    final docs = _readDocs(data);
                    final pendingDocs = docs
                        .where((e) =>
                            (e['status'] ?? 'pending').toString() == 'pending')
                        .length;
                    final requiredSummary =
                        _requiredDocumentReviewSummary(docs);
                    final canFinalApprove = _canFinalApproveCenter(docs);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: scheme.outline.withValues(alpha: 0.14),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: isArabic
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                  textAlign: isArabic
                                      ? TextAlign.right
                                      : TextAlign.left,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _statusColor(status)
                                      .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  _statusLabel(status, isArabic),
                                  style: TextStyle(
                                    color: _statusColor(status),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              if (isBlocked) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD84B4B)
                                        .withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    isArabic ? 'محظور' : 'Blocked',
                                    style: const TextStyle(
                                      color: Color(0xFFD84B4B),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                              if (email.trim().isNotEmpty) ...[
                                const SizedBox(height: 6),
                                Text(
                                  email,
                                  textAlign: isArabic
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              if (category.isNotEmpty) _chip(category),
                              if (city.isNotEmpty || area.isNotEmpty)
                                _chip(
                                  [city, area]
                                      .where((e) => e.trim().isNotEmpty)
                                      .join(' / '),
                                ),
                              if (sortOrder.isNotEmpty)
                                _chip('sortOrder: $sortOrder'),
                              if (docs.isNotEmpty)
                                _chip(
                                  isArabic
                                      ? 'وثائق مرفوعة: ${docs.length}'
                                      : 'Uploaded docs: ${docs.length}',
                                ),
                              if (pendingDocs > 0)
                                _chip(
                                  isArabic
                                      ? 'بانتظار المراجعة: $pendingDocs'
                                      : 'Pending review: $pendingDocs',
                                ),
                              _chip(
                                isArabic
                                    ? 'اكتمال الوثائق المطلوبة: ${requiredSummary['approved']} / ${requiredSummary['required']}'
                                    : 'Required docs completed: ${requiredSummary['approved']} / ${requiredSummary['required']}',
                              ),
                              if ((requiredSummary['missing'] ?? 0) > 0)
                                _chip(
                                  isArabic
                                      ? 'غير مرفوعة: ${requiredSummary['missing']}'
                                      : 'Missing: ${requiredSummary['missing']}',
                                ),
                              if ((requiredSummary['needsUpdate'] ?? 0) > 0)
                                _chip(
                                  isArabic
                                      ? 'تحتاج تحديث: ${requiredSummary['needsUpdate']}'
                                      : 'Needs update: ${requiredSummary['needsUpdate']}',
                                ),
                              if ((requiredSummary['rejected'] ?? 0) > 0)
                                _chip(
                                  isArabic
                                      ? 'مرفوضة: ${requiredSummary['rejected']}'
                                      : 'Rejected: ${requiredSummary['rejected']}',
                                ),
                              if (isBlocked)
                                _chip(
                                  isArabic
                                      ? 'سبب الحظر: ${blockReason.isEmpty ? "غير محدد" : blockReason}'
                                      : 'Block reason: ${blockReason.isEmpty ? "Not provided" : blockReason}',
                                ),
                              if (isBlocked && blockedAt.isNotEmpty)
                                _chip(
                                  isArabic
                                      ? 'تاريخ الحظر: $blockedAt'
                                      : 'Blocked at: $blockedAt',
                                ),
                            ],
                          ),
                          if (docs.isNotEmpty) ...[
                            const SizedBox(height: 14),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: scheme.primary.withValues(alpha: 0.04),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: scheme.outline.withValues(alpha: 0.10),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: isArabic
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isArabic
                                        ? 'مراجعة وثائق المركز'
                                        : 'Center document review',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    isArabic
                                        ? 'حالة الوثائق مستقلة عن حالة اعتماد المركز. استخدمها لتقييم المستندات قبل اتخاذ قرار الاعتماد.'
                                        : 'Document review is separate from center account approval. Use it to inspect supporting files before account decisions.',
                                    textAlign: isArabic
                                        ? TextAlign.right
                                        : TextAlign.left,
                                  ),
                                  const SizedBox(height: 12),
                                  ...docs.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final item = entry.value;
                                    final docType =
                                        (item['documentType'] ?? '').toString();
                                    final fileName =
                                        (item['originalFileName'] ??
                                                item['fileName'] ??
                                                '')
                                            .toString();
                                    final fileUrl = (item['fileUrl'] ?? '')
                                        .toString()
                                        .trim();
                                    final docStatus =
                                        (item['status'] ?? 'pending')
                                            .toString();
                                    final reviewNote =
                                        (item['reviewNote'] ?? '')
                                            .toString()
                                            .trim();
                                    final uploadedAt =
                                        _dateText(item['uploadedAt']);

                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: scheme.surface,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: scheme.outline
                                              .withValues(alpha: 0.10),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: isArabic
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: isArabic
                                                      ? CrossAxisAlignment.end
                                                      : CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(
                                                      docType.isEmpty
                                                          ? (isArabic
                                                              ? 'وثيقة'
                                                              : 'Document')
                                                          : docType,
                                                      textAlign: isArabic
                                                          ? TextAlign.right
                                                          : TextAlign.left,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                    if (fileName
                                                        .trim()
                                                        .isNotEmpty) ...[
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        isArabic
                                                            ? 'الملف: $fileName'
                                                            : 'File: $fileName',
                                                      ),
                                                    ],
                                                    if (uploadedAt
                                                        .isNotEmpty) ...[
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        isArabic
                                                            ? 'تاريخ الرفع: $uploadedAt'
                                                            : 'Uploaded at: $uploadedAt',
                                                      ),
                                                    ],
                                                    if (reviewNote
                                                        .isNotEmpty) ...[
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        isArabic
                                                            ? 'ملاحظة المركز: $reviewNote'
                                                            : 'Center note: $reviewNote',
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: _documentStatusColor(
                                                    docStatus,
                                                  ).withValues(alpha: 0.12),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    999,
                                                  ),
                                                ),
                                                child: Text(
                                                  _documentStatusLabel(
                                                    docStatus,
                                                    isArabic,
                                                  ),
                                                  style: TextStyle(
                                                    color: _documentStatusColor(
                                                      docStatus,
                                                    ),
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (fileUrl.isNotEmpty) ...[
                                            const SizedBox(height: 10),
                                            Align(
                                              alignment: isArabic
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              child: OutlinedButton.icon(
                                                onPressed: () =>
                                                    _openDocumentUrl(fileUrl),
                                                icon: const Icon(
                                                  Icons.open_in_new,
                                                ),
                                                label: Text(
                                                  isArabic
                                                      ? 'فتح رابط الوثيقة'
                                                      : 'Open document link',
                                                ),
                                              ),
                                            ),
                                          ],
                                          const SizedBox(height: 10),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            alignment: WrapAlignment.end,
                                            children: [
                                              FilledButton.tonalIcon(
                                                onPressed: () =>
                                                    _updateDocumentStatus(
                                                  centerId: id,
                                                  currentDocs: docs,
                                                  index: index,
                                                  nextStatus: 'approved',
                                                ),
                                                icon: const Icon(
                                                  Icons.check_circle_outline,
                                                ),
                                                label: Text(
                                                  isArabic
                                                      ? 'قبول الوثيقة'
                                                      : 'Approve document',
                                                ),
                                              ),
                                              FilledButton.tonalIcon(
                                                onPressed: () =>
                                                    _updateDocumentStatus(
                                                  centerId: id,
                                                  currentDocs: docs,
                                                  index: index,
                                                  nextStatus: 'needs_update',
                                                ),
                                                icon: const Icon(
                                                  Icons.refresh_outlined,
                                                ),
                                                label: Text(
                                                  isArabic
                                                      ? 'يحتاج تحديث'
                                                      : 'Needs update',
                                                ),
                                              ),
                                              OutlinedButton.icon(
                                                onPressed: () =>
                                                    _updateDocumentStatus(
                                                  centerId: id,
                                                  currentDocs: docs,
                                                  index: index,
                                                  nextStatus: 'rejected',
                                                ),
                                                icon: const Icon(
                                                  Icons.cancel_outlined,
                                                ),
                                                label: Text(
                                                  isArabic
                                                      ? 'رفض الوثيقة'
                                                      : 'Reject document',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              if (status == 'pending_admin' ||
                                  status == 'pending_review')
                                FilledButton.icon(
                                  onPressed: () => _moveToFollowUp(id),
                                  icon: const Icon(Icons.fact_check_outlined),
                                  label: Text(
                                    isArabic ? 'تحويل للمتابعة' : 'Follow-up',
                                  ),
                                ),
                              if (status == 'center_follow_up')
                                FilledButton.icon(
                                  onPressed: canFinalApprove
                                      ? () => _approve(id)
                                      : null,
                                  icon: const Icon(Icons.check_circle_outline),
                                  label: Text(
                                    isArabic ? 'قبول نهائي' : 'Final approve',
                                  ),
                                ),
                              if (status == 'pending_admin' ||
                                  status == 'pending_review' ||
                                  status == 'center_follow_up')
                                OutlinedButton.icon(
                                  onPressed: () => _reject(id),
                                  icon: const Icon(Icons.cancel_outlined),
                                  label: Text(isArabic ? 'رفض' : 'Reject'),
                                ),
                              OutlinedButton.icon(
                                onPressed: () => _toggleBlock(
                                  context: context,
                                  centerId: id,
                                  currentlyBlocked: isBlocked,
                                ),
                                icon: Icon(
                                  isBlocked
                                      ? Icons.lock_open_outlined
                                      : Icons.block_outlined,
                                ),
                                label: Text(
                                  isBlocked
                                      ? (isArabic ? 'إلغاء الحظر' : 'Unblock')
                                      : (isArabic ? 'حظر' : 'Block'),
                                ),
                              ),
                            ],
                          ),
                          if (status == 'center_follow_up' &&
                              !canFinalApprove) ...[
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE39B2E)
                                    .withValues(alpha: 0.10),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFE39B2E)
                                      .withValues(alpha: 0.25),
                                ),
                              ),
                              child: Text(
                                _approvalBlockReason(
                                  docs: docs,
                                  isArabic: isArabic,
                                ),
                                textAlign:
                                    isArabic ? TextAlign.right : TextAlign.left,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
