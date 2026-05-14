# Compliance Traceability Graph

## Status

Draft documentation only. Requires legal and compliance review before production use.

## Traceability Flow

```mermaid
flowchart TD
  A["User disclosure and consent"] --> B["Legal consent foundation"]
  B --> C["Versioned consent records"]
  C --> D["Audit readiness"]

  E["AI governance placeholders"] --> F["Events, incidents, traces"]
  F --> D

  G["AI safety core skeleton"] --> H["Fail-closed contracts"]
  H --> F

  I["Crisis-safe UX copy"] --> J["Human support direction"]
  J --> K["No emergency guarantee"]

  L["Backend boundaries"] --> M["Server-owned governance fields"]
  M --> N["Deny-by-default Firestore posture"]
  N --> D
```

## Compliance Themes

- User safety: calm support copy, human-support direction, no diagnosis claims.
- Privacy: data minimization, no raw AI conversation storage by default, no diagnosis fields.
- Auditability: consent versions, AI event placeholders, policy snapshot placeholders.
- Store readiness: clear limits, no emergency-service claim, no treatment claim.
- Future governance: backend-owned operations for lifecycle, escalation, policy, and AI safety decisions.
