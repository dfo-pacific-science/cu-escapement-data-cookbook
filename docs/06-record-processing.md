# Step 4: Record Processing

## Objective

Transform selected records into analysis-ready values **and** leave a clear QC
trail showing how you got there.

## Step 4 is where hidden logic becomes visible

This is the point in the workflow where annual prep repos often stop looking
simple. Gap fills, decomposition logic, suppressions, timing fixes, and
historical-layer rules all tend to show up here.

The cookbook standard is straightforward:

- keep the method explicit,
- keep the raw-versus-adjusted distinction traceable, and
- keep the intermediate QC artifacts.

## Required outputs from Step 4

- `processed_records.csv`
- `processing_log.md`
- `exception-register.csv`
- `qc-artifact-review.md`
- species-specific tracking or decomposition files written by the prep repo

## Processing actions (in order)

1. Apply approved transformations only.
2. Preserve raw values and adjusted values, or leave a clear link between them.
3. Add method tags and adjustment flags.
4. Write intermediate QC artifacts.
5. Summarize exceptions that require reviewer sign-off.

## Treat intermediate artifacts as first-class outputs

Do not review only the final flat files.

Intermediate artifacts often contain the evidence that the method behaved as
intended, for example:

- matching checks,
- decomposition tables,
- CU-specific prep tables,
- unmatched-site reports,
- historical-layer comparison tables,
- pop-versus-CU comparison checks.

If a reviewer cannot see those files, they cannot really review the run.

## Minimum columns for `exception-register.csv`

- `species`
- `output_layer`
- `object`
- `years_affected`
- `rule_type`
- `implemented_in`
- `rationale`
- `review_required`
- `reviewer_notes`

Typical `rule_type` values include `rename`, `suppress`, `merge`, `timing_override`,
`gap_fill`, `decomposition`, and `manual_value`.

## Keep output-layer semantics explicit

| Output layer | Typical fields | What they mean | Common trap |
|---|---|---|---|
| `cu_timeseries` | `SpnForTrend_*`, `SpnForAbd_*` | canonical CU series for status and benchmarks | assuming trend and abundance fields are always identical |
| `pop_representation` | pop IDs, pop names, spawner fields | representation or context layer | assuming pop sums must equal CU totals |
| `historical_context` | historical stream or aggregate rows | continuity/context only | treating context rows as authoritative CU estimates |
| status bundle | CU series + metric specs | downstream compute contract | mixing authoring notes into machine tables |

## Species-pattern notes from current production repos

- **Sockeye**: multiple CU-specific gap-fill families exist. Treat them as
  declared methods with reviewable outputs, not as mysterious script magic.
- **Coho**: natural/hatchery decomposition and brood-year derivation are central
  processing steps. Review the decomposition tables, not just the final CU file.
- **Chum**: CU totals are assembled from major systems plus Harrison logic.
  Review the composition assumptions and document expected CU/pop non-equality.
- **Pink**: keep the official CU series distinct from the historical NuSEDS
  representation layer. The layers answer different questions.

## Minimum QC expectations

- every material adjustment has a flag or method tag,
- raw-versus-adjusted traceability is preserved,
- intermediate QC artifacts are reviewed and logged,
- intentional `NA` patterns are explained,
- expected non-equality patterns are explained before release.

## Escalate when

- adjustments materially change interpretation but the rationale is weak,
- manual fixes are introduced without a reproducible rule expression,
- the only evidence for a method choice lives inside code comments, or
- you cannot explain a major output change using the intermediate artifacts.

