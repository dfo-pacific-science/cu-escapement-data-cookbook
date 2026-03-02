# Step 6: Metadata and Metric Specifications

## Objective

Produce a metadata package that makes each CU time series understandable,
reviewable, and machine-usable.

This chapter follows the practical conversion approach from the metadata
questionnaire distillation: convert question prompts into **how-to-fill
procedures**.

## Metadata package components

At minimum, keep these files together:

- `metadata_cu.csv`
- `metric_specs.csv`
- `codes.csv` (controlled vocabularies)
- `metadata_notes.md`

## How-to-fill blocks

### 1) CU context

Fields to fill:

- `CU_ID`, `CU_Name`, `Species`
- verification status + year
- geographic/life-history context fields used by your program

Rules:

- keep CU ID format stable across all files
- if aliases exist, document mapping in a lookup field/table

### 2) Data source + calculation method

Fields to fill:

- source system(s)
- source pull date(s)
- year coverage
- spawner estimate type and calculation method

Rules:

- describe method in plain language plus coded value
- include file/script provenance for reproducibility

### 3) Benchmarks

Fields to fill:

- benchmark type(s)
- method reference
- benchmark values and units

Rules:

- include citations or report references for benchmark method
- distinguish operational benchmark from reference-only benchmark

### 4) Active interventions

Fields to fill:

- hatchery/spawning channel influence flags
- adjustment notes where interventions affect interpretation

### 5) Metric specifications

Fields to fill:

- enabled metrics by CU
- metric parameters
- cycle/benchmark settings where relevant

Rules:

- align column names and coding with the metric engine inputs you will run

### 6) Assessment process + provenance

Fields to fill:

- reviewers/assessment process
- decision date
- run identifier
- script + repo version

## Practical source files for metadata definitions

Local method and field-definition context is available in:

- `code/Metadata-Questionnaire-CU-Series/REPORT/02_questionnaire.Rmd`
- `code/Metadata-Questionnaire-CU-Series/DATA/From_Google_Sheet/Metadata_FieldDefinitions.csv`
- `code/Metadata-Questionnaire-CU-Series/DATA/From_Google_Sheet/Metadata_Questions.csv`

Use these to avoid inventing inconsistent labels.

## Minimum validation script

```r
m <- read.csv("metadata_cu.csv")
req <- c("CU_ID", "CU_Name", "Species")
stopifnot(all(req %in% names(m)))
stopifnot(!any(is.na(m$CU_ID) | m$CU_ID == ""))
```

## Required outputs from Step 6

- completed metadata + metric specs
- controlled vocabulary file
- short note documenting unresolved fields and owners
