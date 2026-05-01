import 'package:flutter/material.dart';
import 'package:flutterprojects/app/router/routes.dart';

class AccountingWorkspacePage extends StatelessWidget {
  const AccountingWorkspacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    final cards = <_AccountingWorkspaceCardData>[
      _AccountingWorkspaceCardData(
        titleAr: 'مراجعة السداد',
        titleEn: 'Payment Review',
        route: Routes.adminPayments,
      ),
      _AccountingWorkspaceCardData(
        titleAr: 'سجل المدفوعات',
        titleEn: 'Payments Ledger',
        route: Routes.adminArchivePayments,
      ),
      _AccountingWorkspaceCardData(
        titleAr: 'السجل المحاسبي',
        titleEn: 'Accounting Ledger',
        route: Routes.adminArchiveAccounting,
      ),
      _AccountingWorkspaceCardData(
        titleAr: 'إغلاق العمليات',
        titleEn: 'Financial Closeout',
        route: Routes.adminArchiveSessions,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic ? 'قسم المحاسبة' : 'Accounting Workspace'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isArabic
                  ? 'هذا القسم يجمع مراجعة السداد، متابعة التحويلات، وإغلاق العمليات المالية في مساحة واحدة.'
                  : 'This workspace groups payment review, payout tracking, and financial closeout in one place.',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.8,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => Navigator.of(context).pushNamed(card.route),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            isArabic ? card.titleAr : card.titleEn,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountingWorkspaceCardData {
  const _AccountingWorkspaceCardData({
    required this.titleAr,
    required this.titleEn,
    required this.route,
  });

  final String titleAr;
  final String titleEn;
  final String route;
}
