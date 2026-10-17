# NOTEv11: Known holes (working record, not accepted theory)

Status codes:

- OPEN: known missing.
- LIMIT: documented in source, kept visible.
- UNVERIFIED: suspected, not checked.

Source names are the files supplied in the session.

## A. Missing structure

H11-01 OPEN. Observability has two partial homes and no bridge.
  Persistence/Relation/Invariance.lean has `observationalEquivalence Φ` over a family of predicates.
  Transformation/Effect/Model.lean has per-dimension `agree` and no notion of a presentation.
  Closes when: a stated relation between Φ and dimension agreement.

H11-02 OPEN. "Meaningful for the referent" exists only at transformation level
  (`Classification.Applicable`, `pattern t = none`), not at dimension level.

H11-03 OPEN. "Known with justified confidence" has no home.
  `Dimension.evidence` is first-order metadata attached to participants.
  There is no layer for warranted belief about a dimension.

H11-04 OPEN. Invariance warrant.
  `Φ ⊆ relationInvariants r` is a hypothesis of the soundness theorems.
  Nothing says how an observable is justified as invariant.
  The justification is relative to a threat or error model.

H11-05 OPEN. Completeness warrant.
  `observational_completeness_iff_invariant_saturation` characterizes completeness.
  Nothing says when it can be warranted for a referent kind.
  Positive co-reference from finite observation needs it.
  Separation needs only one justified invariant that differs.

H11-06 OPEN. Independent records.
  Persistence relates two states of one carrier under a given dynamics.
  Nothing models two records produced by separate processes, or their causal separation.

H11-07 OPEN. Denotation.
  `ReferentCarriers` (Carriers.lean) are three abstract types unrelated to records.
  The `Dynamics` carrier `C` is not tied to them in the files supplied.
  The profile files were not seen.

H11-08 OPEN. Two transformation vocabularies with no mapping.
  Transformation theory has 17 operators, 14 families, 7 kinds and 11 dimensions.
  IdentityRegimes has 10 transformation classes and 9 regimes.
  `Vocab/TransformBasis.lean` was not seen.
  The RE column is IGN in all nine regimes, and what RE denotes is unknown.

H11-09 OPEN. Derived-versus-tabulated check not performed.
  `step_preserves` and `step_breaks` could force some cells of the 9×10 matrix.
  Requires H11-08 plus per-regime identity-relevant dimension sets.
  Most cells would stay undetermined, because footprints are upper bounds.

H11-10 OPEN. Two missing maps.

- World operation → OperatorCode.
- Observed field → Dimension.
  Without them, footprints and requirements say nothing about any observed system.

H11-11 OPEN. Disjunctive required clauses leave "same referent?" undecided.

- CP requires refPop or repPop.
- MG requires composition or refPop.
- VS requires lineage only.
  No rule supplies which one applies.

H11-12 OPEN. Content sensitivity (likelihood form) is not formalized.

H11-13 OPEN. Directed versus symmetric evidence.
  `Survives` is directed and `identityRel` is symmetric.
  Directed evidence such as successive file states is not related to either.

## B. Limits kept visible

H11-20 LIMIT. BRK has no consequence for `identityRel` on general dynamics.
  `stepBrk_not_separating`: only PRS cells generate identity.
  Separation on free dynamics only (`not_identityRel_of_stepBrk_free`).

H11-21 LIMIT. N/A is folded into IGN in `classificationMatrix` (acknowledged in Core.lean).
  `identityRel_eq_of_coarse_eq`: identity is unaffected, but applicability is lost.

H11-22 LIMIT. Equal PRS sets, OBL/NOR-C and CTX-S/NOR-S.
  They are separated only by carrier, which is not modeled.

H11-23 LIMIT. Non-collapse results assume one shared carrier.

H11-24 LIMIT. Footprints are upper bounds.
  An omitted dimension is an assertion about the named operator.
  Incidental changes are separate steps.
  The theory constrains an operator, not a tool's behavior.

## C. Terminology collisions

H11-30 "dimension".

- Dimension.lean: an axis of change.
- Semantics.lean also says "principal structural dimension of change".
- Proposed "structural dimensions": referent properties.

H11-31 "evidence".

- `Dimension.evidence`: claims, verification and attestation metadata.
- URS: what justifies a conclusion.

H11-32 "observational".

- TransformationKind.observational: AT, CP and PR.
- `observationalEquivalence` in Persistence.
- Proposed "observability".

H11-33 "invariant".

- Persistence `Invariant`.
- Paper 100 framework-invariance (flagged in Invariance.lean).

H11-34 "IGN" is written NEU in SE-200 (ClassificationValue.lean).

H11-35 UNVERIFIED. `Traceable` in StructuralExplainability.lean versus provenance traceability.
  The definition was not retrieved; summary-level fetch only.

## D. Paper 100

H11-40 Stable reference lists individuation, co-reference and persistence.
  "unity", "denotation" and "observability" do not occur. The only "denot" hits are the verb "denote".

H11-41 Co-reference is a condition only. It has no warrant side.

H11-42 Referential Common Ground is likely to fail for evidence-relative co-reference of occurrences.
  The boundary section's attributed-claim treatment is not worked out for it.

H11-43 The promised analysis of which regimes yield common-ground commitments
  (Definitions section, after Referential Regime) is not delivered.

H11-44 The boundary example (two records, same or distinct institutional event)
  is not tied to any evidence criterion.

## E. Case-study holes

H11-50 DCS: BLOCKED (evidence access). Carry M1–M8 and R1–R5 from v0.10 unchanged.

H11-51 No occurrence kind with causally separate records identified.
  The vulnerability-matching repo is unread.

H11-52 Pilot observations (facts about what the pilot can show; the pilot repo owns any action):
  a. `noncanonical_slots` is declared only for CycloneDX.
     SPDX loaders never fill `other_purls`.
     A relocation into an SPDX target is reported as VIOLATED_DROPPED.
  b. design.md: 8 CycloneDX + 2 SPDX sources, 20 executable routes = 16 CycloneDX→SPDX + 4 SPDX→CycloneDX.
     Relocation is observable in at most 4 of 20 routes.
  c. NOT_APPLICABLE merges "no PURL" and "unparseable PURL".
     An unparseable target canonical PURL yields DROPPED, not ALTERED.
  d. UNSUPPORTED is unreachable under the current commitment (`representable_in` lists all three formats).
  e. test.md's outcome list omits UNDERDETERMINED.
  f. `purl_canonical.py` uses `except TypeError, ValueError:`, valid only on Python 3.14+.
  g. UNVERIFIED. The SPDX 3.0 adapter reads `packageUrl` and `spdxVersion`.
     Real JSON-LD field names were not confirmed.
  h. The DROPPED detail string ("absent from the anchored target component")
     overstates what the adapter observes (canonical and declared noncanonical slots only).
  i. Anchors are declared hashes, never computed.
     Anchor preservation is untested (schema.md assigns it to a separate commitment).
  j. Source and target are dependent by construction.
     The pilot does not test independent co-reference.

## F. Reading debt

- SE.Substrate.ReferentialRegime / SubstrateSystem / Commitment / ReferentialCommitments.
- SE.IdentityRegimes: Vocab/TransformBasis.lean and Profile/Core.lean.
- SE-300 §4–5.
- SE.NeutralSubstrate.Attribution.Permitted and CommonGround.
- se-verification-vulnerability-matching.
- Pilot files:
  - 03-corpus.toml
  - 05-transformations.toml
  - build_and_selftest.py
  - FREEZE_01_COMMITMENT_EVALUATOR.md
  - known_violations.toml
  - a real SPDX 3 sample
