import { readFileSync, writeFileSync } from 'node:fs';
import { spawnSync } from 'node:child_process';

const projectId = 'mental-key-v2';
const webApiKey = 'AIzaSyBKMIvencDi85fANUSihZuBophyqvwtQvo';

const seedAccounts = [
  {
    key: 'clinician',
    email: 'qa.clinician.01@mental-smile.test',
    password: '1@clinician',
    name: 'QA Clinician 01',
  },
  {
    key: 'center',
    email: 'qa.center.01@mental-smile.test',
    password: '1@center',
    name: 'QA Center 01',
  },
  {
    key: 'client',
    email: 'qa.client.01@mental-smile.test',
    password: '1@client',
    name: 'QA Client 01',
  },
];

function run(command, args) {
  const rendered =
    process.platform === 'win32'
      ? [command, ...args].join(' ')
      : [command, ...args]
          .map((part) => (part.includes(' ') ? `"${part}"` : part))
          .join(' ');

  const result = spawnSync(rendered, [], {
    cwd: process.cwd(),
    encoding: 'utf8',
    shell: true,
    stdio: ['ignore', 'pipe', 'pipe'],
  });

  if (result.status !== 0) {
    throw new Error(
      [
        `Command failed: ${command} ${args.join(' ')}`,
        result.stdout?.trim(),
        result.stderr?.trim(),
      ]
          .filter(Boolean)
          .join('\n'),
    );
  }

  return result.stdout;
}

function getFirebaseAccessToken() {
  const raw = run('npx', ['firebase-tools', 'login:list', '--json']);
  const payload = JSON.parse(raw);
  const token = payload?.result?.[0]?.tokens?.access_token;
  if (!token) {
    throw new Error('Firebase CLI access token is not available.');
  }
  return token;
}

async function signInWithPassword(email, password) {
  return postJson(
    `https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${webApiKey}`,
    {
      email,
      password,
      returnSecureToken: true,
    },
  );
}

function exportAuthUsers() {
  const exportPath = 'tool/_tmp_seed_auth_export.json';
  run('npx', [
    'firebase-tools',
    'auth:export',
    exportPath,
    '--format=json',
    '--project',
    projectId,
  ]);
  const payload = JSON.parse(readFileSync(exportPath, 'utf8'));
  return Array.isArray(payload?.users) ? payload.users : [];
}

async function postJson(url, body, headers = {}) {
  const response = await fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      ...headers,
    },
    body: JSON.stringify(body),
  });

  const text = await response.text();
  const data = text ? JSON.parse(text) : {};
  if (!response.ok) {
    throw new Error(`${response.status} ${url}\n${text}`);
  }
  return data;
}

async function createAuthUserIfMissing(account, existingUsers) {
  const found = existingUsers.find(
    (user) => (user.email ?? '').trim().toLowerCase() === account.email,
  );

  if (found?.localId) {
    return {
      uid: found.localId,
      created: false,
    };
  }

  const data = await postJson(
    `https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${webApiKey}`,
    {
      email: account.email,
      password: account.password,
      returnSecureToken: true,
    },
  );

  return {
    uid: data.localId,
    created: true,
  };
}

function firestoreValue(value) {
  if (value === null) return { nullValue: null };
  if (Array.isArray(value)) {
    return {
      arrayValue: {
        values: value.map((item) => firestoreValue(item)),
      },
    };
  }
  if (value instanceof Date) {
    return { timestampValue: value.toISOString() };
  }
  switch (typeof value) {
    case 'string':
      return { stringValue: value };
    case 'boolean':
      return { booleanValue: value };
    case 'number':
      return Number.isInteger(value)
        ? { integerValue: value.toString() }
        : { doubleValue: value };
    case 'object': {
      const fields = {};
      for (const [key, nested] of Object.entries(value)) {
        fields[key] = firestoreValue(nested);
      }
      return { mapValue: { fields } };
    }
    default:
      return { stringValue: String(value ?? '') };
  }
}

function firestoreFields(data) {
  const fields = {};
  for (const [key, value] of Object.entries(data)) {
    fields[key] = firestoreValue(value);
  }
  return fields;
}

