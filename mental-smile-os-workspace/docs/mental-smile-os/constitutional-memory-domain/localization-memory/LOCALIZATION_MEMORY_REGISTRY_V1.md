# Localization Memory Registry V1

Status: ACTIVE_MEMORY_REGISTRY
Domain: Constitutional Memory Domain
Memory area: localization-memory

## 1. Purpose

Localization Memory Registry tracks Arabic-first terms, English terms, replacement terms, legacy terms, UI labels, route labels, support terms, provider terms, marketplace terms, and accessibility terms.

## 2. Boundary

This registry does not migrate old localization files, approve language runtime, or change app strings.

## 3. Required Term Card Fields

| Field | Requirement |
| --- | --- |
| Term ID | Stable term identifier. |
| Arabic Term | Arabic-first term. |
| English Term | English equivalent. |
| Context | Where the term may be used. |
| Allowed Usage | Approved usage. |
| Forbidden Usage | Blocked usage. |
| Replacement Terms | Replacements for legacy or forbidden language. |
| Source Candidate | Source reference, if any. |
| Owner | Language owner or memory custodian. |
| Lineage Status | Lineage completeness. |
| Validation Status | Validation status. |

## 4. Global Import Rule

```text
Extract -> Purify -> Reclassify -> Rebuild -> Register
```

## 5. Registered Localization Cards

| Term ID | Arabic Term | English Term | Context | Allowed Usage | Forbidden Usage | Replacement Terms | Source Candidate | Owner | Lineage Status | Validation Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| TERM-CLIENT-ROOM | مساحة العميل | Client Room | Future Residential visual identity | Room title and visual system naming. | Diagnosis, case ownership, booking state. | المساحة الشخصية, Client Space | Client dashboard and Client Room docs | Constitutional Memory Domain | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| TERM-TOOL-BOARD | لوحة الأدوات | Tool Board | Client tool selection area | Chosen tools and recommendation slots. | Prescription, treatment command, assignment board. | أدواتي, My Tools | Tool board code-rendered frame | Constitutional Memory Domain | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| TERM-NOTIFICATIONS | التنبيهات | Notifications | Client notification area | Neutral updates and reminders. | Emergency guarantee, clinical alert without authority. | إشعاراتي, My Notifications | Dashboard notification icon | Constitutional Memory Domain | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| TERM-MOTIVATIONAL-NOTE | ملاحظة داعمة | Motivational Note | Reflection and encouragement widget | Gentle non-clinical encouragement. | Therapy claim, diagnosis, promise of outcome. | رسالة هادئة, Calm Note | Notebook/note concept | Constitutional Memory Domain | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| TERM-EXIT | خروج | Exit | Navigation control | Leaving the room/surface. | Data deletion, account closure, emergency exit unless explicitly scoped. | مغادرة, Leave | Exit cup concept | Constitutional Memory Domain | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
| TERM-ROOM-NAVIGATION | تنقل الغرفة | Room Navigation | Client Room movement | Switching zones/views. | Operational routing or admin navigation. | التنقل, Navigation | Room layout concept | Constitutional Memory Domain | LINEAGE_ESTABLISHED | MEMORY_VALIDATED |
