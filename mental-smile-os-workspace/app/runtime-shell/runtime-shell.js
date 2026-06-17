const osMemorySummary = {
  osName: "Mental Smile OS",
  currentStatus: "RUNTIME_MEMORY_AWARENESS_ACTIVE",
  latestCompletedStep: {
    id: "STEP_008",
    name: "App Splash Rebirth",
    promptAsset: "PROMPT_ASSET_015",
  },
  currentWorkingArea: "App Surface Splash Preview",
  nextWorkingArea: "Home / Menu later",
  activeStructure: [
    ["Owner Domain", "ACTIVE", "DNA Vault مصدر السلطة الدستورية."],
    ["Constitutional Memory Domain", "ACTIVE", "يحفظ الاستمرارية والنسب والذاكرة الموثقة."],
    ["Strategic Planning Room", "ACTIVE", "يحول رؤية المالك إلى استراتيجية بناء وتصنيف مصادر."],
    ["Sovereign Construction Studio", "ACTIVE", "ينظم أدوات البناء والحزم المعتمدة."],
  ],
  sourceAuthority: {
    name: "DNA Vault",
    status: "ACTIVE_SOURCE_AUTHORITY",
    foundationStatus: "FOUNDATION_VALIDATED",
    boundary: "DNA يقرر الضرورة الدستورية. Memory تحفظ الاستمرارية. Runtime يعرض الحالة فقط.",
  },
  latestSignals: [
    ["MEMORY_SIGNAL_001", "LINEAGE_ESTABLISHED", "Prompt lineage traceable through PROMPT_ASSET_011."],
    ["MEMORY_SIGNAL_005", "MEMORY_VALIDATED", "Runtime Birth records validated in Constitutional Memory."],
  ],
  availableMemoryAreas: [
    "Prompt Memory",
    "Guide Memory",
    "Card Memory",
    "Signal Memory",
    "UI Memory",
    "Localization Memory",
    "Ownership Memory",
    "Asset Recreation Memory",
    "Master Guide Cards",
    "Source Extraction Queue",
  ],
  promptAssets: [
    ["PROMPT_ASSET_001", "Mental Smile OS Foundation Reset", "FOUNDATIONAL_PROMPT", "NONE", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_002", "Constitutional Memory Domain Genesis", "FOUNDATIONAL_PROMPT", "PROMPT_ASSET_001", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_003", "DNA Card and Signal Doctrine Genesis", "FOUNDATIONAL_PROMPT", "PROMPT_ASSET_002", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_004", "Constitutional Guide Asset Doctrine Genesis", "FOUNDATIONAL_PROMPT", "PROMPT_ASSET_003", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_005", "Strategic Planning Room Genesis", "FOUNDATIONAL_PROMPT", "PROMPT_ASSET_004", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_006", "Sovereign Construction Studio Genesis", "FOUNDATIONAL_PROMPT", "PROMPT_ASSET_005", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_007", "Construction Workbench Runtime Surface", "FOUNDATIONAL_PROMPT", "PROMPT_ASSET_006", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_008", "Sovereign Asset Memory Structure Genesis", "FOUNDATIONAL_PROMPT", "PROMPT_ASSET_007", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_009", "Client Room Visual System Extraction", "FOUNDATIONAL_EXTRACTION_PROMPT", "PROMPT_ASSET_008", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_010", "Mental Smile OS Workspace Separation", "FOUNDATIONAL_SEPARATION_PROMPT", "PROMPT_ASSET_009", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_011", "Mental Smile OS Runtime Birth", "FOUNDATIONAL_RUNTIME_PROMPT", "PROMPT_ASSET_010", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_012", "Runtime Memory Awareness Upgrade", "RUNTIME_AWARENESS_PROMPT", "PROMPT_ASSET_011", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_013", "Surface Topology and Separation Map", "SURFACE_ARCHITECTURE_PROMPT", "PROMPT_ASSET_012", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_014", "Surface Registration Package", "SURFACE_REGISTRATION_PROMPT", "PROMPT_ASSET_013", "VALIDATED", "LINEAGE_ESTABLISHED"],
    ["PROMPT_ASSET_015", "App Surface Splash Rebirth", "APP_SURFACE_SCREEN_REBIRTH_PROMPT", "PROMPT_ASSET_014", "VALIDATED", "LINEAGE_ESTABLISHED"],
  ],
  latestPromptAsset: "PROMPT_ASSET_015",
  constructionStudioTools: [
    "ChatGPT",
    "Codex",
    "Android Studio",
    "GitHub",
    "Firebase",
    "Google Play Console",
    "Local Project",
    "Mental Smile Core Source Repository",
  ],
  currentPendingPackage: "App Surface Splash preview, then Home / Menu later",
};

function card(title, body, meta = "") {
  return `
    <article class="card">
      ${meta ? `<span class="meta-chip">${meta}</span>` : ""}
      <h3>${title}</h3>
      <p>${body}</p>
    </article>
  `;
}

function routeShell(title, subtitle, body) {
  return `
    <section class="hero">
      <span class="stamp">Memory Aware Runtime</span>
      <h2>${title}</h2>
      <p class="subtitle">${subtitle}</p>
      <div class="pill-row">
        <span class="pill">No Firebase</span>
        <span class="pill">No Backend</span>
        <span class="pill">No Legacy Runtime</span>
        <span class="pill">Memory Summary Active</span>
      </div>
    </section>
    ${body}
  `;
}

const routes = {
  "/os": () => {
    const structure = osMemorySummary.activeStructure
      .map(([name, status, purpose]) => card(name, purpose, status))
      .join("");

    return routeShell(
      "Mental Smile OS",
      "النظام الآن يرى حالته الدستورية من ذاكرة موثقة، بدون اتصال خارجي.",
      `
        <section class="grid">
          ${card("Mental Smile OS Status", osMemorySummary.currentStatus)}
          ${card("Latest Completed Step", `${osMemorySummary.latestCompletedStep.id} ${osMemorySummary.latestCompletedStep.name}`)}
          ${card("Latest Prompt", osMemorySummary.latestPromptAsset)}
          ${card("Next Working Area", `${osMemorySummary.currentWorkingArea} ثم ${osMemorySummary.nextWorkingArea}`)}
        </section>
        <h2 class="section-title">Active Structure</h2>
        <section class="grid">${structure}</section>
      `,
    );
  },
  "/os/app/splash": () =>
    routeShell(
      "App Surface Splash",
      "معاينة ثابتة لأول شاشة نظيفة في App Surface. لا تنفذ تسجيل دخول أو Firebase أو انتقال حقيقي.",
      `<section class="splash-preview" aria-label="App Surface Splash preview">
        <div class="splash-card">
          <div class="brand-mark" aria-hidden="true">MS</div>
          <p class="splash-kicker">Mental Smile</p>
          <h2>أهلا بك في Mental Smile</h2>
          <p>مساحة هادئة للدعم والاكتشاف</p>
          <button type="button">متابعة</button>
          <div class="splash-tools">
            <span>العربية</span>
            <span>English</span>
          </div>
          <small>جاري التحضير</small>
        </div>
      </section>
      <section class="grid">
        ${card("Source Rule", "Old Splash is source evidence only. This preview is rebuilt from purified OS memory.")}
        ${card("Signals", "APP_SPLASH_SIGNAL_001 through APP_SPLASH_SIGNAL_004 are UI-state signals only.")}
        ${card("Boundary", "No Home / Menu, no registration, no Client Room, no Firebase, no old routes.")}
        ${card("Prompt", "PROMPT_ASSET_015 APP_SURFACE_SCREEN_REBIRTH_PROMPT")}
      </section>`,
    ),
  "/os/owner": () =>
    routeShell(
      "Owner Domain",
      "مجال المالك يحتوي DNA Vault كمصدر دستوري، ولا ينفذ ولا يهاجر runtime قديم.",
      `<section class="grid">
        ${card("DNA Vault", "يجيب: ما الذي يجب أن يوجد؟ ما الذي يجوز أن يوجد؟ ما الذي يجب إزالته أو اصطفافه؟")}
        ${card("Current Constitutional State", "Owner Domain + Constitutional Memory Domain + Strategic Planning Room + Sovereign Construction Studio.")}
        ${card("Owner Boundary", "المالك يراجع ويعتمد. لا يوجد هنا Legal أو Technical Operations أو Residential Domain.")}
      </section>`,
    ),
  "/os/owner/dna-vault": () => {
    const signals = osMemorySummary.latestSignals
      .map(([id, name, summary]) => card(id, summary, name))
      .join("");

    return routeShell(
      "DNA Vault",
      "مصدر السلطة الدستورية وتسلسل البناء داخل Mental Smile OS.",
      `<section class="grid">
        ${card("Current Source Authority", osMemorySummary.sourceAuthority.name, osMemorySummary.sourceAuthority.status)}
        ${card("Foundation Status", osMemorySummary.sourceAuthority.foundationStatus)}
        ${card("Authority Boundary", osMemorySummary.sourceAuthority.boundary)}
        ${card("Next Approved Build Package", osMemorySummary.currentPendingPackage)}
      </section>
      <h2 class="section-title">Latest Signals Summary</h2>
      <section class="grid">${signals}</section>`,
    );
  },
  "/os/memory": () => {
    const memoryAreas = osMemorySummary.availableMemoryAreas
      .map((area) => `<li>${area}</li>`)
      .join("");

    const rows = osMemorySummary.promptAssets
      .map(
        ([id, name, classification, parentPrompt, status, lineage]) => `
          <tr>
            <td>${id}</td>
            <td>${name}</td>
            <td>${classification}</td>
            <td>${parentPrompt}</td>
            <td>${status}</td>
            <td>${lineage}</td>
          </tr>
        `,
      )
      .join("");

    return routeShell(
      "Constitutional Memory Domain",
      "طبقة الاستمرارية والنسب. تحفظ وتربط وتتحقق، لكنها لا تحكم ولا تنفذ.",
      `<section class="grid">
        ${card("Prompt Memory", "PROMPT_ASSET_001 through PROMPT_ASSET_015 are visible in runtime.")}
        ${card("Latest Prompt Asset", osMemorySummary.latestPromptAsset)}
      </section>
      <section class="panel">
        <h3>Available Memory Areas</h3>
        <ul class="compact-list">${memoryAreas}</ul>
      </section>
      <section class="panel">
        <h3>Prompt Assets Registry View</h3>
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>Prompt ID</th>
                <th>Prompt Name</th>
                <th>Classification</th>
                <th>Parent Prompt</th>
                <th>Status</th>
                <th>Lineage</th>
              </tr>
            </thead>
            <tbody>${rows}</tbody>
          </table>
        </div>
      </section>`,
    );
  },
  "/os/strategic-planning": () =>
    routeShell(
      "Strategic Planning Room",
      "تحويل رؤية المالك إلى استراتيجية بناء نظيفة بدون تنفيذ تقني.",
      `<section class="grid">
        ${card("Current Strategic Packages", "Residential Domain Build Strategy V1.")}
        ${card("Residential Build Strategy", "جاهزة كاستراتيجية ومراجعة فقط. لا تبني Residential Domain.")}
        ${card("Source Classification Status", "USE_AFTER_PURIFICATION, REBUILD_FROM_SCRATCH, REMOVE, NOT_RELEVANT, MISSING_CREATE_NEW.")}
        ${card("Pending Owner Reviews", "Owner review required before أي بناء أو تنفيذ.")}
      </section>`,
    ),
  "/os/construction-studio": () => {
    const tools = osMemorySummary.constructionStudioTools
      .map((tool) => card(tool, "Shortcut placeholder only. No credentials, no secrets, no runtime execution."))
      .join("");

    return routeShell(
      "Sovereign Construction Studio",
      "مساحة البناء السيادي للحزم المعتمدة، وليست Technical Operations.",
      `<section class="grid">
        ${card("Construction Workbench", "Placeholder index موجود داخل app/owner/construction-workbench.")}
        ${card("Current Build Package", osMemorySummary.currentPendingPackage)}
        ${card("Current Extraction Packages", "Client Room Visual System Extraction records.")}
        ${card("Tool Registry", "Construction tool list displayed from OS memory summary.")}
      </section>
      <h2 class="section-title">Tool Shortcuts</h2>
      <section class="grid">${tools}</section>`,
    );
  },
};

function currentRoute() {
  const hash = window.location.hash.replace("#", "");
  return routes[hash] ? hash : "/os";
}

function render() {
  const route = currentRoute();
  document.querySelectorAll(".nav a").forEach((link) => {
    link.classList.toggle("active", link.dataset.route === route);
  });
  document.getElementById("app").innerHTML = routes[route]();
}

window.addEventListener("hashchange", render);
if (!window.location.hash) {
  window.location.hash = "/os";
}
render();