function documentPayloadFor(account, uid, now) {
  if (account.key === 'clinician') {
    return {
      collection: 'clinicians',
      docId: uid,
      data: {
        displayName: account.name,
        fullDisplayNameAr: `الأخصائي ${account.name}`,
        fullDisplayNameEn: account.name,
        professionalTitleKey: 'specialist',
        professionalTitleLabelAr: 'أخصائي',
        professionalTitleLabelEn: 'Specialist',
        email: account.email,
        specialty: 'إرشاد نفسي',
        specialtyKey: 'psychologist',
        specialtyLabel: 'أخصائي نفسي',
        offersGroupSessions: false,
        bio: 'حساب QA نظيف لاختبار مسارات الأخصائي.',
        sessionPriceText: '250 EGP',
        sessionDurationText: '45 min',
        sessionModes: ['حضوري', 'أونلاين'],
        role: 'clinician',
        isActive: true,
        isAdmin: false,
        photoUrl: '',
        photoAsset: '',
        documentsSubmitted: true,
        documentsUploadMode: 'manual_pending',
        approvalStatus: 'approved',
        identityFileName: 'qa_identity.pdf',
        certificateFileName: 'qa_certificate.pdf',
        extraFileName: '',
        identityDocumentUrl: '',
        certificateDocumentUrl: '',
        extraDocumentUrl: '',
        isBlocked: false,
        blockedAt: null,
        blockedBy: '',
        blockReason: '',
        createdAt: now,
        updatedAt: now,
      },
    };
  }

  if (account.key === 'center') {
    return {
      collection: 'centers',
      docId: uid,
      data: {
        name: account.name,
        role: 'center',
        active: true,
        isActive: true,
        displayName: account.name,
        centerName: account.name,
        category: 'recovery',
        categoryLabelAr: 'مراكز التعافي',
        categoryLabelEn: 'Recovery Centers',
        email: account.email,
        phone: '01000000001',
        city: 'Cairo',
        address: 'QA Seed Address',
        description: 'مركز تجريبي نظيف لاختبار مسارات المراكز.',
        managerName: 'QA Center Manager',
        sortOrder: 10,
        approvalStatus: 'approved',
        imagesReady: false,
        documentsReady: false,
        galleryImages: [],
        documentItems: [],
        isBlocked: false,
        blockedAt: null,
        blockedBy: '',
        blockReason: '',
        createdAt: now,
        updatedAt: now,
      },
    };
  }

  return {
    collection: 'clients',
    docId: uid,
    data: {
      role: 'client',
      displayName: account.name,
      email: account.email,
      avatarAsset: 'assets/images/avatar_client_male.png',
      isBlocked: false,
      blockedAt: null,
      blockedBy: '',
      blockReason: '',
      createdAt: now,
      updatedAt: now,
    },
  };
}

async function commitFirestoreWrites(accessToken, writes) {
  return postJson(
    `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents:commit`,
    { writes },
    {
      Authorization: `Bearer ${accessToken}`,
    },
  );
}

async function signInCheck(email, password) {
  const data = await signInWithPassword(email, password);
  return data.localId;
}

async function main() {
  run('npx', ['firebase-tools', 'projects:list', '--json']);
  const accessToken = getFirebaseAccessToken();
  const existingUsers = exportAuthUsers();
  const now = new Date();

  const createdAccounts = [];
  const writes = [];

  for (const account of seedAccounts) {
    const authResult = await createAuthUserIfMissing(account, existingUsers);
    const doc = documentPayloadFor(account, authResult.uid, now);
    writes.push({
      update: {
        name: `projects/${projectId}/databases/(default)/documents/${doc.collection}/${doc.docId}`,
        fields: firestoreFields(doc.data),
      },
    });

    createdAccounts.push({
      email: account.email,
      password: account.password,
      role: account.key,
      uid: authResult.uid,
      authCreatedNow: authResult.created,
      firestoreCollection: doc.collection,
      startingState:
        account.key === 'clinician'
          ? 'approved + active'
          : account.key === 'center'
            ? 'approved + active + recovery category'
            : 'client doc ready',
    });
  }

  await commitFirestoreWrites(accessToken, writes);

  const loginChecks = [];
  for (const account of seedAccounts) {
    const uid = await signInCheck(account.email, account.password);
    loginChecks.push({
      email: account.email,
      uid,
      loginOk: true,
    });
  }

  const summary = {
    projectId,
    createdAccounts,
    loginChecks,
    supportedFlows: {
      clinician: [
        'clinician pages',
        'booking selection',
        'admin clinician management',
      ],
      center: [
        'center dashboard',
        'center operations',
        'public center listing/details',
        'admin center management',
      ],
      client: [
        'client dashboard',
        'my bookings baseline',
        'booking creation baseline',
      ],
    },
    intentionallyNotSeeded: [
      'second standalone clinician account',
      'bookings',
      'payments',
      'sessions',
      'change requests',
      'chat threads',
      'escalations',
    ],
  };

  writeFileSync(
    'tool/qa_seed_summary.json',
    JSON.stringify(summary, null, 2),
    'utf8',
  );

  console.log(JSON.stringify(summary, null, 2));
}

await main();
