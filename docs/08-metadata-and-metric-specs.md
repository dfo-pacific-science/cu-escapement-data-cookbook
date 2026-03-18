# Step 6: Metadata and Metric Specifications

## Objective

Produce the metadata and metric-spec layer that makes the CU series
understandable, reviewable, and reusable.

## Key rule: keep one source of truth

Use one canonical worksheet or flat-file source for metadata authoring, then
derive the export files from it. Do not hand-edit multiple near-duplicate files
and hope they stay aligned.

## Core files in this layer

| File | Purpose |
|---|---|
| `cu_metadata.csv` | CU context, method notes, provenance, interpretation |
| `wsp_metric_specs.csv` | metric settings, benchmark fields, CU-level status config |
| `codes.csv` | controlled vocabularies and permitted values |
| `metadata_notes.md` | unresolved items, ownership, caveats |
| `metadata_field_definitions.csv` | recommended field dictionary for maintainers |
| `published_integrated_statuses.csv` | optional comparison input |

## What `cu_metadata.csv` should carry

At minimum, keep fields that answer these questions:

1. **What CU is this?**
2. **What data sources and method produced the series?**
3. **What interventions or caveats affect interpretation?**
4. **Who reviewed it, when, and with which versioned inputs?**

Useful field groups include:

- CU identity and aliases,
- source systems and year coverage,
- estimation mode,
- benchmark-compatibility notes,
- intervention and enhancement notes,
- review status and provenance.

## What `wsp_metric_specs.csv` should carry

This file is the machine-facing spec for downstream metric/status tools.

At minimum, make the metric choices explicit for each CU:

- identity/context fields (`CU_ID`, `CU_Name`, `Group`),
- abundance / trend metric selection,
- generation and smoothing settings,
- cyclic benchmark flags,
- lower and upper benchmarks,
- notes on disabled or non-applicable metrics.

If a metric is enabled, the supporting benchmark fields should be present and
interpretable.

## Controlled vocabularies belong in `codes.csv`

Do not bury permitted values in prose. Record them.

A minimal code-list structure is:

- `field_name`
- `code`
- `label`
- `definition`
- `status` (`current`, `proposed`, `deprecated`)
- `notes`

This is especially helpful for metric types, verification states,
intervention flags, and any controlled status labels.

## Spreadsheet / Google Sheet normalization rules

If metadata is maintained in a sheet, document the export rules explicitly:

- retain a raw export,
- exclude `README` or instruction tabs from normalized exports,
- use one approved delimiter for repeatable values,
- validate that multi-value fields do not mix delimiters,
- flag placeholder text such as `TBD` or `TEXT` before release.

The point is not bureaucracy. It is avoiding silent cell-format nonsense.

## Minimum validation script

```r
m <- read.csv("cu_metadata.csv")
s <- read.csv("wsp_metric_specs.csv")

stopifnot(!any(names(m) == ""))
stopifnot(!any(names(s) == ""))
stopifnot(all(c("CU_ID", "CU_Name", "Species") %in% names(m)))
stopifnot(all(c("CU_ID", "CU_Name") %in% names(s)))
stopifnot(!any(is.na(m$CU_ID) | m$CU_ID == ""))
stopifnot(!any(duplicated(m["CU_ID"])))
stopifnot(setequal(unique(m$CU_ID), unique(s$CU_ID)))
```

Add stricter field checks for your release, but at minimum catch blank columns,
missing CU IDs, and CU/spec mismatches between files.

## Metadata QC bundle

Before sign-off, produce a short review pack that covers:

- completeness summary,
- unresolved placeholder list,
- verification-pending list,
- stale-status or stale-method flags,
- any unexpected new code values.

## Required outputs from Step 6

- completed `cu_metadata.csv`
- completed `wsp_metric_specs.csv`
- `codes.csv`
- `metadata_notes.md`
- optional field-definition or summary outputs used by reviewers

