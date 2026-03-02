# Worked Examples

This chapter gives concrete, reproducible runs you can follow directly.

## Worked Example A — Fraser Sockeye annual update

### Scenario

You received updated annual Sockeye files and need refreshed CU and pop outputs.

### Run

```bash
cd FRSK-WSPDataPrep
Rscript CODE/Prep4_CleanedFlatFile_Fraser_Sk_KDEdits2024.R
```

### Expected outputs

- `DATA_OUT/Cleaned_FlatFile_ByCU_FraserSockeye.csv`
- `DATA_OUT/Cleaned_FlatFile_ByPop_FraserSockeye.csv`
- tracking artifacts in `DATA_TRACKING/`

### Minimum QC

```r
cu <- read.csv("DATA_OUT/Cleaned_FlatFile_ByCU_FraserSockeye.csv")
stopifnot(!any(duplicated(cu[c("CU_ID", "Year")])))

pop <- read.csv("DATA_OUT/Cleaned_FlatFile_ByPop_FraserSockeye.csv")
stopifnot(all(c("Pop_ID", "CU_ID", "Year") %in% names(pop)))
```

### Notes

Document any custom gap-fill/suppression years used in this run.

---

## Worked Example B — Interior Fraser Coho annual update

### Scenario

You need updated Coho CU/pop outputs and brood-year-derived CU components.

### Run

```bash
cd FRCo-WSPDataPrep
Rscript CODE/Prep5_CleanedFlatFile_Fraser_Coho.R
```

### Expected outputs

- `DATA_OUT/Cleaned_FlatFile_ByCU_FraserCoho.csv`
- `DATA_OUT/Cleaned_FlatFile_ByPop_FraserCoho.csv`
- `DATA_PROCESSING/All IFC CUs BY Table_EC.max=NA_infill=FALSE.csv`

### Minimum QC

```r
cu <- read.csv("DATA_OUT/Cleaned_FlatFile_ByCU_FraserCoho.csv")
stopifnot(!any(duplicated(cu[c("CU_ID", "Year")])))
stopifnot(min(cu$Year, na.rm = TRUE) >= 1998)

pop <- read.csv("DATA_OUT/Cleaned_FlatFile_ByPop_FraserCoho.csv")
stopifnot(all(c("Pop_ID", "CU_ID", "Year", "Pop_Name") %in% names(pop)))
```

### Notes

Review tributary naming mismatches before release packaging.

---

## Worked Example C — Lower Fraser Chum annual update

### Scenario

You need current CU and pop outputs using major-systems and extensive-table
inputs.

### Run

```bash
cd FRCm-WSPDataPrep
Rscript "CODE/Prep7_Create Fraser Chum2.R"
```

### Expected outputs

- `DATA_OUT/Cleaned_FlatFile_ByCU_FraserChum.csv`
- `DATA_OUT/Cleaned_FlatFile_ByPop_FraserChum_all.csv`

### Minimum QC

```r
drop_unnamed <- function(d) d[, names(d) != "", drop = FALSE]

cu <- drop_unnamed(read.csv("DATA_OUT/Cleaned_FlatFile_ByCU_FraserChum.csv"))
stopifnot(!any(duplicated(cu[c("CU_ID", "Year")])))

pop <- drop_unnamed(read.csv("DATA_OUT/Cleaned_FlatFile_ByPop_FraserChum_all.csv"))
stopifnot(all(c("Pop_ID", "Year") %in% names(pop)))
```

### Notes

Current implementation is truncated to years consistent with available source
composition (review annual range each update).

---

## Worked Example D — Fraser Pink annual update

### Scenario

You need updated CU series from official esc-rec source plus pop-level historical
context.

### Run

```bash
cd FRPink-WSPDataPrep
Rscript "CODE/Prep6_Create Fraser Pink_2.R"
```

### Expected outputs

- `DATA_OUT/Cleaned_FlatFile_ByCU_FraserPink.csv`
- `DATA_OUT/Cleaned_FlatFile_ByPop_FraserPink_All_Nuseds.csv`

### Minimum QC

```r
drop_unnamed <- function(d) d[, names(d) != "", drop = FALSE]

cu <- drop_unnamed(read.csv("DATA_OUT/Cleaned_FlatFile_ByCU_FraserPink.csv"))
stopifnot(!any(duplicated(cu[c("CU_ID", "Year")])))

pop <- drop_unnamed(read.csv("DATA_OUT/Cleaned_FlatFile_ByPop_FraserPink_All_Nuseds.csv"))
stopifnot(all(c("Pop_ID", "CU_ID", "Year") %in% names(pop)))
```

### Notes

Confirm expected historical + mainstem representation before release sign-off.
