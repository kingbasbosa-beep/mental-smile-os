import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/core/visibility/visibility_readiness.dart';
import 'package:flutterprojects/features/contact_requests/data/contact_request_repository.dart';
import 'package:flutterprojects/features/saved_destinations/data/saved_destination_repository.dart';
import 'package:flutterprojects/features/saved_destinations/domain/models/saved_destination.dart';
import 'package:flutterprojects/features/signals/signals.dart';
import 'package:flutterprojects/features/specialists/data/clinician_specialty_catalog.dart';
import 'package:flutterprojects/shared/analytics/app_analytics.dart';
import 'package:flutterprojects/shared/utils/asset_path_utils.dart';

class SpecialistDetailsPage extends StatelessWidget {
  const SpecialistDetailsPage({
    super.key,
    required this.args,
  });

  final Map<String, dynamic> args;
  static final Set<String> _emittedProfileViews = <String>{};

  Map<String, dynamic> _mergedData(Map<String, dynamic>? firestoreData) {
    return {
      ...args,
      if (firestoreData != null) ...firestoreData,
    };
  }

  String _text(dynamic value, String fallback) {
    final text = (value ?? '').toString().trim();
    return text.isEmpty ? fallback : text;
  }

  List<String> _stringList(dynamic value) {
    if (value is List) {
      return value
          .map((e) => e.toString().trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return const [];
  }

  List<String> _providerSignalTags(Map<String, dynamic> data) {
    return <String>[
      _text(data['specialtyKey'], ''),
      _text(data['specialty'], ''),
      _text(data['professionalTitleKey'], ''),
    ].where((value) => value.trim().isNotEmpty).toSet().toList();
  }

  Future<void> _sendProviderContactRequest({
    required BuildContext context,
    required String providerId,
    required bool isArabic,
  }) async {
    final clientId = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (clientId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'يرجى تسجيل الدخول لإرسال طلب التواصل.'
                : 'Please sign in to send a contact request.',
          ),
        ),
      );
      return;
    }

