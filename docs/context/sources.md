### WSP-Metrics-Pkg (metrics + rapid status engine)

- **Pipeline entry points**: `calculateMetricsByCU()` (expects CU time-series with `SpnForAbd_Wild`, `SpnForTrend_Wild`, `UseYear`, benchmark columns, trend/avg settings), `prepDataForRapidStatus()` (converts metrics to Rel/Abs LBM/UBM ratios and long-form outputs), `generateRapidStatus()` (joins integrated statuses and applies decision tree), `applyRapidStatusTree()` (hard-wired Learning Tree 3 rules/thresholds with confidence scoring), `plotStatusDashboards()` (multi-panel PNG per CU with BM ribbons and timelines), `generateReportTemplate()` (README/quarto scaffold referencing dashboards and specs).
- **Data contracts to surface in cookbook**: CU specs need booleans `AbdMetric`, `AbsAbdMetric`, `ShortTrendMetric`, `LongTrendMetric`, `PercentileMetric`, benchmark columns (`RelAbd_LBM/UBM`, `AbsAbd_LBM/UBM`, `LongTrend_LBM/UBM`, `PercChange_LBM/UBM`), cycle flags and cycle-specific BMs. Time-series require CU*ID cleaning (`*`vs`-`), wild vs total series, and `UseYear` logic.
- **Generalization path**: wrap the calculate→prep→generate→plot chain as a cookbook “metrics runner” recipe with YAML-configured spec files and file-name conventions (current scripts rely on CSV names). Expose hooks for (a) turning metrics off by CU (already supported), (b) injecting alternative decision trees, and (c) swapping plot palettes or BM ribbons.
- **Direct cookbook examples**: include the minimal call sequence (see `Approved-WSP-Statuses/CODE/1_Run_MetricsCalcs&RapidStatus.R`) and a table mapping required columns to cookbook dataset schemas. Link dashboards back to QC checklists.

### Data-Standards repo

- **FUNCTION_extract_SiteSelectionText.R**: turns site selection lookup tables (nuSEDS-style) into text summaries with counts by CU, enhancement filters, inclusion/exclusion wording, and default metadata stubs (e.g., Spn sources, calc methods). Pattern to generalize: pass any site-level spec (POP_ID, CU, enhancement rank, persistent flag) → get templated text + metadata fields for cookbook “site selection” section.
- **SCRIPTS/1_PrototypeTesting.R**: runnable example that reads lookup CSVs, adds label columns, calls `extract_SiteSelectionText()`, and writes the summary. Use as cookbook code block for “generate site-selection text from specs.”

### Metadata-Questionnaire-CU-Series repo

- **Module_read_google_sheet.R**: authenticated-public reader that iterates tabs, cleans list columns, replaces commas, and writes per-tab CSVs. Good for a cookbook “ingest metadata from Google Sheets” recipe with list-column flattening.
- **x_Module_generate2WayContingency.R** (stub) + **Module_generatePivotTable/Module_plotPivotTable/Module_Local_Sparkplot** (noted in scripts): building blocks for coverage summaries and small-multiple spark plots. Cookbook use: quick CU metadata coverage summaries and sparkline dashboards of CU data; add guidance on ensuring placeholder values (`TBD`) and NA handling.
- **CODE/2_Prelim_Summaries.R**: demonstrates reading crosswalks, summarizing benchmarks by species, generating CU-level spark plots, and assembling metadata dashboards. Treat as a pattern for “QC plots + benchmark coverage” section.

### Approved-WSP-Statuses repo

- **1_Run_MetricsCalcs&RapidStatus.R**: end-to-end script orchestrating WSP-Metrics-Pkg (install, calculate metrics, prep rapid status, run decision tree, plot dashboards). Use as a minimal runnable recipe; shows expected input filenames (`DATA/CU_Data.csv`, `SPECS/CU_Metric_Specifications.csv`, `SPECS/CU_CyclicBM.csv`, published integrated statuses).

### dfo_salmon_compilation repo (broad data harmonization patterns)

- **code/data_filtering.R**: large pipeline that harmonizes multi-species spawner-recruit data across many sources (PSC Fraser sockeye, Skeena/Nass updates, PSE exports, WA datasets, ADFG series), renames age structures, filters usable years, merges metadata, and writes compiled CSVs. Cookbook reuse: patterns for (1) source-specific cleaning blocks, (2) harmonizing column names/ages, (3) merging “official” replacements, and (4) writing standardized `stock_info` and compiled datasets with logRS.
- **code/functions.R**: helper `gr_to_euro()` for age naming conversion (Gilbert-Rich to European) — include in an “age naming conventions” appendix.
- **code/sps_data_exploration.R**: extracts brood tables from NOAA SPS, reconstructs recruits by age, and screens data quality; shows how to rebuild brood tables from partial age proportions.
- **pse_explore.R** (not opened) likely extends PSE harmonization; treat this repo as the canonical pattern for large multi-source data ingestion.

### Yukon run-reconstruction repos

- **yukon-chinook-multi-CU-run-reconstructions**: `fitRR.R` (TMB-based run reconstruction), `run-recon.R` (executes fit, computes harvest exploitation, CU spawner time series, exports COSEWIC/CSAS-ready CSVs), `tools.R` (nbinom/logit helpers, inverse-gamma, file readers). Cookbook reuse: worked example for “run reconstruction to CU escapement,” showing how to propagate border passage, exploitation, and uncertainty to CU series; illustrates mapping run-recon outputs to COSEWIC/CSAS formats.
- **yukon-CK-ResDoc**: expanded version with control-file driven TMB model, MAP construction, dynamic library compilation (`yukonChinookRunRecon.cpp`), and shared utilities (`analysis/R/misc/*` for tradeoffs, cosewic, demographic ref points). Use as reference for: (a) TMB control-file pattern, (b) splitting deterministic vs random effects, (c) producing benchmarking inputs for assessments.

### SalmonLRP_csasdown

- **make_tree_diagram.R / make_tree_diagram_fr.R**: DiagrammeR scripts that render the rapid-status decision tree (Learning Tree 3) to PNG/SVG; useful for cookbook visuals and keeping tree diagrams in sync with `applyRapidStatusTree()`.
- **make_maps.R** variants (not opened here) likely handle CU map rendering; consider for “visual assets” section.

### FR-PK-ResDoc

- **analysis/R/functions.R**: contains benchmark utilities (`get_Smsy` via lambert_W0, `get_Sgen` root solving), HCR functions (`current_HCR`, `PA_HCR`, `alt_HCR`), and helpers for quantiles; supports trajectory/forward-sim plotting files. Cookbook reuse: benchmark calculation snippets and harvest control rule templates for “Estimation/Benchmarks” and “Decision-tree/HCR” appendices.
- Other files (`fit-sr-stan.R`, `fwd-sim.R`, inference figs) show Bayesian SR fitting and scenario sims; good references for advanced estimation section.

### FIA-CN-FSRR-FSAR

- Small analytical utilities (`age_tau.R` estimating tau from age proportions; other files named for DFA, mortality tables, flow covariates). Use selectively for age-composition likelihoods or DFA patterns in an “advanced methods” sidebar.

### Other notes

- Many scripts assume relative paths and CSV inputs; cookbook should standardize folder conventions and encourage function-ized ingestion instead of monolithic scripts.
- Where multiple “live” decision trees exist, keep `applyRapidStatusTree()` as the canonical logic and regenerate figures from SalmonLRP_csasdown to avoid drift.
