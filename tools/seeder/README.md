# Mental Smile Firebase Staging Seeder

This utility script synchronizes Auth test accounts, Custom Claims, and Firestore Role Documents for the staging environment.

## Prerequisites

1. **Install Dependencies**
   Navigate to the seeder directory (or project root) and install the Admin SDK:
   ```bash
   npm install firebase-admin
   ```

2. **Obtain Service Account Key**
   - Go to Firebase Console -> Project Settings -> Service Accounts.
   - Click "Generate new private key".
   - **WARNING:** Do not commit this JSON file to the repository. Store it in a secure location outside your project directory.

## Configuration

Set the environment variable pointing to your JSON key:

**PowerShell:**
```powershell
$env:FIREBASE_SERVICE_ACCOUNT_PATH="C:/path/to/your-key.json"
```

**Bash:**
```bash
export FIREBASE_SERVICE_ACCOUNT_PATH="/path/to/your-key.json"
```

## Usage

### Seed Staging Users
This will create or update the six standard test users (Admin, Client, Clinician Approved/Pending, Center Approved/Pending) and set their custom claims.

```bash
node tools/seeder/seed_staging_users.js
```

### Cleanup Staging Users
This will delete the Auth accounts and Firestore documents for emails starting with `staging_` or `pending_`.

```bash
node tools/seeder/seed_staging_users.js --cleanup
```

## Security Rules Note
Authorization in this project depends on custom claims (`request.auth.token.role`). If you create users manually through the UI, they will **NOT** have permission to write to Firestore until you run this script to set their claims.
