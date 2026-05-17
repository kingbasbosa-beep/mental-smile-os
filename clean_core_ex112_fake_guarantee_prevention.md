# EX-112 Fake Guarantee Prevention

## Fake-Guarantee Risk

Fake guarantees arise when package labels imply capabilities the package does
not own.

## Prevented Fake Guarantees

### Routing/Admission

`EscalationQueue.accepts` and routing/admission helpers remain blocked.

### Moderation Ownership

Safety/team ownership language remains internal or blocked.

### Backend Enforcement

`backendGoverned` remains a backend-only contract. Public labels do not prove
backend governance.

### Client Outcome Writes

`clientOutcomeWritesAllowed` and governance/write mappers remain blocked.

### Emergency Handling

Emergency guarantees are blocked. Public emergency language is negative posture:
`emergencyCapabilityNotGuaranteed`.

### Provider Causality

Provider issue labels remain internal. Public labels do not diagnose provider
failure.

### Fallback Recovery

Fallback loop labels remain internal. Public labels do not claim recovery.

## Prevention Strategy

- caveat every public label
- expose only low-risk labels
- keep high-risk labels internal
- avoid mappers and persistence
- avoid consumers in the export wave
- keep rollback local

## Prevention Verdict

The wave successfully prevented package labels from becoming fake guarantees.
