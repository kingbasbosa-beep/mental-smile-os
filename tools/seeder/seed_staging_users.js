/**
 * Mental Smile Staging Firebase Admin Seeder
 *
 * Synchronizes Auth test accounts, Custom Claims, and Firestore Role Documents.
 *
 * USAGE:
 * $env:FIREBASE_SERVICE_ACCOUNT_PATH="C:/path/to/key.json"
 * node tools/seeder/seed_staging_users.js [--cleanup]
 */

const admin = require('firebase-admin');
const path = require('path');

const serviceAccountPath = process.env.FIREBASE_SERVICE_ACCOUNT_PATH;
const isCleanup = process.argv.includes('--cleanup');

if (!serviceAccountPath) {
  console.error('❌ ERROR: FIREBASE_SERVICE_ACCOUNT_PATH environment variable is not set.');
  process.exit(1);
}

try {
  const serviceAccount = require(path.resolve(serviceAccountPath));
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });
} catch (e) {
  console.error(`❌ ERROR: Failed to initialize Firebase Admin. Check your service account path.\n${e.message}`);
  process.exit(1);
}

const auth = admin.auth();
const db = admin.firestore();

const DEFAULT_PASSWORD = 'MentalSmile_Staging_123456!';

const STAGING_USERS = [
  {
    email: 'staging_admin@mental-smile.com',
    role: 'admin',
    displayName: 'Staging Admin',
    firestore: { collection: 'admins', data: { active: true } }
  },
  {
    email: 'staging_client@mental-smile.com',
    role: 'client',
    displayName: 'Staging Client',
    firestore: { collection: 'clients', data: { role: 'client' } }
  },
  {
    email: 'staging_clinician@mental-smile.com',
    role: 'clinician',
    displayName: 'Staging Clinician (Approved)',
    firestore: {
      collection: 'clinicians',
      data: { role: 'clinician', approvalStatus: 'approved', isActive: true }
    }
  },
  {
    email: 'staging_center@mental-smile.com',
    role: 'center',
    displayName: 'Staging Center (Approved)',
    firestore: {
      collection: 'centers',
      data: { role: 'center', approvalStatus: 'approved', isActive: true }
    }
  },
  {
    email: 'pending_clinician@mental-smile.com',
    role: 'clinician',
    displayName: 'Staging Clinician (Pending)',
    firestore: {
      collection: 'clinicians',
      data: { role: 'clinician', approvalStatus: 'pending_review', isActive: false }
    }
  },
  {
    email: 'pending_center@mental-smile.com',
    role: 'center',
    displayName: 'Staging Center (Pending)',
    firestore: {
      collection: 'centers',
      data: { role: 'center', approvalStatus: 'pending_admin', isActive: false }
    }
  }
];

async function seedUser(userSpec) {
  let user;
  try {
    user = await auth.getUserByEmail(userSpec.email);
    console.log(`ℹ️ User exists: ${userSpec.email} (${user.uid})`);
  } catch (e) {
    if (e.code === 'auth/user-not-found') {
      user = await auth.createUser({
        email: userSpec.email,
        password: DEFAULT_PASSWORD,
        displayName: userSpec.displayName,
      });
      console.log(`✅ Created user: ${userSpec.email} (${user.uid})`);
    } else {
      throw e;
    }
  }

  // 1. Set Custom Claims (Required for Firestore Security Rules)
  await auth.setCustomUserClaims(user.uid, { role: userSpec.role });
  console.log(`🔑 Set claims: { role: '${userSpec.role}' } for ${userSpec.email}`);

  // 2. Upsert Firestore Role Document
  const docData = {
    ...userSpec.firestore.data,
    displayName: userSpec.displayName,
    email: userSpec.email,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  };

  // Only add createdAt if it's a new document/creation flow
  await db.collection(userSpec.firestore.collection).doc(user.uid).set(docData, { merge: true });
  console.log(`📄 Updated Firestore: ${userSpec.firestore.collection}/${user.uid}`);
}

async function cleanupUser(userSpec) {
  if (!userSpec.email.startsWith('staging_') && !userSpec.email.startsWith('pending_')) {
    console.warn(`⚠️ Skipping cleanup for non-staging email: ${userSpec.email}`);
    return;
  }

  try {
    const user = await auth.getUserByEmail(userSpec.email);
    await auth.deleteUser(user.uid);
    console.log(`🗑️ Deleted Auth user: ${userSpec.email}`);

    await db.collection(userSpec.firestore.collection).doc(user.uid).delete();
    console.log(`🗑️ Deleted Firestore doc: ${userSpec.firestore.collection}/${user.uid}`);
  } catch (e) {
    if (e.code === 'auth/user-not-found') {
      console.log(`ℹ️ Already clean: ${userSpec.email}`);
    } else {
      console.error(`❌ Cleanup failed for ${userSpec.email}: ${e.message}`);
    }
  }
}

async function run() {
  console.log(`🚀 Starting ${isCleanup ? 'CLEANUP' : 'SEEDING'} process...`);

  for (const user of STAGING_USERS) {
    if (isCleanup) {
      await cleanupUser(user);
    } else {
      await seedUser(user);
    }
  }

  console.log(`\n✨ Done. ${isCleanup ? 'Cleanup' : 'Seeding'} finished successfully.`);
  process.exit(0);
}

run().catch(err => {
  console.error(`\n💥 CRITICAL ERROR: ${err.message}`);
  process.exit(1);
});
