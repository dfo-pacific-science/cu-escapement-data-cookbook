# 2026-03-17 — CU Escapement Data Cookbook Stabilization + SPSR Handoff ExecPlan

This ExecPlan is a living document. Keep `Progress`, `Decision Log`, `Stable-state gates`, and `Outcomes` current as work proceeds.

## Purpose / Big Picture

Stabilize the **CU Escapement Data Cookbook** by the end of this week so it becomes the clear human-facing contract for:

1. how analysts build CU escapement outputs,
2. which QC artifacts prove the outputs are trustworthy,
3. how those outputs feed downstream WSP metrics/status workflows, and
4. how the same outputs can be wrapped as **CU Salmon Data Packages** and bridged into **SPSR** composite upload workflows.

The target is not just “more content.” The target is a cookbook that is:
- easy for a biologist to follow,
- explicit about hidden assumptions and exceptions,
- stable enough to hand off across repos and analysts,
- aligned with the longer-term **Salmon Data Package + ontology + SPSR** direction.

## Map

### Problem type
Cross-repo contract stabilization across documentation, data packaging, and downstream upload integration.

### Decision needed

1. What is the canonical analytical bundle produced by the cookbook?
2. What role should the Salmon Data Package (SDP) play now vs later?
3. How should cookbook outputs feed SPSR composite upload without making SPSR the cookbook’s canonical source of truth?
4. Which helpers belong in `metasalmon`, `WSP-Metrics-Pkg`, species repos, or a later thin utilities package?

### Conflicting models to harmonize

- **Species prep repos**: practical, production-tested, but inconsistent and full of local assumptions
- **WSP metrics/status repos**: downstream compute contract, but with some doc/file drift
- **Salmon Data Package / metasalmon**: packaging + metadata + semantics layer
- **SPSR composite upload**: consumer-specific CUYear ingestion path and roundtrip contract

### Stakeholders

- Brett / DSU (overall architecture + delivery)
- species analysts maintaining Fraser and related prep pipelines
- WSP metrics/status maintainers
- `metasalmon` / SDP maintainers
- SPSR maintainers and downstream upload users

## Stable-state principle

At every slice, leave the system in a state where:

1. the cookbook still reads cleanly,
2. one source of truth is obvious,
3. deferred work is explicit rather than hidden,
4. the next step can be picked up without re-deriving the architecture.

## Progress

- [x] Canonical source inventory shifted to `library/wsp-fisheries/sources.yaml`; duplicate cookbook `sources.md` removed.
- [x] Rapid status worked-example repo reference updated to `SOLV-Code/WSP-Rapid-Status-WorkedExamples`.
- [x] Cross-repo review sweep completed for:
  - species prep pipelines,
  - metadata/site-selection patterns,
  - WSP metrics/status tooling,
  - advanced methods,
  - harmonization architecture.
- [x] This ExecPlan created in the cookbook repo.
- [x] Add appendix link in the rendered guidebook.
- [x] Update core guidebook chapters to reflect the stabilized contract.
- [x] Add explicit SPSR composite-upload bridge section to this plan and the guidebook appendix.
- [x] Validate rendered guidebook for readability / concision.
- [ ] Commit and push to `main` once the guidebook reads cleanly.
- [x] (2026-03-17) Merge the chapter-level contract rewrite back into the main cookbook repo and preserve the in-repo ExecPlan as a tracked artifact.

## Decision Log

- Decision: `library/wsp-fisheries/sources.yaml` is the canonical repo/source inventory; the cookbook should not keep a second full source-of-truth list.
  - Rationale: duplicate source inventories drift immediately.

- Decision: treat `SOLV-Code/WSP-Rapid-Status-WorkedExamples` as the current canonical worked-example repo for rapid status material.
  - Rationale: it is materially more current than the `Pacific-salmon-assess` copy.

- Decision: use **one bundle, two layers**.
  - Analytical layer = small WSP/CU table bundle.
  - Packaging layer = Salmon Data Package wrapping that bundle.
  - Rationale: keeps daily workflow simple while preserving long-term interoperability.

