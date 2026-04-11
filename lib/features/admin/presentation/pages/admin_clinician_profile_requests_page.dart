import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';
import 'package:flutterprojects/features/centers/data/models/center_pricing.dart';

// ADMIN_SURFACE: SAFE_UI
class AdminClinicianProfileRequestsPage extends StatefulWidget {
  const AdminClinicianProfileRequestsPage({super.key});

  @override
  State<AdminClinicianProfileRequestsPage> createState() =>
      _AdminClinicianProfileRequestsPageState();
}

class _AdminClinicianProfileRequestsPageState
    extends State<AdminClinicianProfileRequestsPage> {
  final Set<String> _busyIds = {};
  String _selectedStatusFilter = 'all';
  String _selectedEntityFilter = 'clinician';

  bool _isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

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

  String _requestTypeLabel(String entityType, String type, bool isArabic) {
    if (entityType == 'center') {
      switch (type) {
        case 'profile_update':
          return isArabic ? 'تعديل بيانات المركز' : 'Center data update';
        case 'gallery_update':
          return isArabic ? 'تعديل صور المركز' : 'Center image update';
        case 'document_update':
          return isArabic ? 'تعديل وثائق المركز' : 'Center document update';
        default:
          return isArabic ? 'طلب تعديل بيانات المركز' : 'Center change request';
      }
    }

    switch (type) {
      case 'bio_update':
        return isArabic ? 'تعديل النبذة' : 'Bio update';
      case 'photo_update':
        return isArabic ? 'تعديل الصورة الشخصية' : 'Photo update';
      case 'photo_add':
        return isArabic ? 'إضافة صورة شخصية' : 'Add profile photo';
      case 'profile_update':
        return isArabic ? 'تعديل النبذة والصورة' : 'Profile update';
      default:
        return isArabic ? 'طلب تعديل' : 'Change request';
    }
  }

  String _statusLabel(String status, bool isArabic) {
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

  String _filterLabel(String filter, bool isArabic) {
    switch (filter) {
      case 'pending':
        return isArabic ? 'قيد المراجعة' : 'Pending';
      case 'approved':
        return isArabic ? 'مقبول' : 'Approved';
      case 'rejected':
        return isArabic ? 'مرفوض' : 'Rejected';
      case 'all':
      default:
        return isArabic ? 'الكل' : 'All';
    }
  }

  bool _matchesSelectedStatus(String status) {
    if (_selectedStatusFilter == 'all') return true;
    return status == _selectedStatusFilter;
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'approved':
        return AppColors.success;
      case 'rejected':
        return AppColors.danger;
      case 'pending':
      default:
        return AppColors.accentLavender;
    }
  }

  List<Map<String, dynamic>> _mapList(dynamic raw) {
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((e) => e.map((k, v) => MapEntry('$k', v)))
          .toList();
    }
    return const [];
  }

  List<String> _orderedCenterGalleryUrls(List<Map<String, dynamic>> items) {
    const slotOrder = ['front', 'reception', 'inside_1', 'inside_2'];
    final ordered = <String>[];

    for (final slot in slotOrder) {
      final match = items.cast<Map<String, dynamic>?>().firstWhere(
            (item) => (item?['slotKey'] ?? '').toString() == slot,
            orElse: () => null,
          );
      final url = (match?['url'] ?? '').toString().trim();
      if (url.isNotEmpty) {
        ordered.add(url);
      }
    }

    return ordered;
  }

  List<Map<String, dynamic>> _normalizeCenterDocuments(
    List<Map<String, dynamic>> items,
  ) {
    return items
        .map(
          (item) => {
            'name': (item['name'] ??
                    item['fileName'] ??
                    item['originalFileName'] ??
                    '')
                .toString()
                .trim(),
            'url': (item['url'] ?? item['fileUrl'] ?? '').toString().trim(),
            'type':
                (item['type'] ?? item['documentType'] ?? '').toString().trim(),
          },
        )
        .where(
          (item) =>
              (item['name'] ?? '').toString().isNotEmpty &&
              (item['url'] ?? '').toString().isNotEmpty,
        )
        .toList();
  }

  String _assetSummary({
    required List<Map<String, dynamic>> items,
    required String singularLabel,
    required String pluralLabel,
  }) {
    if (items.isEmpty) return '';
    final count = items.length;
    final labels = items
        .map((item) => (item['label'] ?? item['documentType'] ?? '').toString())
        .where((value) => value.trim().isNotEmpty)
        .take(3)
        .toList();
    final preview = labels.isEmpty ? '' : ' - ${labels.join(' / ')}';
    return '$count ${count == 1 ? singularLabel : pluralLabel}$preview';
  }

  String _pricingSummary(dynamic raw, bool isArabic) {
    final items = mergeAccommodationCostItems(raw)
        .where((item) => item.enabled && item.price > 0)
        .toList();
    if (items.isEmpty) {
      return isArabic ? 'لا توجد فئات مفعلة' : 'No enabled categories';
    }
    return items
        .map((item) =>
            '${isArabic ? item.labelAr : item.labelEn}: ${item.price.toStringAsFixed(item.price.truncateToDouble() == item.price ? 0 : 2)}${item.pricingUnit.isEmpty ? '' : ' / ${item.pricingUnit}'}')
        .join(' | ');
  }

  String _autismPricingSummary(dynamic raw, bool isArabic) {
    final items = mergeAutismCareCostItems(raw)
        .where((item) => item.enabled && item.price > 0)
        .toList();
    if (items.isEmpty) {
      return isArabic ? 'لا توجد بنود مفعلة' : 'No enabled items';
    }
    return items
        .map((item) =>
            '${isArabic ? item.labelAr : item.labelEn}: ${item.price.toStringAsFixed(item.price.truncateToDouble() == item.price ? 0 : 2)}${item.pricingUnit.isEmpty ? '' : ' / ${item.pricingUnit}'}')
        .join(' | ');
  }

  String _capabilitiesSummary(dynamic raw, bool isArabic) {
    final flags = CenterCapabilityFlags.fromMap(
      raw is Map ? Map<String, dynamic>.from(raw) : const <String, dynamic>{},
    );
    final items = <String>[];
    if (flags.supportsAddictionCasesWithHiv) {
      items.add(isArabic
          ? 'يدعم حالات الإدمان المصاحبة لفيروس HIV'
          : 'Supports addiction cases with HIV');
    }
    if (flags.acceptsAddictionCases) {
      items.add(isArabic ? 'يستقبل حالات الإدمان' : 'Accepts addiction cases');
    }
    if (flags.acceptsPsychiatricCasesWithoutAddiction) {
      items.add(isArabic
          ? 'يستقبل الحالات النفسية بدون إدمان'
          : 'Accepts psychiatric cases without addiction');
    }
    return items.isEmpty
        ? (isArabic ? 'لا توجد قدرات محددة' : 'No capabilities set')
        : items.join(' | ');
  }

  Future<void> _approveRequest({
    required String requestId,
    required Map<String, dynamic> data,
  }) async {
    await _setBusy(requestId, true);

    try {
      final db = FirebaseFirestore.instance;
      final clinicianId = (data['clinicianId'] ?? '').toString().trim();

      if (clinicianId.isEmpty) {
        throw Exception('Missing clinicianId');
      }

      final requestedBio = (data['requestedBio'] ?? '').toString().trim();
      final requestedPhotoUrl =
          (data['requestedPhotoUrl'] ?? '').toString().trim();

      final clinicianRef = db.collection('clinicians').doc(clinicianId);
      final requestRef =
          db.collection('clinician_profile_change_requests').doc(requestId);

      final clinicianUpdates = <String, dynamic>{
        'updatedAt': FieldValue.serverTimestamp(),
        'lastApprovedProfileChangeAt': FieldValue.serverTimestamp(),
      };

      if (requestedBio.isNotEmpty) {
        clinicianUpdates['bio'] = requestedBio;
      }

      if (requestedPhotoUrl.isNotEmpty) {
        clinicianUpdates['photoUrl'] = requestedPhotoUrl;
      }

      await clinicianRef.set(clinicianUpdates, SetOptions(merge: true));

      await requestRef.update({
        'status': 'approved',
        'reviewedAt': FieldValue.serverTimestamp(),
        'adminDecision': 'approved',
        'adminNote': 'تمت الموافقة وتطبيق التعديل على الحساب',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تمت الموافقة على الطلب وتحديث بيانات الأخصائي'),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('فشل قبول الطلب: $e'),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _rejectRequest({
    required String requestId,
  }) async {
    await _setBusy(requestId, true);

    try {
      await FirebaseFirestore.instance
          .collection('clinician_profile_change_requests')
          .doc(requestId)
          .update({
        'status': 'rejected',
        'reviewedAt': FieldValue.serverTimestamp(),
        'adminDecision': 'rejected',
        'adminNote': 'تم رفض الطلب من الإدارة',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم رفض الطلب'),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('فشل رفض الطلب: $e'),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _approveCenterRequest({
    required String requestId,
    required Map<String, dynamic> data,
  }) async {
    await _setBusy(requestId, true);

    try {
      final db = FirebaseFirestore.instance;
      final centerId = (data['centerId'] ?? '').toString().trim();

      if (centerId.isEmpty) {
        throw Exception('Missing centerId');
      }

      final requestedCenterName =
          (data['requestedCenterName'] ?? '').toString().trim();
      final requestedManagerName =
          (data['requestedManagerName'] ?? '').toString().trim();
      final requestedDescription =
          (data['requestedDescription'] ?? '').toString().trim();
      final requestedCity = (data['requestedCity'] ?? '').toString().trim();
      final requestedAddress =
          (data['requestedAddress'] ?? '').toString().trim();
      final requestedGalleryItems = _mapList(data['requestedGalleryItems']);
      final requestedDocumentItems = _mapList(data['requestedDocumentItems']);
      final requestedAccommodationCosts = _mapList(
        data['requestedAccommodationCosts'],
      );
      final requestedAutismCareCosts = _mapList(
        data['requestedAutismCareCosts'],
      );
      final normalizedGalleryUrls =
          _orderedCenterGalleryUrls(requestedGalleryItems);
      final normalizedDocuments =
          _normalizeCenterDocuments(requestedDocumentItems);

      final centerUpdates = <String, dynamic>{
        'updatedAt': FieldValue.serverTimestamp(),
        'lastApprovedProfileChangeAt': FieldValue.serverTimestamp(),
        'galleryItems': requestedGalleryItems,
        'galleryImages': normalizedGalleryUrls,
        'galleryImageUrls': normalizedGalleryUrls,
        'imageUrl':
            normalizedGalleryUrls.isNotEmpty ? normalizedGalleryUrls.first : '',
        'coverImageUrl':
            normalizedGalleryUrls.isNotEmpty ? normalizedGalleryUrls.first : '',
        'imagesReady': (data['requestedImagesReady'] ?? false) == true,
        'documentItems': requestedDocumentItems,
        'documents': normalizedDocuments,
        'documentsReady': (data['requestedDocumentsReady'] ?? false) == true,
        'accommodationCosts': requestedAccommodationCosts,
        'autismCareCosts': requestedAutismCareCosts,
        'centerCapabilities': data['requestedCenterCapabilities'] is Map
            ? Map<String, dynamic>.from(data['requestedCenterCapabilities'])
            : const <String, dynamic>{},
      };

      if (requestedCenterName.isNotEmpty) {
        centerUpdates['name'] = requestedCenterName;
        centerUpdates['centerName'] = requestedCenterName;
        centerUpdates['displayName'] = requestedCenterName;
      }
      if (requestedManagerName.isNotEmpty) {
        centerUpdates['managerName'] = requestedManagerName;
      }
      if (requestedDescription.isNotEmpty) {
        centerUpdates['description'] = requestedDescription;
      }
      if (requestedCity.isNotEmpty) {
        centerUpdates['city'] = requestedCity;
      }
      if (requestedAddress.isNotEmpty) {
        centerUpdates['address'] = requestedAddress;
      }

      await db.collection('centers').doc(centerId).set(
            centerUpdates,
            SetOptions(merge: true),
          );

      await db
          .collection('center_profile_change_requests')
          .doc(requestId)
          .update({
        'status': 'approved',
        'reviewedAt': FieldValue.serverTimestamp(),
        'adminDecision': 'approved',
        'adminNote': 'تمت الموافقة وتطبيق التعديل على بيانات المركز',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تمت الموافقة على طلب المركز وتحديث البيانات'),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('فشل قبول طلب المركز: $e'),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Future<void> _rejectCenterRequest({
    required String requestId,
  }) async {
    await _setBusy(requestId, true);

    try {
      await FirebaseFirestore.instance
          .collection('center_profile_change_requests')
          .doc(requestId)
          .update({
        'status': 'rejected',
        'reviewedAt': FieldValue.serverTimestamp(),
        'adminDecision': 'rejected',
        'adminNote': 'تم رفض طلب تعديل بيانات المركز',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم رفض طلب المركز'),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('فشل رفض طلب المركز: $e'),
        ),
      );
    } finally {
      await _setBusy(requestId, false);
    }
  }

  Widget _buildFieldBlock({
    required String title,
    required String value,
  }) {
    if (value.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: AppSectionPanel(
        padding: const EdgeInsets.all(AppSpacing.md),
        color: Colors.white.withValues(alpha: 0.72),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusFilters(bool isArabic) {
    final filters = ['all', 'pending', 'approved', 'rejected'];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      alignment: WrapAlignment.end,
      children: filters.map((filter) {
        final selected = _selectedStatusFilter == filter;
        return ChoiceChip(
          label: Text(_filterLabel(filter, isArabic)),
          selected: selected,
          onSelected: (_) {
            setState(() {
              _selectedStatusFilter = filter;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildEntityFilters(bool isArabic) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      alignment: WrapAlignment.end,
      children: [
        ChoiceChip(
          label: Text(isArabic ? 'طلبات الأخصائيين' : 'Clinician requests'),
          selected: _selectedEntityFilter == 'clinician',
          onSelected: (_) {
            setState(() {
              _selectedEntityFilter = 'clinician';
            });
          },
        ),
        ChoiceChip(
          label: Text(isArabic ? 'طلبات المراكز' : 'Center requests'),
          selected: _selectedEntityFilter == 'center',
          onSelected: (_) {
            setState(() {
              _selectedEntityFilter = 'center';
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);
    final requestCollection = _selectedEntityFilter == 'center'
        ? 'center_profile_change_requests'
        : 'clinician_profile_change_requests';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.warmIvory,
        appBar: AppShellActions.buildAppBar(
          context,
          title: isArabic
              ? 'طلبات تعديل البيانات'
              : 'Profile/Data change requests',
        ),
        body: AppPageBackground(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection(requestCollection)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Text(
                      isArabic
                          ? 'تعذر تحميل الطلبات:\n${snapshot.error}'
                          : 'Unable to load requests:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final docs = [...snapshot.data!.docs];

              docs.sort((a, b) {
                final aTs = a.data()['createdAt'];
                final bTs = b.data()['createdAt'];

                final aDate = aTs is Timestamp
                    ? aTs.toDate()
                    : DateTime.fromMillisecondsSinceEpoch(0);

                final bDate = bTs is Timestamp
                    ? bTs.toDate()
                    : DateTime.fromMillisecondsSinceEpoch(0);

                return bDate.compareTo(aDate);
              });

              final filteredDocs = docs.where((doc) {
                final data = doc.data();
                final status = (data['status'] ?? 'pending').toString().trim();
                return _matchesSelectedStatus(status);
              }).toList();

              if (docs.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      isArabic
                          ? 'لا توجد طلبات تعديل حالياً'
                          : 'No change requests yet',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  AppSurfaceCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          isArabic ? 'فلترة الطلبات' : 'Request filters',
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Align(
                          alignment: Alignment.centerRight,
                          child: _buildEntityFilters(isArabic),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Align(
                          alignment: Alignment.centerRight,
                          child: _buildStatusFilters(isArabic),
                        ),
                      ],
                    ),
                  ),
                  if (filteredDocs.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Text(
                          isArabic
                              ? 'لا توجد طلبات بهذه الحالة'
                              : 'No requests for this status',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  else
                    ...filteredDocs.map((doc) {
                      final data = doc.data();
                      final requestId = doc.id;
                      final busy = _busyIds.contains(requestId);
                      final isCenterRequest = _selectedEntityFilter == 'center';

                      final entityName = isCenterRequest
                          ? (data['centerName'] ?? '').toString().trim()
                          : (data['clinicianName'] ?? '').toString().trim();
                      final entityEmail = isCenterRequest
                          ? (data['centerEmail'] ?? '').toString().trim()
                          : (data['clinicianEmail'] ?? '').toString().trim();
                      final requestType =
                          (data['requestType'] ?? '').toString().trim();
                      final status =
                          (data['status'] ?? 'pending').toString().trim();

                      final currentBio =
                          (data['currentBio'] ?? '').toString().trim();
                      final requestedBio =
                          (data['requestedBio'] ?? '').toString().trim();
                      final currentPhotoUrl =
                          (data['currentPhotoUrl'] ?? '').toString().trim();
                      final requestedPhotoUrl =
                          (data['requestedPhotoUrl'] ?? '').toString().trim();
                      final currentCenterName =
                          (data['currentCenterName'] ?? '').toString().trim();
                      final requestedCenterName =
                          (data['requestedCenterName'] ?? '').toString().trim();
                      final currentManagerName =
                          (data['currentManagerName'] ?? '').toString().trim();
                      final requestedManagerName =
                          (data['requestedManagerName'] ?? '')
                              .toString()
                              .trim();
                      final currentDescription =
                          (data['currentDescription'] ?? '').toString().trim();
                      final requestedDescription =
                          (data['requestedDescription'] ?? '')
                              .toString()
                              .trim();
                      final currentCity =
                          (data['currentCity'] ?? '').toString().trim();
                      final requestedCity =
                          (data['requestedCity'] ?? '').toString().trim();
                      final currentAddress =
                          (data['currentAddress'] ?? '').toString().trim();
                      final requestedAddress =
                          (data['requestedAddress'] ?? '').toString().trim();
                      final currentGallerySummary = _assetSummary(
                        items: _mapList(data['currentGalleryItems']),
                        singularLabel: 'صورة',
                        pluralLabel: 'صور',
                      );
                      final requestedGallerySummary = _assetSummary(
                        items: _mapList(data['requestedGalleryItems']),
                        singularLabel: 'صورة',
                        pluralLabel: 'صور',
                      );
                      final currentDocumentsSummary = _assetSummary(
                        items: _mapList(data['currentDocumentItems']),
                        singularLabel: 'وثيقة',
                        pluralLabel: 'وثائق',
                      );
                      final requestedDocumentsSummary = _assetSummary(
                        items: _mapList(data['requestedDocumentItems']),
                        singularLabel: 'وثيقة',
                        pluralLabel: 'وثائق',
                      );
                      final currentAccommodationSummary = _pricingSummary(
                        data['currentAccommodationCosts'],
                        isArabic,
                      );
                      final requestedAccommodationSummary = _pricingSummary(
                        data['requestedAccommodationCosts'],
                        isArabic,
                      );
                      final currentAutismSummary = _autismPricingSummary(
                        data['currentAutismCareCosts'],
                        isArabic,
                      );
                      final requestedAutismSummary = _autismPricingSummary(
                        data['requestedAutismCareCosts'],
                        isArabic,
                      );
                      final currentCapabilitiesSummary = _capabilitiesSummary(
                        data['currentCenterCapabilities'],
                        isArabic,
                      );
                      final requestedCapabilitiesSummary = _capabilitiesSummary(
                        data['requestedCenterCapabilities'],
                        isArabic,
                      );
                      final adminNote =
                          (data['adminNote'] ?? '').toString().trim();
                      final createdAt = _dateText(data['createdAt']);

                      return Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.md),
                        child: AppSurfaceCard(
                          color: Colors.white.withValues(alpha: 0.84),
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: AppStatusBadge(
                                  label: _statusLabel(status, isArabic),
                                  color: _statusColor(status),
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 420,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        entityName.isEmpty
                                            ? (isCenterRequest
                                                ? (isArabic ? 'مركز' : 'Center')
                                                : (isArabic
                                                    ? 'أخصائي'
                                                    : 'Clinician'))
                                            : entityName,
                                        textAlign: TextAlign.right,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(fontSize: 22),
                                      ),
                                      const SizedBox(height: AppSpacing.xxs),
                                      if (entityEmail.isNotEmpty)
                                        Text(
                                          entityEmail,
                                          textAlign: TextAlign.right,
                                        ),
                                      const SizedBox(height: AppSpacing.xxs),
                                      Text(
                                        _requestTypeLabel(
                                          isCenterRequest
                                              ? 'center'
                                              : 'clinician',
                                          requestType,
                                          isArabic,
                                        ),
                                        textAlign: TextAlign.right,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      if (createdAt.isNotEmpty) ...[
                                        const SizedBox(height: AppSpacing.xxs),
                                        Text(
                                          isArabic
                                              ? 'تاريخ الطلب: $createdAt'
                                              : 'Request date: $createdAt',
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                              if (isCenterRequest) ...[
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'اسم المركز الحالي'
                                      : 'Current center name',
                                  value: currentCenterName,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'اسم المركز المطلوب'
                                      : 'Requested center name',
                                  value: requestedCenterName,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'اسم المسؤول الحالي'
                                      : 'Current manager name',
                                  value: currentManagerName,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'اسم المسؤول المطلوب'
                                      : 'Requested manager name',
                                  value: requestedManagerName,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'الوصف الحالي'
                                      : 'Current description',
                                  value: currentDescription,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'الوصف المطلوب'
                                      : 'Requested description',
                                  value: requestedDescription,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'المدينة الحالية'
                                      : 'Current city',
                                  value: currentCity,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'المدينة المطلوبة'
                                      : 'Requested city',
                                  value: requestedCity,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'العنوان الحالي'
                                      : 'Current address',
                                  value: currentAddress,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'العنوان المطلوب'
                                      : 'Requested address',
                                  value: requestedAddress,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'الصور الحالية'
                                      : 'Current images',
                                  value: currentGallerySummary,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'الصور المطلوبة'
                                      : 'Requested images',
                                  value: requestedGallerySummary,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'الوثائق الحالية'
                                      : 'Current documents',
                                  value: currentDocumentsSummary,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'الوثائق المطلوبة'
                                      : 'Requested documents',
                                  value: requestedDocumentsSummary,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'تكلفة الإقامة الحالية'
                                      : 'Current accommodation cost',
                                  value: currentAccommodationSummary,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'تكلفة الإقامة المطلوبة'
                                      : 'Requested accommodation cost',
                                  value: requestedAccommodationSummary,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'تكاليف التوحد الحالية'
                                      : 'Current autism costs',
                                  value: currentAutismSummary,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'تكاليف التوحد المطلوبة'
                                      : 'Requested autism costs',
                                  value: requestedAutismSummary,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'قدرات المركز الحالية'
                                      : 'Current center capabilities',
                                  value: currentCapabilitiesSummary,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'قدرات المركز المطلوبة'
                                      : 'Requested center capabilities',
                                  value: requestedCapabilitiesSummary,
                                ),
                              ] else ...[
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'النبذة الحالية'
                                      : 'Current bio',
                                  value: currentBio,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'النبذة المطلوبة'
                                      : 'Requested bio',
                                  value: requestedBio,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'رابط الصورة الحالية'
                                      : 'Current photo URL',
                                  value: currentPhotoUrl,
                                ),
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'رابط الصورة المطلوبة'
                                      : 'Requested photo URL',
                                  value: requestedPhotoUrl,
                                ),
                              ],
                              if (adminNote.isNotEmpty)
                                _buildFieldBlock(
                                  title: isArabic
                                      ? 'ملاحظة الإدارة'
                                      : 'Admin note',
                                  value: adminNote,
                                ),
                              if (status == 'pending') ...[
                                const SizedBox(height: AppSpacing.md),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Wrap(
                                    spacing: AppSpacing.sm,
                                    runSpacing: AppSpacing.sm,
                                    alignment: WrapAlignment.end,
                                    children: [
                                      FilledButton.icon(
                                        onPressed: busy
                                            ? null
                                            : () {
                                                if (isCenterRequest) {
                                                  _approveCenterRequest(
                                                    requestId: requestId,
                                                    data: data,
                                                  );
                                                } else {
                                                  _approveRequest(
                                                    requestId: requestId,
                                                    data: data,
                                                  );
                                                }
                                              },
                                        icon: const Icon(
                                            Icons.check_circle_outline),
                                        label:
                                            Text(isArabic ? 'قبول' : 'Approve'),
                                      ),
                                      OutlinedButton.icon(
                                        onPressed: busy
                                            ? null
                                            : () {
                                                if (isCenterRequest) {
                                                  _rejectCenterRequest(
                                                    requestId: requestId,
                                                  );
                                                } else {
                                                  _rejectRequest(
                                                    requestId: requestId,
                                                  );
                                                }
                                              },
                                        icon: const Icon(Icons.cancel_outlined),
                                        label:
                                            Text(isArabic ? 'رفض' : 'Reject'),
                                        style: appDestructiveButtonStyle(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

