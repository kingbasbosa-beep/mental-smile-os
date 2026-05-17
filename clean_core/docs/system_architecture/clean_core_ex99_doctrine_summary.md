# EX-99 Doctrine Summary

## Additive Split Doctrine

Mapper-bound records were not moved directly. Instead, the wave used additive splits:

- create a pure package model;
- create a host-side Firestore mapper;
- retain the existing host compatibility file;
- add one explicit package export;
- avoid consumer reconnect.

## Semantic Freeze Methodology

Before each split, fields and meanings were frozen. The freeze identified:

- package-safe fields;
- prohibited semantics;
- host-owned mapper responsibilities;
- rollback scope;
- stop conditions.

## Metadata-Only Philosophy

Package contracts are passive data contracts. They do not execute, enforce, approve, schedule, route, persist, or own backend authority.

## Firestore Mapper Isolation

Firestore imports, `Timestamp`, `FieldValue`, server timestamps, field names, null handling, nested map conversion, and storage compatibility remain host-owned.

## Export Governance

Package barrel additions are explicit file-by-file exports only. No wildcard exports or directory exports are permitted.

## Rollback Doctrine

Each additive split remains rollback-local: package file, mapper file, and one export line.
