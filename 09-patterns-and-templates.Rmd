# Patterns and Templates

## How to use pattern cards

Treat each card as a **do-this-exactly** runbook for a common scenario.

Each card tells you:

- when to use it,
- which layers it produces,
- which inputs are hard-coded or conditional,
- which intermediate artifacts must be reviewed,
- what to escalate.

---

## Pattern Card 1 — Fraser Sockeye (dual stream layers + targeted gap fills)

### Use when

- Species is Fraser Sockeye
- You need CU outputs plus pop/context outputs aligned with current production
  practice
- You expect CU-specific gap-fill logic and decoder-heavy matching

### Repo and script

- Repo: `FRSK-WSPDataPrep`
- Script: `CODE/Prep4_CleanedFlatFile_Fraser_Sk_KDEdits2024.R`

### Key output layers

- `cu_trend`
- `cu_abundance`
- `pop_representation`

### Required inputs

- `DATA_IN/SKAll (Nov YYYY).csv`
- `DATA_IN/Fraser Sockeye SR Data_YYYY.csv`
- `DATA_IN/Sockeye_Fraser_CU_Streams.csv`
- `DATA_IN/Sockeye_Fraser_SR_Streams.csv`
- `DATA_IN/Sockeye_Fraser_Expansion_Years.csv`
- `DATA_LOOKUP_FILES/MOD_MAIN_CU_LOOKUP_FOR_SOS.csv`
- `DATA_LOOKUP_FILES/Site_Info_GeneratedDecoder_Fraser_Sk.csv`

### Important notes before run

- Check whether the script expects literal file names.
- Keep trend-layer and abundance-layer stream lists distinct.
- Open the exception register before running; you will probably need it.

### Run

```bash
cd FRSK-WSPDataPrep
Rscript CODE/Prep4_CleanedFlatFile_Fraser_Sk_KDEdits2024.R
```

### Review these artifacts before release

- `DATA_TRACKING/FraserSockeye_MatchingCheck.csv`
- `DATA_TRACKING/Sites not in CUs.csv`
- CU-specific prep files in `DATA_TRACKING/FraserSockeyePrep/`
- any manual suppression or gap-fill notes recorded in the run log

### Escalate if

- decoder joins break because stream names changed,
- a high-priority CU changes method family,
- the abundance and trend layers can no longer be explained cleanly.

---

## Pattern Card 2 — Interior Fraser Coho (WSP-only CU layer + all-stream pop layer)

### Use when

- Species is Interior Fraser Coho
- You need CU outputs, pop outputs, and brood-year / decomposition support

### Repo and scripts

- Repo: `FRCo-WSPDataPrep`
- Scripts:
  - `CODE/SUB_Data extraction and clean up (Coho for now)_2023.R`
  - `CODE/Prep5_CleanedFlatFile_Fraser_Coho.R`

### Key output layers

- `cu_trend`
- `cu_abundance`
- `pop_representation`

### Required inputs

- latest `DATA_IN/IFC Data 1975-<year> ... for Salmon Scanner.csv`
- `DATA_IN/FRSK_CU_Info_masterUpdate.csv`
- `DATA_IN/Fraser Coho POPID Lookup...csv`
- `DATA_LOOKUP_FILES/MOD_MAIN_CU_LOOKUP_FOR_SOS.csv`
- `DATA_IN/IFC Infill exceptions.csv` only if the active path actually uses it

### Important notes before run

- Document whether the CU layer is WSP-only and the pop layer is all-stream.
- Confirm how `Final.Estimate.Type == "NO"` is treated.
- Treat decomposition tables as QC evidence, not as optional extras.

### Run

```bash
cd FRCo-WSPDataPrep
Rscript CODE/Prep5_CleanedFlatFile_Fraser_Coho.R
```

### Review these artifacts before release

- `DATA_PROCESSING/Calc.Nat Table for <CU>.csv`
- `DATA_PROCESSING/All IFC CUs BY Table_EC.max=NA_infill=FALSE.csv`
- any `Check.Natural.Returns` outputs or equivalent summaries

### Escalate if

- tributary names stop matching the POPID crosswalk,
- natural versus hatchery components shift sharply without explanation,
- the pop layer stops being intentionally broader than the CU layer.

---

## Pattern Card 3 — Lower Fraser Chum (major-system CU layer with expected CU/pop non-equality)

### Use when

- Species is Lower Fraser Chum
- You need the production CU layer and pop representation built from major
  systems and Harrison logic

### Repo and script

- Repo: `FRCm-WSPDataPrep`
- Script: `CODE/Prep7_Create Fraser Chum2.R`

### Required inputs

- `DATA_IN/FR Chum Major Systems.csv`
- `DATA_IN/Harrison Chum Escapement Summary.csv`
- `DATA_IN/Chum extensive pivot.csv`
- `DATA_IN/FR Chum POPID Crosswalk.csv`

### Important notes before run

- Do not expect CU totals to equal the sum of pop rows.
- Review any row-name / unnamed-column CSV behaviour before downstream use.
- Log the Harrison and Squawkum handling explicitly.

### Run

```bash
cd FRCm-WSPDataPrep
Rscript "CODE/Prep7_Create Fraser Chum2.R"
```

### Review these artifacts before release

- final CU and pop files,
- any comparison showing Harrison decomposition,
- run-log note explaining expected CU/pop non-equality.

### Escalate if

- the non-equality pattern cannot be explained,
- unnamed first columns break downstream import,
- year truncation changes relative to the prior release.

---

## Pattern Card 4 — Fraser Pink (official CU series + historical context layer)

### Use when

- Species is Fraser Pink
- You need the official CU series plus the historical NuSEDS-based pop/context
  layer

### Repo and script

- Repo: `FRPink-WSPDataPrep`
- Script: `CODE/Prep6_Create Fraser Pink_2.R`

### Required inputs

- `DATA_IN/Fraser Pink esc_rec CU.csv`
- `DATA_IN/FR_Pink_Conservation_Unit_Data_NUSEDs_June 2023.csv`

### Important notes before run

- Keep the official CU series authoritative across the whole time series.
- Treat the historical NuSEDS layer as context, not as a replacement CU series.
- Review the Fraser aggregate pop row separately from ordinary pop rows.

### Run

```bash
cd FRPink-WSPDataPrep
Rscript "CODE/Prep6_Create Fraser Pink_2.R"
```

### Review these artifacts before release

- final CU and pop files,
- a year-transition check around the pre-1993 historical layer,
- confirmation that the Fraser aggregate row retains expected `NA` trend fields.

### Escalate if

- the official CU series appears to be overwritten by stream sums,
- the historical transition years cannot be explained,
- the Fraser aggregate row loses its special semantics.

---

## Pattern Card 5 — CU/WSP bundle handoff

### Use when

- final CU outputs passed release QC,
- you need a stable handoff for metrics, packaging, or another consumer.

### Required inputs

- `cu_timeseries.csv`
- `wsp_metric_specs.csv`
- optional `wsp_cyclic_benchmarks.csv`
- optional `cu_metadata.csv`
- sidecars: `run-log.md`, `decision-log.md`, `qc-summary.md`, `metadata_notes.md`

### Minimum QC before handoff

- CU/spec alignment checked,
- intentional `NA` patterns documented,
- exception register reviewed,
- intermediate QC artifacts linked from the summary.

### Handoff outputs

- status-ready bundle,
- optional Salmon Data Package,
- optional derived consumer bridge.

