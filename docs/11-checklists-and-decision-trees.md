# Checklists and Decision Trees

## Annual release checklist

### A. Data + run control

- [ ] latest annual inputs staged and logged
- [ ] pipeline + script version recorded
- [ ] run log + decision log initialized

### B. Output integrity

- [ ] CU output exists and key uniqueness passes `(CU_ID, Year)`
- [ ] Pop output exists and key checks pass for the selected schema
- [ ] required core columns are present
- [ ] expected year range is present

### C. Consistency checks

- [ ] prior-release diff reviewed and explained
- [ ] major missingness changes explained
- [ ] manual overrides/exceptions documented

### D. Metadata + metrics readiness

- [ ] metadata package updated (`metadata_cu`, `metric_specs`, `codes`)
- [ ] metric-input fields align with selected data series
- [ ] unresolved issues assigned owner + follow-up date

## Pop-level key guidance (important)

Do **not** assume a single universal pop key across species.

- Sockeye/Coho may have repeated `Pop_ID` across names or contexts.
- Use a composite key appropriate to pipeline output (e.g.,
  `CU_ID + Pop_Name + Year`) unless your species method defines otherwise.

## Decision tree: choose estimation pattern

Start:

- Do you have near-complete direct site coverage with stable inclusion?
  - Yes → **Direct-sum pattern**
  - No → continue
- Do you have defensible expansion factors from indicator systems?
  - Yes → **Indicator expansion pattern**
  - No → continue
- Do you have model/run-reconstruction inputs and method support?
  - Yes → **Run reconstruction/model-based pattern**
  - No → **Escalate to custom method design**

## Decision tree: infill vs no infill

- Is infill policy already approved for this CU/species path?
  - No → do not infill; escalate for policy decision
  - Yes → continue
- Are infilled years and method documented and reproducible?
  - No → stop and document before release
  - Yes → apply and flag affected rows

## Top failure modes and fixes

- **ID mismatch across files**
  - Fix: update/confirm crosswalk, rerun joins, recheck keys.
- **Unexpected year truncation**
  - Fix: inspect start-year rules and source file coverage.
- **Large retrospective shifts**
  - Fix: compare input changes vs method changes; isolate source of delta.
- **Schema drift in output columns**
  - Fix: run required-column checks and normalize structure.
- **Unnamed first column from CSV row names**
  - Fix: drop blank-column headers before downstream processing.

## Minimum reusable QC snippet

```r
x <- read.csv("DATA_OUT/<cu-file>.csv")
if ("" %in% names(x)) x <- x[, names(x) != "", drop = FALSE]

stopifnot(!any(duplicated(x[c("CU_ID", "Year")])))
req <- c("CU_ID", "CU_Name", "Year", "SpnForAbd_Total", "SpnForTrend_Total")
stopifnot(all(req %in% names(x)))
```
