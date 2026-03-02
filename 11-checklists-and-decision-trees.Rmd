# Checklists and Decision Trees

## Annual update loop

- [ ] Refresh source extracts and rerun verification checks.
- [ ] Reapply site/survey selection and note classification changes.
- [ ] Re-run record selection, processing, and aggregation.
- [ ] Diff outputs against last release; document changes.
- [ ] Re-run metrics and regenerate dashboards/plots.
- [ ] Update metadata and archive prior outputs.
- [ ] Revalidate code lists (add new values explicitly rather than drifting).

## Decision trees to include

- Site inclusion/exclusion (quality and enhancement rules)
- Infill vs scale (when to expand indicator surveys)
- Handling enhancement (when to subtract or retain components)
- Choosing estimation method (direct sum vs indicator vs run reconstruction)
- Benchmark choice (relative vs absolute vs cyclic)

## Validation checklists

- Data completeness: years present, NA handling, zero policy documented.
- Consistency: ID integrity, units, absence of duplicates.
- Biological plausibility: outlier review, known trends respected.
- Cross-validation: compare to previous versions and alternate sources where
  available.
- Metrics readiness: required benchmark and metric-spec columns populated for
  each CU and aligned with the chosen time-series (wild vs total).
