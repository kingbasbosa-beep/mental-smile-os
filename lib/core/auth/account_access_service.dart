import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mental_smile_os/core/visibility/visibility_readiness.dart';
import 'package:mental_smile_os/shared/contracts/role_names.dart';

class SignedInAccessState {
  const SignedInAccessState({
    this.role,
    this.isBlocked = false,
    this.blockReason = '',
    this.visibilityReadiness = '',
    this.collection,
    this.docId,
  });

  final String? role;
  final bool isBlocked;
  final String blockReason;
  final String visibilityReadiness;
  final String? collection;
  final String? docId;
}

class AccountAccessService {
  AccountAccessService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<SignedInAccessState> resolve(User user) async {
    final uid = user.uid;
    final email = (user.email ?? '').trim().toLowerCase();
    final claimedRole = await _roleFromClaims(user);

    if (_isConstitutionalRole(claimedRole)) {
      return SignedInAccessState(role: claimedRole);
    }

    final clinicianDoc = await _safeGet('clinicians', uid);
    if (clinicianDoc?.exists == true) {
      final data = clinicianDoc?.data() ?? const <String, dynamic>{};
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
      final clinicianByEmail = await _safeQueryByEmail('clinicians', email);
      if (clinicianByEmail != null) {
        final data = clinicianByEmail.data();
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
      if (_matchesProviderRole(data['role'], 'center')) {
        return _stateForDoc(
          role: 'center',
          data: data,
          collection: 'centers',
          docId: centerDoc!.id,
        );
      }
    }

    if (email.isNotEmpty) {
      final centerByEmail = await _safeQueryByEmail('centers', email);
      if (centerByEmail != null) {
        final data = centerByEmail.data();
        if (_matchesProviderRole(data['role'], 'center')) {
          return _stateForDoc(
            role: 'center',
            data: data,
            collection: 'centers',
            docId: centerByEmail.id,
          );
        }
      }
    }

    return const SignedInAccessState();
  }

  Future<String?> _roleFromClaims(User user) async {
    try {
      final token = await user.getIdTokenResult();
      final role = _normalizedRole(token.claims?['role']);
      if (role.isNotEmpty) return role;
    } on FirebaseException {
      return null;
    } catch (_) {
      return null;
    }
    return null;
  }

  bool _isConstitutionalRole(String? role) {
    return role == RoleNames.owner ||
        role == RoleNames.monitoringOperator ||
        role == RoleNames.registrySteward ||
        role == RoleNames.declarationReviewer ||
        role == RoleNames.supportObserver;
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
      visibilityReadiness: VisibilityReadiness.resolve(data),
      collection: collection,
      docId: docId,
    );
  }

  String _normalizedRole(dynamic value) {
    return (value ?? '').toString().trim().toLowerCase();
  }

  bool _matchesProviderRole(dynamic value, String expectedRole) {
    final role = _normalizedRole(value);
    return role.isEmpty || role == expectedRole;
  }

  void _accessTrace(String message) {
    if (!kDebugMode) return;
    debugPrint('ACCESS_TRACE $message');
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
