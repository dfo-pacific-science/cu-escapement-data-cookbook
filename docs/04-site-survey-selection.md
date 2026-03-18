# Step 2: Site and Survey Selection

## Objective

Build an explicit site/survey selection specification for **each output layer**
you plan to produce.

## Most workflows do not have one final selected dataset

That is the key thing to keep straight.

In live species pipelines, different outputs may use different site sets. For
example, one layer may support CU trend estimation while another supports pop
representation or historical context.

## Start by naming the output layers

At minimum, decide which of these you need:

| Output layer | Typical purpose | Typical selection basis |
|---|---|---|
| `cu_trend` | trend metrics and status interpretation | indicator/WSP systems or species-specific trend stream set |
| `cu_abundance` | abundance, benchmarks, or benchmark-compatible roll-up | abundance/SR stream set or equivalent |
| `pop_representation` | pop-level context or reporting | broader mapped stream set |
| `historical_context` | continuity or legacy context | historical source layer with explicit caveats |

Not every run needs all four. The point is to **declare the layer first**, then
select sites for that layer.

## Required artifact set

- `site_selection_layers.csv` — one row per output layer
- `site_selection_spec.csv` — row-level include/exclude decisions
- `site_selection_excluded_projects.csv` — reviewed-but-excluded systems
- `site_selection_summary.md` — plain-language rationale

If you generate narrative text from the spec table, keep that output with the
bundle as supporting metadata.

## Minimum columns for `site_selection_spec.csv`

- `output_layer`
- `site_or_project_id`
- `site_or_project_name`
- `CU_ID` or target grouping field
- `classification`
- `include_flag`
- `enhancement_handling`
- `rationale`
- `source_reference`
- `review_date`
- `reviewer`

Add species-specific fields when needed, but keep the core columns stable.

## Do this exactly

1. Start from verified lookup and crosswalk tables.
2. Declare the output layers required for this run.
3. Apply inclusion/exclusion rules separately for each layer.
4. Record the reason for every exclusion and special case.
5. Export both machine-readable and plain-language summaries.

## Minimum rule set to document

- quality threshold used,
- enhancement handling rule,
- aggregation / double-counting rule,
- start-year or historical-context rule,
- special-case handling rule.

## Practical implementation notes from current repos

- **Sockeye**: keep decoder, timing labels, and stream lists synchronized; the
  trend layer and abundance layer are not always the same thing.
- **Coho**: document whether the run uses WSP-only systems for CU outputs and a
  broader all-stream layer for pop outputs.
- **Chum**: selection is simpler, but aggregation assumptions still need to be
  declared explicitly.
- **Pink**: keep the official CU series separate from the historical context
  layer.

## Generated narrative text is useful, but not a substitute for the table

The `Data-Standards` repo includes patterns for generating plain-language site
selection text. Use that if helpful, but keep the machine-readable spec table as
the primary source of truth.

## Stop conditions

Do **not** proceed quietly if:

- a required CU ends up with zero included sites for a required layer,
- site counts shift sharply from the prior release without explanation,
- key systems disappear because of naming drift, or
- two source datasets imply conflicting inclusion rules.

