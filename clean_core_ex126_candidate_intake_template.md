# EX-126 Candidate Intake Template

## Scope

Docs/template only. Future waves must complete this intake before proposing
any package contract, barrel export, host mapper, consumer migration, passive
vocabulary exposure, queue/boundary concept, runtime/provider diagnostic, or
operational/admin surface change.

This template does not approve implementation. It must not be treated as
permission to create contracts, mappers, exports, imports, consumer reconnects,
provider behavior, Firebase behavior, or runtime activation.

## 1. Candidate Name

- Candidate name:
- Proposed symbol/file names:
- Proposed owning area:
- Related EX wave:

## 2. Candidate Type

Select exactly one primary type and list any secondary types:

- package contract
- barrel export
- host mapper
- consumer migration
- passive vocabulary
- queue/boundary concept
- runtime/provider diagnostic
- operational/admin surface

Primary type:

Secondary types:

## 3. Intended Purpose

- What passive fact or host-owned behavior does this candidate document?
- What problem does it solve?
- Why is a package/mapper/export/migration change needed instead of docs only?
- What behavior must remain host-owned?

## 4. Exact Files In Scope

List exact files that may be read or changed in the future proposal:

- File:
- Intended change:
- Reason:

## 5. Out-Of-Scope Files

List files and areas explicitly excluded:

- Runtime/source logic outside the proposal:
- Package barrel, if export is not explicitly in scope:
- Firestore/Firebase/adapters/providers:
- Consumers/imports:
- Tests/tooling:
- Other:

## 6. Semantic Risk Checklist

Complete `clean_core_ex126_semantic_risk_checklist.md` and summarize:

- Passive:
- Pure Dart:
- Authority implication:
- Execution implication:
- Routing/admission implication:
- Backend enforcement implication:
- Emergency handling implication:
- Provider causality implication:
- Retry/fallback recovery implication:
- Operational/admin implication:

## 7. Authority/Fake Guarantee Checklist

Complete `clean_core_ex126_fake_guarantee_checklist.md` and summarize:

- Could the name imply a guarantee?
- Could consumers treat it as a command?
- Could consumers treat it as a permission?
- Could consumers treat it as proof?
- Are caveats required?
- Are caveats included in the proposed surface?

## 8. Mapper/Persistence Checklist

- Does this candidate require mapping?
- Is mapping host-side only?
- Does it introduce Firestore/Firebase/Timestamp/FieldValue behavior?
- Does it imply persistence success?
- Does it imply audit verification?
- Does it imply backend enforcement?
- Does rollback require mapper deletion?

## 9. Export/Public API Checklist

- Is public export required?
- Why is internal-only insufficient?
- Is the export an explicit file export?
- Does it avoid wildcard and directory exports?
- Does it expose only passive metadata?
- Does it expose mapper/Firebase behavior?
- Does it require consumer migration to be meaningful?

## 10. Consumer Migration Checklist

- Are consumers in scope?
- Which exact consumers/imports would change?
- Is migration explicitly approved by this wave?
- Does migration activate runtime/provider/Firebase/adapters?
- Does migration change behavior or only type ownership?
- Is rollback local and documented?

## 11. Rollback Plan

Complete `clean_core_ex126_rollback_template.md` and summarize:

- Files to remove:
- Exports to remove:
- Mappers to remove:
- Consumers to revert:
- Compatibility impact:
- Rollback owner:

## 12. Compatibility Plan

- Existing public APIs affected:
- Existing host behavior affected:
- Existing mapper behavior affected:
- Existing consumers affected:
- Breaking changes:
- Compatibility preservation strategy:

## 13. Verification Plan

Complete `clean_core_ex126_verification_template.md` and summarize:

- Static docs verification:
- Barrel/export verification:
- Mapper containment verification:
- Consumer reconnect verification:
- Holdback verification:
- Tooling explicitly not run:

## 14. Stop Conditions

Stop immediately if any answer is yes:

- The name implies authority, execution, routing, admission, enforcement,
  emergency handling, provider causality, retry, fallback recovery, or
  operational/admin control.
- The proposal requires package-owned Firestore/Firebase behavior.
- The proposal requires a package mapper.
- The proposal requires wildcard or directory export.
- The proposal exposes an internal holdback vocabulary without doctrine
  reopening.
- The proposal reconnects consumers without explicit migration approval.
- The proposal activates runtime/provider/Firebase/adapters.
- Rollback is not local.
- Compatibility is not preserved or explicitly planned.
- Public export is not justified.

## 15. Required Final Verdict Format

Use this exact verdict structure:

```md
## Final Verdict

Candidate:
Candidate type:

Decision:
- Approved for docs-only review:
- Approved for implementation:
- Approved for export:
- Approved for mapper creation:
- Approved for consumer migration:

Required gates:
- Semantic risk:
- Fake guarantee:
- Mapper/persistence:
- Export/public API:
- Consumer migration:
- Rollback:
- Compatibility:
- Verification:

Blocked items:

Required follow-up:

Final statement:
```

Allowed final decisions:

- `Pass for documentation only`
- `Blocked`
- `Needs doctrine review`
- `Needs compatibility plan`
- `Needs rollback plan`
- `Needs explicit export approval`
- `Needs explicit consumer migration approval`

## Template Verdict

Pass. This intake template is mandatory for future proposals and authorizes no
implementation by itself.
