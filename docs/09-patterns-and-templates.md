# Patterns and Templates

## Purpose

Provide reusable patterns distilled from case studies so new CU groups can adopt
the closest-fit workflow without copying bespoke scripts.

## Patterns to document

- **nuSEDS direct-sum pattern** (Fraser Chinook precedent): persistent sites,
  low/unknown enhancement, direct summation after selection and basic infill.
- **Run reconstruction pattern** (Yukon Chinook precedent): multi-source
  harvest and border passage inputs, model-based CU estimates, and uncertainty
  handling.
- **Indicator expansion pattern** (Skeena Sockeye precedent): indicator surveys
  scaled to CU totals with documented expansion factors and QA checks.
- **Metadata template**: how to fill required fields and link them to the
  workflow outputs.

## What to include for each pattern

- Input shape (columns, codes, required lookups)
- Processing phases and decision points
- Code snippets or scripts to run
- QC/validation steps and expected outputs
- How to document metadata for the pattern
- How to feed outputs into `WSP-Metrics-Pkg` (column expectations, toggle flags
  for metrics on/off per CU)
- A short “diff against prior release” recipe so updates are reviewable
