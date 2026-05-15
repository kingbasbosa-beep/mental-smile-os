import 'package:flutter_test/flutter_test.dart';

import '../../../mental_smile_clean_core/lib/mental_smile_clean_core.dart';
import '../emulator/protected_field_fixture.dart';

void main() {
  group('Backend boundaries', () {
    test('detect protected governance fields in client payloads', () {
      final protected = ProtectedGovernanceFields.protectedIn(
        ProtectedFieldFixture.protectedClientPayload.keys,
      );

      expect(
        protected.toSet(),
        containsAll(ProtectedFieldFixture.expectedProtectedFields),
      );
    });

    test('marks backend-governed action as unsafe for protected client writes', () {
      final contract = CloudFunctionBoundary.contractFor(
        TrustedOperationType.bookingOrchestration,
      );
      final action = BackendGovernedAction(
        contract: contract,
        payloadPreview: ProtectedFieldFixture.protectedClientPayload,
        clientWritableFields: const {'clientId', 'note'},
      );

      expect(action.containsProtectedClientWrites, isTrue);
      expect(contract.requiresAuditTrail, isTrue);
    });
  });
}
