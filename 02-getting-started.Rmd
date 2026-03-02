# Getting Started

## Quick orientation

You will use **this cookbook repo** plus one or more production prep repos.

Think of this guide as orchestration:

- pattern cards tell you which pipeline to run
- worked examples show exact run paths
- checklists protect release quality

## Repository map (what each repo is for)

### Core cookbook

- `dfo-pacific-science/cu-escapement-data-cookbook`
  - Purpose: follow-me procedures, examples, templates, QA

### Species prep repos (primary execution)

- `BronwynMacDonald/FRSK-WSPDataPrep`
  - Fraser Sockeye CU + pop prep (complex gap-fill logic)
- `BronwynMacDonald/FRCo-WSPDataPrep`
  - Interior Fraser Coho prep (CU/pop + brood-year components)
- `BronwynMacDonald/FRCm-WSPDataPrep`
  - Lower Fraser Chum prep
- `BronwynMacDonald/FRPink-WSPDataPrep`
  - Fraser Pink prep

### Source-report repos (method context)

- `code/Data-Standards`
  - Source workflow framing and case-study context
- `code/Metadata-Questionnaire-CU-Series`
  - Field definitions, metadata examples, summary patterns

### Downstream metrics/tooling repos

- `Pacific-salmon-assess/WSP-Metrics-Pkg`
- `Pacific-salmon-assess/WSP-Rapid-Status-WorkedExamples`

## Standard prep-repo folders

Most species repos use:

- `DATA_IN/` input files for annual updates
- `DATA_LOOKUP_FILES/` lookups/crosswalks
- `DATA_PROCESSING/` intermediates (species-dependent)
- `DATA_OUT/` deliverable flat files
- `DATA_TRACKING/` diagnostics and review artifacts
- `CODE/` executable scripts

## Package bootstrap (R)

Install baseline packages before first run:

```r
install.packages(c(
  "dplyr", "tidyr", "stringr", "forcats", "Hmisc", "mgsub", "tidyverse"
))
```

Note: some pipelines can run with a subset, but Sockeye/Coho scripts often
assume the broader set.

## Pre-run checklist (required)

- [ ] Confirm repo access for all required species pipelines
- [ ] Confirm latest annual files are staged in `DATA_IN/`
- [ ] Confirm lookup files/crosswalks are current
- [ ] Confirm target run year and release label
- [ ] Select the matching Pattern Card (Chapter 9)
- [ ] Open a run log (Appendix template)

## Minimum key-file checks by species

- Sockeye: `SKAll`, SR file, CU stream maps, expansion-year table
- Coho: latest IFC data extract, infill exceptions, CU info + POPID lookup
- Chum: major systems, Harrison summary, extensive pivot, POPID crosswalk
- Pink: official esc-rec CU file + historical NuSEDS source file

## Before moving to Step 1

You should have:

- selected pipeline(s)
- staged inputs
- a destination release folder/branch
- named reviewer(s) for QC sign-off
