# Appendix

## A. Minimal run-log template

```markdown
# Run Log — <species> — <run date>

## Inputs
- Source files used:
- Annual/static/conditional status:
- Data pull dates:
- Lookup/crosswalk versions:
- Hard-coded file-name handling:

## Layers produced
- CU trend:
- CU abundance:
- Pop representation:
- Historical context:

## Commands run
1.
2.

## Outputs generated
- CU file:
- Pop/context file:
- Tracking files:
- Bundle files:

## Notes
- Deviations from standard pattern:
- Open issues:
```

## B. Minimal decision-log template

```markdown
# Decision Log — <species> — <run date>

## Decision

## Why this decision was needed

## Options considered
- Option 1:
- Option 2:

## Chosen approach

## Affected layer(s)

## Impact on outputs / QC
```

## C. Minimal QC summary template

```markdown
# QC Summary — <species> — <run date>

## Required checks
- [ ] CU uniqueness `(CU_ID, Year)`
- [ ] Pop/context key checks
- [ ] Year coverage check
- [ ] Intermediate QC artifacts reviewed
- [ ] Exception register reviewed
- [ ] Prior-release diff reviewed
- [ ] Bundle alignment checked

## Key evidence files
- Matching / decomposition / tracking files:
- Release diff:
- Metadata / specs:

## Findings

## Pass / fail

## Reviewer
```

## D. Exception-register template

```csv
species,output_layer,object,years_affected,rule_type,implemented_in,rationale,review_required,reviewer_notes
```

## E. Selection-layer matrix template

```csv
output_layer,intended_use,selection_basis,source_files,expected_review_artifacts,notes
cu_trend,trend metrics,WSP/indicator systems,,,
cu_abundance,abundance or benchmark roll-up,abundance/SR systems,,,
pop_representation,pop reporting/context,broader mapped stream set,,,
historical_context,legacy continuity,historical source layer,,,
```

## F. Canonical bundle quick reference

| File | Required? | Role |
|---|---|---|
| `cu_timeseries.csv` | Yes | canonical CU series |
| `wsp_metric_specs.csv` | Yes | downstream metric/status configuration |
| `wsp_cyclic_benchmarks.csv` | Conditional | cyclic benchmark support |
| `cu_metadata.csv` | Recommended | context, provenance, interpretation |
| `run-log.md` | Yes | run trace |
| `decision-log.md` | Yes | explicit method decisions |
| `qc-summary.md` | Yes | release evidence |
| `metadata_notes.md` | Recommended | unresolved items and caveats |

## G. Derived consumer bridge note

If another system needs a different file shape, create it **after** the
canonical bundle passes QC. Treat exports such as a Salmon Data Package or a
derived `cuyear.csv` as handoff products, not the primary analytical model.

## H. Active stabilization plan and local source inventory

- Active cookbook stabilization plan:
  - [2026-03-17 CU cookbook stabilization ExecPlan](plans/2026-03-17-cu-cookbook-stabilization-execplan.md)
- Canonical local source inventory:
  - `library/wsp-fisheries/sources.yaml`

## I. Key reference links

### Policy and core methods

- Wild Salmon Policy (DFO page):
  - `https://www.pac.dfo-mpo.gc.ca/fm-gp/salmon-saumon/wsp-pss/policy-politique-eng.html`
- Conservation Units (CSAS 2007/070):
  - `https://www.dfo-mpo.gc.ca/csas-sccs/publications/resdocs-docrech/2007/2007_070-eng.htm`
- Indicators and benchmarks (CSAS 2009/058):
  - `https://www.dfo-mpo.gc.ca/csas-sccs/publications/resdocs-docrech/2009/2009_058-eng.htm`
- Rapid status approximation context (CSAS ScR 2024/004):
  - `https://www.dfo-mpo.gc.ca/csas-sccs/Publications/ScR-RS/2024/2024_004-eng.html`

### Core code packages

- WSP Metrics package:
  - `https://github.com/Pacific-salmon-assess/WSP-Metrics-Pkg`
- Rapid status worked examples:
  - `https://github.com/SOLV-Code/WSP-Rapid-Status-WorkedExamples`

### Public dataset context

- Open Canada: Pacific Salmon Conservation Units, Sites & Status:
  - `https://open.canada.ca/data/en/dataset/1ac00a39-4770-443d-8a6b-9656c06df6a3`

## J. Local method-context repos (for deeper reading)

- `code/Data-Standards`
- `code/Metadata-Questionnaire-CU-Series`
- `library/wsp-fisheries` (local source library and notes)

