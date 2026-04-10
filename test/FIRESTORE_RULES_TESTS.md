# Firestore Rules Test Setup

هذا setup صغير لاختبار دورة المركز محليًا على Firestore emulator.

## التثبيت

```powershell
cd C:\flutterprojects\mental_smile_app_clean\test
npm install
```

## التشغيل

من جذر المشروع:

```powershell
firebase emulators:start --only firestore
```

في terminal ثانية:

```powershell
cd C:\flutterprojects\mental_smile_app_clean\test
npm run test:center-cycle
```

## ما الذي يغطيه

- `pending_admin -> center_follow_up`
- `center_follow_up -> awaiting_payment`
- `center_follow_up -> client_update_required`
- تحقق سلبي أن العميل لا يستطيع فرض `awaiting_payment`
