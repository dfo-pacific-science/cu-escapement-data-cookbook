# Step 3: Record Selection

## Objective

Select the single best usable record per analysis key (typically Pop/CU + Year)
before processing adjustments.

## Do this exactly

1. Define a deterministic selection hierarchy.
2. Apply it consistently.
3. Capture all overrides in a decision log.

## Recommended hierarchy template

1. preferred estimate class/type
2. preferred survey method/platform
3. preferred verified source
4. manual expert override (must be documented)

## Mandatory checks

- no duplicate selected rows by key
- zero-policy applied consistently (biological zero vs missing)
- year assignment rule is explicit (`UseYear` or equivalent)

## Example implementation patterns

- Coho workflow can be configured to use WSP-only systems vs broader set;
  document your setting in the run log.
- Sockeye workflow uses run-timing-aware matching and custom handling for known
  problematic stream/year combinations; keep these choices explicit.

## Required outputs from Step 3

- `selected_records.csv`
- `selection_decisions.md`
- `selection_exclusions.csv`

## Escalate when

- multiple records tie after full hierarchy
- estimate-class shifts cause large retrospective changes
- zero/missing ambiguity cannot be resolved from source documentation
