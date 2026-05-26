const fs = require('fs');
const path = require('path');
const admin = require('firebase-admin');

const EXPECTED_PROJECT_ID = 'mental-smile-app-clean';

const OWNER_EMAILS = [
  'kingbasbosa@gmail.com',
  'mentalsmile.platform@gmail.com',
];

function resolveServiceAccountPath() {
  const fromEnv = process.env.GOOGLE_APPLICATION_CREDENTIALS;
  if (fromEnv) {
    return path.resolve(fromEnv);
  }

  return path.resolve(__dirname, 'serviceAccount.local.json');
}

function loadServiceAccount() {
  const serviceAccountPath = resolveServiceAccountPath();

  if (!fs.existsSync(serviceAccountPath)) {
    throw new Error(
      [
        '[OWNER_BOOTSTRAP][MISSING_SERVICE_ACCOUNT]',
        `Expected service account at: ${serviceAccountPath}`,
        'Set GOOGLE_APPLICATION_CREDENTIALS or create tools/firebase/serviceAccount.local.json.',
      ].join(' '),
    );
  }

  const serviceAccount = require(serviceAccountPath);

  if (serviceAccount.project_id !== EXPECTED_PROJECT_ID) {
    throw new Error(
      [
        '[OWNER_BOOTSTRAP][PROJECT_ID_MISMATCH]',
        `expected=${EXPECTED_PROJECT_ID}`,
        `actual=${serviceAccount.project_id || 'unknown'}`,
      ].join(' '),
    );
  }

  return serviceAccount;
}

async function bootstrapOwner(email) {
  let user;

  try {
    user = await admin.auth().getUserByEmail(email);
  } catch (error) {
    if (error.code === 'auth/user-not-found') {
      console.warn(`[OWNER_BOOTSTRAP][MISSING_AUTH_USER] ${email}`);
      return;
    }

    throw error;
  }

  await admin.auth().setCustomUserClaims(user.uid, { role: 'admin' });

  await admin.firestore().collection('admins').doc(user.uid).set(
    {
      email,
      displayName: user.displayName || email,
      role: 'admin',
      active: true,
      isActive: true,
      isAdmin: true,
      isBlocked: false,
      approvalStatus: 'approved',
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    },
    { merge: true },
  );

  console.log(`[OWNER_BOOTSTRAP][UPDATED] email=${email} uid=${user.uid}`);
}

async function main() {
  const serviceAccount = loadServiceAccount();

  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    projectId: EXPECTED_PROJECT_ID,
  });

  const appProjectId = admin.app().options.projectId;
  if (appProjectId !== EXPECTED_PROJECT_ID) {
    throw new Error(
      `[OWNER_BOOTSTRAP][APP_PROJECT_ID_MISMATCH] expected=${EXPECTED_PROJECT_ID} actual=${appProjectId}`,
    );
  }

  console.log(`[OWNER_BOOTSTRAP][PROJECT_OK] ${appProjectId}`);

  for (const email of OWNER_EMAILS) {
    await bootstrapOwner(email);
  }

  console.log('[OWNER_BOOTSTRAP][DONE]');
}

main().catch((error) => {
  console.error('[OWNER_BOOTSTRAP][FAILED]', error);
  process.exitCode = 1;
});
