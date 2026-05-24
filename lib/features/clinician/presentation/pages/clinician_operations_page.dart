import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

// Clinician-domain structural decoupling: keep legacy mirror writes disabled.
// Rollback remains trivial if bookingRequests compatibility must be restored.
const bool _legacyBookingRequestsWriteEnabled = false;

// Controlled freeze: clinician home actions stay visible but inactive for now.
// Rollback remains trivial by re-enabling this local guard.
const bool _clinicianHomeActionsEnabled = true;

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

  String _dashboardBackgroundAsset(double width) {
    if (width < 700) {
      return 'assets/branding/client_dashboard/mobile/client_dashboard_mobile_bg.png';
    }
    if (width <= 1100) {
      return 'assets/branding/client_dashboard/tablet/client_dashboard_tablet_bg.png';
    }
    return 'assets/branding/client_dashboard/desktop/client_dashboard_desktop_bg.png';
  }

  Alignment _dashboardBackgroundAlignment(double width) {
    if (width < 700) {
      return Alignment.topCenter;
    }
    return const Alignment(-0.08, 0);
  }

  double _dashboardOverlayAlpha(double width) {
    if (width < 700) return 0.38;
    if (width <= 1100) return 0.32;
    return 0.28;
  }

  Widget _buildDashboardBackground({required Widget child}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _dashboardBackgroundAsset(width),
              fit: BoxFit.cover,
              alignment: _dashboardBackgroundAlignment(width),
              errorBuilder: (context, error, stackTrace) =>
                  const ColoredBox(color: Color(0xFF061D24)),
            ),
            ColoredBox(
              color: Colors.black.withValues(
                alpha: _dashboardOverlayAlpha(width),
              ),
            ),
            child,
          ],
        );
      },
    );
  }

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
      if (_legacyBookingRequestsWriteEnabled)
        // TODO(EX-137): Legacy bookingRequests fallback is transitional only.
        // Canonical booking collection is booking_requests.
        // Do not expand this fallback; remove only after manual legacy data verification.
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
        'clinicianAccepted': true,
        'clinicianRejected': false,
        'clinicianCompleted': false,
        'clinicianRespondedAt': FieldValue.serverTimestamp(),
        'payment_confirmed': false,
        'sessionStatus': 'not_created',
        'reviewStatus': 'not_started',
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'تمت الموافقة، والطلب الآن بانتظار الجاهزية'
                : 'Accepted. Request is now awaiting readiness.',
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
        'sessionStatus': 'not_created',
        'reviewStatus': 'not_started',
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
        return status == 'session_setup_pending' ||
            status == 'session_scheduled' ||
            status == 'session_in_progress' ||
            status == 'reschedule_pending';
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

  bool _paymentConfirmedFrom(Map<String, dynamic> data) {
    final explicitGate = data['payment_confirmed'] ?? data['paymentConfirmed'];
    if (explicitGate is bool) return explicitGate;

    return false;
  }

  String _statusLabel(String status, AppLocalizations l10n) {
    switch (status) {
      case 'session_setup_pending':
        return l10n.statusSessionSetupPending;
      case 'reschedule_pending':
        return l10n.statusReschedulePending;
      case 'session_scheduled':
        return l10n.statusSessionScheduled;
      case 'session_in_progress':
        return l10n.statusSessionInProgress;
      case 'session_completed_pending_reviews':
        return l10n.statusPendingReviews;
      case 'completed':
      case 'completed_success':
        return l10n.statusCompleted;
      case 'clinician_rejected':
        return l10n.statusClinicianRejected;
      case 'rejected_admin':
        return l10n.statusRejected;
      case 'cancelled':
        return l10n.statusCancelled;
      default:
        return l10n.statusNewRequest;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'session_setup_pending':
      case 'reschedule_pending':
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
        .collection('support_requests')
        .where('createdByUid', isEqualTo: _uid)
        .where('supportType', isEqualTo: 'clinician_support')
        .snapshots()
        .map((snapshot) => snapshot.docs.where((doc) {
              final data = doc.data();
              final status = (data['status'] ?? '').toString().trim();
              return status != 'closed';
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

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;

    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildClinicianTopBar(
          context: context,
          isArabic: isArabic,
          clinicianName: clinicianName,
          clinicianPhotoUrl: clinicianPhotoUrl,
        ),
        const SizedBox(height: 8),
        _buildRatingsSummary(isArabic),
        const SizedBox(height: 16),
        _buildOperationsActions(
          context: context,
          isArabic: isArabic,
        ),
      ],
    );
  }

  Widget _buildClinicianTopBar({
    required BuildContext context,
    required bool isArabic,
    required String clinicianName,
    required String clinicianPhotoUrl,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final gap = constraints.maxWidth < 420 ? 8.0 : 16.0;

        return Row(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ClinicianGoldLogo(isArabic: isArabic),
            SizedBox(width: gap),
            Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: _ClinicianCompactProfile(
                  isArabic: isArabic,
                  clinicianName: clinicianName,
                  clinicianPhotoUrl: clinicianPhotoUrl,
                  onSignOut: _signOut,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOperationsActions({
    required BuildContext context,
    required bool isArabic,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return _OperationActionsCarousel(
      children: [
        _OperationActionButton(
          label: l10n.clinicianOpenCases,
          icon: Icons.forum_outlined,
          imageAsset:
              'assets/images/clinicians_dashboard/actions/clinician_open_cases.png',
          primary: true,
          onTap: _clinicianHomeActionsEnabled
              ? () {
                  Navigator.of(context).pushNamed(
                    Routes.clinicianChatInbox,
                  );
                }
              : null,
        ),
        _OperationActionButton(
          label: l10n.clinicianSendSupportRequest,
          icon: Icons.chat_bubble_outline_rounded,
          imageAsset:
              'assets/images/clinicians_dashboard/actions/clinician_support_request.png',
          onTap: _clinicianHomeActionsEnabled
              ? () {
                  Navigator.of(context).pushNamed(
                    Routes.supportIssueSelector,
                    arguments: const {'supportType': 'clinician_support'},
                  );
                }
              : null,
        ),
        _OperationActionButton(
          label: l10n.clinicianEditProfile,
          icon: Icons.edit_outlined,
          imageAsset:
              'assets/images/clinicians_dashboard/actions/clinician_edit_profile.png',
          onTap: () => Navigator.of(context).pushNamed(
            Routes.clinicianProfileEditRequest,
          ),
        ),
        _OperationActionButton(
          label: l10n.clinicianMySessions,
          icon: Icons.video_call_outlined,
          imageAsset:
              'assets/images/clinicians_dashboard/actions/clinician_sessions.png',
          primary: true,
          onTap: () => Navigator.of(context).pushNamed(
            Routes.clinicianSessions,
          ),
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
        _buildAssignmentsHeader(
          context: context,
          isArabic: isArabic,
        ),
        const SizedBox(height: 20),
        if (docs.isEmpty)
          const SizedBox.shrink()
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
        _buildProfileEditRequestEntryCard(
          context: context,
          isArabic: isArabic,
        ),
      ],
    );
  }

  Widget _buildProfileEditRequestEntryCard({
    required BuildContext context,
    required bool isArabic,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(24),
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
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Color(0xFFFFF4D4)),
        child: Row(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: const Color(0xFFE7C766).withValues(alpha: 0.12),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFE7C766).withValues(alpha: 0.28),
                ),
              ),
              child: const Icon(
                Icons.manage_accounts_outlined,
                color: Color(0xFFE7C766),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? 'تعديل بياناتي' : 'Edit my profile',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: const Color(0xFFFFF4D4),
                          fontWeight: FontWeight.w800,
                        ),
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isArabic
                        ? 'إرسال طلب تعديل الصورة أو النبذة'
                        : 'Send a photo or bio change request',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFEBDDB7),
                        ),
                    textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            FilledButton(
              onPressed: () => Navigator.of(context).pushNamed(
                Routes.clinicianProfileEditRequest,
              ),
              child: Text(isArabic ? 'فتح' : 'Open'),
            ),
          ],
        ),
      ),
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
    final photoUri = Uri.tryParse(clinicianPhotoUrl.trim());
    final hasValidPhotoUrl = photoUri != null &&
        (photoUri.scheme == 'http' || photoUri.scheme == 'https');

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: scheme.primary.withValues(alpha: 0.12),
            backgroundImage: hasValidPhotoUrl
                ? NetworkImage(clinicianPhotoUrl.trim())
                : null,
            child: hasValidPhotoUrl
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
    final l10n = AppLocalizations.of(context)!;
    return StreamBuilder<int>(
      stream: _messagesCountStream(),
      builder: (context, msgSnapshot) {
        final count = msgSnapshot.data ?? 0;
        return _SectionCard(
          title: l10n.clinicianSupportRequest,
          subtitle: '${l10n.clinicianCurrentSupportRequests}: $count',
          icon: Icons.chat_bubble_outline_rounded,
          actionLabel: l10n.clinicianSendSupportRequest,
          onTap: _clinicianHomeActionsEnabled
              ? () {
                  Navigator.of(context).pushNamed(
                    Routes.supportIssueSelector,
                    arguments: const {'supportType': 'clinician_support'},
                  );
                }
              : null,
        );
      },
    );
  }

  Widget _buildChatCasesSummaryCard({
    required BuildContext context,
    required bool isArabic,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return StreamBuilder<int>(
      stream: _chatCasesCountStream(),
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        return _SectionCard(
          title: l10n.clinicianReferredChatCases,
          subtitle: isArabic
              ? 'حالات شات مصعّدة أو مُحالة تتطلب تدخل الأخصائي: $count'
              : 'Escalated or referred chat cases that need clinician involvement: $count',
          icon: Icons.forum_outlined,
          actionLabel: l10n.clinicianOpenCases,
          onTap: _clinicianHomeActionsEnabled
              ? () {
                  Navigator.of(context).pushNamed(Routes.clinicianChatInbox);
                }
              : null,
        );
      },
    );
  }

  Widget _buildProfileChangeRequestCard({
    required BuildContext context,
    required bool isArabic,
    required Map<String, dynamic> clinicianData,
  }) {
    final l10n = AppLocalizations.of(context)!;
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
            l10n.clinicianProfileChangeTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            isArabic
                ? 'أي تعديل على الصورة الشخصية أو النبذة يذهب للمراجعة أولًا. الاسم والوثائق غير قابلة للتعديل من هنا.'
                : 'Any update to the profile photo or bio is sent for review first. Name and documents cannot be edited here.',
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _requestedPhotoUrlController,
            decoration: InputDecoration(
              labelText: l10n.clinicianNewPhotoUrl,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _requestedBioController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: l10n.clinicianNewBio,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: !_clinicianHomeActionsEnabled ||
                      _submittingChangeRequest
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
                    ? l10n.clinicianSendingRequest
                    : l10n.clinicianSendChangeRequest,
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
                                ? 'ملاحظة المراجعة: $adminNote'
                                : 'Review note: $adminNote',
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
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: [
          _FilterPill(
            selected: _tab == 'assigned_clinician',
            label: l10n.clinicianNewRequests,
            onTap: () => setState(() => _tab = 'assigned_clinician'),
          ),
          _FilterPill(
            selected: _tab == 'in_progress',
            label: l10n.clinicianActiveRequests,
            onTap: () => setState(() => _tab = 'in_progress'),
          ),
          _FilterPill(
            selected: _tab == 'completed',
            label: l10n.clinicianCompleted,
            onTap: () => setState(() => _tab = 'completed'),
          ),
          _FilterPill(
            selected: _tab == 'closed',
            label: l10n.clinicianClosed,
            onTap: () => setState(() => _tab = 'closed'),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentCard({
    required BuildContext context,
    required bool isArabic,
    required String requestId,
    required Map<String, dynamic> data,
  }) {
    final l10n = AppLocalizations.of(context)!;
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
    final clinicianAccepted = (data['clinicianAccepted'] ?? false) == true;
    final paymentConfirmed = _paymentConfirmedFrom(data);
    final canReviewSession = !clinicianReviewSubmitted &&
        (status == 'session_completed_pending_reviews' ||
            (sessionStatus == 'completed' &&
                (reviewStatus == 'pending_reviews' ||
                    reviewStatus == 'partial')));
    final canMarkCompleted =
        paymentConfirmed && status == 'session_in_progress';

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
                    Text(l10n.clinicianAssignedRequest),
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
                  _statusLabel(status, l10n),
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
              if (status == 'assigned_clinician' && !clinicianAccepted)
                FilledButton.icon(
                  onPressed: busy ? null : () => _acceptRequest(requestId),
                  icon: const Icon(Icons.check_circle_outline),
                  label: Text(l10n.clinicianAcceptRequest),
                ),
              if (status == 'assigned_clinician' && !clinicianAccepted)
                OutlinedButton.icon(
                  onPressed: busy ? null : () => _rejectRequest(requestId),
                  icon: const Icon(Icons.cancel_outlined),
                  label: Text(l10n.clinicianRejectRequest),
                ),
              if (canMarkCompleted)
                FilledButton.tonalIcon(
                  onPressed: busy ? null : () => _markCompleted(requestId),
                  icon: const Icon(Icons.task_alt_outlined),
                  label: Text(l10n.clinicianEndSession),
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
                  label: Text(l10n.clinicianReviewSession),
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
          .where('reviewerType', isEqualTo: 'client')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildRatingsCompactCounters(
            l10n: AppLocalizations.of(context)!,
            isArabic: isArabic,
            count: '--',
            avgStars: '--',
            avgPercentage: '--',
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Center(
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 1.6,
                color: Color(0xFFE7C766),
              ),
            ),
          );
        }

        final docs = snapshot.data?.docs ?? const [];
        final compactCount = docs.length;
        double compactTotalStars = 0;
        double compactTotalPercentage = 0;

        for (final doc in docs) {
          final data = doc.data();
          compactTotalStars += ((data['derivedStars'] ?? 0) as num).toDouble();
          compactTotalPercentage +=
              ((data['percentageScore'] ?? 0) as num).toDouble();
        }

        final compactAvgStars =
            compactCount == 0 ? 0.0 : compactTotalStars / compactCount;
        final compactAvgPercentage =
            compactCount == 0 ? 0.0 : compactTotalPercentage / compactCount;

        return _buildRatingsCompactCounters(
          l10n: AppLocalizations.of(context)!,
          isArabic: isArabic,
          count: '$compactCount',
          avgStars: compactAvgStars.toStringAsFixed(1),
          avgPercentage: '${compactAvgPercentage.toStringAsFixed(1)}%',
        );
      },
    );
  }

  Widget _buildRatingsCompactCounters({
    required AppLocalizations l10n,
    required bool isArabic,
    required String count,
    required String avgStars,
    required String avgPercentage,
  }) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          spacing: 7,
          runSpacing: 7,
          children: [
            _RatingMetricChip(
              title: l10n.clinicianRatings,
              value: count,
            ),
            _RatingMetricChip(
              title: l10n.clinicianStars,
              value: avgStars,
            ),
            _RatingMetricChip(
              title: l10n.clinicianOverall,
              value: avgPercentage,
            ),
          ],
        ),
      ),
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
                ? 'تم إرسال طلب تعديل البيانات للمراجعة'
                : 'Profile change request sent for review',
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
    final l10n = AppLocalizations.of(context)!;

    if (_uid.isEmpty) {
      return Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          body: _buildDashboardBackground(
            child: Center(
              child: Text(
                l10n.clinicianPleaseSignIn,
              ),
            ),
          ),
        ),
      );
    }

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: _buildDashboardBackground(
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: 72,
                    ),
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

