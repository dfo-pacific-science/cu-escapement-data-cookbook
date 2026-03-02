# Step 4: Record Processing

## Objective

Transform selected records into analysis-ready values with explicit adjustment
flags.

## Processing actions (in order)

1. Apply approved infill/expansion logic (if applicable).
2. Apply enhancement handling rules (wild vs total expectations).
3. Harmonize year fields and numeric formats.
4. Preserve both raw and adjusted values.
5. Emit flags for every adjustment type.

## Species-pattern notes from current production repos

- Sockeye: multiple CU-specific gap-fill functions exist (regular, Quesnel,
  Shuswap, Takla-Trem, average-based); treat these as declared methods, not
  hidden code behavior.
- Coho: decomposition between hatchery and natural-origin components feeds CU
  brood-year outputs; verify assumptions remain unchanged.
- Chum: CU totals are assembled from major systems + Harrison components;
  document composition assumptions.
- Pink: official CU series is retained while historical stream context is merged
  for pop-level representation.

## Minimum output columns (recommended)

- key IDs (CU/Pop/year)
- processed value(s)
- raw value(s)
- adjustment flags (infill/scale/enhancement)
- notes or method tag

## Required outputs from Step 4

- `processed_records.csv`
- `processing_log.md`

## Escalate when

- adjustments materially change trend interpretation but method justification is
  weak
- custom manual fixes are introduced without reproducible rule expression
