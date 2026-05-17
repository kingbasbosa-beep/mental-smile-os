# EX-108 Export Strategy Review

## Grouping Strategy

The EX-105 grouped-file strategy remains correct.

Keep separate groups:

- queue passive labels
- boundary passive labels
- emergency posture labels
- provider issue labels
- fallback observation labels

Grouping reduces confusion by preventing one broad "review vocabulary" surface
from looking like a workflow contract.

## Export Strategy Options

### Option A: Keep Internal-Only

Safest option. Maintains rollback-local isolation and prevents consumer misuse.

### Option B: Partial Controlled Export

Potentially acceptable for the lowest-risk labels only:

- `policyIssueObserved`
- `manualSupportRequested`
- `policyReferencePresent`
- `auditReferencePresent`
- `emergencyCapabilityNotGuaranteed`

Requires explicit public caveats.

### Option C: Full Export

Not recommended now.

Full export includes lifecycle, boundary, provider, and fallback labels that can
be misused as execution signals.

## Runtime/Provider Wave Dependency

Export does not need runtime/provider activation, but the provider/fallback
labels should probably remain internal until the runtime/provider doctrine wave
defines public misuse boundaries.

## EX-109 Readiness

EX-109 is partially approved only if it is a docs-only or export-plan phase, or
if it exports a narrow low-risk subset with public caveats and no consumers.

EX-109 is blocked for:

- full barrel export
- consumer reconnection
- mappers
- runtime/provider activation
- routing/admission helpers
- backend enforcement policy
- emergency guarantees

## Export Strategy Verdict

Controlled export is not broadly ready. Partial export may be considered, but
internal-only remains the recommended default.
