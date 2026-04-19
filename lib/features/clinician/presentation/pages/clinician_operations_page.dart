import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class ClinicianOperationsPage extends StatefulWidget {
  const ClinicianOperationsPage({super.key});

  @override
  State<ClinicianOperationsPage> createState() =>
      _ClinicianOperationsPageState();
}

class _ClinicianOperationsPageState extends State<ClinicianOperationsPage> {
  String _tab = 'assigned_clinician';
  final Set<String> _busyIds = {};

  final _requestedPhotoUrlController = TextEditingController();
  final _requestedBioController = TextEditingController();

  bool _submittingChangeRequest = false;

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> _setBusy(String id, bool value) async {
    if (!mounted) return;
    setState(() {
      if (value) {
        _busyIds.add(id);
      } else {
        _busyIds.remove(id);
      }
    });
  }

  Future<void> _updateRequestEverywhere(
    String requestId,
    Map<String, dynamic> updates,
  ) async {
    final db = FirebaseFirestore.instance;
    final payload = {
      ...updates,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final refs = [
      db.collection('booking_requests').doc(requestId),
      db.collection('bookingRequests').doc(requestId),
    ];

    for (final ref in refs) {
      final snap = await ref.get();
      if (snap.exists) {
        await ref.update(payload);
      }
    }
  }

  Future<void> _acceptRequest(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'awaiting_payment',
        'clinicianAccepted': true,
        'clinicianRejected': false,
        'clinicianCompleted': false,
        'clinicianRespondedAt': FieldValue.serverTimestamp(),
        'paymentStatus': 'pending_client_transfer',
        'sessionStatus': 'not_created',
        'reviewStatus': 'not_started',
        'payoutStatus': 'blocked',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تمت الموافقة، والطلب الآن بانتظار التحويل المالي'
                : 'Accepted. Request is now awaiting payment.',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _rejectRequest(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'clinician_rejected',
        'clinicianAccepted': false,
        'clinicianRejected': true,
        'clinicianCompleted': false,
        'clinicianRespondedAt': FieldValue.serverTimestamp(),
        'paymentStatus': 'not_applicable',
        'sessionStatus': 'not_created',
        'reviewStatus': 'not_started',
        'payoutStatus': 'blocked',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context) ? 'تم رفض الطلب' : 'Request rejected',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _markCompleted(String requestId) async {
    await _setBusy(requestId, true);
    try {
      await _updateRequestEverywhere(requestId, {
        'status': 'session_completed_pending_reviews',
        'clinicianAccepted': true,
        'clinicianRejected': false,
        'clinicianCompleted': true,
        'completedAt': FieldValue.serverTimestamp(),
        'reviewStatus': 'pending_reviews',
        'payoutStatus': 'blocked',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم تعليم الجلسة كمكتملة وبانتظار التقييمات'
                : 'Session marked completed and now pending reviews.',
          ),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  bool _matchesTab(String status) {
    switch (_tab) {
      case 'in_progress':
        return status == 'awaiting_payment' ||
            status == 'payment_review' ||
            status == 'session_setup_pending' ||
            status == 'session_scheduled' ||
            status == 'session_in_progress' ||
            status == 'reschedule_pending' ||
            status == 'payout_pending';
      case 'completed':
        return status == 'session_completed_pending_reviews' ||
            status == 'completed' ||
            status == 'completed_success';
      case 'closed':
        return status == 'clinician_rejected' ||
            status == 'cancelled' ||
            status == 'rejected_admin';
      default:
        return status == 'assigned_clinician';
    }
  }

  String _statusLabel(String status, bool isArabic) {
    switch (status) {
      case 'awaiting_payment':
        return isArabic ? 'بانتظار التحويل المالي' : 'Awaiting payment';
      case 'payment_review':
        return isArabic ? 'مراجعة السداد' : 'Payment review';
      case 'session_setup_pending':
        return isArabic ? 'بانتظار تجهيز الجلسة' : 'Session setup pending';
      case 'reschedule_pending':
        return isArabic ? 'إعادة جدولة' : 'Reschedule';
      case 'payout_pending':
        return isArabic ? 'بانتظار التحويل' : 'Payout pending';
      case 'session_scheduled':
        return isArabic ? 'جلسة مجدولة' : 'Scheduled';
      case 'session_in_progress':
        return isArabic ? 'جلسة جارية' : 'In progress';
      case 'session_completed_pending_reviews':
        return isArabic ? 'بانتظار التقييمات' : 'Pending reviews';
      case 'completed':
      case 'completed_success':
        return isArabic ? 'مكتمل' : 'Completed';
      case 'clinician_rejected':
        return isArabic ? 'مرفوض من الأخصائي' : 'Rejected by clinician';
      case 'rejected_admin':
        return isArabic ? 'مرفوض من الإدارة' : 'Rejected by admin';
      case 'cancelled':
        return isArabic ? 'ملغي' : 'Cancelled';
      default:
        return isArabic ? 'طلب جديد' : 'New request';
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'awaiting_payment':
      case 'payment_review':
      case 'session_setup_pending':
      case 'reschedule_pending':
      case 'payout_pending':
        return const Color(0xFFE39B2E);
      case 'session_scheduled':
      case 'session_in_progress':
        return const Color(0xFF2E5AAC);
      case 'session_completed_pending_reviews':
      case 'completed':
      case 'completed_success':
        return const Color(0xFF1F9D63);
      case 'clinician_rejected':
      case 'rejected_admin':
      case 'cancelled':
        return const Color(0xFFD84B4B);
      default:
        return const Color(0xFF6C55B3);
    }
  }

  String _dateText(dynamic value) {
    if (value is Timestamp) {
      final d = value.toDate();
      final day = d.day.toString().padLeft(2, '0');
      final month = d.month.toString().padLeft(2, '0');
      final year = d.year.toString();
      final hour = d.hour.toString().padLeft(2, '0');
      final minute = d.minute.toString().padLeft(2, '0');
      return '$hour:$minute $day-$month-$year';
    }
    return '';
  }

  int _sortByCreatedAtDesc(
    QueryDocumentSnapshot<Map<String, dynamic>> a,
    QueryDocumentSnapshot<Map<String, dynamic>> b,
  ) {
    final aTs = a.data()['createdAt'];
    final bTs = b.data()['createdAt'];

    final aDate = aTs is Timestamp
        ? aTs.toDate()
        : DateTime.fromMillisecondsSinceEpoch(0);
    final bDate = bTs is Timestamp
        ? bTs.toDate()
        : DateTime.fromMillisecondsSinceEpoch(0);

    return bDate.compareTo(aDate);
  }

  Stream<Map<String, dynamic>?> _clinicianStream() {
    if (_uid.isEmpty) return Stream.value(null);

    return FirebaseFirestore.instance
        .collection('clinicians')
        .doc(_uid)
        .snapshots()
        .map((doc) => doc.data());
  }

  Stream<int> _messagesCountStream() {
    if (_uid.isEmpty) return Stream.value(0);

    return FirebaseFirestore.instance
        .collection('chat_threads')
        .where('ownerUid', isEqualTo: _uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              return (data['needsHumanSupport'] ?? false) == true ||
                  (data['handoffState'] ?? '').toString() == 'admin_review' ||
                  (data['handoffState'] ?? '').toString() == 'admin_replying';
            }).length)
        .handleError((_) => 0);
  }

  Stream<int> _chatCasesCountStream() {
    if (_uid.isEmpty) return Stream.value(0);

    return FirebaseFirestore.instance
        .collection('chat_escalations')
        .where('assignedToType', isEqualTo: 'clinician')
        .where('assignedToUid', isEqualTo: _uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              return (data['status'] ?? '').toString() != 'resolved';
            }).length)
        .handleError((_) => 0);
  }

  Widget _buildHomeSummary({
    required BuildContext context,
    required bool isArabic,
    required Map<String, dynamic> clinicianData,
    required String clinicianName,
    required String clinicianBio,
    required String clinicianPhotoUrl,
  }) {
    return Column(
      children: [
        _buildClinicianHeaderCard(
          context: context,
          isArabic: isArabic,
          clinicianName: clinicianName,
          clinicianBio: clinicianBio,
          clinicianPhotoUrl: clinicianPhotoUrl,
        ),
        const SizedBox(height: 14),
        _buildChatCasesSummaryCard(
          context: context,
          isArabic: isArabic,
        ),
        const SizedBox(height: 12),
        _buildAdminChatSummaryCard(
          context: context,
          isArabic: isArabic,
        ),
        const SizedBox(height: 12),
        _buildRatingsSummary(isArabic),
        const SizedBox(height: 12),
        _buildProfileWorkspaceSection(
          context: context,
          isArabic: isArabic,
          clinicianData: clinicianData,
        ),
      ],
    );
  }

  Widget _buildAssignmentsSection({
    required BuildContext context,
    required bool isArabic,
    required List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  }) {
    return Column(
      children: [
        _buildAssignmentsIntro(
          context: context,
          isArabic: isArabic,
        ),
        const SizedBox(height: 12),
        _buildAssignmentsHeader(
          context: context,
          isArabic: isArabic,
        ),
        const SizedBox(height: 16),
        if (docs.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                isArabic
                    ? 'لا توجد طلبات في هذا القسم'
                    : 'No requests in this section',
              ),
            ),
          )
        else
          ...docs.map((doc) {
            final data = doc.data();
            return _buildAssignmentCard(
              context: context,
              isArabic: isArabic,
              requestId: doc.id,
              data: data,
            );
          }),
      ],
    );
  }

  Widget _buildAssignmentsIntro({
    required BuildContext context,
    required bool isArabic,
  }) {
    return Align(
      alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic
                ? 'الحالات والطلبات المعينة'
                : 'Assigned cases and requests',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            isArabic
                ? 'هذه هي المساحة الأساسية لمراجعة الطلبات المحوّلة إليك واتخاذ إجراءات القبول أو الرفض أو الإكمال.'
                : 'This is the primary area for reviewing requests assigned to you and taking accept, reject, or completion actions.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileWorkspaceSection({
    required BuildContext context,
    required bool isArabic,
    required Map<String, dynamic> clinicianData,
  }) {
    return Column(
      children: [
        Align(
          alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
          child: Column(
            crossAxisAlignment:
                isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                isArabic
                    ? 'الملف المهني المضمّن'
                    : 'Embedded professional profile',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                isArabic
                    ? 'هذه مساحة ملف مهني مدمجة مؤقتًا داخل الصفحة الرئيسية. وهي ليست مسارًا تشغيليًا موازيًا للطلبات أو الجلسات أو حالات الشات.'
                    : 'This is a temporary embedded professional profile area inside the home workspace. It is not a parallel operational flow like assignments, sessions, or chat cases.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildProfileChangeRequestCard(
          context: context,
          isArabic: isArabic,
          clinicianData: clinicianData,
        ),
        const SizedBox(height: 12),
        _buildProfileChangeRequestsSection(
          context: context,
          isArabic: isArabic,
        ),
      ],
    );
  }

  Widget _buildClinicianHeaderCard({
    required BuildContext context,
    required bool isArabic,
    required String clinicianName,
    required String clinicianBio,
    required String clinicianPhotoUrl,
  }) {
    final scheme = Theme.of(context).colorScheme;

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: scheme.primary.withValues(alpha: 0.12),
            backgroundImage: clinicianPhotoUrl.trim().isNotEmpty
                ? NetworkImage(clinicianPhotoUrl)
                : null,
            child: clinicianPhotoUrl.trim().isNotEmpty
                ? null
                : Text(
                    clinicianName.isEmpty
                        ? 'C'
                        : clinicianName.characters.first,
                    style: TextStyle(
                      color: scheme.primary,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  clinicianName.isEmpty
                      ? (isArabic ? 'أخصائي' : 'Clinician')
                      : clinicianName,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),
                const SizedBox(height: 6),
                Text(
                  clinicianBio.isEmpty
                      ? (isArabic
                          ? 'لا توجد نبذة محفوظة حاليًا'
                          : 'No saved bio yet')
                      : clinicianBio,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminChatSummaryCard({
    required BuildContext context,
    required bool isArabic,
  }) {
    return StreamBuilder<int>(
      stream: _messagesCountStream(),
      builder: (context, msgSnapshot) {
        final count = msgSnapshot.data ?? 0;
        return _SectionCard(
          title: isArabic ? 'الشات مع الإدارة' : 'Chat with admin',
          subtitle: isArabic
              ? 'عدد المحادثات المفتوحة مع الإدارة: $count'
              : 'Open conversations with admin: $count',
          icon: Icons.chat_bubble_outline_rounded,
          actionLabel: isArabic ? 'فتح الشات' : 'Open chat',
          onTap: () {
            Navigator.of(context).pushNamed(
              Routes.chat,
              arguments: const {'mode': 'admin_support'},
            );
          },
        );
      },
    );
  }

  Widget _buildChatCasesSummaryCard({
    required BuildContext context,
    required bool isArabic,
  }) {
    return StreamBuilder<int>(
      stream: _chatCasesCountStream(),
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        return _SectionCard(
          title: isArabic ? 'حالات الشات المحالة' : 'Referred chat cases',
          subtitle: isArabic
              ? 'حالات شات مصعّدة أو مُحالة تتطلب تدخل الأخصائي: $count'
              : 'Escalated or referred chat cases that need clinician involvement: $count',
          icon: Icons.forum_outlined,
          actionLabel: isArabic ? 'فتح الحالات' : 'Open cases',
          onTap: () {
            Navigator.of(context).pushNamed(Routes.clinicianChatInbox);
          },
        );
      },
    );
  }

  Widget _buildProfileChangeRequestCard({
    required BuildContext context,
    required bool isArabic,
    required Map<String, dynamic> clinicianData,
  }) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: scheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isArabic
                ? 'طلب تعديل الصورة أو النبذة'
                : 'Request photo or bio update',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            isArabic
                ? 'أي تعديل على الصورة الشخصية أو النبذة يذهب للإدارة أولًا للمراجعة والموافقة. الاسم والوثائق غير قابلة للتعديل من هنا.'
                : 'Any update to the profile photo or bio is sent to admin for approval first. Name and documents cannot be edited here.',
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _requestedPhotoUrlController,
            decoration: InputDecoration(
              labelText: isArabic ? 'رابط الصورة الجديدة' : 'New photo URL',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _requestedBioController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: isArabic ? 'النبذة الجديدة' : 'New bio',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: _submittingChangeRequest
                  ? null
                  : () => _submitProfileChangeRequest(context, clinicianData),
              icon: _submittingChangeRequest
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.fact_check_outlined),
              label: Text(
                _submittingChangeRequest
                    ? (isArabic ? 'جارٍ إرسال الطلب...' : 'Sending request...')
                    : (isArabic ? 'إرسال طلب التعديل' : 'Send change request'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileChangeRequestsSection({
    required BuildContext context,
    required bool isArabic,
  }) {
    final scheme = Theme.of(context).colorScheme;

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('clinician_profile_change_requests')
          .where('clinicianId', isEqualTo: _uid)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, reqSnapshot) {
        if (reqSnapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: scheme.outline.withValues(alpha: 0.12),
              ),
            ),
            child: Text(
              isArabic
                  ? 'تعذر تحميل طلبات التعديل: ${reqSnapshot.error}'
                  : 'Unable to load change requests: ${reqSnapshot.error}',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
            ),
          );
        }

        if (!reqSnapshot.hasData) {
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: scheme.outline.withValues(alpha: 0.12),
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final requests = reqSnapshot.data!.docs;

        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: scheme.outline.withValues(alpha: 0.12),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                isArabic ? 'طلبات التعديل السابقة' : 'Previous change requests',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              if (requests.isEmpty)
                Text(
                  isArabic
                      ? 'لا توجد طلبات تعديل حتى الآن'
                      : 'No change requests yet',
                )
              else
                ...requests.map((doc) {
                  final data = doc.data();
                  final status = (data['status'] ?? 'pending').toString();
                  final requestType = (data['requestType'] ?? '').toString();
                  final requestedBio = (data['requestedBio'] ?? '').toString();
                  final requestedPhotoUrl =
                      (data['requestedPhotoUrl'] ?? '').toString();
                  final adminNote = (data['adminNote'] ?? '').toString();
                  final createdAt = _dateText(data['createdAt']);

                  String typeLabel() {
                    switch (requestType) {
                      case 'bio_update':
                        return isArabic
                            ? 'نوع الطلب: تعديل نبذة'
                            : 'Type: Bio update';
                      case 'photo_update':
                        return isArabic
                            ? 'نوع الطلب: تعديل صورة'
                            : 'Type: Photo update';
                      case 'photo_add':
                        return isArabic
                            ? 'نوع الطلب: إضافة صورة'
                            : 'Type: Photo add';
                      default:
                        return isArabic
                            ? 'نوع الطلب: تعديل بيانات'
                            : 'Type: Profile update';
                    }
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          isArabic ? 'الحالة: $status' : 'Status: $status',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(typeLabel()),
                        if (createdAt.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            isArabic
                                ? 'تاريخ الطلب: $createdAt'
                                : 'Request date: $createdAt',
                          ),
                        ],
                        if (requestedPhotoUrl.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            isArabic
                                ? 'الصورة المطلوبة: $requestedPhotoUrl'
                                : 'Requested photo: $requestedPhotoUrl',
                          ),
                        ],
                        if (requestedBio.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            isArabic
                                ? 'النبذة المطلوبة: $requestedBio'
                                : 'Requested bio: $requestedBio',
                          ),
                        ],
                        if (adminNote.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            isArabic
                                ? 'ملاحظة الإدارة: $adminNote'
                                : 'Admin note: $adminNote',
                          ),
                        ],
                      ],
                    ),
                  );
                }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAssignmentsHeader({
    required BuildContext context,
    required bool isArabic,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        FilledButton.icon(
          onPressed: () =>
              Navigator.of(context).pushNamed(Routes.clinicianSessions),
          icon: const Icon(Icons.video_call_outlined),
          label: Text(isArabic ? 'جلساتي' : 'My Sessions'),
        ),
        ChoiceChip(
          selected: _tab == 'assigned_clinician',
          label: Text(isArabic ? 'طلبات جديدة' : 'New'),
          onSelected: (_) => setState(() => _tab = 'assigned_clinician'),
        ),
        ChoiceChip(
          selected: _tab == 'in_progress',
          label: Text(isArabic ? 'طلبات نشطة' : 'In progress'),
          onSelected: (_) => setState(() => _tab = 'in_progress'),
        ),
        ChoiceChip(
          selected: _tab == 'completed',
          label: Text(isArabic ? 'مكتملة' : 'Completed'),
          onSelected: (_) => setState(() => _tab = 'completed'),
        ),
        ChoiceChip(
          selected: _tab == 'closed',
          label: Text(isArabic ? 'مرفوضة/ملغاة' : 'Closed'),
          onSelected: (_) => setState(() => _tab = 'closed'),
        ),
      ],
    );
  }

  Widget _buildAssignmentCard({
    required BuildContext context,
    required bool isArabic,
    required String requestId,
    required Map<String, dynamic> data,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final busy = _busyIds.contains(requestId);

    final clientName = (data['clientName'] ?? 'Client').toString();
    final clientId = (data['clientId'] ?? '').toString();
    final note = (data['note'] ?? '').toString();
    final status = (data['status'] ?? 'assigned_clinician').toString();
    final clinicianReviewSubmitted =
        (data['clinicianReviewSubmitted'] ?? false) == true;
    final createdAt = _dateText(data['createdAt']);
    final assignedName = (data['assignedClinicianName'] ?? '').toString();
    final sessionStatus = (data['sessionStatus'] ?? '').toString();
    final reviewStatus = (data['reviewStatus'] ?? '').toString();
    final canReviewSession = !clinicianReviewSubmitted &&
        (status == 'session_completed_pending_reviews' ||
            status == 'payout_pending' ||
            (sessionStatus == 'completed' &&
                (reviewStatus == 'pending_reviews' ||
                    reviewStatus == 'partial')));

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
        crossAxisAlignment:
            isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      clientName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isArabic
                          ? 'طلب محول من الإدارة'
                          : 'Request assigned by admin',
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _statusColor(status).withValues(alpha: 0.12),
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
            ],
          ),
          const SizedBox(height: 12),
          if (assignedName.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                isArabic
                    ? 'الأخصائي المعين: $assignedName'
                    : 'Assigned clinician: $assignedName',
              ),
            ),
          if (clientId.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                isArabic ? 'معرف العميل: $clientId' : 'Client ID: $clientId',
              ),
            ),
          if (createdAt.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                isArabic
                    ? 'تاريخ الطلب: $createdAt'
                    : 'Request date: $createdAt',
              ),
            ),
          if (note.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                isArabic ? 'ملاحظة العميل: $note' : 'Client note: $note',
              ),
            ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              if (status == 'assigned_clinician')
                FilledButton.icon(
                  onPressed: busy ? null : () => _acceptRequest(requestId),
                  icon: const Icon(Icons.check_circle_outline),
                  label: Text(isArabic ? 'قبول الطلب' : 'Accept request'),
                ),
              if (status == 'assigned_clinician')
                OutlinedButton.icon(
                  onPressed: busy ? null : () => _rejectRequest(requestId),
                  icon: const Icon(Icons.cancel_outlined),
                  label: Text(isArabic ? 'رفض الطلب' : 'Reject request'),
                ),
              if (status == 'session_scheduled' ||
                  status == 'session_in_progress')
                FilledButton.tonalIcon(
                  onPressed: busy ? null : () => _markCompleted(requestId),
                  icon: const Icon(Icons.task_alt_outlined),
                  label: Text(isArabic ? 'تعليم كمكتمل' : 'Mark completed'),
                ),
              if (canReviewSession)
                FilledButton.icon(
                  onPressed: busy
                      ? null
                      : () {
                          Navigator.of(context).pushNamed(
                            Routes.sessionReview,
                            arguments: {
                              'requestId': requestId,
                              'reviewerType': 'clinician',
                            },
                          );
                        },
                  icon: const Icon(Icons.rate_review_outlined),
                  label: Text(isArabic ? 'تقييم الجلسة' : 'Review session'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingsSummary(bool isArabic) {
    if (_uid.isEmpty) return const SizedBox.shrink();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('sessionRatings')
          .where('clinicianId', isEqualTo: _uid)
          .snapshots(),
      builder: (context, snapshot) {
        final scheme = Theme.of(context).colorScheme;

        if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: scheme.outline.withValues(alpha: 0.12),
              ),
            ),
            child: Text(
              isArabic
                  ? 'تعذر تحميل التقييمات الآن'
                  : 'Unable to load ratings right now',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: scheme.outline.withValues(alpha: 0.12),
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final docs = snapshot.data?.docs ?? const [];
        if (docs.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: scheme.outline.withValues(alpha: 0.12),
              ),
            ),
            child: Text(
              isArabic
                  ? 'لا توجد تقييمات ظاهرة حتى الآن'
                  : 'No ratings are visible yet',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
            ),
          );
        }

        final count = docs.length;

        double totalStars = 0;
        double totalPercentage = 0;

        for (final doc in docs) {
          final data = doc.data();
          totalStars += ((data['derivedStars'] ?? 0) as num).toDouble();
          totalPercentage += ((data['percentageScore'] ?? 0) as num).toDouble();
        }

        final avgStars = count == 0 ? 0.0 : totalStars / count;
        final avgPercentage = count == 0 ? 0.0 : totalPercentage / count;

        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: scheme.outline.withValues(alpha: 0.12),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                isArabic
                    ? 'ملخص تقييمات الأخصائي'
                    : 'Clinician ratings summary',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _InfoMiniCard(
                      title: isArabic ? 'عدد التقييمات' : 'Ratings count',
                      value: '$count',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _InfoMiniCard(
                      title: isArabic ? 'متوسط النجوم' : 'Average stars',
                      value: avgStars.toStringAsFixed(1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _InfoMiniCard(
                title: isArabic ? 'المتوسط العام' : 'Overall average',
                value: '${avgPercentage.toStringAsFixed(1)}%',
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _submitProfileChangeRequest(
    BuildContext context,
    Map<String, dynamic>? clinicianData,
  ) async {
    if (_uid.isEmpty) return;

    final requestedPhotoUrl = _requestedPhotoUrlController.text.trim();
    final requestedBio = _requestedBioController.text.trim();

    if (requestedPhotoUrl.isEmpty && requestedBio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'اكتب نبذة جديدة أو رابط صورة جديد على الأقل'
                : 'Enter a new bio or a new photo URL at minimum',
          ),
        ),
      );
      return;
    }

    setState(() => _submittingChangeRequest = true);

    try {
      final data = clinicianData ?? <String, dynamic>{};

      String requestType = 'profile_update';
      if (requestedBio.isNotEmpty && requestedPhotoUrl.isNotEmpty) {
        requestType = 'profile_update';
      } else if (requestedBio.isNotEmpty) {
        requestType = 'bio_update';
      } else if (requestedPhotoUrl.isNotEmpty &&
          ((data['photoUrl'] ?? '').toString().trim().isEmpty)) {
        requestType = 'photo_add';
      } else if (requestedPhotoUrl.isNotEmpty) {
        requestType = 'photo_update';
      }

      await FirebaseFirestore.instance
          .collection('clinician_profile_change_requests')
          .add({
        'clinicianId': _uid,
        'clinicianName': (data['displayName'] ?? '').toString(),
        'clinicianEmail': (data['email'] ?? '').toString(),
        'requestType': requestType,
        'currentBio': (data['bio'] ?? '').toString(),
        'requestedBio': requestedBio,
        'currentPhotoUrl': (data['photoUrl'] ?? '').toString(),
        'requestedPhotoUrl': requestedPhotoUrl,
        'status': 'pending',
        'adminDecision': '',
        'adminNote': '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      _requestedPhotoUrlController.clear();
      _requestedBioController.clear();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تم إرسال طلب تعديل البيانات للإدارة'
                : 'Profile change request sent to admin',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _submittingChangeRequest = false);
      }
    }
  }

  @override
  void dispose() {
    _requestedPhotoUrlController.dispose();
    _requestedBioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    if (_uid.isEmpty) {
      return Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          appBar: AppShellActions.buildAppBar(
            context,
            title: isArabic ? 'غرفة عمليات الأخصائي' : 'Clinician operations',
          ),
          body: AppPageBackground(
            child: Center(
              child: Text(
                isArabic ? 'يجب تسجيل الدخول أولًا' : 'Please sign in first',
              ),
            ),
          ),
        ),
      );
    }

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic ? 'غرفة عمليات الأخصائي' : 'Clinician operations',
        ),
        body: AppPageBackground(
          child: StreamBuilder<Map<String, dynamic>?>(
            stream: _clinicianStream(),
            builder: (context, clinicianSnapshot) {
              final clinicianData =
                  clinicianSnapshot.data ?? <String, dynamic>{};
              final clinicianName =
                  (clinicianData['displayName'] ?? '').toString().trim();
              final clinicianBio =
                  (clinicianData['bio'] ?? '').toString().trim();
              final clinicianPhotoUrl =
                  (clinicianData['photoUrl'] ?? '').toString().trim();

              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('booking_requests')
                    .where('assignedClinicianId', isEqualTo: _uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          isArabic
                              ? 'تعذر تحميل طلبات الأخصائي'
                              : 'Unable to load clinician requests',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final allDocs = [...snapshot.data!.docs];
                  allDocs.sort(_sortByCreatedAtDesc);

                  final docs = allDocs.where((doc) {
                    final status =
                        (doc.data()['status'] ?? 'assigned_clinician')
                            .toString();
                    return _matchesTab(status);
                  }).toList();

                  return ListView(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    children: [
                      _buildHomeSummary(
                        context: context,
                        isArabic: isArabic,
                        clinicianData: clinicianData,
                        clinicianName: clinicianName,
                        clinicianBio: clinicianBio,
                        clinicianPhotoUrl: clinicianPhotoUrl,
                      ),
                      const SizedBox(height: 12),
                      _buildAssignmentsSection(
                        context: context,
                        isArabic: isArabic,
                        docs: docs,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String actionLabel;
  final VoidCallback onTap;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.actionLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: scheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: scheme.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
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
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          FilledButton(
            onPressed: onTap,
            child: Text(actionLabel),
          ),
        ],
      ),
    );
  }
}

class _InfoMiniCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoMiniCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F5FB),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: scheme.outline.withValues(alpha: 0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.68),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}
