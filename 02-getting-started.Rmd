# Getting Started

## Quick orientation

Use this cookbook to keep the **human-facing contract** straight while the
species prep repos do the heavy lifting.

This repo tells you:

- what you are producing,
- which intermediate artifacts must be reviewed,
- what belongs in the final CU/WSP bundle, and
- what can be treated as a derived handoff for another system.

## The deliverable in one sentence

For most runs, the core analytical bundle is:

- `cu_timeseries`
- `wsp_metric_specs`
- optional `wsp_cyclic_benchmarks`
- recommended `cu_metadata`

Keep these human-readable sidecars with the bundle:

- `run-log.md`
- `decision-log.md`
- `qc-summary.md`
- `metadata_notes.md`

## One bundle, two layers

### Analytical layer

This is the day-to-day contract used by analysts and downstream WSP tooling.
Keep it small and explicit.

### Exchange layer

Wrap the analytical bundle in a Salmon Data Package only when you need a clean
release or handoff. Consumer-specific exports such as SPSR bridge files should
be treated as **derived outputs**, not as the canonical source of truth.

## Keep these data layers separate

| Layer | Typical files | Why it exists |
|---|---|---|
| Source inputs | annual extracts, lookups, static crosswalks | raw material for the run |
| Selection + processing intermediates | matching checks, decomposition tables, CU-specific prep tables | prove the method behaved as expected |
| Release tables | `cu_timeseries`, optional `pop_timeseries` | main analytical outputs |
| Status bundle tables | `wsp_metric_specs`, optional `wsp_cyclic_benchmarks`, optional `published_integrated_statuses` | supports WSP metric and rapid-status workflows |
| Exchange / consumer bridges | Salmon Data Package, derived `cuyear.csv`, derived `cu_metadata.csv` | packaging and system-specific handoff |

The main trap to avoid is pretending there is one flat "selected dataset" that
feeds every output. In practice, species workflows often use **different data
layers for different purposes**.

## Repository map (what each repo is for)

### Core cookbook

- `dfo-pacific-science/cu-escapement-data-cookbook`
  - Purpose: contract, templates, examples, QA

### Species prep repos (primary execution)

- `BronwynMacDonald/FRSK-WSPDataPrep`
  - Fraser Sockeye CU + pop prep
- `BronwynMacDonald/FRCo-WSPDataPrep`
  - Interior Fraser Coho CU + pop prep
- `BronwynMacDonald/FRCm-WSPDataPrep`
  - Lower Fraser Chum prep
- `BronwynMacDonald/FRPink-WSPDataPrep`
  - Fraser Pink prep

### Source-method repos (context and reusable structures)

- `code/Data-Standards`
- `code/Metadata-Questionnaire-CU-Series`
- `library/wsp-fisheries/sources.yaml`

### Downstream metric/status repos

- `https://github.com/Pacific-salmon-assess/WSP-Metrics-Pkg`
- `https://github.com/SOLV-Code/WSP-Rapid-Status-WorkedExamples`

## Standard prep-repo folders

Most species repos use:

- `DATA_IN/` — annual inputs and staged source extracts
- `DATA_LOOKUP_FILES/` — static lookups and crosswalks
- `DATA_PROCESSING/` — intermediate processing tables
- `DATA_TRACKING/` — matching checks and review artifacts
- `DATA_OUT/` — final species outputs
- `CODE/` — executable scripts

Treat `DATA_PROCESSING/` and `DATA_TRACKING/` as part of the deliverable, not as
throwaway scratch.

## Before first run

### Install baseline R packages

```r
install.packages(c(
  "dplyr", "tidyr", "stringr", "forcats", "Hmisc", "mgsub", "tidyverse"
))
```

Some pipelines can run with less, but Sockeye and Coho paths often assume a
broader tidyverse-style setup.

### Build a file inventory up front

For each required input, record:

- file name,
- annual/static/conditional status,
- source contact or repo,
- pull date,
- expected year range,
- whether the script expects a **hard-coded file name**.

### Hard-coded filename warning

Several production scripts read literal file names. Before you run anything,
decide whether you will:

1. rename the staged input to the expected name, or
2. edit the script path.

Either choice is fine if it is logged. Quietly doing neither is how you lose an
afternoon.

## Suggested run graph

1. verify source files and identifiers,
2. declare the output layers you need,
3. select sites/surveys for each layer,
4. select records and apply approved fixes,
5. process values and review intermediate QC artifacts,
6. estimate `cu_timeseries` and any supporting outputs,
7. assemble metadata + metric specs,
8. optionally wrap the release in a package or consumer bridge.

## Minimum outputs to plan for

Even a straightforward annual update should usually leave you with:

- one canonical `cu_timeseries` table,
- any needed supporting tables (`pop_timeseries`, historical context layer),
- a populated `wsp_metric_specs` file,
- intermediate QC artifacts reviewed and logged,
- an exception register,
- short run/decision/QC notes.

## Pre-run checklist (required)

- [ ] Confirm repo access for the required species workflow(s)
- [ ] Confirm latest annual files are staged in `DATA_IN/`
- [ ] Confirm lookup files/crosswalks are current
- [ ] Record annual vs static vs conditional inputs
- [ ] Check scripts for hard-coded file names or paths
- [ ] Confirm target run year and release label
- [ ] Select the matching Pattern Card (Chapter 9)
- [ ] Open `run-log.md`, `decision-log.md`, and `qc-summary.md`
- [ ] Name reviewer(s) for sign-off before you start editing outputs

## Before moving to Step 1

You should know:

- which outputs are required (`cu_timeseries`, pop/context tables, status bundle),
- which files are annual vs static,
- where intermediate QC artifacts will be written, and
- who will review the run before release.

