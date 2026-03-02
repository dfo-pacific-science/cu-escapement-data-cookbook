# Getting Started

## Prerequisites

- Data access: current nuSEDS exports (or equivalent area datasets), CU lookup
  tables, site/survey classifications, benchmark records (if available), and
  prior published time series for comparison.
- Tools: R with `bookdown`, `dplyr`, `readr`, and access to the canonical WSP
  metrics package (`WSP-Metrics-Pkg`).
- Working directories: standardize `DATA/`, `SPECS/`, `OUTPUT/`, and `QC/`
  folders to reduce path drift across Areas.
- Vocabularies: stable code lists for estimate type, enhancement level,
  verification status, aggregation flags, and benchmark basis (keep them in
  `SPECS/codes.csv` so multiple datasets share the same meanings).

## Initial data inventory (checklist)

- [ ] List all input sources (nuSEDS extract, local survey files, hatchery
  records, border passage data, exploitation estimates, enhancement flags).
- [ ] Confirm identifiers: CU IDs, POP_ID/site IDs, survey IDs, year formats,
  and units.
- [ ] Capture site/survey classifications: quality class, enhancement level,
  aggregation flags.
- [ ] Locate benchmark information: existing relative/absolute benchmarks,
  cyclic benchmarks if applicable.
- [ ] Retrieve prior outputs for diffing: last published CU time series and
  WSP status outputs (if available).
- [ ] Note refresh cadence per source (e.g., annual nuSEDS export, in-season
  survey feeds) and who to contact when values look wrong.

## Workspace setup

- Keep raw extracts read-only; work from copies in `DATA/raw/` and write
  standardized, column-named tables to `DATA/processed/`.
- Store configurable decisions (filters, exclusions, expansions) in specs YAML
  or CSV files to keep scripts reproducible.
- Version-control specs and scripts; treat rendered outputs as artifacts that
  can be regenerated.
- Keep a `QC/` folder for plots, diffs, and validation outputs so reviewers know
  what was checked.

## Outputs you should have before moving on

- A documented list of inputs with paths and refresh frequency.
- A validated CU/site crosswalk and site/survey classification table.
- A placeholder metadata file capturing CU context and data provenance fields
  (to be completed in Chapter 8).
- A codes file for categorical fields so later steps can reuse the same
  picklists.
