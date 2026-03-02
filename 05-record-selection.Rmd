# Step 3: Record Selection

## Objective

Pick the best record per CU-year (or survey event) before any infilling or
scaling.

## Actions

- Define selection hierarchy (e.g., preferred estimate type, preferred survey
  platform, handling of late/early surveys).
- Resolve conflicts: duplicates, overlapping surveys, or divergent estimates
  for the same CU-year.
- Document exclusions with reasons (e.g., data deficient, suspect expansion,
  zero-count policy).
- Capture timing rules (e.g., escapement year vs calendar year) and enforce
  consistent `UseYear` derivation.

## Outputs

- A selected-records table with rationale columns.
- A short note on conflict resolution patterns applied (e.g., earliest
  credible, highest quality flag).

## Tips

- Automate tie-breaks in code but leave an override column for documented,
  manual resolutions.
- Keep zero-count handling explicit—state whether zeros are biological or
  missing/unsampled.
- Store pre-selection and post-selection tables to make diffs easy during
  review.
