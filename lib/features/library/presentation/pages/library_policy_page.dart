import 'package:flutter/material.dart';
import 'package:mental_smile_os/app/router/routes.dart';

// [S] Knowledge Governance Asset
// Approved by Wave S-3 Classification Board.
// Must remain educational, non-diagnostic, and free from legacy workflow coupling.
class LibraryPolicyPage extends StatelessWidget {
  const LibraryPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isAr =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF070401),
                    Color(0xFF120B05),
                    Color(0xFF03080D),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 920),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: _PolicyBackButton(isAr: isAr),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          isAr
                              ? 'سياسة استخدام مكتبة Mental Smile'
                              : 'Library Usage Policy',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFFFD47A),
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            height: 1.05,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 16,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        _PolicyCard(
                          children: [
                            _PolicySection(
                              title: isAr
                                  ? 'غرض المكتبة'
                                  : 'Purpose of the Library',
                              body: isAr
                                  ? 'مكتبة Mental Smile مخصصة للتوعية والتعليم والدعم النفسي العام. المحتوى لا يقدم تشخيصًا طبيًا، ولا يقدم علاجًا مباشرًا، ولا يغني عن استشارة مختص عند الحاجة.'
                                  : 'The Mental Smile Library is designed for awareness, education, and general psychological support. The content does not provide medical diagnosis, direct treatment, or a replacement for consulting a qualified specialist when needed.',
                            ),
                            _PolicySection(
                              title:
                                  isAr ? 'حدود المحتوى' : 'Content Boundaries',
                              body: isAr
                                  ? 'المحتوى تعليمي وداعم فقط. لا يجب استخدامه كبديل لطبيب أو أخصائي. في الحالات الطارئة أو عند وجود خطر إيذاء النفس، يجب طلب مساعدة فورية من مختص أو جهة طوارئ محلية.'
                                  : 'The content is educational and supportive only. It must not be used as a replacement for a doctor or specialist. In emergencies or when there is risk of self-harm, seek immediate help from a qualified professional or local emergency service.',
                            ),
                            _PolicySection(
                              title:
                                  isAr ? 'الروابط الخارجية' : 'External Links',
                              body: isAr
                                  ? 'بعض الموارد قد تكون روابط خارجية. Mental Smile لا ينسخ محتوى الجهات الخارجية، ويتم عرض المصدر والحقوق عند توفرها. المستخدم مسؤول عن فتح المواقع الخارجية بحذر.'
                                  : 'Some resources may point to external links. Mental Smile does not copy third-party content, and source or rights information is shown when available. Users should open external websites carefully.',
                            ),
                            _PolicySection(
                              title: isAr ? 'حقوق الملكية' : 'Content Rights',
                              body: isAr
                                  ? 'المحتوى الأصلي مملوك أو مرخص لـ Mental Smile. المحتوى الخارجي يستخدم كرابط أو بإذن/ترخيص عند الحاجة. أي استخدام غير مصرح به للمحتوى ممنوع.'
                                  : 'Original content is owned by or licensed to Mental Smile. External content is used as a link or with permission/license when needed. Unauthorized use of content is prohibited.',
                            ),
                            _PolicySection(
                              title: isAr
                                  ? 'المحتوى المهني'
                                  : 'Professional Content',
                              body: isAr
                                  ? 'بعض الموارد المهنية أو أدوات VR مستقبلًا ستكون للأخصائيين فقط، ولن يتم إتاحتها مباشرة للعملاء بدون إشراف مناسب. أي أدوات عالية الحساسية تحتاج رصد سلامة بشري.'
                                  : 'Some professional resources or future VR tools will be available only to clinicians and will not be exposed directly to clients without proper supervision. High-sensitivity tools require safety observation.',
                            ),
                            _PolicySection(
                              title: isAr
                                  ? 'الذكاء الاصطناعي'
                                  : 'Artificial Intelligence',
                              body: isAr
                                  ? 'قد يساعد الذكاء الاصطناعي مستقبلًا في إعداد أو تصنيف المحتوى، لكن لا يتم نشر أي محتوى حساس بدون رصد بشري. الذكاء الاصطناعي ليس بديلًا عن المختصين.'
                                  : 'AI may help in the future with preparing or classifying content, but sensitive content is not published without human safety observation. AI is not a replacement for qualified specialists.',
                            ),
                            _PolicySection(
                              title: isAr
                                  ? 'تأكيد القراءة وتتبع السياسات'
                                  : 'Policy Confirmation',
                              body: isAr
                                  ? 'هذه الصفحة تعريفية فقط في المرحلة الحالية. نظام تتبع تأكيدات القراءة وإصدارات السياسة سيتم تفعيله لاحقًا، ولا يتم الآن تخزين أي تأكيد داخل Firebase أو الجهاز.'
                                  : 'This page is informational only in the current phase. Policy acceptance tracking and policy versions will be activated later. No confirmation is currently stored in Firebase or on the device.',
                            ),
                            const SizedBox(height: 6),
                            _StaticConfirmationNote(isAr: isAr),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PolicyBackButton extends StatelessWidget {
  const _PolicyBackButton({required this.isAr});

  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(Routes.webLibrary);
      },
      child: Container(
        width: 48,
        height: 48,
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
        child: Icon(
          isAr ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
          color: const Color(0xFFFFE7B2),
        ),
      ),
    );
  }
}

class _PolicyCard extends StatelessWidget {
  const _PolicyCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF080704).withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFFFD98A).withValues(alpha: 0.44),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE7A94C).withValues(alpha: 0.12),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  const _PolicySection({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFFFD47A),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(
              color: const Color(0xFFFFE7B2).withValues(alpha: 0.84),
              fontSize: 14,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StaticConfirmationNote extends StatelessWidget {
  const _StaticConfirmationNote({required this.isAr});

  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFD8A13F).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFFFD98A).withValues(alpha: 0.34),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: Color(0xFFFFD47A),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isAr
                  ? 'تأكيد القراءة هنا بصري فقط في هذه المرحلة، ولا يتم حفظ أي موافقة.'
                  : 'Reading confirmation is visual only in this phase. No acceptance is stored.',
              style: TextStyle(
                color: const Color(0xFFFFE7B2).withValues(alpha: 0.86),
                fontSize: 13,
                height: 1.35,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
