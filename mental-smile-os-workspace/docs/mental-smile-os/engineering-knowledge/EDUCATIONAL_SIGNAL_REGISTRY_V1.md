# Educational Signal Registry V1

Result: EDUCATIONAL_SIGNAL_REGISTRY_CREATED

Purpose: detect project-specific warning signs early.

| Signal ID | Educational Signal | Indicates | Prevention |
| --- | --- | --- | --- |
| EDU-SIGNAL-001 | `admin` appears in active rules or runtime authority. | Legacy authority residue. | Run Admin Zero audit. |
| EDU-SIGNAL-002 | Booking/payment/session terms appear in active routes, collections, or public copy. | Old marketplace model contamination. | Reclassify as forbidden or historical. |
| EDU-SIGNAL-003 | Product name, package name, namespace, and Firebase identity disagree. | Identity drift. | Use identity matrix before release. |
| EDU-SIGNAL-004 | Runtime imports a source/extraction package. | Source repository is still active dependency. | Require import candidate card and extraction audit. |
| EDU-SIGNAL-005 | Docs say READY but route audit says scaffold/partial. | Documentation outran runtime. | Block promotion until runtime evidence exists. |
| EDU-SIGNAL-006 | User-facing button leads to "coming soon" or placeholder. | Route/card mistaken for product feature. | Hide, label, or implement. |
| EDU-SIGNAL-007 | Signal registries exist but no signal validation tests exist. | Federation is doctrine-only or partial. | Add signal runtime validation. |
| EDU-SIGNAL-008 | Work continues after handoff without current diff baseline. | Handoff drift. | Create forensic baseline before activation. |
| EDU-SIGNAL-009 | Public story is polished but first action is unclear. | Marketing outran UX. | Run human journey audit. |
| EDU-SIGNAL-010 | Archive has many reports but no archive cards. | Preservation became navigation noise. | Create archive cards and lessons. |
| EDU-SIGNAL-011 | Build/analyze pass but release scope is undecided. | Technical pass without Owner release decision. | Use release governance gate. |
| EDU-SIGNAL-012 | Support signal succeeds but does not explain next step. | Human support expectation gap. | Add support expectation and safety copy. |

## Educational Use

These signals should be checked during:

- Release candidate preparation.
- Firebase activation.
- Runtime validation.
- Public website updates.
- Tool Center implementation.
- Archive freeze.
- Handoff between chats or operators.

## Required Reaction Levels

| Signal Type | Reaction |
| --- | --- |
| Authority signal | Stop and audit before deploy. |
| Identity signal | Stage cleanup with rollback. |
| Runtime placeholder signal | Hide or label before public release. |
| Support expectation signal | Treat as launch blocker. |
| Archive noise signal | Package, extract lessons, then freeze. |
