import { mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { spawnSync } from 'node:child_process';

const projectId = 'mental-key-v2';
const preserveEmails = new Set([
  'kingbasbosa@gmail.com',
  'kingbasbosa@hotmail.com',
]);

const collectionsToDelete = [
  'clinicians',
  'clients',
  'centers',
  'booking_requests',
  'bookingRequests',
  'clinician_profile_change_requests',
  'center_profile_change_requests',
  'sessionRatings',
  'chat_threads',
  'chat_escalations',
  'chatThreads',
  'debug',
];

function run(command, args, { allowFailure = false } = {}) {
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

  if (result.status !== 0 && !allowFailure) {
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

  return result;
}

function getFirebaseLogin() {
  const result = run('npx', [
    'firebase-tools',
    'login:list',
    '--json',
  ]);
  const payload = JSON.parse(result.stdout);
  const first = payload?.result?.[0];
  if (!first?.tokens?.access_token) {
    throw new Error('Firebase CLI access token was not available.');
  }
  return first;
}

function exportAuthUsers(exportPath) {
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

async function googleApiJson(url, accessToken, options = {}) {
  const response = await fetch(url, {
    ...options,
    headers: {
      Authorization: `Bearer ${accessToken}`,
      'Content-Type': 'application/json',
      ...(options.headers ?? {}),
    },
  });

  if (!response.ok) {
    throw new Error(
      `Google API error ${response.status} for ${url}: ${await response.text()}`,
    );
  }

  if (response.status === 204) {
    return {};
  }

  return response.json();
}

async function deleteAuthUsers(accessToken, usersToDelete) {
  const chunkSize = 100;
  let deleted = 0;

  for (let index = 0; index < usersToDelete.length; index += chunkSize) {
    const chunk = usersToDelete.slice(index, index + chunkSize);
    await googleApiJson(
      `https://identitytoolkit.googleapis.com/v1/projects/${projectId}/accounts:batchDelete`,
      accessToken,
      {
        method: 'POST',
        body: JSON.stringify({
          localIds: chunk.map((user) => user.localId),
          force: true,
        }),
      },
    );
    deleted += chunk.length;
  }

  return deleted;
}

function deleteFirestoreCollections() {
  const deletedCollections = [];

  for (const collection of collectionsToDelete) {
    const result = run(
      'npx',
      [
        'firebase-tools',
        'firestore:delete',
        collection,
        '--recursive',
        '--force',
        '--project',
        projectId,
      ],
      { allowFailure: true },
    );

    const combined = `${result.stdout}\n${result.stderr}`;
    if (
      result.status === 0 ||
      combined.includes('No documents found') ||
      combined.includes('does not exist')
    ) {
      deletedCollections.push(collection);
      continue;
    }

    throw new Error(
      `Failed deleting collection ${collection}:\n${combined.trim()}`,
    );
  }

  return deletedCollections;
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

function preservedDocsForUser(user, now) {
  const email = (user.email ?? '').trim().toLowerCase();
  const displayName = email.split('@')[0] || 'QA Admin';

  return [
    {
      collection: 'clinicians',
      docId: user.localId,
      data: {
        role: 'clinician',
        displayName,
        email,
        specialty: 'qa_test',
        professionalTitleLabelAr: 'حساب اختبار',
        professionalTitleLabelEn: 'QA Account',
        approvalStatus: 'approved',
        isActive: true,
        isAdmin: true,
        offersGroupSessions: false,
        isBlocked: false,
        blockedAt: null,
        blockedBy: '',
        blockReason: '',
        createdAt: now,
        updatedAt: now,
      },
    },
    {
      collection: 'clients',
      docId: user.localId,
      data: {
        role: 'client',
        displayName,
        email,
        avatarAsset: 'assets/images/avatar_client_male.png',
        isBlocked: false,
        blockedAt: null,
        blockedBy: '',
        blockReason: '',
        createdAt: now,
        updatedAt: now,
      },
    },
    {
      collection: 'centers',
      docId: user.localId,
      data: {
        role: 'center',
        name: displayName,
        displayName,
        centerName: displayName,
        email,
        managerName: displayName,
        category: 'recovery',
        categoryLabelAr: 'مراكز التعافي',
        categoryLabelEn: 'Recovery Centers',
        active: true,
        isActive: true,
        approvalStatus: 'approved',
        sortOrder: 999,
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
    },
  ];
}

async function restorePreservedDocs(accessToken, preservedUsers) {
  const now = new Date();
  const writes = preservedUsers.flatMap((user) =>
    preservedDocsForUser(user, now).map((doc) => ({
      update: {
        name: `projects/${projectId}/databases/(default)/documents/${doc.collection}/${doc.docId}`,
        fields: firestoreFields(doc.data),
      },
    })),
  );

  await googleApiJson(
    `https://firestore.googleapis.com/v1/projects/${projectId}/databases/(default)/documents:commit`,
    accessToken,
    {
      method: 'POST',
      body: JSON.stringify({ writes }),
    },
  );

  return writes.length;
}

async function main() {
  const tempDir = mkdtempSync(join(tmpdir(), 'mk-qa-clean-'));
  const exportPath = join(tempDir, 'auth-export.json');

  try {
    const login = getFirebaseLogin();
    const accessToken = login.tokens.access_token;

    const authUsers = exportAuthUsers(exportPath);
    const preservedUsers = authUsers.filter((user) =>
      preserveEmails.has((user.email ?? '').trim().toLowerCase()),
    );

    if (preservedUsers.length !== preserveEmails.size) {
      throw new Error(
        `Expected ${preserveEmails.size} preserved auth users, found ${preservedUsers.length}.`,
      );
    }

    const authUsersToDelete = authUsers.filter(
      (user) => !preserveEmails.has((user.email ?? '').trim().toLowerCase()),
    );

    const deletedAuthUsers = await deleteAuthUsers(
      accessToken,
      authUsersToDelete,
    );
    const deletedCollections = deleteFirestoreCollections();
    const restoredDocs = await restorePreservedDocs(accessToken, preservedUsers);

    const summary = {
      projectId,
      preservedAdmins: preservedUsers.map((user) => ({
        email: user.email,
        uid: user.localId,
      })),
      deletedAuthUsers,
      deletedCollections,
      restoredDocs,
      expectedMinimalCounts: {
        clinicians: preservedUsers.length,
        clients: preservedUsers.length,
        centers: preservedUsers.length,
        booking_requests: 0,
        bookingRequests: 0,
        clinician_profile_change_requests: 0,
        center_profile_change_requests: 0,
        sessionRatings: 0,
        chat_threads: 0,
        chat_escalations: 0,
      },
    };

    writeFileSync(
      join(process.cwd(), 'tool', 'qa_cleanup_summary.json'),
      JSON.stringify(summary, null, 2),
      'utf8',
    );

    console.log(JSON.stringify(summary, null, 2));
  } finally {
    rmSync(tempDir, { recursive: true, force: true });
  }
}

await main();