- Decision: the cookbook’s human-facing contract should not be identical to whatever current repos happen to emit.
  - Rationale: production repos contain local drift, CSV hygiene issues, and hidden assumptions.

- Decision: `WSP-Metrics-Pkg` remains the compute engine, not the cross-repo workflow kitchen sink.
  - Rationale: keep compute responsibilities separate from normalization/packaging/provenance.

- Decision: SPSR upload shape is a **consumer bridge**, not the cookbook’s canonical analytical model.
  - Rationale: the cookbook should not let one downstream system distort the general bundle contract.
  - Note: SPSR’s bulk/package route still needs broader route coverage (at least CU/composite, SMU, and Population), but the cookbook remains focused on the CU/composite bundle that it actually authors.

## Target end-state for this week

By end of week, the stable state should be:

1. **Cookbook** clearly defines the operational CU/WSP bundle and required QC.
2. **Appendix** links to this plan and the key downstream contracts.
3. **SDP role** is explicit: release/handoff envelope, not authoring burden.
4. **Ontology role** is explicit: selective, useful semantics only.
5. **SPSR bridge** is explicit: cookbook package → derived SPSR composite-upload artifacts.
6. **Next implementation path** is externalized for `metasalmon`, `WSP-Metrics-Pkg`, and SPSR.

## Canonical bundle contract to stabilize in the cookbook

### Core analytical tables

These should become the named, repeatable cookbook bundle:

- `cu_timeseries`
- `wsp_metric_specs`
- optional `wsp_cyclic_benchmarks`
- recommended `cu_metadata`
- optional `published_integrated_statuses`

### Required sidecars

These stay human-readable and should **not** be forced into ontology-shaped tables:

- `run-log.md`
- `decision-log.md`
- `qc-summary.md`
- `metadata_notes.md`

### Core rule

The analytical bundle is the computational contract.
The Salmon Data Package is the exchange envelope around that contract.

## Work packages

## WP-0 — ExecPlan + appendix wiring

### Goal
Make the execution path visible from inside the guidebook.

### Tasks
- Add appendix link to this ExecPlan.
- Keep the plan in `docs/plans/` so it ships with the rendered site.
- Add explicit note that this plan is the active stabilization path for the cookbook.

### Stable-state gate
- A reader can move from the appendix directly to the active plan.
- The plan is stored in the repo, not hidden in chat or memory.

### Next step after gate
Start direct chapter edits against a visible plan rather than free-floating discussion.

## WP-1 — Core guidebook contract rewrite

### Goal
Upgrade the cookbook from “script orchestration notes” to a stable human-facing contract.

### Priority chapters
- `02-getting-started.Rmd`
- `04-site-survey-selection.Rmd`
- `06-record-processing.Rmd`
- `07-estimation.Rmd`
- `08-metadata-and-metric-specs.Rmd`
- `10-worked-examples.Rmd`
- `11-checklists-and-decision-trees.Rmd`
- `12-appendix.Rmd`

### Content upgrades required
- distinguish data layers explicitly (CU vs pop vs historical context vs downstream status tables)
- surface hidden exception logic through an exception register pattern
- promote intermediate QC artifacts to first-class outputs
- define real WSP bundle outputs rather than vague “metric-ready” prose
- rewrite worked examples around non-trivial review cases, not just runnable scripts

### Stable-state gate
- A biologist can identify: what they are producing, what assumptions shape it, and what files prove it passed review.

### Next step after gate
Formalize the bundle profile and its QC rules.

## WP-2 — Bundle profile + QC hardening

### Goal
Freeze the minimum bundle contract used between cookbook outputs and downstream WSP status tooling.

### Must document
- file/table names
- minimum required columns and optional fields
- `*_Wild` vs `*_Total` semantics
- cyclic benchmark requirements
- alignment checks between time-series and metric specs
- vocabulary/value checks (`Abs_Abd`, `RelIdx`, status/confidence values, etc.)

### Stable-state gate
- A reviewer can reject or accept a bundle using explicit checks rather than repo folklore.

### Next step after gate
Wrap the same bundle in a Salmon Data Package profile.

