# Finding: Connected Does Not Mean Needed V1

Finding ID: FINDING-CONNECTED-DOES-NOT-MEAN-NEEDED-V1
Status: ACTIVE_FINDING
Source Operation: OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1

## Finding

Router cases, validators, rules, and asset bundles can remain technically connected after their product purpose expires.

## Evidence

- Signal validators accept old residential signals with no active producers found.
- Public portal request routes are routable but no persistence flow was found.
- `saved_destinations` has write capability and a watch method, but no active readback caller was found.

## Doctrine

Connected is not the same as needed. Purpose must be proven by an active journey, owner, and verification path.

