import 'package:flutter/material.dart';
import 'package:flutterprojects/features/gateway_layer/shared/gateway_shell_widgets.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';
import 'package:flutterprojects/shared/ui_kit/app_shell_actions.dart';

class AdminFollowupCareGovernancePage extends StatelessWidget {
  const AdminFollowupCareGovernancePage({super.key});

  Widget _buildGovernanceCard(
    BuildContext context, {
    required String title,
    required String summary,
    required String boundaryNote,
    required String supervisionNote,
    String statusLabel = 'حوكمة إشرافية',
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppSectionPanel(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              statusLabel,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF2E5AAC),
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              summary,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.obsidian.withValues(alpha: 0.84),
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Boundary: $boundaryNote',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.obsidian.withValues(alpha: 0.70),
                    height: 1.35,
                  ),
            ),
            const SizedBox(height: AppSpacing.xs),
            GatewaySupervisionNote(text: supervisionNote),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      appBar: AppShellActions.buildAppBar(
        context,
        title: 'Follow-Up Care Governance',
      ),
      body: AppPageBackground(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const GatewayPageIntroCard(
              title: 'Follow-Up Care Governance',
              summary:
                  'هذه الصفحة تحدد الحوكمة الإشرافية لمتابعة داعمة داخل التطبيق، تكون مملوكة للإدارة فقط وتركز على الاستمرارية والتوعية والدعم الخفيف.',
              boundaryNote:
                  'هذه الطبقة ليست علاجًا، وليست جلسات، وليست مملوكة للمراكز أو الأخصائيين. هي فقط إطار إداري داعم للاستمرارية والمتابعة الرقيقة.',
              emphasis:
                  'أي متابعة هنا يجب أن تبقى غير علاجية، غير تشخيصية، وآمنة أخلاقيًا، مع احترام حدود الدعم وعدم التدخل في السياقات الحساسة.',
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'الفئات المستهدفة',
              description:
                  'هذه الفئات تمثل الجهات التي يمكن التفكير في متابعتها ضمن إطار دعم خفيف واستمرارية فقط.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'المتعافين',
                  summary:
                      'يمكن دعم هذه الفئة برسائل خفيفة تحفظ الاستمرارية والطمأنة والتذكير بالمحتوى النافع.',
                  boundaryNote:
                      'المتابعة هنا ليست علاجًا مستمرًا ولا بديلاً عن أي رعاية متخصصة إذا كانت مطلوبة.',
                  supervisionNote:
                      'الإدارة فقط تملك هذه الطبقة، ولا يوجد فيها دور للمراكز أو الأخصائيين.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'أسر ذوي الاحتياجات الخاصة',
                  summary:
                      'يمكن توفير متابعة خفيفة للأسر من باب الدعم والتوعية والاستمرارية وربطهم بالمحتوى المناسب.',
                  boundaryNote:
                      'لا يجب أن تتحول المتابعة إلى تدخل علاجي أو إرشاد تشخيصي.',
                  supervisionNote:
                      'الهدف هنا الدعم والاستمرار، لا إدارة حالة علاجية.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'اضطرابات بدون إدمان',
                  summary:
                      'يمكن التفكير في متابعة داعمة لهذه الفئة من زاوية التوعية والاستقرار وربطها بمحتوى مناسب.',
                  boundaryNote:
                      'المتابعة لا يجب أن تُفهم كعلاج أو بديل عن تدخل مختص عند الحاجة.',
                  supervisionNote:
                      'هذه الفئة تبقى ضمن إطار دعم خفيف فقط داخل التطبيق.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'أنواع المتابعة',
              description:
                  'أنواع المتابعة المسموح التفكير فيها هنا يجب أن تبقى خفيفة، إنسانية، وغير تدخلية.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'رسائل دعم',
                  summary:
                      'رسائل قصيرة تعطي دعمًا نفسيًا خفيفًا وطمأنة عامة دون تدخل علاجي.',
                  boundaryNote:
                      'يُمنع أن تحمل وعودًا علاجية أو تشخيصًا أو توجيهًا سريريًا.',
                  supervisionNote:
                      'الرسائل هنا داعمة فقط وليست بديلًا عن الرعاية.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'رسائل تفقد',
                  summary:
                      'رسائل خفيفة للاطمئنان والاستمرارية دون الدخول في تدخل عميق أو متابعة سريرية.',
                  boundaryNote:
                      'يجب ألا تتحول رسائل التفقد إلى ضغط أو إزعاج أو ملاحقة متكررة.',
                  supervisionNote:
                      'الغرض هو الاستمرارية الرقيقة فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'رسائل توعية',
                  summary:
                      'رسائل تربط المستخدم بمعلومة أو محتوى توعوي مناسب لحالته العامة أو فئته.',
                  boundaryNote:
                      'يجب أن تبقى الرسائل معلوماتية وغير تشخيصية.',
                  supervisionNote:
                      'المعرفة والتوعية هنا أولى من أي منطق تدخل مباشر.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'رسائل تهنئة',
                  summary:
                      'رسائل مناسبة للمناسبات أو للتشجيع الرمزي ضمن حدود داعمة وبسيطة.',
                  boundaryNote:
                      'يجب أن تبقى غير متطفلة وغير مرتبطة باستغلال عاطفي.',
                  supervisionNote:
                      'الهدف تقوية الانتماء والاستمرارية، لا التأثير العلاجي.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'nudges خفيفة',
                  summary:
                      'تنبيهات أو دفعات خفيفة جدًا تشجع على العودة للمحتوى أو الاستفادة من التوعية.',
                  boundaryNote:
                      'يجب ألا تصبح هذه الـ nudges مزعجة أو ضاغطة أو متكررة بصورة مرهقة.',
                  supervisionNote:
                      'الدفعات هنا لطيفة ومحدودة فقط.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ربط المحتوى',
              description:
                  'المتابعة هنا ترتبط بالمحتوى التوعوي أكثر من ارتباطها بأي تدخل تشغيلي أو علاجي.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'ربط الرسائل بالمكتبة',
                  summary:
                      'يمكن أن ترتبط رسائل المتابعة بروابط أو إحالات إلى محتوى مناسب داخل المكتبة.',
                  boundaryNote:
                      'هذا الربط يجب أن يبقى توعويًا ومساندًا، لا علاجياً ولا إلزاميًا.',
                  supervisionNote:
                      'المكتبة هنا نقطة دعم واستمرارية فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'تحديد المحتوى المناسب لكل فئة',
                  summary:
                      'يجب أن تكون هناك مواءمة واضحة بين الفئة المستهدفة ونوع المحتوى الذي يتم اقتراحه أو الإشارة إليه.',
                  boundaryNote:
                      'يُمنع تقديم محتوى غير مناسب أو حساس أو يحمل إيحاءات علاجية غير منضبطة.',
                  supervisionNote:
                      'اختيار المحتوى جزء من الحوكمة وليس من التخصيص العلاجي.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'قواعد الإرسال',
              description:
                  'الإرسال يجب أن يكون محدودًا ومحكومًا بوضوح حتى لا يتحول إلى إزعاج أو ضغط.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'frequency limits',
                  summary:
                      'يجب وضع حدود واضحة للتكرار حتى تبقى المتابعة خفيفة ومقبولة.',
                  boundaryNote:
                      'الهدف هو الاستمرارية الهادئة لا الإغراق أو الضغط.',
                  supervisionNote:
                      'هذه الصفحة لا تنفذ limits فعليًا، بل توثقها فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'منع الإزعاج',
                  summary:
                      'أي متابعة يجب أن تراعي عدم الإزعاج أو التكرار المرهق أو التطفل على المستخدم.',
                  boundaryNote:
                      'حماية راحة المستخدم جزء أساسي من شرعية المتابعة.',
                  supervisionNote:
                      'لا متابعة مفيدة إذا أصبحت عبئًا.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'شروط الإرسال',
                  summary:
                      'الإرسال يجب أن يكون مشروطًا بسياقات هادئة وآمنة ومناسبة لطبيعة المتابعة.',
                  boundaryNote:
                      'يمنع الإرسال في أي سياق قد يسبب تشويشًا أو تضاربًا مع الدعم أو السلامة.',
                  supervisionNote:
                      'الشروط هنا إشرافية فقط وليست منطقًا تشغيليًا.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'حالات الإيقاف',
                  summary:
                      'يجب تعريف الحالات التي تتوقف فيها المتابعة بالكامل أو مؤقتًا.',
                  boundaryNote:
                      'الإيقاف قد يكون مطلوبًا عند وجود حساسية، أو تدخل دعم مباشر، أو ظروف لا تسمح بمتابعة خفيفة.',
                  supervisionNote:
                      'هذه الصفحة تحدد الإطار فقط، لا تنفذ الإيقاف آليًا.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'الحدود الأخلاقية',
              description:
                  'هذه الحدود تحفظ الفرق بين المتابعة الداعمة وبين أي تدخل علاجي أو حسّاس.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'لا تدخل أثناء جلسات',
                  summary:
                      'المتابعة لا يجب أن تتقاطع مع الجلسات أو تشوش على المسارات العلاجية المنظمة.',
                  boundaryNote:
                      'يفصل ذلك بين المتابعة الداعمة وبين الجلسات الفعلية.',
                  supervisionNote:
                      'المتابعة هنا ليست جلسة ولا امتدادًا لها.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'لا تدخل أثناء crisis',
                  summary:
                      'أي سياق أزمة أو حساسية عالية يجب أن يبقى خاليًا من أي متابعة خفيفة أو رسائل موازية.',
                  boundaryNote:
                      'السلامة دائمًا تتقدم على الاستمرارية أو التوعية أو الـ nudges.',
                  supervisionNote:
                      'هذا حد أخلاقي ثابت، لا مجرد تفضيل تصميمي.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'لا تشخيص',
                  summary:
                      'المتابعة لا تحمل تشخيصًا، ولا قراءة لحالة المستخدم، ولا تفسيرًا سريريًا.',
                  boundaryNote:
                      'تحافظ هذه القاعدة على التموضع غير الطبي وغير التشخيصي.',
                  supervisionNote:
                      'أي خرق لهذا الحد يخرج الطبقة من وظيفتها الأصلية.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'لا تضارب مع المختصين',
                  summary:
                      'المتابعة يجب ألا تتداخل مع دور المختصين أو تقدم نفسها كبديل عنهم.',
                  boundaryNote:
                      'تحافظ هذه القاعدة على الفصل الواضح بين الدعم الإداري وبين الرعاية المتخصصة.',
                  supervisionNote:
                      'هذه الطبقة مملوكة للإدارة فقط وليست للمختصين أو المراكز.',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            GatewaySectionCard(
              title: 'ملاحظات إشرافية',
              description:
                  'تلخص هذه الملاحظات طبيعة Follow-Up Care Governance وحدودها الحالية.',
              children: [
                _buildGovernanceCard(
                  context,
                  title: 'النظام داعم فقط',
                  summary:
                      'هذه الطبقة مخصصة لدعم خفيف واستمرارية وطمأنة وتوجيه للمحتوى، لا أكثر.',
                  boundaryNote:
                      'الدور هنا داعم فقط، وليس دور علاج أو تقييم أو إدارة حالة.',
                  supervisionNote:
                      'هذا التحديد أساسي للحفاظ على سلامة المعمارية والتموضع.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'غير علاجي',
                  summary:
                      'المتابعة لا تقدم علاجًا، ولا جلسات، ولا تدخلًا سريريًا.',
                  boundaryNote:
                      'يفصل ذلك بوضوح بين هذه الطبقة وبين أي رعاية علاجية فعلية.',
                  supervisionNote:
                      'كل ما في هذه الصفحة إشرافي فقط.',
                ),
                _buildGovernanceCard(
                  context,
                  title: 'يعتمد على التوعية والاستمرارية',
                  summary:
                      'القيمة الأساسية هنا تأتي من الاستمرارية الهادئة وربط المستخدم بالمحتوى والدعم الخفيف.',
                  boundaryNote:
                      'يبقى المسار محكومًا بالتوعية لا بالعلاج ولا بالتصعيد التشغيلي.',
                  supervisionNote:
                      'هذا هو تعريف الطبقة كما ينبغي أن تبقى في المرحلة الحالية.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
