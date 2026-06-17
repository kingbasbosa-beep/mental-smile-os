import 'package:flutter/material.dart';
import 'package:mental_smile_os/app/router/routes.dart';
import 'package:mental_smile_os/shared/ui_kit/app_design_system.dart';
import 'package:url_launcher/url_launcher.dart';

class AppExitSocialLinksPage extends StatelessWidget {
  const AppExitSocialLinksPage({super.key});

  static const List<_OfficialChannel> _channels = <_OfficialChannel>[
    _OfficialChannel(
      icon: Icons.language_rounded,
      labelAr: 'الموقع',
      labelEn: 'Website',
      url: 'https://mental-smile-platform.web.app',
    ),
    _OfficialChannel(
      icon: Icons.auto_awesome_rounded,
      labelAr: 'Mental Smile OS',
      labelEn: 'Mental Smile OS',
      url: 'https://kingbasbosa-beep.github.io/mental-smile-os/',
    ),
    _OfficialChannel(
      icon: Icons.facebook_rounded,
      labelAr: 'فيسبوك',
      labelEn: 'Facebook',
      url: 'https://www.facebook.com/MentalSmileOrg',
    ),
    _OfficialChannel(
      icon: Icons.business_center_rounded,
      labelAr: 'لينكدإن',
      labelEn: 'LinkedIn',
      url: 'https://www.linkedin.com/company/mentalsmileorg',
    ),
    _OfficialChannel(
      icon: Icons.send_rounded,
      labelAr: 'تيليجرام',
      labelEn: 'Telegram',
      url: 'https://t.me/MentalSmileOrg',
    ),
    _OfficialChannel(
      icon: Icons.chat_rounded,
      labelAr: 'واتساب',
      labelEn: 'WhatsApp',
      url: 'https://wa.me/201014116531',
    ),
    _OfficialChannel(
      icon: Icons.photo_camera_rounded,
      labelAr: 'إنستجرام',
      labelEn: 'Instagram',
      url: 'https://instagram.com/mentalsmile.platform',
    ),
    _OfficialChannel(
      icon: Icons.alternate_email_rounded,
      labelAr: 'X',
      labelEn: 'X',
      url: 'https://x.com/MentaSmileorg',
    ),
    _OfficialChannel(
      icon: Icons.music_note_rounded,
      labelAr: 'تيك توك',
      labelEn: 'TikTok',
      url: 'https://www.tiktok.com/@mentalsmileorg',
    ),
    _OfficialChannel(
      icon: Icons.play_circle_outline_rounded,
      labelAr: 'يوتيوب',
      labelEn: 'YouTube',
      url: 'https://www.youtube.com/@MentalSmileOs',
    ),
    _OfficialChannel(
      icon: Icons.code_rounded,
      labelAr: 'GitHub',
      labelEn: 'GitHub',
      url: 'https://github.com/kingbasbosa-beep/mental-smile-os',
    ),
    _OfficialChannel(
      icon: Icons.mail_outline_rounded,
      labelAr: 'البريد الإلكتروني',
      labelEn: 'Email',
      url: 'mailto:mentalsmile.platform@gmail.com',
    ),
  ];

  bool _isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';
  }

  Future<void> _openChannel(
    BuildContext context,
    _OfficialChannel channel,
  ) async {
    final isArabic = _isArabic(context);
    final uri = Uri.parse(channel.url);
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isArabic
                ? 'تعذر فتح الرابط الآن.'
                : 'Could not open this link right now.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _isArabic(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: const Color(0xFF080B0D),
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.44),
              radius: 1.05,
              colors: <Color>[
                Color(0xFF172225),
                Color(0xFF080B0D),
              ],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 980
                    ? 4
                    : constraints.maxWidth >= 620
                        ? 3
                        : 2;

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(18, 22, 18, 28),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1040),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _ExitHero(isArabic: isArabic),
                          const SizedBox(height: 22),
                          _SafetyNote(isArabic: isArabic),
                          const SizedBox(height: 22),
                          Text(
                            isArabic
                                ? 'ابقَ على تواصل معنا'
                                : 'Stay connected with Mental Smile',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: AppColors.mutedGold,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                          const SizedBox(height: 16),
                          GridView.builder(
                            itemCount: _channels.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columns,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: columns == 2 ? 1.06 : 1.18,
                            ),
                            itemBuilder: (context, index) {
                              final channel = _channels[index];
                              return _OfficialChannelCard(
                                channel: channel,
                                isArabic: isArabic,
                                onTap: () => _openChannel(context, channel),
                              );
                            },
                          ),
                          const SizedBox(height: 22),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              FilledButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.login,
                                    (route) => false,
                                  );
                                },
                                icon: const Icon(Icons.login_rounded),
                                label: Text(
                                  isArabic
                                      ? 'العودة لتسجيل الدخول'
                                      : 'Back to login',
                                ),
                              ),
                              OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.home,
                                    (route) => false,
                                  );
                                },
                                icon: const Icon(Icons.home_outlined),
                                label: Text(
                                  isArabic ? 'الصفحة الرئيسية' : 'Home',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ExitHero extends StatelessWidget {
  const _ExitHero({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
      decoration: BoxDecoration(
        color: const Color(0xFF111719).withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: AppColors.mutedGold.withValues(alpha: 0.34),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.mutedGold.withValues(alpha: 0.14),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.waving_hand_rounded,
            color: AppColors.mutedGold,
            size: 42,
          ),
          const SizedBox(height: 14),
          Text(
            isArabic ? 'نراك قريبًا' : 'See you soon',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.warmIvory,
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            isArabic
                ? 'روابط منتال سمايل الرسمية للتواصل والمتابعة.'
                : 'Official Mental Smile links for contact and updates.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.sandstone.withValues(alpha: 0.88),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _SafetyNote extends StatelessWidget {
  const _SafetyNote({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1214).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.mutedGold.withValues(alpha: 0.22),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.privacy_tip_outlined,
            color: AppColors.mutedGold,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isArabic
                  ? 'روابطنا الرسمية للتواصل والمتابعة. لا تشارك أي بيانات حساسة عبر قنوات عامة.'
                  : 'Official links for contact and updates. Please do not share sensitive information through public channels.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.sandstone.withValues(alpha: 0.88),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OfficialChannelCard extends StatelessWidget {
  const _OfficialChannelCard({
    required this.channel,
    required this.isArabic,
    required this.onTap,
  });

  final _OfficialChannel channel;
  final bool isArabic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = isArabic ? channel.labelAr : channel.labelEn;

    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF111719).withValues(alpha: 0.84),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.mutedGold.withValues(alpha: 0.28),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(channel.icon, color: AppColors.mutedGold, size: 30),
                const SizedBox(height: 10),
                Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.warmIvory,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  isArabic ? 'فتح الرابط' : 'Open',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.mutedGold,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OfficialChannel {
  const _OfficialChannel({
    required this.icon,
    required this.labelAr,
    required this.labelEn,
    required this.url,
  });

  final IconData icon;
  final String labelAr;
  final String labelEn;
  final String url;
}
