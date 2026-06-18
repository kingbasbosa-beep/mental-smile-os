import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class VisibilityReadiness {
  VisibilityReadiness._();

  static const String ready = 'ready';
  static const String incomplete = 'incomplete';
  static const String blocked = 'blocked';
  static const String withdrawn = 'withdrawn';

  static String resolve(Map<String, dynamic> data) {
    final readiness =
        (data['visibilityReadiness'] ?? '').toString().trim().toLowerCase();
    return readiness.isEmpty ? incomplete : readiness;
  }

  static bool isVisible(Map<String, dynamic> data) {
    return data['isBlocked'] != true && resolve(data) == ready;
  }

  static String label(Map<String, dynamic> data) {
    return resolve(data) == ready ? 'Ready' : 'Incomplete';
  }
}

class VisibilityReadinessStreams {
  VisibilityReadinessStreams._();

  static Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      watchVisibleDocuments(
    CollectionReference<Map<String, dynamic>> collection,
  ) {
    late StreamController<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
        controller;
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
        canonicalSubscription;
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;

    void emit() {
      if (controller.isClosed) return;
    }

    controller =
        StreamController<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
      onListen: () {
        subscription = collection
            .where('visibilityReadiness', isEqualTo: VisibilityReadiness.ready)
            .snapshots()
            .listen(
          (snapshot) {
            if (controller.isClosed) return;
            controller.add(
              snapshot.docs
                  .where((doc) => VisibilityReadiness.isVisible(doc.data()))
                  .toList(growable: false),
            );
          },
          onError: controller.addError,
        );
      },
      onCancel: () async {
        await subscription?.cancel();
      },
    );

    return controller.stream;
  }
}
