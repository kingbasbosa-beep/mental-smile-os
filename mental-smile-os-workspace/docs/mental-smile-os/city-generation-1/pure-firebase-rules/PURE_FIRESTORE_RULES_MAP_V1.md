# Pure Firestore Rules Map V1

Status: FIRESTORE_BOUNDARY_MAP
Prompt Asset: PROMPT_ASSET_045

## Purpose

Define future Firestore boundary classes without writing rules or schemas.

## Future Collection Classes

| Collection Class | Constitutional Owner | May Read | May Write | Forbidden |
| --- | --- | --- | --- | --- |
| Zone Collections | Local Zone | Local zone, approved gateway summaries, Owner by audit path | Local zone only | Foreign zone mutation |
| Gateway Collections | Local Zone Gateway | Local gateway, Monitoring, Smart Archive | Local gateway only | Governance decisions |
| Registry Collections | Declared Registry Owner | Owner, Smart Archive, approved registry custodians | Registry custodian by lifecycle | Unregistered assets |
| Archive Collections | Smart Archive Zone | Smart Archive, Owner, approved Strategic summaries | Smart Archive only | Runtime mutation |
| Strategic Collections | Strategic Intelligence Zone | Strategic, Owner, Smart Archive snapshots | Strategic Intelligence only | Authorization or execution |
| Owner Collections | Owner Zone | Owner, audited governance readers | Owner authority path only | Hidden owner bypass |

## Rule Derivation Requirement

Every future Firestore rule must map to:

- Zone.
- Gateway if applicable.
- Authority doctrine.
- Read authority.
- Mutation authority.
- Registry or card owner.
- Audit status.

## Forbidden Map Entries

- Legacy booking collections.
- Legacy payment collections.
- Legacy session collections.
- Undefined admin collections.
- Wildcard catch-all write rules.
- Temporary collections without expiry and owner.

