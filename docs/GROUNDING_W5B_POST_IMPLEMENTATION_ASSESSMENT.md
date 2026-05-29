# GROUNDING-W5B Post-Implementation Assessment

Mental Smile - Grounding Era

Scope: assessment only.

Commands executed by Codex for this assessment: none.

Manual commands required for this assessment: none.

Verification status: assessment only.

Source context:

- `docs/GROUNDING_W1_RUNTIME_INVENTORY_AUTHORITY_MAP.md`
- `docs/GROUNDING_W2_LEGACY_FREEZER_REGISTRY.md`
- `docs/GROUNDING_W3_ADMIN_BOOKING_COMMAND_WRAPPER_SPEC.md`
- `docs/GROUNDING_W4_BOOKING_COMMAND_AUDIT_ARTIFACT_SPEC.md`
- `docs/GROUNDING_W5_ASSIGN_CLINICIAN_SHADOW_WRAPPER_PLAN.md`
- `docs/GROUNDING_W5A_ASSIGN_CLINICIAN_SHADOW_WRAPPER_IMPLEMENTATION.md`
- `lib/features/admin_surface/data/commands/admin_booking_command_wrapper.dart`
- `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart`
- `lib/features/admin_surface/pages/admin_booking_queue_page.dart`

## 1. Runtime Impact

What actually changed:

- A new passive wrapper was added for `booking.assign_clinician`.
- `AdminBookingCommandWrapper.assignClinician` now sits between the admin booking queue assignment action and `AdminBookingDecisionAdapter.assignClinician`.
- The wrapper attempts a diagnostic read of `booking_requests/{requestId}`.
- The wrapper builds an in-memory `BookingCommandEnvelope`.
- The wrapper computes non-blocking validation warnings.
- The wrapper logs minimal `BOOKING_COMMAND_SHADOW` diagnostics.
- `_assignToClinician` in `admin_booking_queue_page.dart` is wired to call the wrapper.

What did not change:

- `AdminBookingDecisionAdapter.assignClinician` still performs the actual mutation.
- Booking payload fields remain unchanged.
- Firestore rules remain unchanged.
- Firebase custom claims remain unchanged.
- No backend functions were added.
- No audit collections were created.
- No command collections were created.
- No validation is enforced.
- Payment, payout, accounting, archive, session, and center approval flows were not touched.
- Routes were not migrated or renamed.

What authority changed:

- No constitutional or Firestore authority changed.
- No new runtime authority was granted.
- No command/audit/backend authority was activated.
- The only practical change is that assignment now passes through a passive diagnostic layer before delegating to the old adapter.

What authority did not change:

- Generic admin authority remains the operative authority.
- Firestore custom claim authority remains the real runtime authority.
- `booking_requests` remains the source truth collection.
- The legacy adapter remains the executor of the mutation.

## 2. Behavioral Equivalence

Expected old path:

```text
UI
 -> Adapter
 -> Firestore
```

Current W5A path:

```text
UI
 -> Wrapper
 -> Adapter
 -> Firestore
```

Behavioral equivalence assessment:

The path is intended to be behaviorally equivalent for booking assignment because the wrapper delegates to the same `AdminBookingDecisionAdapter.assignClinician` method and returns the same `AdminAssignClinicianResult`.

Preserved behavior:

- Same UI method: `_assignToClinician`.
- Same core inputs: `requestId`, `adminUid`.
- Same adapter mutation method.
- Same Firestore update payload from the adapter.
- Same return type.
- Same already-assigned result handling.
- Same missing booking exception behavior from the adapter.
- Same missing requested clinician exception behavior from the adapter.
- Same snackbar/result handling after the returned result.

Known differences:

- One additional diagnostic read may happen before the adapter call.
- Minimal debug logging may occur before delegation, after success, or on failure.
- Local in-memory duplicate detection may add a warning count in logs only.
- If the wrapper diagnostic read fails, it is swallowed and converted into a diagnostic warning; the adapter still determines final behavior.

Important limitation:

Behavioral equivalence has not been proven by analyzer/tests in this assessment. It is a code-path assessment, not an executed verification.

## 3. New Risks Introduced

