# Step 5: Estimation

## Objective

Produce final CU-level time series suitable for WSP status workflows and metric
execution.

## Choose estimation mode

- **Direct sum**: complete/near-complete site coverage with stable inclusion
  rules
- **Indicator expansion**: partial coverage with defensible expansion factors
- **Run reconstruction/model-based**: where aggregate + stock-share or modeled
  structure is required

## Do this exactly

1. generate CU series from processed records
2. apply start-year policy where defined
3. attach benchmark/metric-ready fields
4. compare against prior release and explain differences

## Minimum estimation QC

- uniqueness by `(CU_ID, Year)`
- plausible continuity (no unexplained structural breaks)
- expected missingness pattern documented
- trend/abundance fields aligned with intended metric usage

## Downstream metric execution

Preferred tooling:

- `https://github.com/Pacific-salmon-assess/WSP-Metrics-Pkg`
- `https://github.com/Pacific-salmon-assess/WSP-Rapid-Status-WorkedExamples`

## Required outputs from Step 5

- `Cleaned_FlatFile_ByCU_<Species>.csv`
- `release_diff_summary.md`
- metric-input-ready table(s) or mapping note

## Escalate when

- prior-release diffs are large and unexplained
- benchmark assumptions differ from metric configuration
- estimation mode changed relative to prior release
