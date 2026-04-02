import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class FirebaseBootstrap {
  static const Duration _timeout = Duration(seconds: 20);

  /// doConnectivityCheck:
  /// - writes debug/{sessionId}, then reads it back (with timeout) to detect OK/permission-denied/hang.
  ///
  /// doSeed (idempotent):
  /// - writes fixed doc IDs into collection "resources" with merge:true so multiple runs don't duplicate.
  static Future<void> run({
    bool doConnectivityCheck = false,
    bool doSeed = false,
  }) async {
    const uuid = Uuid();
    final sessionId = uuid.v4();

    debugPrint('FirebaseBootstrap (NO AUTH) sessionId=$sessionId');
    debugPrint(
      'Flags: doConnectivityCheck=$doConnectivityCheck, doSeed=$doSeed',
    );

    try {
      if (doConnectivityCheck) {
        try {
          await _connectivityCheck(sessionId);
        } catch (e, st) {
          debugPrint('Firestore connectivityCheck error: $e');
          debugPrint('$st');
        }
      }
      if (doSeed) {
        await _seedResources(sessionId);
      }
      debugPrint('FirebaseBootstrap done sessionId=$sessionId');
    } catch (e, st) {
      debugPrint('Firestore bootstrap error: $e');
      debugPrint('$st');
    }
  }

  static Future<void> _connectivityCheck(String sessionId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      debugPrint('Firestore: connectivityCheck skipped (no auth user)');
      return;
    }
    debugPrint('Firestore: writing debug/$sessionId ...');

    await FirebaseFirestore.instance.collection('debug').doc(uid).set({
      'ts': DateTime.now().toIso8601String(),
      'platform': kIsWeb ? 'web' : 'native',
      'note': 'auth_disabled_temp',
      'type': 'connectivity_check',
    }, SetOptions(merge: true)).timeout(_timeout);

    debugPrint('Firestore write OK: debug/$sessionId');

    debugPrint('Firestore: reading debug/$sessionId ...');

    final snap = await FirebaseFirestore.instance
        .collection('debug')
        .doc(uid)
        .get()
        .timeout(_timeout);

    debugPrint('Firestore read OK: exists=${snap.exists} data=${snap.data()}');
  }

  static Future<void> _seedResources(String sessionId) async {
    debugPrint('Seed: starting (idempotent) ...');

    const seedVersion = '2026-02-25';
    final metaRef =
        FirebaseFirestore.instance.collection('debug').doc('seed_meta');

    await metaRef.set({
      'lastSeedAt': DateTime.now().toIso8601String(),
      'seedVersion': seedVersion,
      'bySessionId': sessionId,
      'note': 'dev_seed_only',
    }, SetOptions(merge: true)).timeout(_timeout);

    // Base public resources (Arabic strings via unicode escapes to avoid mojibake)
    final resources = <Map<String, dynamic>>[
      {
        'id': 'res_001',
        'audience': 'public',
        'title_en': 'Welcome Resource',
        'title_ar':
            '\u0645\u0648\u0631\u062F \u062A\u0631\u062D\u064A\u0628\u064A',
        'category': 'general',
        'category_ar': '\u0639\u0627\u0645',
        'type': 'article',
        'type_ar': '\u0645\u0642\u0627\u0644',
        'url': 'https://example.com/welcome',
        'supervisedOnly': false,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'res_002',
        'audience': 'public',
        'title_en': 'Library Starter',
        'title_ar':
            '\u0628\u062F\u0627\u064A\u0629 \u0627\u0644\u0645\u0643\u062A\u0628\u0629',
        'category': 'library',
        'category_ar': '\u0645\u0643\u062A\u0628\u0629',
        'type': 'article',
        'type_ar': '\u0645\u0642\u0627\u0644',
        'url': 'https://example.com/library',
        'supervisedOnly': false,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'res_003',
        'audience': 'public',
        'title_en': 'Support Contacts',
        'title_ar': '\u062C\u0647\u0627\u062A \u062F\u0639\u0645',
        'category': 'support',
        'category_ar': '\u062F\u0639\u0645',
        'type': 'list',
        'type_ar': '\u0642\u0627\u0626\u0645\u0629',
        'url': 'https://example.com/support',
        'supervisedOnly': true,
        'updatedAt': DateTime.now().toIso8601String(),
      },

      // Clinician-only resources (for DEV clinician mode)
      {
        'id': 'clin_001',
        'audience': 'clinician',
        'title_en': 'CBT Exposure: Clinician Guide (Overview)',
        'title_ar':
            '\u062F\u0644\u064A\u0644 \u0627\u0644\u0645\u062E\u062A\u0635: \u0627\u0644\u062A\u0639\u0631\u0636 \u0641\u064A CBT (\u0646\u0638\u0631\u0629 \u0639\u0627\u0645\u0629)',
        'category': 'research',
        'category_ar': '\u0623\u0628\u062D\u0627\u062B',
        'type': 'reference',
        'type_ar': '\u0645\u0631\u062C\u0639',
        'url': 'https://example.com/clinician/cbt-exposure-overview',
        'tags': ['exposure', 'cbt', 'protocol'],
        'supervisedOnly': true,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'clin_002',
        'audience': 'clinician',
        'title_en': 'Session Protocol: Graded Exposure Plan (Template)',
        'title_ar':
            '\u0628\u0631\u0648\u062A\u0648\u0643\u0648\u0644 \u062C\u0644\u0633\u0629: \u062E\u0637\u0629 \u062A\u0639\u0631\u0636 \u062A\u062F\u0631\u064A\u062C\u064A\u0629 (\u0642\u0627\u0644\u0628)',
        'category': 'protocols',
        'category_ar':
            '\u0628\u0631\u0648\u062A\u0648\u0643\u0648\u0644\u0627\u062A',
        'type': 'protocol',
        'type_ar': '\u0628\u0631\u0648\u062A\u0648\u0643\u0648\u0644',
        'url': 'https://example.com/clinician/graded-exposure-template',
        'tags': ['exposure', 'graded', 'hierarchy', 'plan'],
        'supervisedOnly': true,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      {
        'id': 'clin_003',
        'audience': 'clinician',
        'title_en': 'VR Exposure Video: Social Anxiety Scenario (Supervised)',
        'title_ar':
            '\u0641\u064A\u062F\u064A\u0648 VR \u0644\u0644\u062A\u0639\u0631\u0636: \u0633\u064A\u0646\u0627\u0631\u064A\u0648 \u0627\u0644\u0642\u0644\u0642 \u0627\u0644\u0627\u062C\u062A\u0645\u0627\u0639\u064A (\u0628\u0625\u0634\u0631\u0627\u0641)',
        'category': 'vr',
        'category_ar': 'VR',
        'type': 'video',
        'type_ar': '\u0641\u064A\u062F\u064A\u0648',
        'delivery': 'vr',
        'durationSec': 420,
        'url': 'https://example.com/clinician/vr-social-anxiety',
        'tags': ['vr', 'exposure', 'social anxiety'],
        'supervisedOnly': true,
        'updatedAt': DateTime.now().toIso8601String(),
      },
    ];

    final col = FirebaseFirestore.instance.collection('resources');

    for (final r in resources) {
      final id = r['id'] as String;
      debugPrint('Seed: writing resources/$id ...');
      await col.doc(id).set(r, SetOptions(merge: true)).timeout(_timeout);
      debugPrint('Seed: wrote resources/$id');
    }

    debugPrint('Seed: done (version=$seedVersion)');
  }
}
