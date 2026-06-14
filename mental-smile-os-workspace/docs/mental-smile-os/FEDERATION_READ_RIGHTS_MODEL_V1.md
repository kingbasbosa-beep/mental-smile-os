# Federation Read Rights Model V1

Status: ACTIVE_READ_RIGHTS_MODEL
Prompt Asset: PROMPT_ASSET_033

## Read Rights Scope

| Reader | May Read | May Not Read |
| --- | --- | --- |
| Zone | Own internal runtime state, signals, reports, cards, registries, and memory. | Foreign zone internals unless packaged through gateway or registry boundary. |
| Gateway | Signal packages, counts, classifications, summaries, buffers, and routing metadata within approved scope. | Foreign zone runtime internals or private registries outside package scope. |
| Archive | Detail reports, memory packages, snapshots, lineage records, and preserved registries. | Live runtime state as a control surface. |
| Strategic Planning | Human summaries, detail reports, strategic packages, and approved planning inputs. | Direct runtime internals or mutation surfaces. |
| Owner | Constitutional records, registries, doctrine, reports, lineage, and authority packages. | Bypass audit or read outside constitutional lifecycle. |

## Rule

Read rights define scope only. No implementation, Firestore rules, backend code, or query permissions are created.