class _RatingMetricChip extends StatelessWidget {
  final String title;
  final String value;

  const _RatingMetricChip({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 86),
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: const Color(0xFFE7C766).withValues(alpha: 0.22),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE7C766).withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: const Color(0xFFFFE7B2),
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                  letterSpacing: 0,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.64),
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                  letterSpacing: 0,
                ),
          ),
        ],
      ),
    );
  }
}

class _ClinicianLogoutButton extends StatelessWidget {
  final bool isArabic;
  final VoidCallback onPressed;

  const _ClinicianLogoutButton({
    required this.isArabic,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Tooltip(
      message: l10n.commonLogout,
      child: SizedBox(
        height: 30,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.logout_rounded, size: 15),
          label: Text(l10n.clinicianLogout),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFFFE7B2),
            side: BorderSide(
              color: const Color(0xFFE7C766).withValues(alpha: 0.62),
            ),
            backgroundColor: Colors.black.withValues(alpha: 0.24),
            minimumSize: const Size(0, 30),
            padding: const EdgeInsets.symmetric(horizontal: 9),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                ),
          ),
        ),
      ),
    );
  }
}

class _ClinicianGoldLogo extends StatelessWidget {
  final bool isArabic;

  const _ClinicianGoldLogo({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE7C766).withValues(alpha: 0.24),
              blurRadius: 28,
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.28),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Image.asset(
          'assets/branding/logo_icon.png',
          width: 82,
          height: 82,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.auto_awesome_rounded,
              color: Color(0xFFE7C766),
              size: 78,
            );
          },
        ),
      ),
    );
  }
}

