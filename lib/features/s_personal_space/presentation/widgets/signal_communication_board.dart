import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterprojects/features/signals/signals.dart';
import 'package:flutterprojects/shared/ui_kit/app_design_system.dart';

class SignalCommunicationBoard extends StatelessWidget {
  const SignalCommunicationBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const SizedBox.shrink();

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('signal_events')
          .where('actorId', isEqualTo: user.uid)
          .orderBy('timestamp', descending: true)
          .limit(20)
          .snapshots(),
      builder: (context, snapshot) {
        // Fallback to static if no data yet or error
        final events = snapshot.hasData
            ? snapshot.data!.docs
                .map((doc) => SignalPackage.fromMap(doc.data()))
                .toList()
            : <SignalPackage>[];

        return _BoardPresenter(events: events);
      },
    );
  }
}

class _BoardPresenter extends StatelessWidget {
  const _BoardPresenter({required this.events});

  final List<SignalPackage> events;

  @override
  Widget build(BuildContext context) {
    final isArabic =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'ar';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _LaneCard(
          title: isArabic ? 'الرسائل' : 'Messages',
          icon: Icons.chat_bubble_outline_rounded,
          accentColor: const Color(0xFFE7C766),
          content: _buildMessages(isArabic),
        ),
        const SizedBox(height: 14),
        _LaneCard(
          title: isArabic ? 'تنبيهات السلامة' : 'Safety Notices',
          icon: Icons.shield_outlined,
          accentColor: const Color(0xFF8EDBFF),
          content: _buildSafetyNotices(isArabic),
        ),
        const SizedBox(height: 14),
        _LaneCard(
          title: isArabic ? 'مقترحات الاستكشاف' : 'Recommendations',
          icon: Icons.explore_outlined,
          accentColor: const Color(0xFFE7C766),
          content: _buildRecommendations(isArabic),
        ),
        const SizedBox(height: 14),
        _LaneCard(
          title: isArabic ? 'إعلانات المنصة' : 'Announcements',
          icon: Icons.campaign_outlined,
          accentColor: const Color(0xFF8EDBFF),
          content: _buildAnnouncements(isArabic),
        ),
      ],
    );
  }

  Widget _buildMessages(bool isArabic) {
    if (events.isEmpty) {
      return _EmptyLane(
        message: isArabic
            ? 'مساحتك ستنمو كلما استكشفت وحفظت واخترت ما يهمك.'
            : 'Your space will grow as you explore, save, and choose what matters to you.',
      );
    }

    final latest = events.first;
    String text = isArabic
        ? 'يسعدنا استكشافك للتطبيق. نحن هنا لدعم رحلتك.'
        : 'We are glad you are exploring. We are here to support your journey.';

    if (latest.signalType == SignalTypeRegistry.destinationSaved) {
      text = isArabic
          ? 'لقد قمت بحفظ وجهة جديدة مؤخرًا. رحلة الألف ميل تبدأ بخطوة.'
          : 'You saved a new destination recently. A journey of a thousand miles begins with a single step.';
    } else if (latest.signalType == SignalTypeRegistry.goalSelected) {
      text = isArabic
          ? 'تحديد أهدافك هو أول طريق النجاح. استمر في التركيز.'
          : 'Defining your goals is the first step to success. Stay focused.';
    }

    return _EntryText(text: text);
  }

  Widget _buildSafetyNotices(bool isArabic) {
    // V1: Simple static guidance.
    return _EntryText(
      text: isArabic
          ? 'تذكر أن الصحة النفسية رحلة مستمرة. يمكنك دائمًا طلب استشارة من مختص مؤهل عند الحاجة.'
          : 'Remember that mental health is a continuous journey. You can always seek a consultation from a qualified specialist when needed.',
    );
  }

  Widget _buildRecommendations(bool isArabic) {
    final interests = events
        .where((e) => e.signalType == SignalTypeRegistry.interestSelected)
        .map((e) => e.targetId)
        .toSet();

    if (interests.contains('recovery')) {
      return _EntryText(
        text: isArabic
            ? 'قد ترغب في استكشاف مسار دعم التعافي المتاح في قسم المدينة.'
            : 'You may explore the recovery support pathway available in the City district.',
      );
    }

    if (interests.contains('family_support')) {
      return _EntryText(
        text: isArabic
            ? 'قد ترغب في استكشاف موارد الإرشاد الأسري في المكتبة.'
            : 'You may explore family guidance resources in the Library.',
      );
    }

    return _EntryText(
      text: isArabic
          ? 'يمكنك استكشاف دليل الأخصائيين للتعرف على الخيارات المتاحة.'
          : 'You may explore the Specialist Directory to learn about available options.',
    );
  }

  Widget _buildAnnouncements(bool isArabic) {
    return _EntryText(
      text: isArabic
          ? 'تم تحديث نظام [S] لضمان خصوصية بياناتك وتركيز التطبيق على دعمك.'
          : 'The [S] system has been updated to ensure data privacy and keep the app focused on your support.',
    );
  }
}

class _LaneCard extends StatelessWidget {
  const _LaneCard({
    required this.title,
    required this.icon,
    required this.accentColor,
    required this.content,
  });

  final String title;
  final IconData icon;
  final Color accentColor;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: accentColor),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          content,
        ],
      ),
    );
  }
}

class _EntryText extends StatelessWidget {
  const _EntryText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFFFFE7B2),
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _EmptyLane extends StatelessWidget {
  const _EmptyLane({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: TextStyle(
        color: const Color(0xFFFFE7B2).withValues(alpha: 0.6),
        fontSize: 13,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
