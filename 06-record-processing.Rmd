# Step 4: Record Processing

## Objective

Transform selected records into analysis-ready values by handling gaps,
adjustments, and harmonization.

## Actions

- Infill missing values where policy allows (e.g., borrow adjacent years,
  apply simple imputation) and flag imputed rows.
- Scale indicator surveys to full CU coverage when appropriate; record
  expansion factors and assumptions.
- Adjust for enhancement where needed (e.g., subtract hatchery components when
  reporting wild escapement).
- Standardize units, rounding, and year definitions (`UseYear`) to align with
  downstream metric engines.
- Preserve both raw and adjusted values; keep flags for each adjustment step.

## Outputs

- A processed records table with flags for infill, scaling, enhancement
  adjustments, and notes.
- A short processing log describing methods and any deviations from the
  default rules.

## Tips

- Keep processing rules in configuration where possible; avoid hard-coding CU
  exceptions in scripts.
- Preserve pre-processed values for auditability; never overwrite raw columns.
- When applying expansion factors, store the factor source and version (e.g.,
  which lookup or survey year the factor came from).
