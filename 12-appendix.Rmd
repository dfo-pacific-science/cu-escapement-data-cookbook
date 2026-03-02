# Appendix

## A. Minimal run-log template

```markdown
# Run Log — <species> — <run date>

## Inputs
- Source files used:
- Data pull dates:
- Lookup/crosswalk versions:

## Commands run
1.
2.

## Outputs generated
- CU file:
- Pop file:
- Tracking files:

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

## Impact on outputs/QC
```

## C. Minimal QC summary template

```markdown
# QC Summary — <species> — <run date>

## Required checks
- [ ] CU uniqueness `(CU_ID, Year)`
- [ ] Pop key checks
- [ ] Year coverage check
- [ ] Missingness review on core fields
- [ ] Prior-release diff reviewed

## Findings

## Pass/fail

## Reviewer
```

## D. Key reference links

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
  - `https://github.com/Pacific-salmon-assess/WSP-Rapid-Status-WorkedExamples`

### Public dataset context

- Open Canada: Pacific Salmon Conservation Units, Sites & Status:
  - `https://open.canada.ca/data/en/dataset/1ac00a39-4770-443d-8a6b-9656c06df6a3`

## E. Local method-context repos (for deeper reading)

- `code/Data-Standards`
- `code/Metadata-Questionnaire-CU-Series`
- `library/wsp-fisheries` (local source library and notes)
