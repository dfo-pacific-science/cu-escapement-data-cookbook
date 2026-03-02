# Patterns and Templates

## How to use pattern cards

Treat each card as a **do-this-exactly** runbook for a common scenario.

Each card includes:

- when to use it
- required inputs
- exact run steps
- expected outputs
- minimum QC checks
- escalation triggers

---

## Pattern Card 1 — Fraser Sockeye (direct sum + targeted gap fills)

### Use when

- Species is Fraser Sockeye
- You need CU and pop flat files aligned with existing SoS/WSP practice
- You need built-in handling for known gap-fill pathways (e.g., Quesnel,
  Shuswap, Takla-Trem, Nahatlatch)

### Repo and script

- Repo: `FRSK-WSPDataPrep`
- Script: `CODE/Prep4_CleanedFlatFile_Fraser_Sk_KDEdits2024.R`

### Required inputs

- `DATA_IN/SKAll (Nov YYYY).csv`
- `DATA_IN/Fraser Sockeye SR Data_YYYY.csv`
- `DATA_IN/Sockeye_Fraser_CU_Streams.csv`
- `DATA_IN/Sockeye_Fraser_SR_Streams.csv`
- `DATA_IN/Sockeye_Fraser_Expansion_Years.csv`
- `DATA_LOOKUP_FILES/MOD_MAIN_CU_LOOKUP_FOR_SOS.csv`
- `DATA_LOOKUP_FILES/Site_Info_GeneratedDecoder_Fraser_Sk.csv`

### Run

```bash
cd FRSK-WSPDataPrep
Rscript CODE/Prep4_CleanedFlatFile_Fraser_Sk_KDEdits2024.R
```

### Expected outputs

- `DATA_OUT/Cleaned_FlatFile_ByPop_FraserSockeye.csv`
- `DATA_OUT/Cleaned_FlatFile_ByCU_FraserSockeye.csv`
- `DATA_TRACKING/FraserSockeye_MatchingCheck.csv`
- `DATA_TRACKING/Sites not in CUs.csv`

### Minimum QC

- CU-level uniqueness by `(CU_ID, Year)`
- Year range reaches current update year
- `Sites not in CUs.csv` reviewed and signed off
- Manual exception years (e.g., Taseko/Birkenhead) documented in run log

### Escalate if

- CU totals fail plausibility checks against prior release
- input stream naming changes break decoder joins
- new missingness patterns appear in high-priority CUs

---

## Pattern Card 2 — Interior Fraser Coho (CU decomposition + brood-year outputs)

### Use when

- Species is Interior Fraser Coho
- You need CU and pop outputs plus hatchery/natural decomposition flow

### Repo and scripts

- Repo: `FRCo-WSPDataPrep`
- Scripts:
  - `CODE/SUB_Data extraction and clean up (Coho for now)_2023.R`
  - `CODE/Prep5_CleanedFlatFile_Fraser_Coho.R`

### Required inputs

- latest `DATA_IN/IFC Data 1975-<year> ... for Salmon Scanner.csv`
- `DATA_IN/IFC Infill exceptions.csv`
- `DATA_IN/FRSK_CU_Info_masterUpdate.csv`
- `DATA_IN/Fraser Coho POPID Lookup...csv`
- `DATA_LOOKUP_FILES/MOD_MAIN_CU_LOOKUP_FOR_SOS.csv`

### Run

```bash
cd FRCo-WSPDataPrep
Rscript CODE/Prep5_CleanedFlatFile_Fraser_Coho.R
```

### Expected outputs

- `DATA_OUT/Cleaned_FlatFile_ByPop_FraserCoho.csv`
- `DATA_OUT/Cleaned_FlatFile_ByCU_FraserCoho.csv`
- `DATA_PROCESSING/All IFC CUs BY Table_EC.max=NA_infill=FALSE.csv`

### Minimum QC

- CU output starts at expected analysis years (typically 1998+)
- CU-level uniqueness by `(CU_ID, Year)`
- Pop-level `Pop_ID` coverage reviewed for unmatched names
- Recruit columns checked for expected NA windows in terminal years

### Escalate if

- large shifts in hatchery vs natural components are unexplained
- key tributary naming/crosswalks no longer match lookup rules

---

## Pattern Card 3 — Lower Fraser Chum (major-system aggregate)

### Use when

- Species is Lower Fraser Chum
- You need fast CU + pop outputs using major systems + extensive pivot

### Repo and script

- Repo: `FRCm-WSPDataPrep`
- Script: `CODE/Prep7_Create Fraser Chum2.R`

### Required inputs

- `DATA_IN/FR Chum Major Systems.csv`
- `DATA_IN/Harrison Chum Escapement Summary.csv`
- `DATA_IN/Chum extensive pivot.csv`
- `DATA_IN/FR Chum POPID Crosswalk.csv`

### Run

```bash
cd FRCm-WSPDataPrep
Rscript "CODE/Prep7_Create Fraser Chum2.R"
```

### Expected outputs

- `DATA_OUT/Cleaned_FlatFile_ByCU_FraserChum.csv`
- `DATA_OUT/Cleaned_FlatFile_ByPop_FraserChum_all.csv`

### Minimum QC

- CU year range aligns with known truncation (2002+ in current implementation)
- remove unnamed first column if present before downstream use
- pop-level row counts/missingness reviewed against prior release

---

## Pattern Card 4 — Fraser Pink (official CU series + historical stream layer)

### Use when

- Species is Fraser Pink
- You need CU series from official esc-rec source plus pop-level historical
  stream representation

### Repo and script

- Repo: `FRPink-WSPDataPrep`
- Script: `CODE/Prep6_Create Fraser Pink_2.R`

### Required inputs

- `DATA_IN/Fraser Pink esc_rec CU.csv`
- `DATA_IN/FR_Pink_Conservation_Unit_Data_NUSEDs_June 2023.csv`

### Run

```bash
cd FRPink-WSPDataPrep
Rscript "CODE/Prep6_Create Fraser Pink_2.R"
```

### Expected outputs

- `DATA_OUT/Cleaned_FlatFile_ByCU_FraserPink.csv`
- `DATA_OUT/Cleaned_FlatFile_ByPop_FraserPink_All_Nuseds.csv`

### Minimum QC

- CU years include latest run year
- remove unnamed first column if present before downstream use
- historical years and mainstem representation are both present in pop output
- expected NA behavior in trend/rec columns reviewed

---

## Template bundle (use with any pattern)

For each run, store:

- `run-log.md` — what you ran, when, with which files
- `decision-log.md` — any deviations/exceptions and why
- `qc-summary.md` — pass/fail checks with evidence links
