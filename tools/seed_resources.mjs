import { initializeApp } from "firebase/app";
import { getFirestore, collection, doc, setDoc, serverTimestamp } from "firebase/firestore";

const firebaseConfig = {
  apiKey: "REPLACE_ME",
  authDomain: "REPLACE_ME",
  projectId: "mental-key-v2",
  appId: "REPLACE_ME"
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

const items = [
  {
    id: "addiction_basics",
    category: "addiction",
    type: "article",
    title_ar: "فهم الإدمان داخل الأسرة",
    title_en: "Understanding Addiction in Families",
    url: "https://www.nimh.nih.gov/health/topics/substance-use-and-mental-health",
    tags: ["family","awareness"]
  },
  {
    id: "stress_grounding",
    category: "family_stress",
    type: "article",
    title_ar: "تمارين تهدئة بسيطة وقت التوتر",
    title_en: "Simple Grounding During Stress",
    url: "https://www.mind.org.uk/information-support/tips-for-everyday-living/relaxation/",
    tags: ["calm","breathing"]
  }
];

async function run() {
  for (const it of items) {
    await setDoc(doc(collection(db, "resources"), it.id), {
      ...it,
      enabled: true,
      createdAt: serverTimestamp()
    }, { merge: true });
    console.log("✅ seeded:", it.id);
  }
  process.exit(0);
}
run().catch(e => { console.error(e); process.exit(1); });
