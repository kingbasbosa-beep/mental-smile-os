const admin = require("firebase-admin");
const {BigQuery} = require("@google-cloud/bigquery");
const {logger} = require("firebase-functions");
const {onSchedule} = require("firebase-functions/v2/scheduler");

admin.initializeApp();

const db = admin.firestore();
const bigquery = new BigQuery();

const ANALYTICS_COLLECTION = "analytics_summaries";
const PERIOD = "hourly";
const VERSION = 1;
const ALLOWED_MODULES = [
  "family_support",
  "recovery_support",
  "specialists",
  "centers",
  "library",
];
const ALLOWED_CONTEXTS = [
  "general",
  "family_support",
  "recovery_support",
];

exports.writeAnalyticsSummariesHourly = onSchedule(
  {
    schedule: "0 * * * *",
    timeZone: "Etc/UTC",
    timeoutSeconds: 540,
    memory: "256MiB",
    region: "us-central1",
  },
  async () => {
    const dataset = toTrimmedString(process.env.ANALYTICS_BQ_DATASET);
    const location = toTrimmedString(process.env.ANALYTICS_BQ_LOCATION);
    const projectId =
      process.env.GCLOUD_PROJECT ||
      process.env.GCP_PROJECT ||
      process.env.PROJECT_ID;

    if (!projectId || !dataset || !location) {
      logger.error("Analytics summary writer configuration is incomplete.", {
        projectIdPresent: Boolean(projectId),
        datasetPresent: Boolean(dataset),
        locationPresent: Boolean(location),
        expectedEnv: [
          "ANALYTICS_BQ_DATASET",
          "ANALYTICS_BQ_LOCATION",
        ],
      });
      return;
    }

    const windowEnd = truncateToHour(new Date());
    const windowStart = new Date(windowEnd.getTime() - 60 * 60 * 1000);
    const tableSuffixes = buildTableSuffixes(windowStart, windowEnd);
    const tablePath = buildTablePath(projectId, dataset);

    logger.info("Starting analytics summary writer.", {
      period: PERIOD,
      windowStart: windowStart.toISOString(),
      windowEnd: windowEnd.toISOString(),
      tablePath,
      tableSuffixes,
    });

    try {
      const [topModulesRows, topPathsRows, chatContextRows] = await Promise.all([
        fetchTopEntryModules({
          tablePath,
          tableSuffixes,
          windowStart,
          windowEnd,
          location,
        }),
        fetchTopSelectedPaths({
          tablePath,
          tableSuffixes,
          windowStart,
          windowEnd,
          location,
        }),
        fetchChatOpensByContext({
          tablePath,
          tableSuffixes,
          windowStart,
          windowEnd,
          location,
        }),
      ]);

      logger.info("Analytics queries completed.", {
        topEntryModulesRows: topModulesRows.length,
        topSelectedPathsRows: topPathsRows.length,
        chatContextRows: chatContextRows.length,
      });

      const generatedAt = admin.firestore.Timestamp.now();
      const windowStartTs = admin.firestore.Timestamp.fromDate(windowStart);
      const windowEndTs = admin.firestore.Timestamp.fromDate(windowEnd);

      const topEntryModulesDoc = {
        summaryName: "top_entry_modules",
        period: PERIOD,
        generatedAt,
        windowStart: windowStartTs,
        windowEnd: windowEndTs,
        version: VERSION,
        items: topModulesRows.map((row) => ({
          key: row.key,
          count: row.count,
        })),
      };

      const topSelectedPathsDoc = {
        summaryName: "top_selected_paths",
        period: PERIOD,
        generatedAt,
        windowStart: windowStartTs,
        windowEnd: windowEndTs,
        version: VERSION,
        items: topPathsRows.map((row) => ({
          key: row.key,
          module: row.module,
          path: row.path,
          count: row.count,
        })),
      };

      const chatTotal = chatContextRows.reduce(
        (sum, row) => sum + row.count,
        0,
      );
      const chatOpensByContextDoc = {
        summaryName: "chat_opens_by_context",
        period: PERIOD,
        generatedAt,
        windowStart: windowStartTs,
        windowEnd: windowEndTs,
        version: VERSION,
        total: chatTotal,
        items: chatContextRows.map((row) => ({
          context: row.context,
          count: row.count,
        })),
      };

      await Promise.all([
        writeSummaryDoc("top_entry_modules", topEntryModulesDoc),
        writeSummaryDoc("top_selected_paths", topSelectedPathsDoc),
        writeSummaryDoc("chat_opens_by_context", chatOpensByContextDoc),
      ]);

      logger.info("Analytics summaries written successfully.", {
        collection: ANALYTICS_COLLECTION,
        documentIds: [
          "top_entry_modules",
          "top_selected_paths",
          "chat_opens_by_context",
        ],
      });
    } catch (error) {
      logger.error("Analytics summary writer failed.", {
        message: error instanceof Error ? error.message : String(error),
      });
    }
  },
);

