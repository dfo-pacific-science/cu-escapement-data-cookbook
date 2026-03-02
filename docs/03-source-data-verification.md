# Step 1: Source Data Verification

## Objective

Confirm that inputs are current, identifiable, and interpretable **before** any
selection or estimation logic.

## Do this exactly

1. Build an input inventory (file name, source contact, pull date, run year).
2. Validate core identifiers:
   - CU IDs
   - Pop/site IDs
   - year fields
   - species/run-timing fields where applicable
3. Confirm unit meaning:
   - wild vs total
   - expanded vs observed
   - biological zero vs missing
4. Record anomalies and owner for resolution.

## Quick validation script (adapt path as needed)

```r
x <- read.csv("DATA_IN/<input-file>.csv")

# Required columns (edit per file)
required <- c("Year")
stopifnot(all(required %in% names(x)))

# Year sanity
stopifnot(!all(is.na(x$Year)))

# Duplicate check on candidate key (edit key fields)
key <- c("Year")
if (all(key %in% names(x))) {
  stopifnot(!any(duplicated(x[key])))
}
```

## Species-specific verification notes

- Sockeye: verify timing labels and stream-name consistency against decoder and
  CU stream lists.
- Coho: verify tributary naming against POPID lookup before final joins.
- Chum: verify Harrison + Major systems year alignment before aggregation.
- Pink: verify official esc-rec year coverage and historical NuSEDS alignment.

## Required outputs from Step 1

- `source-inventory.csv` (or markdown equivalent)
- `verification-notes.md` with anomalies + decisions
- list of files approved for Step 2

## Escalate when

- IDs are missing for high-priority records
- source year ranges conflict across required files
- a field meaning changed from prior year without documentation