## WP-3 — Salmon Data Package + ontology boundary

### Goal
Make the SDP/ontology path explicit without burying the cookbook in semantic bureaucracy.

### Policy to document
- SDP is the **release/handoff envelope**.
- Core analytical tables remain the authoring and compute contract.
- Use semantic IRIs now only for:
  - true measurement columns,
  - important coded fields in `codes.csv`.
- Prefer `smn:` when a shared term exists.
- Use `gcdfo:` for DFO/WSP-specific constructs.
- Do **not** force I-ADOPT decomposition onto config flags, admin columns, or freeform QC notes.

### Stable-state gate
- The cookbook has a credible path to interoperable packaging, but still reads like a field manual.

### Next step after gate
Tie the release package to SPSR ingestion needs.

## WP-4 — SPSR composite-upload bridge

### Goal
Define the cleanest bridge from cookbook outputs to SPSR without making SPSR the canonical model.

### Current reality to respect
- SPSR composite route already behaves as a **CU-level** upload path (`data_level=CU`).
- SPSR composite route expects CUYear-style time-series + metadata files and WSP-capable headers / aliases.
- SPSR active roundtrip package contract `spsr.bulk.roundtrip.v1` currently **excludes composite** from the v1 exported bundle scope.

### Recommended bridge architecture

#### Canonical cookbook outputs
- `cu_timeseries`
- `wsp_metric_specs`
- optional `wsp_cyclic_benchmarks`
- `cu_metadata`
- sidecars (`run-log.md`, `decision-log.md`, `qc-summary.md`, `metadata_notes.md`)

#### Release package
- Salmon Data Package containing the canonical bundle + metadata/dictionary/codes + sidecars

#### Preferred SPSR target model
- SPSR should grow a **package-first CU Salmon Data Package intake mode** for cookbook-origin composite/WSP deliveries.
- In that model, SPSR reads the package directly, prefills metadata/review state, and performs the CU bundle → `CUYear` mapping internally.
- This keeps contributors from having to unpack or hand-manage SPSR-specific bridge files.

#### SPSR bridge export (derived, consumer-specific)
Until package-first SPSR intake exists, generate a derived SPSR-ready pair from the canonical bundle:
- `data/cuyear.csv`
- `data/cu_metadata.csv`

with:
- SPSR-compatible headers / aliases,
- composite-route provenance note,
- explicit route target = `composite`,
- recognition that SPSR persists composite as `data_level=CU`.

### This week’s stable decision
For this week:
- treat **package-first SPSR intake** as the preferred target architecture,
- treat the **SPSR bulk upload route** as the place that should converge on that package-first CU Salmon Data Package contract,
- treat **SPSR bridge export** as the operational fallback handoff until that package-first route exists,
- do **not** block cookbook stabilization on SPSR adding composite to the active v1 roundtrip export contract.

### Follow-on SPSR decision
SPSR should now aim to:
1. implement package-first Salmon Data Package intake for cookbook-origin composite/WSP deliveries **on the bulk upload route**,
2. make sure that same bulk/package route also supports at least SMU and Population package lanes,
3. keep direct CSV wizard upload as compatibility mode, and
4. then decide whether composite support lands as an extension of `spsr.bulk.roundtrip.v1` or as an explicit v2 contract.

### Stable-state gate
- No one has to guess whether cookbook outputs can feed SPSR.
- The answer is explicit: canonical bundle first, derived SPSR bridge second.

### Next step after gate
Externalize required helper functions and contract tests.

## Key external references

- SPSR roundtrip package contract:
  - `/Users/alan/.openclaw/workspace/code/salmon-population-summary-repository/docs/contracts/spsr-roundtrip-package-contract-v1.md`
- SPSR integrated route contract / composite route behavior:
  - `/Users/alan/.openclaw/workspace/code/salmon-population-summary-repository/demo/wizard_route_contract.py`
  - `/Users/alan/.openclaw/workspace/code/salmon-population-summary-repository/docs/entrypoints.md`
- WSP composite → CUYear semantic mapping:
  - `/Users/alan/.openclaw/workspace/code/salmon-population-summary-repository/docs/wsp-cuyear-semantic-mapping.md`
