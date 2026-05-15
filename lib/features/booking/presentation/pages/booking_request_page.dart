import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/booking/data/services/booking_legacy_chat_adapter.dart';
import 'package:flutterprojects/l10n/app_localizations.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

const String kDevClinicianUid =
    String.fromEnvironment('MK_DEV_CLINICIAN_UID', defaultValue: '');

class BookingRequestArgs {
  final String clinicianId;
  final String clinicianName;

  const BookingRequestArgs({
    required this.clinicianId,
    required this.clinicianName,
  });
}

class BookingRequestPage extends StatefulWidget {
  final BookingRequestArgs args;

  const BookingRequestPage({super.key, required this.args});

  @override
  State<BookingRequestPage> createState() => _BookingRequestPageState();
}

class _GoldBackIcon extends StatelessWidget {
  const _GoldBackIcon({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 44.0 : 52.0;
    final iconSize = compact ? 22.0 : 26.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1B1007).withValues(alpha: 0.50),
        border: Border.all(
          color: const Color(0xFFFFD98A).withValues(alpha: 0.56),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE7A94C).withValues(alpha: 0.16),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Image.asset(
        Directionality.of(context) == TextDirection.rtl
            ? 'assets/branding/navigation/back/back_right_gold.png'
            : 'assets/branding/navigation/back/back_left_gold.png',
        width: iconSize,
        height: iconSize,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return IconTheme(
            data: IconThemeData(
              color: const Color(0xFFFFE7B2),
              size: iconSize,
            ),
            child: const BackButtonIcon(),
          );
        },
      ),
    );
  }
}

class _BookingRequestPageState extends State<BookingRequestPage> {
  final BookingLegacyChatAdapter _bookingChatAdapter =
      BookingLegacyChatAdapter();
  final TextEditingController _noteCtrl = TextEditingController();
  bool _submitting = false;
  String? _result;

