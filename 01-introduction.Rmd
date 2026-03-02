# Introduction

## What this guide is

A **follow-me cookbook** for building CU-based escapement time series for State
of the Salmon and Wild Salmon Policy (WSP) workflows.

This guide is intentionally practical: if you are in a known situation, you
should be able to find the matching pattern and run it step-by-step.

## Who this is for

- Biologists and analysts building CU time series for the first time
- Analysts who already build CU series but want reusable patterns and QA checks
- Reviewers who need a clear record of what was done and why

## What this guide is not

- Not a full replacement for expert judgement
- Not a complete catalog of every CU edge case
- Not a place to reinvent existing code already used in production workflows

## What you will produce

- CU-level time series outputs (wild/total as needed)
- Pop-level supporting outputs where applicable
- Metadata and metric-spec inputs suitable for WSP metric runs
- A repeatable run log and QC evidence package

## How to use this cookbook

### Lane A: First-time user (linear)

1. Read **Getting Started** (Chapter 2)
2. Follow workflow steps (Chapters 3–8)
3. Pick the nearest **Pattern Card** (Chapter 9)
4. Run a **Worked Example** (Chapter 10)
5. Complete checklists (Chapter 11)

### Lane B: Experienced user (lookup)

1. Jump to **Pattern Cards** (Chapter 9)
2. Run the matching script path
3. Use checklists (Chapter 11) for release QC

## Five-step workflow at a glance

1. Source data verification
2. Site/survey selection
3. Record selection
4. Record processing
5. Estimation to CU-level series

In parallel: complete metadata + metric specifications so the outputs can be
reviewed and reused.

## Core principles

- **Reuse before rewrite**: start from existing species workflows
- **Document every exception**: no hidden “magic” edits
- **QC is part of the run**: uniqueness, year coverage, schema checks
- **Keep decisions explicit**: when to apply a pattern, and when to escalate

## Policy and method anchors

This cookbook aligns to core WSP references and related status-assessment
methods:

- WSP policy page: `https://www.pac.dfo-mpo.gc.ca/fm-gp/salmon-saumon/wsp-pss/policy-politique-eng.html`
- CSAS 2007/070 (Conservation Units)
- CSAS 2009/058 (Indicators and benchmarks)
- CSAS ScR 2024/004 (Rapid status approximation context)

## Limits and escalation

If your case does not match a pattern card (or fails QC), stop and escalate to a
custom workflow with documented assumptions.
