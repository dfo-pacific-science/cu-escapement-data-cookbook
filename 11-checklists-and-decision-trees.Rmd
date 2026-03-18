# Checklists and Decision Trees

## Annual release checklist

### A. Run control

- [ ] latest annual inputs staged and logged
- [ ] annual/static/conditional file inventory completed
- [ ] hard-coded file-name expectations checked
- [ ] run log, decision log, and QC summary initialized

### B. Output-layer definition

- [ ] required output layers declared (`cu_trend`, `cu_abundance`, pop, historical context as needed)
- [ ] `site_selection_layers.csv` completed
- [ ] selection rules documented separately for each layer
- [ ] zero-site or zero-CU edge cases reviewed explicitly

### C. Intermediate QC artifacts

- [ ] matching / decoder / decomposition artifacts reviewed
- [ ] exception register updated and reviewer-facing
- [ ] manual overrides or suppressions explained
- [ ] expected non-equality patterns explained where relevant
- [ ] intentional `NA` patterns explained where relevant

### D. Final bundle integrity

- [ ] CU output exists and uniqueness passes `(CU_ID, Year)`
- [ ] pop/context outputs exist when required
- [ ] required core columns are present
- [ ] year coverage is as expected
- [ ] prior-release diffs reviewed and explained
- [ ] `cu_timeseries` and `wsp_metric_specs` align on CU set
- [ ] cyclic benchmark file present when required

### E. Metadata and specs readiness

- [ ] `cu_metadata.csv` updated or intentionally deferred with owner noted
- [ ] `wsp_metric_specs.csv` updated
- [ ] `codes.csv` reviewed for new or drifted values
- [ ] unresolved placeholders (`TBD`, `TEXT`) reviewed
- [ ] provenance, reviewer, and version notes captured

### F. Release / handoff

- [ ] intermediate QC artifacts are linked from `qc-summary.md`
- [ ] consumer-specific exports are marked as derived outputs
- [ ] reviewer sign-off recorded

## Pop-level key guidance

Do **not** assume one universal pop key across species.

Use the key that matches the method, for example:

- `Pop_ID + Year`,
- `CU_ID + Pop_Name + Year`, or
- a species-specific stream/timing key for intermediate processing.

## Decision tree: do you need multiple selection layers?

Start:

- Are you producing only one CU series with one consistent site set?
  - Yes -> one declared layer may be enough
  - No -> continue
- Do different outputs serve different purposes (trend, abundance, pop, historical context)?
  - Yes -> declare separate output layers and selection specs
  - No -> document why one layer is sufficient
- Does any required layer end up with zero included sites or unresolved conflicts?
  - Yes -> stop and escalate
  - No -> proceed to record selection

## Decision tree: choose estimation pattern

Start:

- Do you have near-complete direct site coverage with stable inclusion?
  - Yes -> **Direct-sum pattern**
  - No -> continue
- Do you have defensible expansion factors from indicator systems?
  - Yes -> **Indicator expansion pattern**
  - No -> continue
- Do you have model/run-reconstruction inputs and method support?
  - Yes -> **Run reconstruction / model-based pattern**
  - No -> **Escalate to custom method design**

## Decision tree: is the bundle ready for downstream status work?

- Does `cu_timeseries` pass uniqueness and year-range checks?
  - No -> fix the CU series first
  - Yes -> continue
- Are `SpnForAbd_*` and `SpnForTrend_*` semantics documented?
  - No -> stop and document them
  - Yes -> continue
- Does `wsp_metric_specs` align to the same CU set?
  - No -> fix spec alignment
  - Yes -> continue
- Are cyclic benchmark cases supplied with a benchmark file?
  - No -> stop and add the file
  - Yes -> bundle is ready for status/tool handoff

## Top failure modes and fixes

- **ID mismatch across files**
  - Fix: update the crosswalk, rerun joins, and recheck keys.
- **Unexpected year truncation**
  - Fix: inspect start-year rules and source coverage.
- **Large retrospective shifts**
  - Fix: compare input changes versus method changes; isolate the source of the delta.
- **Schema drift in output columns**
  - Fix: run required-column checks and normalize structure before release.
- **Unnamed first column from CSV row names**
  - Fix: drop blank-column headers before downstream processing.
- **Bundle looks clean but meaning is unclear**
  - Fix: strengthen metadata notes and field semantics before handoff.

## Minimum reusable QC snippet

```r
x <- read.csv("cu_timeseries.csv")
if ("" %in% names(x)) x <- x[, names(x) != "", drop = FALSE]

stopifnot(!any(duplicated(x[c("CU_ID", "Year")])))
req <- c("CU_ID", "CU_Name", "Year", "SpnForAbd_Wild", "SpnForTrend_Wild")
stopifnot(all(req %in% names(x)))
```

