# Step 5: Estimation

## Objective

Aggregate processed records to CU-level time series and document estimation
methods.

## Actions

- Choose estimation approach: direct summation, indicator expansion, run
  reconstruction, or other model-based aggregation.
- Apply CU-level quality checks: continuity, plausibility, and year-to-year
  consistency relative to previous releases.
- Prepare benchmark inputs and metric-ready columns (wild vs total, trend
  series, `UseYear`, benchmark fields).
- If using model-based methods, capture control files, priors, and versioned
  model outputs alongside the derived CU series.

## Outputs

- CU-level escapement time series with method notes.
- A benchmark-ready dataset for feeding into the WSP metrics engine.
- A comparison table against prior releases highlighting changes.

## Tips

- Keep estimation choices explicit and link them to benchmark assumptions.
- When using model-based estimates (e.g., run reconstruction), store control
  files and model outputs alongside the derived CU series for reproducibility.
- Record whether outputs are wild-only, total, or mixed and how enhancement was
  handled so metric settings match the data.
