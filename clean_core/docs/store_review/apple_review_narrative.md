# Apple Review Narrative Draft

## App Purpose

Mental Smile is a wellness, awareness, and support-navigation app. It helps users explore support options, booking flows, and safe informational guidance. It does not provide medical diagnosis, therapy, treatment, or emergency response.

## AI Status and Limitations

Runtime AI is not enabled in the current build phase. The codebase includes AI safety and governance foundations for future review, but no live AI model calls, no AI chat runtime, and no automated crisis escalation are active.

If AI features are enabled in the future, the app will disclose that AI may be limited or wrong and is not a doctor, therapist, diagnosis tool, or emergency service.

## Safety Layers

The architecture includes draft legal consent contracts, AI governance placeholders, safety core skeletons, crisis-safe support copy, and backend boundary contracts. These are designed to prevent client-side governance authority and support future auditability.

## Crisis Limitations

Mental Smile may encourage users to contact local emergency support or a trusted nearby person when danger is immediate. The app does not guarantee rescue, monitoring, dispatch, or emergency intervention.

## Privacy and Data Minimization

The app follows a privacy-first posture and avoids raw AI conversation storage, diagnosis fields, unsafe profiling, and client-controlled governance fields in its foundation. Firestore posture is deny-by-default for protected operations.

## No Diagnosis or Treatment Claims

Mental Smile should not be marketed as a medical device, diagnostic tool, therapy replacement, medication advisor, or emergency service.
