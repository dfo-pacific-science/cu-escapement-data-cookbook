# Step 3: Record Selection

## Objective

Select the best usable record for each analysis key **after** basic
normalization and before final processing.

## Important distinction

A "selected record" is not always a raw source row.

Sometimes the selected record is:

- a cleaned source row,
- a recoded value,
- a merged record assembled from multiple inputs, or
- a record retained specifically for a pop or historical-context layer.

That is fine, as long as the rule is explicit.

## Do this exactly

1. Normalize obvious naming, timing, and estimate-class issues.
2. Define a deterministic selection hierarchy for the layer you are building.
3. Apply the hierarchy consistently.
4. Capture all overrides in the exception register and decision log.

## Recommended hierarchy template

1. preferred estimate class or estimate type,
2. preferred survey method or platform,
3. preferred verified source,
4. approved manual override,
5. escalate if a true tie still remains.

## Mandatory checks

- no duplicate selected rows by analysis key,
- biological zero vs missing is handled consistently,
- year assignment rule is explicit,
- output-layer intent is preserved.

## Hidden patches should be promoted into explicit exceptions

If you rename a system, override a timing group, suppress a year, or force a
value, put it in the exception register. Do not leave it buried in a script with
no run-level note.

## Typical analysis keys

Use the key that matches the layer you are building. For example:

- `CU_ID + Year` for CU time series,
- `Pop_ID + Year` or `CU_ID + Pop_Name + Year` for pop outputs,
- a species-specific stream/timing key for matching or pre-processing steps.

## Required outputs from Step 3

- `selected_records.csv`
- `selection_exclusions.csv`
- `selection_decisions.md`
- updated `exception-register.csv`

## Escalate when

- multiple records still tie after the full hierarchy,
- estimate-class changes cause large retrospective shifts,
- zero/missing ambiguity cannot be resolved from source documentation, or
- a manual fix would materially change interpretation without a clear rationale.

