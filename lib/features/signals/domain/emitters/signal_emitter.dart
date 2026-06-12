import '../../data/services/signal_storage_service.dart';
import '../models/signal_package.dart';

abstract class SignalEmitter {
  Future<void> emitSignal(SignalPackage signal);
}

class NoopSignalEmitter implements SignalEmitter {
  const NoopSignalEmitter();

  @override
  Future<void> emitSignal(SignalPackage signal) async {}
}

class FirestoreSignalEmitter implements SignalEmitter {
  FirestoreSignalEmitter({SignalStorageService? storageService})
      : _storageService = storageService ?? SignalStorageService();

  final SignalStorageService _storageService;

  @override
  Future<void> emitSignal(SignalPackage signal) async {
    // Fail-soft is handled inside saveSignal
    await _storageService.saveSignal(signal);
  }
}
