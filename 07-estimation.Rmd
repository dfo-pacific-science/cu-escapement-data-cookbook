# Step 5: Estimation

## Objective

Produce the canonical CU/WSP bundle used for release, review, and downstream
metric execution.

## What counts as the main output

The canonical analytical output is `cu_timeseries`.

You may also produce:

- `pop_timeseries` for supporting representation,
- a historical-context layer,
- a status bundle built from the CU series,
- a package or consumer bridge built after QC.

Do **not** let a consumer-specific file shape become the definition of the run.
The CU series comes first.

## Choose estimation mode

- **Direct sum** — near-complete site coverage with stable inclusion rules
- **Indicator expansion** — partial coverage with defensible expansion factors
- **Run reconstruction / model-based** — aggregate counts, stock-share data, or
  model structure required

## Do this exactly

1. build `cu_timeseries` from the processed records,
2. apply start-year policy where defined,
3. populate the metric-facing fields deliberately,
4. compare against the prior release,
5. record any material difference in `release_diff_summary.md`.

## Minimum `cu_timeseries` contract

At minimum, the table should make these fields available or intentionally
explain why they are absent:

- `CU_ID`
- `CU_Name`
- `Species`
- `Year`
- `SpnForAbd_Wild`
- `SpnForTrend_Wild`

Strongly recommended context fields:

- `SpnForAbd_Total`
- `SpnForTrend_Total`
- `Recruits_Wild`
- `Recruits_Total`
- `Group`
- method or provenance tag

### Important semantic rule

`SpnForAbd_*` and `SpnForTrend_*` are not just duplicate columns with annoying
names. They can represent **different intended uses** and should only be made
equal when that is truly what the method means.

## Bundle files to keep together

| File | Role |
|---|---|
| `cu_timeseries` | canonical CU time series |
| `wsp_metric_specs` | one row per CU describing metric settings and benchmarks |
| `wsp_cyclic_benchmarks` | required only for cyclic benchmark cases |
| `cu_metadata` | supporting CU context, method, provenance, and interpretation |
| `published_integrated_statuses` | optional comparison input |
| sidecars | run, decision, QC, and metadata notes |

## Alignment checks before release

- uniqueness by `(CU_ID, Year)`,
- all CUs in `cu_timeseries` appear in `wsp_metric_specs`,
- start-year trimming is documented,
- wild vs total semantics are consistent with the metric plan,
- cyclic benchmark files are present when required,
- prior-release diffs are explained in plain language.

## If the estimation path is model-based

Add these fields or sidecars to the release package:

- point estimate,
- interval bounds,
- `cv` or `se`,
- method tag,
- run ID or control-file reference,
- short note on post-fit corrections.

That is enough to make the output reviewable without turning the cookbook into a
full assessment manual.

## Downstream metric execution

Preferred tooling:

- `https://github.com/Pacific-salmon-assess/WSP-Metrics-Pkg`
- `https://github.com/SOLV-Code/WSP-Rapid-Status-WorkedExamples`

Record the repo URL and commit SHA used for any downstream metric or
rapid-status run. "Latest GitHub" is not a method.

## Required outputs from Step 5

- `cu_timeseries.csv` (or the species file mapped to that role)
- optional `pop_timeseries.csv`
- `release_diff_summary.md`
- `wsp_metric_specs.csv`
- optional `wsp_cyclic_benchmarks.csv`

## Derived bridge exports

If another system needs a different file shape, generate that **after** the
bundle passes QC. For example, a package or a derived `cuyear.csv` export is a
consumer handoff, not the canonical analytical model.

## Escalate when

- prior-release diffs are large and unexplained,
- benchmark assumptions differ from metric configuration,
- estimation mode changed relative to the prior release, or
- the output is clean numerically but the meaning of key fields is still fuzzy.