| Risk | Description | Severity | Mitigation / Current Status |
| ---- | ----------- | -------- | --------------------------- |
| Additional read | Wrapper attempts a diagnostic read before the adapter performs its own read. | Medium | Acceptable for shadow phase, but should be measured later. |
| Possible latency | Extra read can add delay to assignment action. | Medium | Keep wrapper scoped to assignment only; profile during QA. |
| Read consistency drift | Wrapper snapshot and adapter snapshot may differ if document changes between reads. | Low | Wrapper is diagnostic-only; adapter snapshot remains behavior source. |
| Coupling to `booking_requests` | Wrapper knows collection name directly. | Medium | Acceptable for current scope; future command registry should own this. |
| Hidden source route assumption | Wrapper defaults to `/admin/booking-queue`. | Low | Correct for current wiring; future callers must pass route explicitly. |
| Logging risk | Logs could accidentally expand if future edits add fields. | Medium | Current logs are minimal; keep forbidden log fields documented. |
| In-memory duplicate detection | `_seenIdempotencyKeys` is process-local and not authoritative. | Low | Diagnostic-only; must not be used for enforcement. |
| Rollback import/field cleanup | Reverting wiring requires removing direct wrapper call and possibly unused import/field. | Low | Rollback remains simple and local. |
| Formatting/analyzer unknown | W5A formatting/analyzer was not completed. | Medium | Run formatter/analyzer before production QA. |

## 4. Grounding Evaluation

Scores use a 0-5 scale.

| Dimension | Before W5A | After W5A | Reasoning |
| --------- | ---------- | -------- | --------- |
| Runtime Grounding | 1 | 2 | Before W5A the command concept was documentation-only. After W5A one real UI path generates passive command shape before legacy execution. |
| Observability | 1 | 2 | `BOOKING_COMMAND_SHADOW` logs add minimal diagnostics, but no persistent audit exists. |
| Safety | 3 | 3 | Safety did not materially improve or decline; no enforcement added, but an extra read/log layer adds small operational risk. |
| Reversibility | 4 | 4 | Rollback remains a local one-path change back to direct adapter call. |
| Audit Readiness | 1 | 2 | Envelope/warning concepts now exist in code for one command, but no audit artifact is persisted. |

Overall:

W5A modestly improves grounding and audit readiness without materially changing authority. It does not solve the underlying admin-centric authority risk.

## 5. Pattern Extraction

Pattern observed:

```text
Passive wrapper
 -> diagnostic read
 -> envelope
 -> non-blocking warnings
 -> minimal log
 -> delegate to existing adapter
 -> preserve result/exception behavior
```

Pattern maturity:

- Mature enough as a narrow shadow pattern for one method.
- Not mature enough for broad reuse without formatting/analyzer/test verification.
- Not mature enough for payment, payout, accounting, financial archive, or enforcement.
- Not mature enough to become a shared command runtime yet.

Potential future candidates:

| Candidate | Readiness | Notes |
| --------- | --------- | ----- |
| `rejectRequest` | Medium-low | It has clear lifecycle intent, but reason capture and terminal-state safety need stronger design before wrapping. |
| `returnToPending` | Medium-low | Good candidate later, but resets many fields and can undo authority decisions. Needs rollback/audit posture. |
| `approveCenterRequest` | Medium-low | Important lifecycle command, but center request prerequisites and tenant/center scope validation are more complex than assignment. |

Do not implement these next by default. The current pattern should first be stabilized and verified around `assignClinician`.

## 6. W6 Recommendation

Options:

- Option A: Shadow Expansion
- Option B: Audit Preparation
- Option C: Verification & Stabilization
- Option D: Something Else

Recommended option:

```text
Option C - Verification & Stabilization
```

Justification:

- W5A introduced the first real runtime grounding layer.
- Formatter/analyzer/test verification has not been completed.
- The extra diagnostic read and logging should be validated before repeating the pattern.
- Expanding shadow wrappers before stabilizing this first one risks multiplying small assumptions.
- Audit preparation remains important, but current implementation must first be verified as behavior-preserving.

Recommended W6 title:

```text
GROUNDING-W6 - AssignClinician Shadow Wrapper Verification & Stabilization
```

W6 should focus on:

- Formatting verification.
- Analyzer verification.
- Targeted tests or manual QA checklist.
- Confirming no extra writes.
- Confirming log privacy.
- Confirming rollback path.
- Documenting observed runtime behavior.

W6 should not expand to `rejectRequest`, `returnToPending`, or `approveCenterRequest` yet.

## 7. Final Verdict

W5A successfully moved one command concept from documentation into a passive runtime-adjacent wrapper.

The implementation remains constitutionally safe in intent because:

- It does not enforce authority.
- It does not write audit or command collections.
- It does not change adapter mutation payloads.
- It does not alter Firebase authority.
- It keeps rollback local.

The platform is not ready for shadow expansion yet. The next safest step is verification and stabilization, not more wrappers.

Commands executed by Codex for this assessment: none.

Manual commands required for this assessment: none.

Verification status: assessment only.