  bool get _isArabic =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> _readCurrentClientProfile(User user) async {
    final firestore = FirebaseFirestore.instance;
    final uid = user.uid;
    final email = (user.email ?? '').trim();

    final directDoc = await firestore.collection('clients').doc(uid).get();
    if (directDoc.exists && directDoc.data() != null) {
      return directDoc.data()!;
    }

    if (email.isNotEmpty) {
      final byEmail = await firestore
          .collection('clients')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (byEmail.docs.isNotEmpty) {
        return byEmail.docs.first.data();
      }
    }

    return <String, dynamic>{};
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _result =
          _isArabic ? 'يجب تسجيل الدخول أولًا' : 'Please sign in first');
      return;
    }

    setState(() {
      _submitting = true;
      _result = null;
    });

    try {
      final firestore = FirebaseFirestore.instance;
      final uid = user.uid;
      final profile = await _readCurrentClientProfile(user);

      final clientName = ((profile['displayName'] ??
                  profile['name'] ??
                  profile['fullName'] ??
                  user.displayName ??
                  'Client')
              .toString())
          .trim();

      final clientEmail =
          ((profile['email'] ?? user.email ?? '').toString()).trim();
      final note = _noteCtrl.text.trim();
      final now = Timestamp.now();

      final requestRef = firestore.collection('booking_requests').doc();

      final requestData = {
        'requestId': requestRef.id,
        'requestKind': 'clinician',
        'clientId': uid,
        'clientName': clientName,
        'clientEmail': clientEmail,
        // Requested clinician target before admin approval.
        'clinicianId': widget.args.clinicianId,
        'clinicianName': widget.args.clinicianName,
        'assignedClinicianId': widget.args.clinicianId,
        'assignedClinicianName': widget.args.clinicianName,
        // Legacy compatibility field.
        'clinicianUid': widget.args.clinicianId,
        'status': 'assigned_clinician',
        'workflowStage': 'assigned_clinician',
        'createdAt': now,
        'updatedAt': now,
        'note': note,
        'adminForwarded': false,
        'adminAssignedBy': '',
        'adminAssignedAt': null,
        'source': 'client_dashboard',
      };

      await requestRef.set(requestData);

      final threadId =
          await _bookingChatAdapter.createOrUpdateAdminThreadForBooking(
        clientId: uid,
        clientName: clientName,
        clientEmail: clientEmail,
        requestId: requestRef.id,
        clinicianId: widget.args.clinicianId,
        clinicianName: widget.args.clinicianName,
        note: note,
        isArabic: _isArabic,
      );

      await requestRef.update({
        'threadId': threadId,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      setState(() => _result = l10n.bookingRequestSent);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.bookingRequestSentAdminChat,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _result = l10n.bookingRequestFailed);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isArabic ? 'فشل الإرسال: $e' : 'Send failed: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return _isArabic ? 'أ' : 'S';
    if (parts.length == 1) return parts.first[0];
    return '${parts.first[0]}${parts.last[0]}';
  }

  String _safePhotoUrl(String raw) {
    final u = raw.trim();
    if (u.isEmpty) return '';
    final uri = Uri.tryParse(u);
    if (uri == null) return '';
    if (!uri.hasScheme) return '';
    return u;
  }

  String _safeAssetPath(String raw) {
    final v = raw.trim();
    if (v.isEmpty) return '';
    if (!v.startsWith('assets/')) return '';
    return v;
  }

  String _backgroundAsset(double width) {
    if (width < 700) {
      return 'assets/images/backgrounds/specialists_bg_mobile.png';
    }
    if (width < 1100) {
      return 'assets/images/backgrounds/specialists_bg_tablet.png';
    }
    return 'assets/images/backgrounds/specialists_bg_desktop.png';
  }

  Widget _glassCard({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
  }) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE7C766).withValues(alpha: 0.32),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE7C766).withValues(alpha: 0.08),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Color(0xFFFFF4D4), height: 1.35),
        child: IconTheme(
          data: const IconThemeData(color: Color(0xFFE7C766)),
          child: child,
        ),
      ),
    );
  }

  Widget _buildClinicianAvatar(
    BuildContext context, {
    required String clinicianName,
    required String photoAsset,
    required String photoUrl,
  }) {
    final asset = _safeAssetPath(photoAsset);
    final network = _safePhotoUrl(photoUrl);

    if (network.isNotEmpty) {
      return CircleAvatar(
        radius: 28,
        backgroundColor: const Color(0xFFE7C766).withValues(alpha: 0.18),
        backgroundImage: NetworkImage(network),
      );
    }

    if (asset.isNotEmpty) {
      return CircleAvatar(
        radius: 28,
        backgroundColor: const Color(0xFFE7C766).withValues(alpha: 0.18),
        child: ClipOval(
          child: Image.asset(
            normalizeAssetPath(asset),
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Text(
                  _initials(clinicianName),
                  style: const TextStyle(
                    color: Color(0xFFFFE7B2),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: 28,
      backgroundColor: const Color(0xFFE7C766).withValues(alpha: 0.18),
      foregroundColor: const Color(0xFFFFE7B2),
      child: Text(
        _initials(clinicianName),
        style: const TextStyle(
          color: Color(0xFFFFE7B2),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black.withValues(alpha: 0.30),
          foregroundColor: const Color(0xFFFFE7B2),
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const _GoldBackIcon(compact: true),
          ),
          title: Text(l10n.bookingRequestTitle),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_backgroundAsset(constraints.maxWidth)),
                  fit: BoxFit.cover,
                  alignment: constraints.maxWidth < 700
                      ? Alignment.topCenter
                      : Alignment.center,
                ),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.52),
                      Colors.black.withValues(alpha: 0.30),
                      Colors.black.withValues(alpha: 0.68),
                    ],
                  ),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 820),
                    child:
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('clinicians')
                          .doc(widget.args.clinicianId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        final data =
                            snapshot.data?.data() ?? <String, dynamic>{};
                        final displayName =
                            (data['displayName'] ?? widget.args.clinicianName)
                                .toString();
                        final photoAsset =
                            (data['photoAsset'] ?? '').toString();
                        final photoUrl =
                            (data['photoUrl'] ?? data['photo_url'] ?? '')
                                .toString();

                        return ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            _glassCard(
                              child: Row(
                                children: [
                                  _buildClinicianAvatar(
                                    context,
                                    clinicianName: displayName,
                                    photoAsset: photoAsset,
                                    photoUrl: photoUrl,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: _isArabic
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          displayName,
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: const Color(0xFFFFE7B2),
                                                fontWeight: FontWeight.w800,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _isArabic
                                              ? 'سيتم إرسال طلبك أولًا إلى الإدارة ثم تحويله إلى الأخصائي المناسب.'
                                              : 'Your request will be sent to admin first, then assigned to the suitable specialist.',
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: const Color(0xFFFFF4D4)
                                                    .withValues(alpha: 0.82),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            _glassCard(
                              child: Column(
                                crossAxisAlignment: _isArabic
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.bookingAdditionalNotes,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          color: const Color(0xFFFFE7B2),
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _isArabic
                                        ? 'اكتب أي تفاصيل تريد أن تصل إلى الإدارة أو الأخصائي.'
                                        : 'Write any details you want admin or the specialist to receive.',
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: const Color(0xFFFFF4D4)
                                              .withValues(alpha: 0.82),
                                        ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    controller: _noteCtrl,
                                    style: const TextStyle(
                                      color: Color(0xFFFFF4D4),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textDirection: _isArabic
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    decoration: InputDecoration(
                                      hintText: _isArabic
                                          ? l10n.bookingWriteNoteHint
                                          : l10n.bookingWriteNoteHint,
                                      hintStyle: TextStyle(
                                        color: const Color(0xFFFFF4D4)
                                            .withValues(alpha: 0.62),
                                      ),
                                      filled: true,
                                      fillColor:
                                          Colors.black.withValues(alpha: 0.26),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        borderSide: BorderSide(
                                          color: const Color(0xFFE7C766)
                                              .withValues(alpha: 0.26),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        borderSide: BorderSide(
                                          color: const Color(0xFFE7C766)
                                              .withValues(alpha: 0.56),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    maxLines: 5,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 54,
                              child: FilledButton.icon(
                                onPressed: _submitting ? null : _submit,
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFFE7C766)
                                      .withValues(alpha: 0.16),
                                  foregroundColor: const Color(0xFFFFE7B2),
                                  disabledBackgroundColor:
                                      Colors.black.withValues(alpha: 0.22),
                                  disabledForegroundColor:
                                      const Color(0xFFFFF4D4)
                                          .withValues(alpha: 0.45),
                                  side: BorderSide(
                                    color: const Color(0xFFE7C766)
                                        .withValues(alpha: 0.44),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                icon: _submitting
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      )
                                    : const Icon(Icons.send_outlined),
                                label: Text(
                                  _submitting
                                      ? l10n.bookingSending
                                      : l10n.bookingSendRequest,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            if (_result != null)
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.34),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFFE7C766)
                                        .withValues(alpha: 0.26),
                                  ),
                                ),
                                child: Text(
                                  _result!,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: const Color(0xFFFFF4D4),
                                      ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