class _ClinicianCompactProfile extends StatelessWidget {
  final bool isArabic;
  final String clinicianName;
  final String clinicianPhotoUrl;
  final VoidCallback onSignOut;

  const _ClinicianCompactProfile({
    required this.isArabic,
    required this.clinicianName,
    required this.clinicianPhotoUrl,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    final photoUri = Uri.tryParse(clinicianPhotoUrl.trim());
    final hasValidPhotoUrl = photoUri != null &&
        (photoUri.scheme == 'http' || photoUri.scheme == 'https');
    final displayName = clinicianName.isEmpty
        ? (isArabic ? 'أخصائي' : 'Clinician')
        : clinicianName;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 92,
              height: 128,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color:
                              const Color(0xFFE7C766).withValues(alpha: 0.22),
                          blurRadius: 24,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.30),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 46,
                      backgroundColor:
                          const Color(0xFFE7C766).withValues(alpha: 0.18),
                      backgroundImage: hasValidPhotoUrl
                          ? NetworkImage(clinicianPhotoUrl.trim())
                          : null,
                      child: hasValidPhotoUrl
                          ? null
                          : Icon(
                              Icons.person_rounded,
                              color: const Color(0xFFE7C766),
                              size: 50,
                            ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: _ClinicianLogoutButton(
                        isArabic: isArabic,
                        onPressed: onSignOut,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Flexible(
              child: Text(
                displayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFFFE7B2),
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                  shadows: const [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 12,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OperationActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String imageAsset;
  final bool primary;
  final VoidCallback? onTap;

  const _OperationActionButton({
    required this.label,
    required this.icon,
    required this.imageAsset,
    required this.onTap,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final accent = primary ? const Color(0xFFE7C766) : const Color(0xFF8EDBFF);
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Opacity(
      opacity: enabled ? 1 : 0.55,
      child: _OperationActionHover(
        accent: accent,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(24),
            hoverColor: accent.withValues(alpha: 0.06),
            splashColor: accent.withValues(alpha: 0.08),
            highlightColor: accent.withValues(alpha: 0.04),
            child: SizedBox(
              width: double.infinity,
              height: 226,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF061D24),
                                const Color(0xFF0B3A3A),
                                accent.withValues(alpha: 0.32),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              icon,
                              color: accent,
                              size: 46,
                            ),
                          ),
                        );
                      },
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.02),
                            Colors.black.withValues(alpha: 0.12),
                            Colors.black.withValues(alpha: 0.62),
                          ],
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.topCenter,
                          radius: 1.1,
                          colors: [
                            accent.withValues(alpha: 0.12),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: accent.withValues(alpha: 0.46),
                          width: 1,
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      start: 14,
                      end: 14,
                      bottom: 14,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            label,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                              color: const Color(0xFFFFE7B2),
                              fontWeight: FontWeight.w900,
                              height: 1.08,
                              shadows: const [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 12,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Icon(
                            isArabic
                                ? Icons.keyboard_arrow_left_rounded
                                : Icons.keyboard_arrow_right_rounded,
                            color: accent,
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OperationActionsCarousel extends StatefulWidget {
  final List<Widget> children;

  const _OperationActionsCarousel({required this.children});

  @override
  State<_OperationActionsCarousel> createState() =>
      _OperationActionsCarouselState();
}

class _OperationActionsCarouselState extends State<_OperationActionsCarousel> {
  PageController? _controller;
  double _viewportFraction = 0.82;
  double _page = 0;
  bool _pageUpdateScheduled = false;

  @override
  void initState() {
    super.initState();
    _syncController(_viewportFraction);
  }

  @override
  void dispose() {
    _controller?.removeListener(_handlePageChange);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _OperationActionsCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != oldWidget.children.length) {
      final maxIndex = widget.children.isEmpty ? 0 : widget.children.length - 1;
      _page = _page.clamp(0, maxIndex).toDouble();
    }
  }

  void _handlePageChange() {
    if (!mounted) return;
    if (_pageUpdateScheduled) return;

    _pageUpdateScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _pageUpdateScheduled = false;
      final nextPage = _controller?.hasClients == true
          ? (_controller?.page ?? _page)
          : _page;
      if (nextPage == _page) return;

      setState(() => _page = nextPage);
    });
  }

  void _syncController(double viewportFraction) {
    if (_controller != null && _viewportFraction == viewportFraction) return;

    final oldPage =
        _controller?.hasClients == true ? (_controller?.page ?? _page) : _page;
    final maxIndex = widget.children.isEmpty ? 0 : widget.children.length - 1;

    _controller?.removeListener(_handlePageChange);
    _controller?.dispose();
    _viewportFraction = viewportFraction;
    _page = oldPage.clamp(0, maxIndex).toDouble();
    _controller = PageController(
      initialPage: _page.round().clamp(0, maxIndex).toInt(),
      viewportFraction: viewportFraction,
    )..addListener(_handlePageChange);
  }

  void _goToPage(int targetIndex) {
    if (widget.children.isEmpty) return;
    final maxIndex = widget.children.length - 1;
    final clamped = targetIndex.clamp(0, maxIndex).toInt();
    _controller?.animateToPage(
      clamped,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.children.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 700;
        final isTablet = width >= 700 && width <= 1100;
        final viewportFraction = isMobile
            ? 0.76
            : isTablet
                ? 0.50
                : 0.30;
        _syncController(viewportFraction);
        final controller = _controller!;
        final currentIndex = _page.round().clamp(0, widget.children.length - 1);
        final canGoBack = currentIndex > 0;
        final canGoForward = currentIndex < widget.children.length - 1;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1040),
            child: SizedBox(
              height: isMobile ? 232 : 260,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: controller,
                    itemCount: widget.children.length,
                    padEnds: true,
                    itemBuilder: (context, index) {
                      final distance = (_page - index).abs().clamp(0.0, 1.0);
                      final scale = 1.0 - (distance * 0.06);
                      final opacity = 1.0 - (distance * 0.18);

                      return AnimatedOpacity(
                        opacity: opacity,
                        duration: const Duration(milliseconds: 260),
                        curve: Curves.easeOutQuart,
                        child: AnimatedScale(
                          scale: scale,
                          duration: const Duration(milliseconds: 260),
                          curve: Curves.easeOutQuart,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 6 : 10,
                            ),
                            child: Center(child: widget.children[index]),
                          ),
                        ),
                      );
                    },
                  ),
                  PositionedDirectional(
                    start: isMobile ? 6 : 18,
                    child: _OperationCarouselArrow(
                      icon: Icons.chevron_left_rounded,
                      enabled: canGoBack,
                      onPressed: () => _goToPage(currentIndex - 1),
                    ),
                  ),
                  PositionedDirectional(
                    end: isMobile ? 6 : 18,
                    child: _OperationCarouselArrow(
                      icon: Icons.chevron_right_rounded,
                      enabled: canGoForward,
                      onPressed: () => _goToPage(currentIndex + 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _OperationCarouselArrow extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  const _OperationCarouselArrow({
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE7C766).withValues(
              alpha: enabled ? 0.12 : 0.04,
            ),
            blurRadius: enabled ? 12 : 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SizedBox(
        width: 38,
        height: 38,
        child: IconButton.filledTonal(
          onPressed: enabled ? onPressed : null,
          icon: Icon(icon),
          style: IconButton.styleFrom(
            backgroundColor: Colors.black.withValues(alpha: 0.30),
            disabledBackgroundColor: Colors.black.withValues(alpha: 0.14),
            foregroundColor: const Color(0xFFFFE7B2),
            disabledForegroundColor: Colors.white.withValues(alpha: 0.30),
            side: BorderSide(
              color: const Color(0xFFE7C766).withValues(
                alpha: enabled ? 0.30 : 0.10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OperationActionHover extends StatefulWidget {
  final Widget child;
  final Color accent;

  const _OperationActionHover({
    required this.child,
    required this.accent,
  });

  @override
  State<_OperationActionHover> createState() => _OperationActionHoverState();
}

class _OperationActionHoverState extends State<_OperationActionHover> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.012 : 1.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutQuart,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: widget.accent.withValues(
                  alpha: _hovered ? 0.20 : 0.10,
                ),
                blurRadius: _hovered ? 20 : 12,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: const Color(0xFFE7C766).withValues(
                  alpha: _hovered ? 0.08 : 0.04,
                ),
                blurRadius: _hovered ? 22 : 14,
                spreadRadius: 0,
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  final bool selected;
  final String label;
  final VoidCallback onTap;

  const _FilterPill({
    required this.selected,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final background = selected
        ? const Color(0xFFE7C766).withValues(alpha: 0.14)
        : Colors.black.withValues(alpha: 0.18);
    final border = selected
        ? const Color(0xFFE7C766).withValues(alpha: 0.46)
        : const Color(0xFFE7C766).withValues(alpha: 0.18);
    final foreground = selected
        ? const Color(0xFFFFE7B2)
        : Colors.white.withValues(alpha: 0.70);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(26),
      child: Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: border),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE7C766).withValues(
                alpha: selected ? 0.07 : 0.02,
              ),
              blurRadius: selected ? 10 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              const Icon(
                Icons.check_rounded,
                size: 14,
                color: Color(0xFFE7C766),
              ),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClinicianProfileEditRequestPage extends StatefulWidget {
  const ClinicianProfileEditRequestPage({super.key});

  @override
  State<ClinicianProfileEditRequestPage> createState() =>
      _ClinicianProfileEditRequestPageState();
}

class _ClinicianProfileEditRequestPageState
    extends State<ClinicianProfileEditRequestPage> {
  String _profileEditBackgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
  }

  BoxDecoration _profileEditGlassDecoration({
    double alpha = 0.34,
    double radius = 22,
  }) {
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

  Widget _buildProfileEditBackground({required Widget child}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _profileEditBackgroundAsset(constraints.maxWidth),
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
            child,
          ],
        );
      },
    );
  }

  InputDecoration _profileEditInputDecoration(String label) {
    const gold = Color(0xFFE7C766);
    const lightText = Color(0xFFFFF4D4);

    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: lightText.withValues(alpha: 0.72),
        fontWeight: FontWeight.w700,
      ),
      filled: true,
      fillColor: Colors.black.withValues(alpha: 0.22),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: gold.withValues(alpha: 0.30),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: gold,
          width: 1.25,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }

  ButtonStyle _profileEditSubmitButtonStyle() {
    return FilledButton.styleFrom(
      backgroundColor: const Color(0xFF1B1007).withValues(alpha: 0.92),
      foregroundColor: const Color(0xFFFFE7B2),
      disabledBackgroundColor: Colors.black.withValues(alpha: 0.28),
      disabledForegroundColor: const Color(0xFFFFE7B2).withValues(alpha: 0.50),
      side: BorderSide(
        color: const Color(0xFFE7C766).withValues(alpha: 0.52),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      elevation: 0,
    );
  }

  final _requestedPhotoUrlController = TextEditingController();
  final _requestedBioController = TextEditingController();

  bool _submittingChangeRequest = false;

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Stream<Map<String, dynamic>?> _clinicianStream() {
    if (_uid.isEmpty) return Stream.value(null);
    return FirebaseFirestore.instance
        .collection('clinicians')
        .doc(_uid)
        .snapshots()
        .map((doc) => doc.exists ? doc.data() : null);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _requestsStream() {
    return FirebaseFirestore.instance
        .collection('clinician_profile_change_requests')
        .where('clinicianId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  String _requestStatusLabel(String status, bool isArabic) {
    switch (status) {
      case 'approved':
        return isArabic ? 'مقبول' : 'Approved';
      case 'rejected':
        return isArabic ? 'مرفوض' : 'Rejected';
      case 'pending':
      default:
        return isArabic ? 'قيد المراجعة' : 'Pending review';
    }
  }

  Future<void> _submitProfileChangeRequest(
    Map<String, dynamic> clinicianData,
  ) async {
    final requestedPhotoUrl = _requestedPhotoUrlController.text.trim();
    final requestedBio = _requestedBioController.text.trim();

    if (requestedPhotoUrl.isEmpty && requestedBio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isArabic(context)
                ? 'أدخل رابط صورة أو نبذة جديدة أولًا'
                : 'Enter a new photo URL or bio first',
          ),
        ),
      );
      return;
    }

    setState(() => _submittingChangeRequest = true);
    try {
      final currentBio = (clinicianData['bio'] ?? '').toString().trim();
      final currentPhotoUrl =
          (clinicianData['photoUrl'] ?? '').toString().trim();
      var requestType = 'profile_update';
      if (requestedBio.isNotEmpty && requestedPhotoUrl.isNotEmpty) {
        requestType = 'photo_and_bio_update';
      } else if (requestedBio.isNotEmpty) {
        requestType = 'bio_update';
      } else if (requestedPhotoUrl.isNotEmpty && currentPhotoUrl.isEmpty) {
        requestType = 'photo_upload';
      } else if (requestedPhotoUrl.isNotEmpty) {
        requestType = 'photo_update';
      }

      await FirebaseFirestore.instance
          .collection('clinician_profile_change_requests')
          .add({
        'clinicianId': _uid,
        'clinicianName': (clinicianData['displayName'] ?? '').toString(),
        'clinicianEmail': (clinicianData['email'] ?? '').toString(),
        'requestType': requestType,
        'currentBio': currentBio,
        'requestedBio': requestedBio,
        'currentPhotoUrl': currentPhotoUrl,
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
                ? 'تم إرسال طلب تعديل البيانات للمراجعة'
                : 'Profile change request sent for review',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _submittingChangeRequest = false);
      }
    }
  }

  Widget _buildRequestForm({
    required BuildContext context,
    required bool isArabic,
    required Map<String, dynamic> clinicianData,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _profileEditGlassDecoration(alpha: 0.34, radius: 22),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Color(0xFFFFF4D4)),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
          Text(
            isArabic
                ? 'طلب تعديل الصورة أو النبذة'
                : 'Request photo or bio update',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFE7C766),
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            isArabic
                ? 'أي تعديل على الصورة الشخصية أو النبذة يذهب للمراجعة أولًا. الاسم والوثائق غير قابلة للتعديل من هنا.'
                : 'Any update to the profile photo or bio is sent for review first. Name and documents cannot be edited here.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFFFF4D4),
                ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _requestedPhotoUrlController,
            style: const TextStyle(
              color: Color(0xFFFFF4D4),
              fontWeight: FontWeight.w600,
            ),
            cursorColor: const Color(0xFFE7C766),
            decoration: _profileEditInputDecoration(
              isArabic ? 'رابط الصورة الجديدة' : 'New photo URL',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _requestedBioController,
            maxLines: 4,
            style: const TextStyle(
              color: Color(0xFFFFF4D4),
              fontWeight: FontWeight.w600,
            ),
            cursorColor: const Color(0xFFE7C766),
            decoration: _profileEditInputDecoration(
              isArabic ? 'النبذة الجديدة' : 'New bio',
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              style: _profileEditSubmitButtonStyle(),
              onPressed: _submittingChangeRequest
                  ? null
                  : () => _submitProfileChangeRequest(clinicianData),
              icon: _submittingChangeRequest
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
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
      ),
    );
  }

  Widget _buildRequestsList({
    required BuildContext context,
    required bool isArabic,
    required List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _profileEditGlassDecoration(alpha: 0.34, radius: 22),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Color(0xFFFFF4D4)),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
          Text(
            isArabic ? 'طلبات التعديل السابقة' : 'Previous change requests',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFE7C766),
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 12),
          if (docs.isEmpty)
            Text(isArabic
                ? 'لا توجد طلبات تعديل حتى الآن'
                : 'No change requests yet')
          else
            ...docs.map((doc) {
              final data = doc.data();
              final status = (data['status'] ?? 'pending').toString();
              final requestedBio = (data['requestedBio'] ?? '').toString();
              final requestedPhotoUrl =
                  (data['requestedPhotoUrl'] ?? '').toString();
              final adminNote = (data['adminNote'] ?? '').toString().trim();

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7C766).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE7C766).withValues(alpha: 0.22),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      _requestStatusLabel(status, isArabic),
                      style: const TextStyle(
                        color: Color(0xFFE7C766),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (requestedPhotoUrl.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(isArabic
                          ? 'الصورة المطلوبة: $requestedPhotoUrl'
                          : 'Requested photo: $requestedPhotoUrl'),
                    ],
                    if (requestedBio.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(isArabic
                          ? 'النبذة المطلوبة: $requestedBio'
                          : 'Requested bio: $requestedBio'),
                    ],
                    if (adminNote.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(isArabic
                          ? 'ملاحظة الإدارة: $adminNote'
                          : 'Admin note: $adminNote'),
                    ],
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
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
    final l10n = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).maybePop();
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.menu,
                  (route) => false,
                );
              }
            },
            icon: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1B1007).withValues(alpha: 0.50),
                border: Border.all(
                  color: const Color(0xFFFFD98A).withValues(alpha: 0.56),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD98A).withValues(alpha: 0.34),
                    blurRadius: 16,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                  BoxShadow(
                    color: const Color(0xFFE7A94C).withValues(alpha: 0.24),
                    blurRadius: 26,
                    spreadRadius: 2,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Image.asset(
                isArabic
                    ? 'assets/branding/navigation/back/back_right_gold.png'
                    : 'assets/branding/navigation/back/back_left_gold.png',
                width: 22,
                height: 22,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xFFFFE7B2),
                    size: 22,
                  );
                },
              ),
            ),
            tooltip: isArabic ? 'رجوع' : 'Back',
          ),
          title: Text(
            l10n.clinicianEditProfile,
            style: const TextStyle(
              color: Color(0xFFC9A75B),
              fontWeight: FontWeight.w800,
            ),
          ),
          backgroundColor: const Color(0xFF0F1316).withValues(alpha: 0.96),
          foregroundColor: const Color(0xFFC9A75B),
          elevation: 0,
        ),
        body: _buildProfileEditBackground(
          child: StreamBuilder<Map<String, dynamic>?>(
            stream: _clinicianStream(),
            builder: (context, clinicianSnapshot) {
              final clinicianData =
                  clinicianSnapshot.data ?? <String, dynamic>{};

              return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _requestsStream(),
                builder: (context, requestSnapshot) {
                  final docs = requestSnapshot.data?.docs ?? const [];
                  final hasPending = docs.any(
                    (doc) => (doc.data()['status'] ?? 'pending') == 'pending',
                  );

                  return ListView(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    children: [
                      if (hasPending)
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: _profileEditGlassDecoration(
                            alpha: 0.34,
                            radius: 22,
                          ),
                          child: Text(
                            isArabic
                                ? 'يوجد طلب تعديل قيد المراجعة. يمكنك متابعة حالته هنا.'
                                : 'A profile change request is pending. You can track it here.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: const Color(0xFFFFF4D4),
                                ),
                            textAlign:
                                isArabic ? TextAlign.right : TextAlign.left,
                          ),
                        )
                      else
                        _buildRequestForm(
                          context: context,
                          isArabic: isArabic,
                          clinicianData: clinicianData,
                        ),
                      const SizedBox(height: 12),
                      _buildRequestsList(
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
  final VoidCallback? onTap;

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
