# Step 2: Site and Survey Selection

## Objective

Decide which sites and surveys belong in the CU workflow using transparent,
repeatable rules.

## Actions

- Apply verification status and quality class rules (e.g., include persistent,
  exclude aggregated/unknown quality).
- Apply enhancement rules (e.g., include low/unknown enhancement; handle
  moderate/high per species policy).
- Resolve aggregation issues: avoid double-counting when sites roll up to
  broader survey areas.
- Generate inclusion/exclusion text directly from the lookup to keep metadata
  aligned with the decision logic.
- Record special cases: extinct/extirpated sites, sites under reconstruction,
  and sites whose estimates are proxies for others.

## Outputs

- A curated list of sites/surveys to include, with rationale.
- Templated site-selection text for the metadata chapter.
- Flags for sites requiring special handling (enhancement, aggregation,
  data-deficient).

## Tips

- Keep the selection criteria in a spec file (CSV/YAML) to avoid editing code
  when rules change.
- Re-run selection whenever classifications change in the source systems.
- If selection yields very few sites, document why (e.g., data deficient) and
  whether indicator scaling will be required downstream.
