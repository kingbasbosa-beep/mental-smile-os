import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterprojects/firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final db = FirebaseFirestore.instance;

  final snap = await db
      .collection('clinician_profile_change_requests')
      .where('status', isEqualTo: 'approved')
      .get();

  print('FOUND APPROVED REQUESTS: ${snap.docs.length}');

  int updated = 0;
  int skipped = 0;
  int failed = 0;

  for (final doc in snap.docs) {
    final data = doc.data();

    final requestId = doc.id;
    final clinicianId = (data['clinicianId'] ?? '').toString().trim();
    final requestType = (data['requestType'] ?? '').toString().trim();
    final requestedBio = (data['requestedBio'] ?? '').toString().trim();
    final requestedPhotoUrl = (data['requestedPhotoUrl'] ?? '').toString().trim();

    if (clinicianId.isEmpty) {
      failed++;
      print('SKIP $requestId -> missing clinicianId');
      continue;
    }

    final updates = <String, dynamic>{
      'updatedAt': FieldValue.serverTimestamp(),
      'lastApprovedProfileChangeAt': FieldValue.serverTimestamp(),
    };

    final normalizedType = requestType.isEmpty ? 'profile_update' : requestType;

    if ((normalizedType == 'bio_update' || normalizedType == 'profile_update') &&
        requestedBio.isNotEmpty) {
      updates['bio'] = requestedBio;
    }

    if ((normalizedType == 'photo_update' ||
            normalizedType == 'photo_add' ||
            normalizedType == 'profile_update') &&
        requestedPhotoUrl.isNotEmpty) {
      updates['photoUrl'] = requestedPhotoUrl;
    }

    if (updates.length <= 2) {
      skipped++;
      print('SKIP $requestId -> no applicable fields');
      continue;
    }

    try {
      await db.collection('clinicians').doc(clinicianId).set(
            updates,
            SetOptions(merge: true),
          );

      updated++;
      print('UPDATED $requestId -> clinician $clinicianId');
    } catch (e) {
      failed++;
      print('FAILED $requestId -> $e');
    }
  }

  print('------------------------------');
  print('DONE');
  print('UPDATED: $updated');
  print('SKIPPED: $skipped');
  print('FAILED : $failed');
}
