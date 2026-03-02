# Step 2: Site and Survey Selection

## Objective

Build a transparent inclusion/exclusion set of sites/surveys for each CU.

## Do this exactly

1. Start from the verified lookup/crosswalk tables.
2. Apply inclusion rules (quality, verification state, enhancement policy).
3. Apply exclusion rules (aggregation duplicates, data-deficient records,
   explicit policy exclusions).
4. Export machine-readable include/exclude lists.
5. Export plain-language summary text for metadata.

## Minimum rule set to document

- quality threshold used
- enhancement handling rule
- aggregation/double-counting rule
- special-case handling rule

## Practical implementation notes from existing repos

- Sockeye: selection is tightly coupled to stream maps and run timing; keep
  decoder + stream lists synchronized.
- Coho: tributary names must align to POPID crosswalk for clean output joins.
- Chum/Pink: selection is simpler, but source table structure still needs year
  and naming consistency checks.

## Suggested output artifacts

- `site_selection_include.csv`
- `site_selection_exclude.csv`
- `site_selection_summary.md` (human-readable rationale)

## Optional helper (from Data-Standards repo)

The source technical workflow includes helper patterns for generated
site-selection narrative text:

- `code/Data-Standards/FUNCTIONS/FUNCTION_extract_SiteSelectionText.R`

## Escalate when

- site counts change sharply from prior release without clear cause
- key systems disappear due to naming or lookup drift
- inclusion rules conflict across source datasets
