# Step 1: Source Data Verification

## Objective

Confirm sources, identifiers, and classifications before downstream processing
so later steps do not rely on mismatched IDs or stale extracts.

## Actions

- Verify source provenance: request latest extracts, log source dates, and note
  any embargoed or draft data.
- Validate identifiers: CU IDs, POP_ID/site IDs, survey IDs, and species codes;
  confirm no duplicates or unexpected formats.
- Check classifications: site type, enhancement level, aggregation flags, and
  quality ratings; reconcile with the latest lookup tables.
- Confirm units and measurement basis (wild-only vs total, expanded vs
  observed).
- Record zero-policy per source (is zero biological, a missing value, or an
  unreported survey?).

## Outputs

- A verified source inventory with extract dates and contacts.
- Cleaned lookup tables for CU/site/survey IDs and classifications.
- A short verification note (date, scope, anomalies) saved with the data pull.

## Tips

- Use a repeatable script to ingest and validate source extracts; keep the
  checks lightweight and quick to rerun.
- Treat any change in classification (e.g., enhancement level) as a trigger to
  re-review inclusion rules in later steps.
- Store per-source verification notes in `DATA/verified/` alongside the cleaned
  extracts for auditability.
