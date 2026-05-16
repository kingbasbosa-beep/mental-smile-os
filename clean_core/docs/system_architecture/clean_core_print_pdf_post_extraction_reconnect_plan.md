# Clean Core Print/PDF Post-Extraction Reconnect Plan

This document describes how print, PDF, report export, receipt, invoice, share, and download capabilities should reconnect after clean_core extraction without leaking host runtime behavior into clean_core.

## Reconnect Philosophy

Reporting and export should reconnect through host-owned adapters and services. clean_core should remain contract-oriented and non-executing. The host app owns UI, Firebase reads, report rendering, PDF generation, file handling, share sheets, and admin route access.

## Future Adapter Candidates

| Adapter Candidate | clean_core Role | Host App Role |
| --- | --- | --- |
| Report export intent adapter | Define inert intent/result contracts later. | Resolve intent, load data, render/export. |
| Print preview adapter | Define preview visibility/safety contract later. | Render UI preview and invoke print runtime. |
| PDF renderer adapter | Define allowed report type/scope later. | Generate PDF with host dependencies. |
| CSV export adapter | Define export request/result contract later. | Save/download/share CSV. |
| Receipt/invoice adapter | Define receipt/invoice metadata contract later. | Render sensitive financial documents. |
| Safety report adapter | Define restricted visibility/audit contract later. | Enforce admin access and export sanitized report. |

## Reconnect Sequence

1. Preserve current host routes and UI pages.
2. Keep current preview/copy behavior stable during package extraction.
3. Introduce host-owned report rendering service after extraction.
4. Add optional clean_core report/export intent contracts only if they are pure Dart and non-executing.
5. Wire one report surface at a time:
   - Reports Archive
   - Payments Archive
   - Admin Session Report
   - Chat Escalation Report
   - Registration Maintenance Report
6. Add host-owned dependency support only after approval.
7. Add manual privacy/security review for sensitive report exports.
8. Add audit signals later if required by governance.

## Reconnect Stop Conditions

Stop reconnect work if any of these appear:

- PDF/printing dependency added to `mental_smile_clean_core`.
- Flutter UI import added to extracted clean_core contracts.
- Firebase import added to extracted clean_core contracts.
- Report export directly mutates trusted backend/protected fields.
- Safety escalation report export exposes raw sensitive content without review.
- Share/download runtime bypasses admin visibility checks.
- Runtime/provider execution is introduced.
- Broad import rewrites pull app-owned reporting into the package.

## Post-Extraction Backlog

| Item | Owner | Priority |
| --- | --- | --- |
| Decide print/PDF/share/download product behavior for each current preview-only button. | Host app/product | High |
| Add host-owned print/PDF dependencies if approved. | Host app | High |
| Create report renderer services behind host interfaces. | Host app | High |
| Convert copy-only CSV to file download if needed. | Host app | Medium |
| Add receipt/invoice generation after financial/privacy review. | Host/backend | Medium |
| Add sanitized safety report export after safety governance review. | Host/backend | Medium |
| Add clean_core export intent contracts only after semantic review. | clean_core docs/contracts | Later |

## Final Reconnect Verdict

The existing report system should remain host-owned after extraction. clean_core can help by defining future governance-safe contracts, but the actual print/PDF/share/download implementation belongs in the host app or backend-controlled adapters.
