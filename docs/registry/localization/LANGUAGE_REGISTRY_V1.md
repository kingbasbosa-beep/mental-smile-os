# LANGUAGE REGISTRY V1

## Authority

This registry is the single governance source for Mental Smile terminology, meaning, lifecycle, ownership, and future AI language generation. It does not alter localization keys, translations, ARB files, generated files, or runtime code.

## Constitutional Rule

Language declares authority. A term may enter active product language only when it has one owner registry, an explicit meaning, allowed and forbidden contexts, and a declared lifecycle. Arabic and English are governed as equal expressions of the same concept.

## Lifecycle Model

- **ACTIVE:** Canonical language approved for current constitutional use.
- **TRANSITIONAL:** Temporarily permitted while runtime and copy migrate; no new doctrine may be built on it.
- **DEPRECATED:** Historical or superseded language; remove from active copy when encountered.
- **FORBIDDEN:** Conflicts with the federation doctrine and must not be introduced into new active language.
- **FUTURE:** Constitutionally valid concept reserved until a governed runtime purpose exists.

## Registry Ownership

| Registry | Terms | Card File |
|---|---:|---|
| `GOVERNANCE_REGISTRY` | 9 | [TERM_CARDS_GOVERNANCE.md](./TERM_CARDS_GOVERNANCE.md) |
| `MARKETPLACE_REGISTRY` | 10 | [TERM_CARDS_MARKETPLACE.md](./TERM_CARDS_MARKETPLACE.md) |
| `CLIENT_REGISTRY` | 10 | [TERM_CARDS_CLIENT.md](./TERM_CARDS_CLIENT.md) |
| `PROVIDER_REGISTRY` | 10 | [TERM_CARDS_PROVIDER.md](./TERM_CARDS_PROVIDER.md) |
| `CENTER_REGISTRY` | 9 | [TERM_CARDS_CENTER.md](./TERM_CARDS_CENTER.md) |
| `ACCESSIBILITY_REGISTRY` | 9 | [TERM_CARDS_ACCESSIBILITY.md](./TERM_CARDS_ACCESSIBILITY.md) |
| `RECOVERY_REGISTRY` | 10 | [TERM_CARDS_RECOVERY.md](./TERM_CARDS_RECOVERY.md) |
| `KNOWLEDGE_REGISTRY` | 8 | [TERM_CARDS_KNOWLEDGE.md](./TERM_CARDS_KNOWLEDGE.md) |
| `MONITORING_REGISTRY` | 10 | [TERM_CARDS_MONITORING.md](./TERM_CARDS_MONITORING.md) |
| `FEDERATION_REGISTRY` | 10 | [TERM_CARDS_FEDERATION.md](./TERM_CARDS_FEDERATION.md) |
| `BRANDING_REGISTRY` | 3 | [TERM_CARDS_BRANDING.md](./TERM_CARDS_BRANDING.md) |
| `POLICY_REGISTRY` | 22 | [TERM_CARDS_POLICY.md](./TERM_CARDS_POLICY.md) |

## Governance Rules

1. Every governed term has exactly one owner registry.
2. Context consumers may reference a term but cannot redefine it.
3. New terminology requires a term card before localization keys or generated language are introduced.
4. Deprecation preserves audit history but removes the term from active doctrine.
5. Forbidden terms may appear only in explicit historical evidence or migration diagnostics.
6. Translation variants must preserve the constitutional meaning, not merely literal wording.
7. AI-generated language must resolve terms through this registry before producing user-facing copy.

## Admission Workflow

A proposed term is documented, assigned to one registry, checked against existing meanings, reviewed for Arabic and English semantic equivalence, given a lifecycle, and only then admitted to active language.

## Deprecation Workflow

A term moves from ACTIVE or TRANSITIONAL to DEPRECATED or FORBIDDEN with a replacement term, affected-context inventory, and migration record. Keys are not renamed or deleted by this governance phase.

## Audit Baseline

- Localization keys inventoried: **205**
- Keys with direct non-generated runtime references: **95**
- Keys without direct non-generated references: **106**
- Missing locale parity findings: **1** (`statusCenterFollowUp` missing English)
- Duplicate-meaning groups: **22**
- Hardcoded-string candidates requiring qualification: **7,003**
- Old-doctrine findings: **771**
- Mojibake confirmed in source data: **0**

## Registry Totals

- Total governed terms: **120**
- ACTIVE: **69**
- TRANSITIONAL: **8**
- DEPRECATED: **6**
- FORBIDDEN: **22**
- FUTURE: **15**

## Related Registers

- [Complete Term Card Registry](./TERM_CARD_REGISTRY.md)
- [Forbidden Terms Registry](./FORBIDDEN_TERMS_REGISTRY.md)
- [Transitional Terms Registry](./TRANSITIONAL_TERMS_REGISTRY.md)
- [Language Governance Report](./LANGUAGE_GOVERNANCE_REPORT.md)
