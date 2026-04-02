import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AnonymousAuthBootstrap {
  static Future<void> ensureSignedIn() async {
    await bootstrapAuth();
  }
}

Future<void> bootstrapAuth() async {
  final auth = FirebaseAuth.instance;
  final user = auth.currentUser;

  if (user == null) {
    final cred = await auth.signInAnonymously();
    debugPrint('Auth: anonymous uid=${cred.user?.uid}');
    return;
  }

  try {
    final uid = user.uid;

    final clientDoc =
        await FirebaseFirestore.instance.collection('clients').doc(uid).get();

    final clinicianDoc = await FirebaseFirestore.instance
        .collection('clinicians')
        .doc(uid)
        .get();

    if (clinicianDoc.exists) {
      final data = clinicianDoc.data() ?? <String, dynamic>{};
      final isAdmin = data['isAdmin'] == true;

      if (isAdmin) {
        debugPrint('Auth: ADMIN logged in uid=$uid');
      } else {
        debugPrint('Auth: clinician logged in uid=$uid');
      }
      return;
    }

    if (clientDoc.exists) {
      debugPrint('Auth: client logged in uid=$uid');
      return;
    }

    debugPrint('Auth: unknown role uid=$uid');
  } catch (e) {
    debugPrint('Auth role detection failed: $e');
  }
}
