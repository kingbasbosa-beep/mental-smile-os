import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_smile_os/features/accessibility/data/accessibility_sample_resources.dart';
import 'package:mental_smile_os/features/accessibility/domain/factories/accessibility_signal_factory.dart';
import 'package:mental_smile_os/features/accessibility/domain/models/accessibility_category.dart';
import 'package:mental_smile_os/features/accessibility/domain/models/accessibility_resource.dart';
import 'package:mental_smile_os/features/accessibility/domain/models/accessibility_signal_type.dart';
import 'package:mental_smile_os/features/accessibility/domain/registries/accessibility_category_registry.dart';
import 'package:mental_smile_os/features/accessibility/domain/registries/accessibility_resource_type_registry.dart';
import 'package:mental_smile_os/features/signals/signals.dart';
import 'package:url_launcher/url_launcher.dart';

class AccessibilityResourceListPage extends StatelessWidget {
  const AccessibilityResourceListPage({
    super.key,
    required this.category,
  });

  final AccessibilityCategory category;

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
    final categoryEntry = AccessibilityCategoryRegistry.entryFor(category);
    final resources = AccessibilitySampleResources.byCategory(category);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F4EF),
        appBar: AppBar(
          title: Text(categoryEntry == null
              ? (isArabic ? 'مصادر الوصول' : 'Accessibility resources')
              : (isArabic ? categoryEntry.titleAr : categoryEntry.titleEn)),
          backgroundColor: const Color(0xFFF7F4EF),
          foregroundColor: const Color(0xFF17201B),
          elevation: 0,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              if (categoryEntry != null)
                _CategoryIntro(entry: categoryEntry, isArabic: isArabic),
              const SizedBox(height: 14),
              if (resources.isEmpty)
                _EmptyResources(isArabic: isArabic)
              else
                for (final resource in resources) ...[
                  _AccessibilityResourceCard(
                    resource: resource,
                    isArabic: isArabic,
                  ),
                  const SizedBox(height: 12),
                ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryIntro extends StatelessWidget {
  const _CategoryIntro({
    required this.entry,
    required this.isArabic,
  });

  final AccessibilityCategoryEntry entry;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF17201B).withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Icon(entry.icon, color: const Color(0xFF116A5B), size: 34),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? entry.titleAr : entry.titleEn,
                  style: const TextStyle(
                    color: Color(0xFF17201B),
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isArabic ? entry.descriptionAr : entry.descriptionEn,
                  style: TextStyle(
                    color: const Color(0xFF17201B).withValues(alpha: 0.68),
                    fontSize: 13,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccessibilityResourceCard extends StatelessWidget {
  const _AccessibilityResourceCard({
    required this.resource,
    required this.isArabic,
  });

  final AccessibilityResource resource;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final title = isArabic ? resource.titleAr : resource.titleEn;
    final description =
        isArabic ? resource.descriptionAr : resource.descriptionEn;

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: const Color(0xFF17201B).withValues(alpha: 0.08),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF17201B),
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),
                ),
                if (resource.isVerified) const _VerifiedBadge(),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: const Color(0xFF17201B).withValues(alpha: 0.70),
                fontSize: 14,
                height: 1.38,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MetaChip(
                  icon: Icons.public_outlined,
                  label: resource.country,
                ),
                _MetaChip(
                  icon: Icons.category_outlined,
                  label: AccessibilityResourceTypeRegistry.label(
                    resource.resourceType,
                    isArabic: isArabic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () => _openResource(resource),
                  icon: const Icon(Icons.open_in_new_rounded, size: 18),
                  label: Text(isArabic ? 'فتح الرابط' : 'Open link'),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF116A5B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () => _emit(
                    AccessibilitySignalType.resourceSaved,
                    resource,
                  ),
                  icon: const Icon(Icons.bookmark_border_rounded, size: 18),
                  label: Text(isArabic ? 'حفظ' : 'Save'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF17201B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () => _emit(
                    AccessibilitySignalType.resourceBrokenLinkReported,
                    resource,
                  ),
                  icon: const Icon(Icons.link_off_rounded, size: 18),
                  label: Text(
                    isArabic ? 'الإبلاغ عن رابط' : 'Report broken link',
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF7A2D23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openResource(AccessibilityResource resource) async {
    _emit(AccessibilitySignalType.resourceOpened, resource);
    final uri = Uri.tryParse(resource.url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _emit(
    AccessibilitySignalType signalType,
    AccessibilityResource resource,
  ) {
    unawaited(
      CleanSignalRuntime.firestore().emit(
        AccessibilitySignalFactory.package(
          signalType: signalType,
          category: resource.category,
          disabilityType: resource.disabilityType,
          resourceId: resource.id,
          userId: FirebaseAuth.instance.currentUser?.uid,
        ),
      ),
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Verified source',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFF116A5B).withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(999),
        ),
        child: const Icon(
          Icons.verified_outlined,
          size: 17,
          color: Color(0xFF116A5B),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF17201B).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF17201B), size: 15),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF17201B),
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyResources extends StatelessWidget {
  const _EmptyResources({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF17201B).withValues(alpha: 0.08),
        ),
      ),
      child: Text(
        isArabic
            ? 'سيتم إضافة مصادر موثوقة هنا بعد مرحلة التحقق.'
            : 'Trusted resources will appear here after verification.',
        style: TextStyle(
          color: const Color(0xFF17201B).withValues(alpha: 0.70),
          fontSize: 14,
          height: 1.35,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
