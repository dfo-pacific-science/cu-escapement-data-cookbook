# Introduction

## What this guide is

A task-first cookbook for building CU-level escapement time series and the
metadata, benchmarks, and metric settings needed to run WSP status metrics.
Where the source reports explain what was done, this guide shows what to do
next, with checklists, decision points, and runnable examples.

## Who this is for

- Area data managers and analysts preparing WSP status updates or Fisheries Act
  reporting
- Biologists and program leads reviewing CU inputs, benchmarks, and metric
  settings
- Analysts onboarding to existing CU workflows who need a single, current
  reference

## What you will produce

- A CU-level escapement time series (wild/total as needed) with clear inclusion
  rules, processing steps, and estimation notes
- A metadata package that documents CU context, dataset lineage, benchmarks, and
  WSP metric settings (aligned to a Salmon Data Package, an open format for
  sharing tabular data with clear code lists and definitions)
- A repeatable run of WSP status metrics using the canonical metrics engine
  (`WSP-Metrics-Pkg`) and decision tree

## How to use this cookbook

- New build: follow chapters in order—getting started → five workflow steps →
  metadata and metric documentation → validation.
- Annual update: jump to the checklists and decision trees, then re-run the
  workflow steps affected by new data.
- Review: use the metadata and metric chapters to verify that required fields
  and code lists are complete and consistent.

## Five-step workflow at a glance

1. **Source data verification** — confirm sources, extract latest data, verify
   identifiers and classifications.
2. **Site/survey selection** — decide which sites/surveys to include based on
   quality, enhancement level, and aggregation rules.
3. **Record selection** — choose the best estimate per CU-year (or survey
   record) and resolve conflicts.
4. **Record processing** — infill, scale, adjust for enhancement, and harmonize
   units.
5. **Estimation** — aggregate to CU, document methods, and prepare inputs for
   WSP metrics.

## Two parallel tracks

- **Build the CU time series** (Chapters 3–7): the five-step workflow derived
  from the Data Standards report.
- **Document metadata and metric specs** (Chapter 8): fields and code lists
  distilled from the Metadata Questionnaire report to make outputs reviewable
  and machine-checked.

## Reuse and code packages

- Metrics engine: prefer calling `WSP-Metrics-Pkg` for metric calculations and
  the rapid-status decision tree instead of re-implementing formulas.
- Data processing helpers: reuse functions from the Data Standards code (e.g.,
  site-selection text generation) and generalize into config-driven scripts.
- Metadata helpers: ingest and summarize questionnaire/coverage data using the
  patterns from the metadata questionnaire code base.

## Conventions and vocabularies

- Controlled vocabularies (e.g., estimate type, enhancement level, verification
  status) should map to stable code lists; treat them as canonical picklists for
  interoperability.
- The DFO Salmon Ontology supplies shared terms and identifiers; use it for
  meaning, not for day-to-day data storage.
- Keep everything CSV-first; when possible, align column definitions and
  picklists to a Salmon Data Package so outputs can be validated automatically.
