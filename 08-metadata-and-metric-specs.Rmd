# Document Metadata and Metric Specifications

## Objective

Capture the CU context, dataset lineage, benchmarks, and WSP metric settings so
outputs are reviewable and machine-checkable.

## Required fields (from the metadata questionnaire)

- CU context: CU ID, name, species, geographic descriptors, biological
  rationale.
- Data description: source systems, coverage years, known gaps, zero-count
  policy, enhancement influence.
- Benchmarks: relative/absolute benchmarks, cyclic benchmarks if applicable,
  benchmark methods and citations.
- Active interventions: hatchery and spawning channel influence, enhancement
  programs, and how they affect inclusion/adjustments.
- Status process: decision tree or assessment process used, dates, reviewers.
- WSP metric specifications: which metrics are active per CU (abundance,
  trend, percentile), parameter settings, and any overrides.
- Provenance: data pull dates, script versions, and contacts.

## How to structure metadata files

- Keep metadata in CSV with clear column names and code lists; align picklists
  (e.g., enhancement level, verification status) to stable controlled
  vocabularies.
- Use a separate codes file for categorical fields; map terms to IRIs from the
  DFO Salmon Ontology when available to preserve meaning.
- Include provenance: data pull dates, scripts used, and contact points.
- For metric specs, mirror the columns expected by `WSP-Metrics-Pkg`
  (abundance/trend settings, benchmark columns, cycle flags) so files can be
  used directly.

## Outputs

- A completed metadata table covering the fields above.
- Code lists for categorical values, stored alongside the metadata.
- Links from each processing step to the corresponding metadata fields (e.g.,
  site-selection text, processing notes, benchmark methods).

## Tips

- Treat the metadata table as part of the deliverable, not an afterthought; keep
  it in version control.
- Reuse the questionnaire wording as hints/tooltips when building data entry
  forms or validation scripts.
- Keep human-readable notes adjacent to coded fields so reviewers can see the
  rationale without opening scripts.
