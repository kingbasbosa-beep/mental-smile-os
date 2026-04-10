const fs = require('fs');
const path = require('path');
const {
  initializeTestEnvironment,
  assertSucceeds,
  assertFails,
} = require('@firebase/rules-unit-testing');
const { doc, getDoc, setDoc, updateDoc } = require('firebase/firestore');

const PROJECT_ID = 'mental-smile-app-clean-rules-tests';
const ADMIN_UID = '1p1UEwzwXFYCHExp22bc0xGSjJj2';
const CLIENT_UID = 'b7qWMYwdISSHGuieeQARLBUKzGu2';
const CENTER_UID = 'a8e6rzUCa0Oh2ZsLGjATGOwNDAE2';

function rulesText() {
  return fs.readFileSync(
    path.resolve(__dirname, '..', 'firestore.rules'),
    'utf8',
  );
}

function baseCenterRequest(overrides = {}) {
  return {
    requestKind: 'center',
    status: 'pending_admin',
    workflowStage: 'pending_admin',
    clientId: CLIENT_UID,
    clientName: 'باسم ميلاد',
    centerId: CENTER_UID,
    centerName: 'مركز 1',
    note: 'test',
    createdAt: '2026-04-07T10:00:00.000Z',
    updatedAt: '2026-04-07T10:00:00.000Z',
    selectedAccommodationKey: 'standard_room',
    selectedAccommodationLabelAr: 'غرفة استاندرد',
    selectedAccommodationPricingSnapshot: '1000',
    selectedAccommodationPrice: 1000,
    selectedAccommodationPricingUnit: 'night',
    adminApproved: false,
    adminRejected: false,
    adminForwarded: false,
    adminDecisionType: '',
    adminDecisionBy: '',
    adminDecisionAt: null,
    adminAssignedBy: '',
    adminAssignedAt: null,
    centerAdminHandledBy: '',
    centerAdminHandledAt: null,
    centerAvailabilityStatus: 'pending',
    centerAvailabilityNote: '',
    centerAvailabilityRespondedAt: null,
    centerAvailabilityRespondedBy: '',
    centerSuggestedAlternativeKey: '',
    centerSuggestedAlternativeLabelAr: '',
    lastCenterAvailabilityStatus: '',
    lastCenterAvailabilityNote: '',
    lastCenterSuggestedAlternativeKey: '',
    lastCenterSuggestedAlternativeLabelAr: '',
    clientRevisionNumber: 0,
    lastCenterFeedbackRevisionNumber: 0,
    clientUpdatedAfterCenterFeedback: false,
    adminCanApproveWithoutCenterRecheck: false,
    paymentStatus: 'not_started',
    sessionStatus: 'not_created',
    reviewStatus: 'not_started',
    payoutStatus: 'blocked',
    assignedClinicianId: '',
    assignedClinicianName: '',
    clinicianId: '',
    clinicianName: '',
    clinicianUid: '',
    ...overrides,
  };
}

async function seedDoc(testEnv, docId, data) {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();
    await setDoc(doc(db, 'admins', ADMIN_UID), {
      active: true,
      createdAt: '2026-04-07T00:00:00.000Z',
    });
    await setDoc(doc(db, 'booking_requests', docId), data);
  });
}

async function run() {
  const testEnv = await initializeTestEnvironment({
    projectId: PROJECT_ID,
    firestore: {
      host: '127.0.0.1',
      port: 8080,
      rules: rulesText(),
    },
  });

  try {
    const adminDb = testEnv.authenticatedContext(ADMIN_UID).firestore();
    const centerDb = testEnv.authenticatedContext(CENTER_UID).firestore();
    const clientDb = testEnv.authenticatedContext(CLIENT_UID).firestore();

    await seedDoc(testEnv, 'center-pending', baseCenterRequest());

    await assertSucceeds(
      updateDoc(doc(adminDb, 'booking_requests', 'center-pending'), {
        status: 'center_follow_up',
        workflowStage: 'center_follow_up',
        adminApproved: false,
        adminRejected: false,
        adminForwarded: false,
        adminDecisionType: 'center_follow_up',
        adminDecisionBy: ADMIN_UID,
        adminDecisionAt: '2026-04-07T10:05:00.000Z',
        adminAssignedBy: ADMIN_UID,
        adminAssignedAt: '2026-04-07T10:05:00.000Z',
        centerAdminHandledBy: ADMIN_UID,
        centerAdminHandledAt: '2026-04-07T10:05:00.000Z',
        updatedAt: '2026-04-07T10:05:00.000Z',
      }),
    );

    await assertSucceeds(getDoc(doc(centerDb, 'booking_requests', 'center-pending')));

    await assertSucceeds(
      updateDoc(doc(centerDb, 'booking_requests', 'center-pending'), {
        centerAvailabilityStatus: 'available',
        centerAvailabilityNote: 'متاح',
        centerAvailabilityRespondedAt: '2026-04-07T10:10:00.000Z',
        centerAvailabilityRespondedBy: CENTER_UID,
        updatedAt: '2026-04-07T10:10:00.000Z',
      }),
    );

    await assertSucceeds(
      updateDoc(doc(adminDb, 'booking_requests', 'center-pending'), {
        status: 'awaiting_payment',
        workflowStage: 'awaiting_payment',
        adminApproved: true,
        adminRejected: false,
        adminForwarded: false,
        adminDecisionType: 'approved',
        adminDecisionBy: ADMIN_UID,
        adminDecisionAt: '2026-04-07T10:15:00.000Z',
        adminAssignedBy: ADMIN_UID,
        adminAssignedAt: '2026-04-07T10:15:00.000Z',
        paymentStatus: 'pending_client_transfer',
        sessionStatus: 'not_created',
        reviewStatus: 'not_started',
        payoutStatus: 'blocked',
        assignedClinicianId: '',
        assignedClinicianName: '',
        clinicianId: '',
        clinicianName: '',
        clinicianUid: '',
        updatedAt: '2026-04-07T10:15:00.000Z',
      }),
    );

    await seedDoc(
      testEnv,
      'center-unavailable',
      baseCenterRequest({
        status: 'center_follow_up',
        workflowStage: 'center_follow_up',
        centerAvailabilityStatus: 'unavailable',
        centerAvailabilityNote: 'ممتلئ',
        centerAvailabilityRespondedAt: '2026-04-07T10:20:00.000Z',
        centerAvailabilityRespondedBy: CENTER_UID,
      }),
    );

    await assertSucceeds(
      updateDoc(doc(adminDb, 'booking_requests', 'center-unavailable'), {
        status: 'client_update_required',
        workflowStage: 'client_update_required',
        lastCenterAvailabilityStatus: 'unavailable',
        lastCenterAvailabilityNote: 'ممتلئ',
        lastCenterSuggestedAlternativeKey: '',
        lastCenterSuggestedAlternativeLabelAr: '',
        lastCenterFeedbackRevisionNumber: 0,
        adminCanApproveWithoutCenterRecheck: false,
        adminDecisionType: 'returned_to_client',
        adminDecisionBy: ADMIN_UID,
        adminDecisionAt: '2026-04-07T10:25:00.000Z',
        updatedAt: '2026-04-07T10:25:00.000Z',
      }),
    );

    await assertFails(
      updateDoc(doc(clientDb, 'booking_requests', 'center-pending'), {
        status: 'awaiting_payment',
        workflowStage: 'awaiting_payment',
      }),
    );

    console.log('PASS center cycle rules');
  } finally {
    await testEnv.cleanup();
  }
}

run().catch((error) => {
  console.error('FAIL center cycle rules');
  console.error(error);
  process.exit(1);
});