async function fetchTopEntryModules({
  tablePath,
  tableSuffixes,
  windowStart,
  windowEnd,
  location,
}) {
  const query = `
    SELECT
      module AS key,
      COUNT(1) AS count
    FROM (
      SELECT
        (
          SELECT ep.value.string_value
          FROM UNNEST(event_params) ep
          WHERE ep.key = 'module'
          LIMIT 1
        ) AS module
      FROM \`${tablePath}\`
      WHERE _TABLE_SUFFIX IN UNNEST(@tableSuffixes)
        AND event_name = 'module_entry'
        AND TIMESTAMP_MICROS(event_timestamp) >= @windowStart
        AND TIMESTAMP_MICROS(event_timestamp) < @windowEnd
    )
    WHERE module IN UNNEST(@allowedModules)
    GROUP BY key
    ORDER BY count DESC, key ASC
    LIMIT 5
  `;

  const rows = await runQuery({
    query,
    location,
    params: {
      tableSuffixes,
      windowStart,
      windowEnd,
      allowedModules: ALLOWED_MODULES,
    },
  });

  return rows.map((row) => ({
    key: toTrimmedString(row.key),
    count: toInteger(row.count),
  }));
}

async function fetchTopSelectedPaths({
  tablePath,
  tableSuffixes,
  windowStart,
  windowEnd,
  location,
}) {
  const query = `
    SELECT
      CONCAT(module, ' -> ', path) AS key,
      module,
      path,
      COUNT(1) AS count
    FROM (
      SELECT
        (
          SELECT ep.value.string_value
          FROM UNNEST(event_params) ep
          WHERE ep.key = 'module'
          LIMIT 1
        ) AS module,
        (
          SELECT ep.value.string_value
          FROM UNNEST(event_params) ep
          WHERE ep.key = 'path'
          LIMIT 1
        ) AS path
      FROM \`${tablePath}\`
      WHERE _TABLE_SUFFIX IN UNNEST(@tableSuffixes)
        AND event_name = 'path_selected'
        AND TIMESTAMP_MICROS(event_timestamp) >= @windowStart
        AND TIMESTAMP_MICROS(event_timestamp) < @windowEnd
    )
    WHERE module IS NOT NULL
      AND module != ''
      AND path IS NOT NULL
      AND path != ''
    GROUP BY key, module, path
    ORDER BY count DESC, key ASC
    LIMIT 5
  `;

  const rows = await runQuery({
    query,
    location,
    params: {
      tableSuffixes,
      windowStart,
      windowEnd,
    },
  });

  return rows.map((row) => ({
    key: toTrimmedString(row.key),
    module: toTrimmedString(row.module),
    path: toTrimmedString(row.path),
    count: toInteger(row.count),
  }));
}

async function fetchChatOpensByContext({
  tablePath,
  tableSuffixes,
  windowStart,
  windowEnd,
  location,
}) {
  const query = `
    SELECT
      entry_context AS context,
      COUNT(1) AS count
    FROM (
      SELECT
        (
          SELECT ep.value.string_value
          FROM UNNEST(event_params) ep
          WHERE ep.key = 'entry_context'
          LIMIT 1
        ) AS entry_context
      FROM \`${tablePath}\`
      WHERE _TABLE_SUFFIX IN UNNEST(@tableSuffixes)
        AND event_name = 'chat_opened'
        AND TIMESTAMP_MICROS(event_timestamp) >= @windowStart
        AND TIMESTAMP_MICROS(event_timestamp) < @windowEnd
    )
    WHERE entry_context IN UNNEST(@allowedContexts)
    GROUP BY context
    ORDER BY count DESC, context ASC
  `;

  const rows = await runQuery({
    query,
    location,
    params: {
      tableSuffixes,
      windowStart,
      windowEnd,
      allowedContexts: ALLOWED_CONTEXTS,
    },
  });

  return rows.map((row) => ({
    context: toTrimmedString(row.context),
    count: toInteger(row.count),
  }));
}

async function runQuery({query, params, location}) {
  const [job] = await bigquery.createQueryJob({
    query,
    params,
    location,
    useLegacySql: false,
  });
  const [rows] = await job.getQueryResults();
  return rows;
}

function buildTablePath(projectId, dataset) {
  const safeProject = sanitizeIdentifier(projectId);
  const safeDataset = sanitizeIdentifier(dataset);
  return `${safeProject}.${safeDataset}.events_*`;
}

function sanitizeIdentifier(value) {
  const trimmed = toTrimmedString(value);
  if (!/^[A-Za-z0-9_:-]+$/.test(trimmed)) {
    throw new Error(`Invalid BigQuery identifier: ${value}`);
  }
  return trimmed;
}

function buildTableSuffixes(windowStart, windowEnd) {
  const suffixes = new Set([
    formatDateForSuffix(windowStart),
    formatDateForSuffix(new Date(windowEnd.getTime() - 1)),
  ]);
  return Array.from(suffixes);
}

function formatDateForSuffix(date) {
  const year = date.getUTCFullYear();
  const month = `${date.getUTCMonth() + 1}`.padStart(2, "0");
  const day = `${date.getUTCDate()}`.padStart(2, "0");
  return `${year}${month}${day}`;
}

function truncateToHour(date) {
  return new Date(
    Date.UTC(
      date.getUTCFullYear(),
      date.getUTCMonth(),
      date.getUTCDate(),
      date.getUTCHours(),
      0,
      0,
      0,
    ),
  );
}

async function writeSummaryDoc(docId, payload) {
  await db.collection(ANALYTICS_COLLECTION).doc(docId).set(payload, {
    merge: true,
  });
}

function toTrimmedString(value) {
  return String(value ?? "").trim();
}

function toInteger(value) {
  if (typeof value === "number") return Math.trunc(value);
  const parsed = Number(value);
  return Number.isFinite(parsed) ? Math.trunc(parsed) : 0;
}
