# EX-78 Human Review Integrity Detox

## Integrity-Adjacent Fields

- `traceHash`
- `hashPlaceholder`
- `snapshotId`

## Required Integrity Caveats

- `traceHash` is not integrity proof.
- `hashPlaceholder` is not security proof.
- `hashPlaceholder` is not integrity proof.
- `snapshotId` does not prove immutability.
- No package metadata field proves tamper resistance, backend signing, or trusted audit linkage.

## Prohibited Integrity Semantics

Package variants must not include:

- hashing logic
- signature logic
- verification logic
- backend trust checks
- immutable snapshot validation
- write authorization logic

## Verdict

Integrity detox is viable only as passive metadata.
