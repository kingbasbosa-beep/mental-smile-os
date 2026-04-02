import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignedInAccessState {
  const SignedInAccessState({
    this.role,
    this.isBlocked = false,
    this.blockReason = '',
    this.collection,
    this.docId,
  });

  final String? role;
  final bool isBlocked;
  final String blockReason;
  final String? collection;
  final String? docId;

  bool get isAdmin => role == 'admin';
}

class AccountAccessService {
  AccountAccessService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const Set<String> knownAdminEmails = {
    'kingbasbosa@gmail.com',
    'kingbasbosa@hotmail.com',
  };

  Future<SignedInAccessState> resolve(User user) async {
    final uid = user.uid;
    final email = (user.email ?? '').trim().toLowerCase();

    if (knownAdminEmails.contains(email)) {
      return const SignedInAccessState(role: 'admin');
    }

    final adminDoc = await _safeGet('admins', uid);
    if (adminDoc?.exists == true) {
      final data = adminDoc?.data() ?? const <String, dynamic>{};
      if ((data['active'] ?? false) == true) {
        return const SignedInAccessState(role: 'admin');
      }
    }

    final clinicianDoc = await _safeGet('clinicians', uid);
    if (clinicianDoc?.exists == true) {
      final data = clinicianDoc?.data() ?? const <String, dynamic>{};
      if ((data['isAdmin'] ?? false) == true) {
        return const SignedInAccessState(role: 'admin');
      }
      if (_normalizedRole(data['role']) == 'clinician') {
        return _stateForDoc(
          role: 'clinician',
          data: data,
          collection: 'clinicians',
          docId: clinicianDoc!.id,
        );
      }
    }

    if (email.isNotEmpty) {
      final adminClinicianByEmail = await _safeQueryByEmail(
        'clinicians',
        email,
        filters: const {'isAdmin': true},
      );
      if (adminClinicianByEmail != null) {
        return const SignedInAccessState(role: 'admin');
      }

      final clinicianByEmail = await _safeQueryByEmail('clinicians', email);
      if (clinicianByEmail != null) {
        final data = clinicianByEmail.data();
        if ((data['isAdmin'] ?? false) == true) {
          return const SignedInAccessState(role: 'admin');
        }
        if (_normalizedRole(data['role']) == 'clinician') {
          return _stateForDoc(
            role: 'clinician',
            data: data,
            collection: 'clinicians',
            docId: clinicianByEmail.id,
          );
        }
      }
    }

    final centerDoc = await _safeGet('centers', uid);
    if (centerDoc?.exists == true) {
      final data = centerDoc?.data() ?? const <String, dynamic>{};
      if (_normalizedRole(data['role']) == 'center') {
        return _stateForDoc(
          role: 'center',
          data: data,
          collection: 'centers',
          docId: centerDoc!.id,
        );
      }
    }

    final clientDoc = await _safeGet('clients', uid);
    if (clientDoc?.exists == true) {
      return _stateForDoc(
        role: 'client',
        data: clientDoc?.data() ?? const <String, dynamic>{},
        collection: 'clients',
        docId: clientDoc!.id,
      );
    }

    if (email.isNotEmpty) {
      final clientByEmail = await _safeQueryByEmail('clients', email);
      if (clientByEmail != null) {
        return _stateForDoc(
          role: 'client',
          data: clientByEmail.data(),
          collection: 'clients',
          docId: clientByEmail.id,
        );
      }
      return const SignedInAccessState(role: 'client');
    }

    return const SignedInAccessState();
  }

  SignedInAccessState _stateForDoc({
    required String role,
    required Map<String, dynamic> data,
    required String collection,
    required String docId,
  }) {
    return SignedInAccessState(
      role: role,
      isBlocked: (data['isBlocked'] ?? false) == true,
      blockReason: (data['blockReason'] ?? '').toString().trim(),
      collection: collection,
      docId: docId,
    );
  }

  String _normalizedRole(dynamic value) {
    return (value ?? '').toString().trim().toLowerCase();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> _safeGet(
    String collection,
    String docId,
  ) async {
    try {
      return await _firestore.collection(collection).doc(docId).get();
    } on FirebaseException {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> _safeQueryByEmail(
    String collection,
    String email, {
    Map<String, Object?> filters = const {},
  }) async {
    try {
      Query<Map<String, dynamic>> query =
          _firestore.collection(collection).where('email', isEqualTo: email);
      filters.forEach((key, value) {
        query = query.where(key, isEqualTo: value);
      });
      final snapshot = await query.limit(1).get();
      if (snapshot.docs.isEmpty) return null;
      return snapshot.docs.first;
    } on FirebaseException {
      return null;
    } catch (_) {
      return null;
    }
  }
}

class AccountBlockingService {
  AccountBlockingService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<void> blockAccount({
    required String collection,
    required String docId,
    required String adminUid,
    required String reason,
  }) async {
    await _firestore.collection(collection).doc(docId).update({
      'isBlocked': true,
      'blockedAt': FieldValue.serverTimestamp(),
      'blockedBy': adminUid,
      'blockReason': reason.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> unblockAccount({
    required String collection,
    required String docId,
  }) async {
    await _firestore.collection(collection).doc(docId).update({
      'isBlocked': false,
      'blockedAt': null,
      'blockedBy': '',
      'blockReason': '',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
