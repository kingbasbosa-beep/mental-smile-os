import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';
import 'package:flutterprojects/features/centers/data/models/center_model.dart';
import 'package:flutterprojects/features/centers/data/services/centers_firestore_service.dart';

class CentersListPage extends StatelessWidget {
  final String category;

  const CentersListPage({
    super.key,
    required this.category,
  });

  String _categoryTitleAr(String key) {
    switch (key) {
      case 'recovery':
        return 'مراكز التعافي';
      case 'detox':
        return 'مراكز سحب السموم';
      case 'hospital':
      case 'hospitals':
        return 'المستشفيات';
      case 'special_needs':
        return 'مراكز رعاية ذوي الاحتياجات الخاصة';
      default:
        return 'المراكز';
    }
  }

  String _locationLine(CenterModel c) {
    final parts = <String>[];
    if (c.city.trim().isNotEmpty) parts.add(c.city.trim());
    if (c.area.trim().isNotEmpty) parts.add(c.area.trim());
    return parts.join(' / ');
  }

  String _shortDescription(String text) {
    final t = text.trim();
    if (t.isEmpty) return '';
    if (t.length <= 120) return t;
    return '${t.substring(0, 120)}…';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final service = CentersFirestoreService();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_categoryTitleAr(category)),
          leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: StreamBuilder<List<CenterModel>>(
          stream: service.streamActiveCentersByCategory(category),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('حدث خطأ أثناء تحميل المراكز'),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final items = snapshot.data ?? const <CenterModel>[];
            if (items.isEmpty) {
              return const Center(
                child: Text('لا توجد مراكز متاحة في هذه الفئة حاليًا'),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final c = items[index];
                final loc = _locationLine(c);
                final desc = _shortDescription(c.description);
                final hasPhone = c.phone.trim().isNotEmpty;
                final chips =
                    c.services.where((e) => e.trim().isNotEmpty).toList();

                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Routes.centerDetails,
                        arguments: {
                          'center': c,
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                            color: scheme.outline.withValues(alpha: 0.12)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            c.name.trim().isEmpty ? 'مركز' : c.name.trim(),
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          if (loc.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              loc,
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: scheme.onSurface
                                        .withValues(alpha: 0.72),
                                  ),
                            ),
                          ],
                          if (desc.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Text(
                              desc,
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                          if (hasPhone) ...[
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      c.phone.trim(),
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Icon(Icons.phone_outlined, size: 18),
                                const SizedBox(width: 6),
                                const Text('هاتف'),
                              ],
                            ),
                          ],
                          if (chips.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: WrapAlignment.end,
                              children: [
                                for (final s in chips.take(10))
                                  Chip(
                                    label: Text(
                                      s,
                                      textAlign: TextAlign.right,
                                    ),
                                    visualDensity: VisualDensity.compact,
                                  ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
