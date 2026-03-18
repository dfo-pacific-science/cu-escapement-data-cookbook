# Worked Examples

This chapter focuses on **reviewable cases**, not just runnable scripts.

## Worked Example A — Fraser Sockeye gap-fill and layer review

### Scenario

You received updated Sockeye annual inputs and need refreshed CU outputs. The
main review question is not merely "did the script run?" but:

> do the trend layer, abundance layer, and documented exceptions still make
> sense?

### Run

```bash
cd FRSK-WSPDataPrep
Rscript CODE/Prep4_CleanedFlatFile_Fraser_Sk_KDEdits2024.R
```

### Review before release

1. Inspect `DATA_TRACKING/FraserSockeye_MatchingCheck.csv`.
2. Review `DATA_TRACKING/Sites not in CUs.csv`.
3. Check CU-specific prep tables in `DATA_TRACKING/FraserSockeyePrep/`.
4. Update `exception-register.csv` for any suppressions, timing overrides, or
   manual fills used in the run.
5. Confirm you can explain which stream set supports `cu_trend` and which
   supports `cu_abundance`.

### Minimum QC

```r
cu <- read.csv("DATA_OUT/Cleaned_FlatFile_ByCU_FraserSockeye.csv")
stopifnot(!any(duplicated(cu[c("CU_ID", "Year")])))
stopifnot(all(c("SpnForAbd_Total", "SpnForTrend_Total") %in% names(cu)))
```

### What to write in the run notes

- any hard-coded file-name handling,
- any CU-specific method family that changed,
- any reviewer concern raised by the tracking files.

---

## Worked Example B — Interior Fraser Coho decomposition review

### Scenario

You need updated Coho CU and pop outputs. The main review question is:

> is the split between the CU layer and the broader pop layer still intentional,
> and do the natural/hatchery decomposition tables support the final outputs?

### Run

```bash
cd FRCo-WSPDataPrep
Rscript CODE/Prep5_CleanedFlatFile_Fraser_Coho.R
```

### Review before release

1. Inspect `DATA_PROCESSING/Calc.Nat Table for <CU>.csv` for one or more key
   CUs.
2. Review `DATA_PROCESSING/All IFC CUs BY Table_EC.max=NA_infill=FALSE.csv`.
3. Confirm the pop output is intentionally broader than the CU output.
4. Record how `Final.Estimate.Type == "NO"` was handled.
5. Update the exception register if any naming or estimate-type patches were
   required.

### Minimum QC

```r
cu <- read.csv("DATA_OUT/Cleaned_FlatFile_ByCU_FraserCoho.csv")
stopifnot(!any(duplicated(cu[c("CU_ID", "Year")])))
stopifnot(min(cu$Year, na.rm = TRUE) >= 1998)

pop <- read.csv("DATA_OUT/Cleaned_FlatFile_ByPop_FraserCoho.csv")
stopifnot(all(c("Pop_ID", "Pop_Name", "Year") %in% names(pop)))
```

### What to write in the run notes

- whether the active path used infill,
- whether any tributary names needed crosswalk repair,
- whether the broader pop layer was reviewed and accepted explicitly.

---

## Worked Example C — Lower Fraser Chum composition review

### Scenario

You need current Chum CU and pop outputs. The main review question is:

> can you explain why the CU totals and pop sums are not the same thing?

### Run

```bash
cd FRCm-WSPDataPrep
Rscript "CODE/Prep7_Create Fraser Chum2.R"
```

### Review before release

1. Drop any unnamed first columns before QC.
2. Confirm the CU layer reflects the intended Harrison treatment.
3. Confirm the pop layer retains the expected decomposition logic.
4. Write a plain-language note explaining the expected CU/pop non-equality.
5. Record any special handling in `exception-register.csv` if a manual patch was
   required.

### Minimum QC

```r
drop_unnamed <- function(d) d[, names(d) != "", drop = FALSE]

cu <- drop_unnamed(read.csv("DATA_OUT/Cleaned_FlatFile_ByCU_FraserChum.csv"))
stopifnot(!any(duplicated(cu[c("CU_ID", "Year")])))

pop <- drop_unnamed(read.csv("DATA_OUT/Cleaned_FlatFile_ByPop_FraserChum_all.csv"))
stopifnot(all(c("Pop_ID", "Year") %in% names(pop)))
```

### What to write in the run notes

- how Harrison and Squawkum were handled,
- why pop sums should not be expected to reproduce CU totals,
- any year-range truncation relative to the previous release.

---

## Worked Example D — Fraser Pink historical transition review

### Scenario

You need updated Pink outputs. The main review question is:

> does the release still preserve the official CU series while carrying the
> historical context layer correctly?

### Run

```bash
cd FRPink-WSPDataPrep
Rscript "CODE/Prep6_Create Fraser Pink_2.R"
```

### Review before release

1. Confirm the CU file still reflects the official CU series.
2. Inspect the pop/context file around the pre-1993 to post-1993 transition.
3. Confirm the Fraser aggregate row is present where expected.
4. Confirm its trend fields remain intentionally `NA` where that is the method.
5. Document any omitted or suppressed historical years.

### Minimum QC

```r
drop_unnamed <- function(d) d[, names(d) != "", drop = FALSE]

cu <- drop_unnamed(read.csv("DATA_OUT/Cleaned_FlatFile_ByCU_FraserPink.csv"))
stopifnot(!any(duplicated(cu[c("CU_ID", "Year")])))

pop <- drop_unnamed(read.csv("DATA_OUT/Cleaned_FlatFile_ByPop_FraserPink_All_Nuseds.csv"))
stopifnot(all(c("Pop_ID", "CU_ID", "Year") %in% names(pop)))
```

### What to write in the run notes

- how the historical layer was treated,
- why the Fraser aggregate row has special semantics,
- any historical-year omissions that reviewers should expect.

---

## Worked Example E — Final CU/WSP bundle handoff

### Scenario

Any species run has passed species-level QC and now needs a stable handoff for
WSP metrics, packaging, or a downstream consumer.

### Assemble the bundle

- `cu_timeseries.csv`
- `wsp_metric_specs.csv`
- optional `wsp_cyclic_benchmarks.csv`
- optional `cu_metadata.csv`
- `run-log.md`
- `decision-log.md`
- `qc-summary.md`
- `metadata_notes.md`

### Review before release

1. Confirm the CU IDs in the time series and metric specs match.
2. Confirm intentional `NA` patterns are documented.
3. Confirm the exception register has been reviewed, not just populated.
4. Confirm key intermediate QC artifacts are linked from `qc-summary.md`.
5. Record any downstream consumer export as a **derived** file.

### Minimum QC

```r
cu <- read.csv("cu_timeseries.csv")
spec <- read.csv("wsp_metric_specs.csv")

stopifnot(!any(duplicated(cu[c("CU_ID", "Year")])))
stopifnot(setequal(unique(cu$CU_ID), unique(spec$CU_ID)))
```

### What to write in the run notes

- which downstream tool or consumer this bundle is for,
- exact repo/version used for any rapid-status run,
- whether any consumer bridge files were generated after bundle QC.

