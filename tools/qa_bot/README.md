# QA Audit Bot

## Overview

This tool is a lightweight Python-based audit utility for reviewing Firestore data integrity in the Mental Smile system.

It defaults to dry-run mode. Firestore writes require an explicit privileged
ops flag.

It is designed to:

* Detect inconsistent or invalid data
* Identify legacy or corrupted documents
* Provide structured audit reports for admin/ops review

⚠️ This tool is **read-only by design** and should NOT modify production data.

---

## Features

* Firestore connectivity check
* Network precheck to `firestore.googleapis.com`
* Collection auditing (currently `centers`, expandable to `booking_requests` and others)
* Structured console output using `rich`
* Exportable audit reports

---

## Requirements

* Python 3.10+
* Firebase service account JSON

Install dependencies:

```bash
pip install -r requirements.txt
```

---

## Environment Variables

You can configure credentials using either:

### Option 1: `.env` file (recommended)

Create a `.env` file in this directory:

```env
QA_FIREBASE_SERVICE_ACCOUNT=path/to/serviceAccount.json
QA_FIREBASE_PROJECT_ID=your-project-id
```

Example (Windows):

```env
QA_FIREBASE_SERVICE_ACCOUNT=C:\secure\mental-smile-app-clean-service-account.json
QA_FIREBASE_PROJECT_ID=mental-smile-app-clean
```

---

### Option 2: System Environment Variables

```powershell
$env:GOOGLE_APPLICATION_CREDENTIALS="path/to/serviceAccount.json"
$env:GOOGLE_CLOUD_PROJECT="your-project-id"
```

---

## Setup

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

---

## Run

```powershell
python qa_audit.py
```

Default runs do not write to Firestore:

```text
DRY RUN: no Firestore writes performed
Target: system_health/latest
Payload summary: ...
```

Privileged ops writes require an explicit flag:

```powershell
python qa_audit.py --write-firestore
python audit_center_followup.py --write-firestore
```

---

## Output

Reports will be generated inside:

```
tools/qa_bot/reports/
```

---

## Safety Notes

* This tool uses Firebase Admin SDK (full access).
* Dry-run is the default; Firestore writes require `--write-firestore`.
* Use **read-only logic only**.
* Never run unverified scripts on production.
* Always test on staging when possible.

---

## Future Expansion

Planned tools:

* audit_center_followup.py
* audit_payouts.py
* audit_chat_threads.py
* find_dirty_documents.py

---

## Purpose in System Architecture

This tool is part of the **Python Ops / QA Layer**, which is:

* Separate from the Flutter app
* Used for diagnostics and auditing only
* Not exposed to end users or admins directly

---

## Maintainer Notes

* Keep scripts modular
* Avoid hardcoding project values
* Always log clearly
* Prefer safe reads over writes

---
