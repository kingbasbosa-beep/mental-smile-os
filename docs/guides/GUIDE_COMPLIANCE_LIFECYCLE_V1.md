# Guide Compliance Lifecycle V1

Status: GUIDE_DRAFT  
Runtime effect: none

## 1. Lifecycle Doctrine

Guide compliance is a read-only governance process until a separate authorized implementation block is opened. Compliance never modifies runtime, Firebase, ARB, or routes by itself.

## 2. Lifecycle Stages

| Stage | Status | Owner | Entry condition | Exit condition |
| --- | --- | --- | --- | --- |
| Draft guide | GUIDE_DRAFT | Guide author | New guide domain or correction needed | Legal & Governance ready to interpret |
| Update guide | GUIDE_UPDATED | Legal & Governance | Draft accepted as guide change | Snapshot requested |
| Snapshot | SYSTEM_SYNC_PENDING | Archive/governance | Guide updated | Snapshot and card pack generated |
| Suspend old cards | OLD_CARD_SUSPENDED | Compliance Agent reports, Owner authorizes | Existing cards mismatch | Replacement card exists or card archived |
| Deploy new card | NEW_CARD_DEPLOYED | Guide/card author | Card cloned from snapshot | Validation begins |
| Validate | VALIDATION_PENDING | Legal & Governance, Technical, Monitoring | Card deployed | Approved or blocked |
| Approve | APPROVED | Owner | All checks pass | Active guide card |
| Block | APPROVAL_BLOCKED | Legal & Governance/Monitoring | Any mismatch or authority risk | Rework or archive |
| Archive | ARCHIVED | Archive | Superseded or removed | Preserved record |

## 3. Compliance Agent Duties

| Duty | Required report field |
| --- | --- |
| read Master Guide | guideVersion |
| find unclosed operations | unclosedStatusList |
| compare guide snapshot vs card pack | mismatchList |
| detect outdated cards | staleCardList |
| detect missing ownership | missingOwnerList |
| detect missing registries | missingRegistryList |
| raise alert | escalationTarget |
| never modify | readOnlyConfirmation |
| never approve | approvalAuthorityConfirmation |
| never execute | executionBlockedConfirmation |

## 4. Escalation Rules

| Rule | Trigger | Severity | Target |
| --- | --- | --- | --- |
| E01 | Snapshot/card pack mismatch | HIGH | Legal & Governance |
| E02 | No report within 15 minutes after mismatch alert | HIGH | Owner |
| E03 | Card suspension affects active process | CRITICAL | Owner + Monitoring |
| E04 | Language BLOCK found | HIGH | Legal & Governance |
| E05 | Runtime gap represented as implemented | CRITICAL | Owner + Technical |
| E06 | Firestore authority mismatch | CRITICAL | Owner + Technical + Monitoring |
| E07 | Missing card ownership | MEDIUM | Legal & Governance |

## 5. Validation Checklist

| Check | Required result |
| --- | --- |
| Guide snapshot ID exists | PASS |
| Card pack ID exists | PASS |
| Every card has owner | PASS or APPROVAL_BLOCKED |
| Every card has registry reference | PASS or documented MISSING_RUNTIME_REGISTRY |
| Every FUTURE system marked FUTURE | PASS |
| Every frozen system marked FROZEN | PASS |
| Surface language policy applied | PASS/LIMITED_ALLOW/BLOCK |
| Runtime implementation not implied by docs | PASS |
| Archive path preserved | PASS |

