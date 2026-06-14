# Mental Smile Domain Membership Constitution V1

## Document Control

| Field | Value |
|---|---|
| Document ID | DOMAIN_MEMBERSHIP_CONSTITUTION_V1 |
| Block | BLOCK_4C |
| Era | IDENTITY_AUTHORITY_CUSTODY_ERA |
| Scope | Constitutional domain membership doctrine only |
| Runtime Changes | NONE |
| Claims Implementation | NONE |
| Version | v1.0.0 |
| Status | ACTIVE_CONSTITUTIONAL_SOURCE |

## Domain Membership Doctrine

Domain membership answers: Which constitutional domain trusts this identity enough to participate?

Membership is not authority by itself. Membership permits review for authority attestation, but authority still requires evidence, scope, validation, and revocation.

## Domain Membership Rules

| Domain ID | Domain | Membership Rules | Entry Rules | Exit Rules | Suspension Rules | Evidence Rules |
|---|---|---|---|---|---|---|
| domain.owner | Owner Domain | Member must represent final ownership authority | Owner identity evidence and ownership registry entry | Owner revocation or transfer evidence | Critical mismatch, identity dispute, ownership conflict | Owner identity evidence, authorization evidence |
| domain.legal | Legal Domain | Member must interpret legal/governance doctrine | Legal identity evidence and legal membership attestation | Legal membership closure evidence | Interpretation conflict, evidence breach | Legal membership evidence |
| domain.compliance | Compliance Domain | Member validates conformity and detects mismatch | Compliance attestation and validation authority source | Compliance membership closure evidence | Failed validation integrity, conflict of interest | Compliance membership evidence |
| domain.technical_verification | Technical Verification Domain | Member verifies technical state only | Technical identity and verification scope evidence | Technical membership closure evidence | Unauthorized execution, self-authorization attempt | Technical verification evidence |
| domain.monitoring | Monitoring Domain | Member observes, reports, escalates | Monitoring identity and observation scope evidence | Monitoring membership closure evidence | Alert suppression, modification attempt | Monitoring membership evidence |
| domain.archive | Archive Domain | Member preserves custody and retrieval proof | Archive identity and custody scope evidence | Archive custody closure evidence | Evidence tampering risk, custody mismatch | Archive custody evidence |
| domain.registry | Registry Domain | Member stewards registry truth | Registry identity and registry stewardship evidence | Registry stewardship closure evidence | Registry drift, hidden authority insertion | Registry membership evidence |
| domain.declaration | Declaration Domain | Member intakes/reviews declarations | Declaration reviewer identity and scope evidence | Declaration membership closure evidence | Declaration bypass, unauthorized approval | Declaration membership evidence |
| domain.support | Support Domain | Member observes support and escalates risk | Support observer identity and scope evidence | Support membership closure evidence | Unauthorized support decision, privacy breach | Support membership evidence |

## Cross Domain Membership

| Cross Membership Type | Allowed? | Rule |
|---|---|---|
| Owner + Legal | Restricted | Legal can advise Owner, but final authorization and legal interpretation records must remain separate |
| Owner + Compliance | Restricted | Owner cannot self-certify compliance |
| Compliance + Technical Verification | Restricted | Same identity cannot validate compliance and execute/verify same change without separation evidence |
| Monitoring + Technical Verification | Restricted | Monitoring cannot suppress alerts for technical work it verifies |
| Archive + Compliance | Restricted | Archive can provide evidence; Compliance validates process |
| Registry + Compliance | Allowed with separation | Registry stewards truth; Compliance validates completeness |
| Declaration + Compliance | Allowed with separation | Declaration can input; Compliance validates |
| Support + Monitoring | Allowed with separation | Support observes support; Monitoring observes system/pattern |
| Technical + Owner | Forbidden for same action | Technical cannot authorize its own execution |
| Monitoring + Owner | Forbidden for same alert resolution | Monitoring cannot authorize resolution of its own alert |
| Generic Admin membership | Forbidden | Admin is not a constitutional domain |

## Membership Evidence

| Evidence ID | Evidence Class | Required Fields |
|---|---|---|
| evidence.membership.entry | Entry evidence | Identity ID, domain ID, steward, source, scope |
| evidence.membership.suspension | Suspension evidence | Identity ID, domain ID, reason, validator, date |
| evidence.membership.exit | Exit evidence | Identity ID, domain ID, exit reason, archive scope |
| evidence.membership.cross_domain | Cross domain evidence | Domains, separation rule, conflict control |
| evidence.membership.recovery | Recovery evidence | Suspended identity, validator, restored scope |

## Block 4C Validation Result

| Pass Condition | Result |
|---|---|
| Membership defined | PASS |
| All requested domains defined | PASS |
| Entry rules defined | PASS |
| Exit rules defined | PASS |
| Suspension rules defined | PASS |
| Evidence rules defined | PASS |
| Cross domain membership defined | PASS |
| Generic admin membership forbidden | PASS |

Final result: `BLOCK_4C_DOMAIN_MEMBERSHIP_COMPLETE`.