- SPSR production umbrella plan:
  - `/Users/alan/.openclaw/workspace/code/salmon-population-summary-repository/docs/plans/2026-02-18-spsr-production-ready-unified-execplan.md`
- SPSR package-first CU SDP intake model:
  - `/Users/alan/.openclaw/workspace/code/salmon-population-summary-repository/docs/plans/2026-03-17-package-first-cu-sdp-intake-model.md`
- Salmon Data Package specification:
  - `/Users/alan/.openclaw/workspace/code/smn-data-pkg/SPECIFICATION.md`
- `metasalmon` package home:
  - `/Users/alan/.openclaw/workspace/code/metasalmon`

## WP-5 — Reusable helper implementation path

### Goal
Externalize the normalization / validation / packaging layer into code, without wrecking package boundaries.

### First-stop package home
Add thin helpers to `metasalmon` first, then split later only if the boundary becomes awkward.

### Candidate helpers
- `validate_cu_series()`
- `validate_pop_series()`
- `validate_wsp_metric_specs()`
- `validate_wsp_bundle_alignment()`
- `build_qc_summary()`
- `build_run_manifest()`
- `wrap_cu_status_bundle()`
- `export_release_sdp()`
- `export_spsr_composite_bridge()`

### Keep out of scope for now
- species-specific infill logic
- Fraser-specific estimation rules
- hidden exception logic masquerading as “generic” package code

### Stable-state gate
- Package responsibilities are clear enough that future implementation does not require re-arguing the architecture.

### Next step after gate
Implement the smallest useful helpers in `metasalmon` and thin validators in `WSP-Metrics-Pkg`.

## Risks / anti-patterns to avoid

- Creating duplicate source inventories again.
- Treating current repo outputs as normative just because they already exist.
- Letting SPSR file shapes become the cookbook’s canonical analytical model.
- Forcing ontology detail onto fields where it adds pain but no clarity.
- Trying to genericize local Fraser exception logic into a fake universal framework.
- Adding a vague “salmon utilities” package that becomes a junk drawer.

## Concrete deliverables for this repo

1. This ExecPlan in `docs/plans/`.
2. Appendix link to this plan.
3. Chapter edits reflecting:
   - explicit data layers,
   - explicit WSP bundle contract,
   - stronger QC,
   - worked examples based on real review decisions,
   - SDP/SPSR bridge explanation.
4. Rendered guidebook refresh in `docs/`.

## Sequenced clean stop points

1. **Planning lock**
   - cookbook exec plan, SPSR exec plans, and SDP spec all point at the same architecture
2. **Spec/layout lock**
   - SDP spec, `metasalmon`, and example package all agree on canonical `metadata/` + `data/` layout
3. **Cookbook contract lock**
   - guidebook names the canonical CU/WSP bundle, required QC, and the SDP boundary cleanly
4. **SPSR target lock**
   - plans clearly state that the bulk upload route should become the package-first route-scoped SDP intake path, with cookbook work using the CU/composite subset first
5. **Bridge fallback lock**
   - until package-first intake ships, the cookbook documents the derived SPSR bridge as fallback rather than pretending the long-term model is already done
6. **Guidebook rewrite lock**
   - chapter-level edits land and the guidebook reads cleanly for a biologist
7. **Implementation lock**
   - next package/code slices in `metasalmon`, `WSP-Metrics-Pkg`, and SPSR can proceed without re-arguing the architecture

Each stop point should be shippable and understandable on its own, so if work pauses after any step the next maintainer inherits a coherent state rather than a half-explained one.

## Validation and acceptance

This slice is accepted when all of the following are true:

1. The appendix links to this plan.
2. The guidebook clearly names the core bundle and required QC artifacts.
3. The guidebook explains SDP as the release envelope, not the day-to-day authoring burden.
4. The guidebook explains the SPSR bridge as a derived consumer export.
5. The rendered guidebook reads cleanly enough for a biologist and stays concise.

## Outcomes

Pending. Update this section as concrete slices ship.
