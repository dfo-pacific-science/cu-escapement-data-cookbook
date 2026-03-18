# Step 1: Source Data Verification

## Objective

Confirm that inputs are current, identifiable, and interpretable **before**
you start selecting sites or building series.

## Build one inventory, not a pile of guesses

Create a simple source inventory with at least these columns:

- `file_name`
- `file_role`
- `annual_static_conditional`
- `source_owner`
- `pull_date`
- `expected_year_start`
- `expected_year_end`
- `hard_coded_name_required`
- `notes`

This catches a lot of avoidable errors early: stale files, missing static
lookups, and scripts that expect literal file names.

## Do this exactly

1. Inventory every file you expect to use.
2. Check identifiers and naming fields.
3. Check unit meaning and missing-value semantics.
4. Build a quick year-coverage matrix for key sources.
5. Write anomaly notes and mismatch files before moving on.

## What to verify

### Identifiers and names

Confirm that the fields you need for joins are present and readable:

- `CU_ID`
- site or project identifiers
- pop identifiers where relevant
- year fields
- run timing, species, or estimate-class fields if the workflow depends on them

Also check for obvious name drift. A small spelling change can quietly break a
large join.

### Meaning of the numbers

For each main input, confirm:

- wild vs total,
- expanded vs observed,
- biological zero vs missing,
- current-year placeholder behaviour,
- whether any values were already adjusted upstream.

A clean numeric column is still dangerous if it means something different than
last year.

### Coverage and freshness

Build a one-page matrix showing which files cover which years. If one required
source ends at 2023 while the rest reach 2024, surface that before Step 2.

## Quick validation script

```r
x <- read.csv("DATA_IN/<input-file>.csv")

stopifnot(!any(names(x) == ""))
stopifnot("Year" %in% names(x))
stopifnot(!all(is.na(x$Year)))

key <- c("Year")
if (all(key %in% names(x))) {
  stopifnot(!any(duplicated(x[key])))
}
```

Adapt the key fields to the actual file. The point is to fail early on obvious
schema or duplication problems.

## Species-specific verification notes

- **Sockeye**: verify stream names, timing labels, and decoder alignment before
  any matching or CU roll-up.
- **Coho**: verify tributary names against the POPID lookup before downstream
  joins; check zero-versus-missing treatment for estimate types.
- **Chum**: verify Harrison and major-system year alignment before aggregation.
- **Pink**: verify official CU year coverage separately from the historical
  NuSEDS layer.

## Required outputs from Step 1

- `source-inventory.csv` (or markdown equivalent)
- `verification-notes.md`
- `verification-mismatches.csv` for unresolved name/ID issues
- a short approved-input list for Step 2

## Escalate when

- IDs are missing for high-priority records,
- source year ranges conflict across required files,
- a field meaning changed from prior year without documentation, or
- an input can only be used after an undocumented manual patch.

