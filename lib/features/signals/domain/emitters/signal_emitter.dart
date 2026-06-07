import '../models/signal_package.dart';

abstract class SignalEmitter {
  Future<void> emitSignal(SignalPackage signal);
}

class NoopSignalEmitter implements SignalEmitter {
  const NoopSignalEmitter();

  @override
  Future<void> emitSignal(SignalPackage signal) async {}
}