    try {
      await ContactRequestRepository().createProviderContactRequest(
        clientId: clientId,
        providerId: providerId,
        message: isArabic
            ? 'أرغب في التواصل مع مقدم الخدمة لمعرفة الخيارات المناسبة.'
            : 'I would like this provider to contact me about suitable options.',
      );
      if (!context.mounted) return;
      AppAnalytics.logPathSelected(
        'specialists',
        'provider_contact_request_created',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم إرسال طلب التواصل. يمكنك متابعة الدعم أو حفظ مقدم الخدمة للرجوع لاحقًا.'
                : 'Contact request sent. You can continue with support or save this provider for later.',
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تعذر إرسال طلب التواصل: $e'
                : 'Could not send contact request: $e',
          ),
        ),
      );
    }
  }

  Future<void> _saveProviderDestination({
    required BuildContext context,
    required Map<String, dynamic> data,
    required String providerId,
    required String providerName,
    required bool isArabic,
  }) async {
    final clientId = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (clientId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'يرجى تسجيل الدخول لحفظ مقدم الخدمة.'
                : 'Please sign in to save this provider.',
          ),
        ),
      );
      return;
    }

    try {
      await SavedDestinationRepository().saveDestination(
        clientId: clientId,
        destinationType: SavedDestinationType.provider,
        destinationId: providerId,
        title: providerName,
        route: Routes.specialistDetails,
        signalTags: _providerSignalTags(data),
      );
      if (!context.mounted) return;
      AppAnalytics.logPathSelected('specialists', 'save_provider_destination');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تم حفظ مقدم الخدمة للرجوع لاحقًا.'
                : 'Provider saved for later.',
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تعذر حفظ مقدم الخدمة: $e'
                : 'Could not save provider: $e',
          ),
        ),
      );
    }
  }

  String _providerSignalLabel(String key, bool isArabic) {
    if (isArabic) {
      switch (key) {
        case 'addiction_counselor':
        case 'recovery_support':
          return 'إدمان وتعافي';
        case 'family_counselor':
        case 'family_support':
          return 'مشورة أسرية';
        case 'children_support':
          return 'أطفال';
        case 'speech_specialist':
        case 'speech_support':
          return 'تخاطب';
        case 'coach':
          return 'كوتشينج';
        case 'hearing_support':
          return 'دعم صعوبات السمع';
        case 'text_based_support':
        case 'text':
          return 'تواصل نصي';
        case 'clinical_psychologist':
        case 'psychologist':
        case 'mental_health_support':
          return 'دعم نفسي';
        case 'hiv_sensitive_support':
          return 'دعم حساس';
        case 'simplified_communication':
          return 'تواصل مبسط';
        case 'group_support':
          return 'جلسات جماعية';
      }
    }

    switch (key) {
      case 'addiction_counselor':
      case 'recovery_support':
        return 'Recovery support';
      case 'family_counselor':
      case 'family_support':
        return 'Family support';
      case 'children_support':
        return 'Children';
      case 'speech_specialist':
      case 'speech_support':
        return 'Speech support';
      case 'coach':
        return 'Coaching';
      case 'hearing_support':
        return 'Hearing support';
      case 'text_based_support':
      case 'text':
        return 'Text support';
      case 'clinical_psychologist':
      case 'psychologist':
      case 'mental_health_support':
        return 'Mental health support';
      case 'hiv_sensitive_support':
        return 'Sensitive support';
      case 'simplified_communication':
        return 'Simplified communication';
      case 'group_support':
        return 'Group support';
    }
    return '';
  }

  List<String> _providerSignalBadges(
    Map<String, dynamic> data,
    bool isArabic, {
    int max = 5,
  }) {
    // [S] Provider Signals
    // Display-only provider signal badges.
    final signals = data['providerSignals'];
    if (signals is! Map) return const [];
    final keys = <String>[
      ..._stringList(signals['capabilitySignals']),
      ..._stringList(signals['accessibilitySignals']),
      ..._stringList(signals['communicationSignals']),
    ];
    final labels = <String>[];
    for (final key in keys) {
      final label = _providerSignalLabel(key, isArabic);
      if (label.isNotEmpty && !labels.contains(label)) {
        labels.add(label);
      }
      if (labels.length >= max) break;
    }
    return labels;
  }

  String _prefix(bool isArabic, String key, String ar, String en) {
    if (isArabic) {
      if (ar.trim().isNotEmpty) return ar.trim();
      switch (key) {
        case 'doctor':
          return 'د.';
        case 'specialist':
          return 'أ.';
        default:
          return '';
      }
    } else {
      if (en.trim().isNotEmpty) return en.trim();
      switch (key) {
        case 'doctor':
          return 'Dr.';
        case 'specialist':
          return 'Spec.';
        default:
          return '';
      }
    }
  }

  String _displayName(Map<String, dynamic> data, bool isArabic) {
    final name = _text(
      data['displayName'],
      isArabic ? 'أخصائي' : 'Specialist',
    );
    final prefix = _prefix(
      isArabic,
      (data['professionalTitleKey'] ?? '').toString(),
      (data['professionalTitleLabelAr'] ?? '').toString(),
      (data['professionalTitleLabelEn'] ?? '').toString(),
    );
    if (prefix.isEmpty) return name;
    return '$prefix $name';
  }

  bool _canShowClinician(Map<String, dynamic> data) {
    final role = _text(data['role'], '');
    return role == 'clinician' && VisibilityReadiness.isVisible(data);
  }

  Widget _safeUnavailable(BuildContext context, bool isArabic) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          isArabic
              ? 'هذا الأخصائي غير متاح للعرض حاليًا.'
              : 'This specialist is not available right now.',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFFFFF4D4)),
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ').where((e) => e.isNotEmpty).toList();
    if (parts.isEmpty) return 'S';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  String _safePhotoUrl(String raw) {
    final u = raw.trim();
    if (u.isEmpty) return '';
    final uri = Uri.tryParse(u);
    if (uri == null || !uri.hasScheme) return '';
    return u;
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

  BoxDecoration _glassDecoration({double radius = 24, double alpha = 0.34}) {
    return BoxDecoration(
      color: Colors.black.withValues(alpha: alpha),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: const Color(0xFFE7C766).withValues(alpha: 0.30),
      ),
      boxShadow: [
        BoxShadow(
          blurRadius: 24,
          offset: const Offset(0, 12),
          color: const Color(0xFFE7C766).withValues(alpha: 0.08),
        ),
      ],
    );
  }

  Widget _buildAvatar(
      BuildContext context, String name, String asset, String network) {
    final assetPath = asset.trim().startsWith('assets/') ? asset.trim() : '';
    final photoUrl = _safePhotoUrl(network);

    if (photoUrl.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          photoUrl,
          width: 132,
          height: 132,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text(
                _initials(name),
                style: const TextStyle(
                  color: Color(0xFFFFE7B2),
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                ),
              ),
            );
          },
        ),
      );
    }

    if (assetPath.isNotEmpty) {
      return ClipOval(
        child: Image.asset(
          normalizeAssetPath(assetPath),
          width: 132,
          height: 132,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text(
                _initials(name),
                style: const TextStyle(
                  color: Color(0xFFFFE7B2),
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                ),
              ),
            );
          },
        ),
      );
    }

    return Center(
      child: Text(
        _initials(name),
        style: const TextStyle(
          color: Color(0xFFFFE7B2),
          fontWeight: FontWeight.w800,
          fontSize: 34,
        ),
      ),
    );
  }
  Widget _buildContent(
    BuildContext context, {
    required bool isArabic,
    required Map<String, dynamic> data,
    required String uid,
  }) {
    final name = _displayName(data, isArabic);
    final specialty = ClinicianSpecialtyCatalog.specialtyLabel(
      specialtyKey: (data['specialtyKey'] ?? '').toString(),
      isArabic: isArabic,
      fallback: _text(
        data['specialty'],
        isArabic ? 'بدون تخصص محدد' : 'No specific specialty',
      ),
    );
    final bio = _text(
      data['bio'],
      isArabic ? 'لا توجد نبذة متاحة حاليًا.' : 'No bio available yet.',
    );
    final asset = _text(data['photoAsset'], '');
    final network = _text(data['photoUrl'], '');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.34),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: const Color(0xFFE7C766).withValues(alpha: 0.30),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 18,
                offset: const Offset(0, 8),
                color: Colors.black.withValues(alpha: 0.05),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
                isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                isArabic ? 'الصورة الشخصية' : 'Profile image',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFFFFE7B2),
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.24),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFFE7C766).withValues(alpha: 0.24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                        color: Colors.black.withValues(alpha: 0.05),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFE7C766),
                            Color(0xFFFFE7B2),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.72),
                          shape: BoxShape.circle,
                        ),
                        child: _buildAvatar(context, name, asset, network),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Center(
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: const Color(0xFFFFE7B2),
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  specialty,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFFFFF4D4).withValues(alpha: 0.78),
                      ),
                ),
              ),
              _ProviderSignalBadges(
                labels: _providerSignalBadges(data, isArabic),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.34),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFE7C766).withValues(alpha: 0.30),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                isArabic ? 'نبذة' : 'About',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFFFFE7B2),
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                bio,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFFFFF4D4),
                      height: 1.5,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        FilledButton.icon(
          onPressed: uid.isEmpty
              ? null
              : () {
                  AppAnalytics.logPathSelected(
                    'specialists',
                    'support_choose_provider',
                  );
                  Navigator.of(context).pushNamed(
                    Routes.supportIssueSelector,
                    arguments: const {
                      'supportType': 'recovery_support',
                    },
                  );
                },
          icon: const Icon(Icons.support_agent_outlined),
          label: Text(
            isArabic
                ? 'طلب دعم للمساعدة في الاختيار'
                : 'Get help choosing a provider',
          ),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            backgroundColor: const Color(0xFFE7C766).withValues(alpha: 0.16),
            foregroundColor: const Color(0xFFFFE7B2),
            side: BorderSide(
              color: const Color(0xFFE7C766).withValues(alpha: 0.44),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: uid.isEmpty
                ? null
                : () {
                    _sendProviderContactRequest(
                      context: context,
                      providerId: uid,
                      isArabic: isArabic,
                    );
                  },
            icon: const Icon(Icons.contact_page_outlined),
            label: Text(
              isArabic ? 'إرسال طلب تواصل' : 'Contact provider',
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              foregroundColor: const Color(0xFFFFE7B2),
              side: BorderSide(
                color: const Color(0xFFE7C766).withValues(alpha: 0.28),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: uid.isEmpty
                ? null
                : () => _saveProviderDestination(
                      context: context,
                      data: data,
                      providerId: uid,
                      providerName: name,
                      isArabic: isArabic,
                    ),
            icon: const Icon(Icons.bookmark_add_outlined),
            label: Text(isArabic ? 'حفظ مقدم الخدمة' : 'Save provider'),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFFFE7B2),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final providerId = _text(args['uid'], '');
    if (providerId.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      final eventKey = '${user?.uid}:$providerId';
      if (user != null &&
          !user.isAnonymous &&
          _emittedProfileViews.add(eventKey)) {
        unawaited(
          CleanSignalRuntime.firestore().emit(
            SignalPackageFactory.providerProfileOpened(
              actorId: user.uid,
              actorRole: 'client',
              targetId: providerId,
            ),
          ),
        );
      }
    }

    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
    final uid = _text(args['uid'], '');

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
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
          title: Text(isArabic ? 'تفاصيل الأخصائي' : 'Specialist details'),
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
                child: uid.isEmpty
                    ? _safeUnavailable(context, isArabic)
                    : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('clinicians')
                            .doc(uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return _safeUnavailable(context, isArabic);
                          }

                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFE7C766),
                              ),
                            );
                          }

                          if (!snapshot.data!.exists) {
                            return _safeUnavailable(context, isArabic);
                          }

                          final firestoreData = snapshot.data?.data();
                          if (firestoreData == null ||
                              !_canShowClinician(firestoreData)) {
                            return _safeUnavailable(context, isArabic);
                          }

                          final mergedData = _mergedData(firestoreData);

                          return _buildContent(
                            context,
                            isArabic: isArabic,
                            data: mergedData,
                            uid: uid,
                          );
                        },
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
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
          return Icon(
            Icons.arrow_back_rounded,
            color: const Color(0xFFFFE7B2),
            size: iconSize,
          );
        },
      ),
    );
  }
}

class _ProviderSignalBadges extends StatelessWidget {
  const _ProviderSignalBadges({required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    if (labels.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final label in labels)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7C766).withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: const Color(0xFFE7C766).withValues(alpha: 0.30),
                  ),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFFFFE7B2),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoMiniCard extends StatelessWidget {
  const _InfoMiniCard({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE7C766).withValues(alpha: 0.24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFFFF4D4).withValues(alpha: 0.70),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFFFFE7B2),
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}

