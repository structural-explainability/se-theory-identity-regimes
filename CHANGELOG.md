# Changelog

<!-- markdownlint-disable MD024 -->

All notable changes to this project will be documented in this file.

The format is based on **[Keep a Changelog](https://keepachangelog.com/en/1.1.0/)**
and this project adheres to **[Semantic Versioning](https://semver.org/spec/v2.0.0.html)**.

## [Unreleased]

---

## [0.1.1] - 2026-04-29

### Added

reference/ files (manual creation / Lean checking):

- regime-classification-values.toml
- regime-families.toml
- regime-profile-derivation.toml
- regime-profiles.toml
- regime-transformations.toml

Reference certification layer is complete:

Classification values:

- IGN/PRS/BRK enumerated, nodup, complete

Regime families:

- 6 families, nodup, complete, order-faithful to TOML

Regime profiles:

- 9 profiles, nodup, complete, order-faithful to TOML order field

Profile derivation:

- flatMap matches profiles by membership,
- split count verified (3/3), nosplit singleton verified

Transformations:

- 10 transformations, nodup, complete, order-faithful to TOML

---

## [0.1.0] - 2026-04-28

### Added

Initial Lean 4 formal contract structure (`SEFormalContract`)

- Core modules: `Basic`, `Regime`, `Neutrality`,
  `Relation`, `Export`, `ExportJson`
- Public library root with stable import surface

Canonical identity regimes (`IdentityRegimes.Basic`):

- Six canonical regimes: `OBL`, `NOR`, `OCC`, `CTX`, `REC`, `ENR`
- `DecidableEq`, `Repr` derived

Regime predicates (`IdentityRegimes.Regimes`):

- `IsCanonicalRegime` predicate
- `all_regimes_canonical` theorem

Requirement structure (`IdentityRegimes.Requirements`):

- `Requirement` structure over canonical regimes
- `RequirementSatisfied` predicate over admissible substrates

Nine derived regime profiles (`IdentityRegimes.Profiles`):

- `RegimeProfileKind`: `OBL`, `OCC`, `REC`, `ENR_L`, `ENR_I`, `CTX_E`, `CTX_S`, `NOR_C`, `NOR_S`
- `RegimeProfileKind.regime`: map from each profile to its parent canonical regime
- `IdentityBasis`: `single`, `content`, `structure`, `extension`, `locus`, `instrument`
- `SplitTransformation`: `none`, `RF`, `AD`, `BF`
- `ProfileAxes`: identity basis and split-forcing transformation per profile
- `RegimeProfileKind.axes`: canonical axes for all nine profiles
- `UnderSplitPressure` predicate with `Decidable` instance
- Split pressure theorems for all nine profiles (`by decide`)
- `splitPressure_iff_refined_regime`: split pressure iff parent is ENR, CTX, or NOR
- `regime_map_not_injective`: distinct profiles can share a parent regime
- `no_split_regime_injective`: stable regimes have unique profiles
- `all_profiles_canonical`: every profile maps to a canonical regime

Transformation basis (`IdentityRegimes.Transformations`):

- `Transformation`: ten-family basis RE, AN, RF, AD, RC, RA, SU, BF, PV, SE
- `TransformationClass`: IGN, PRS, BRK, NA
- `classify`: total classification function over all nine profiles
- OBL, OCC, REC rows verified against SE-300 Section 4 canonical classification tables
- ENR_L, ENR_I, CTX_E, CTX_S, NOR_C, NOR_S rows verified against SE-300 split sections
- `IsPreserving`, `IsBreaking` predicates with `Decidable` instances
- `enr_splits_on_BF`: ENR_L preserves, ENR_I breaks under BF
- `ctx_splits_on_AD`: CTX_E preserves, CTX_S breaks under AD
- `nor_splits_on_RF`: NOR_C preserves, NOR_S breaks under RF

Non-collapse proofs (`IdentityRegimes.NonCollapse`):

- `NonCollapsing` predicate
- `noncollapse_ENR_L_ENR_I`: separated by BF
- `noncollapse_CTX_E_CTX_S`: separated by AD
- `noncollapse_NOR_C_NOR_S`: separated by RF
- `noncollapse_of_distinct_regime`: cross-family separation by distinct parent regime
- `noncollapse_all_pairs`: all 36 unordered pairs non-collapsing

Lower bound (`IdentityRegimes.LowerBound`):

- `derivedRegimeSet`: list of all nine profiles
- `derivedRegimeSet_card`: exactly 9 elements
- `derivedRegimeSet_nodup`: no duplicates
- `derivedRegimeSet_complete`: every profile kind present
- `derivedRegimeSet_pairwise_noncollapse`: all pairs non-collapsing
- `classification_pattern_unique`: classify injective on profiles
- `lower_bound`: any substrate must realize at least 9 non-collapsing profiles

Embedding and representation (`IdentityRegimes.Embedding`):

- `AdmissibleRelation`: five admissible relation types
- `RegimeVertex`, `RegimeEdge`, `RegimeGraph`: regime-typed multigraph structure
- `regimeAssignment_determined_by_classification`: regime assignment injective up to classification
- `representation_theorem`: each profile uniquely determined by classification behavior
- `derived_regime_set_no_behavioral_collapse`: no two distinct profiles behaviorally equivalent
- `nine_regime_lower_bound`: derived regime set witnesses the nine-profile lower bound

Admissibility (`IdentityRegimes.Admissibility`):

- `RegimeApplicationAdmissible`: regime application requires admissible neutral substrate

Theorems (`IdentityRegimes.Theorems`):

- `canonical_of_profile_well_formed`
- `regime_application_admissible_of_neutral`

Witness (`IdentityRegimes.Witness`):

- `oblProfile`: canonical OBL profile witness
- `oblProfile_well_formed`: OBL profile is well formed

Structural relation primitives:

- `equivalent`, `narrower`, `broader`, `overlaps`, `none`

Lean-based contract export layer:

- JSON export via `ExportJson`
- invariant registry
- regime registry
- relation registry
- proof registry

Python validation and CLI interface:

- validation module (`se_formal_contract.app`)
- CLI interface (`se_formal_contract.cli`, `__main__`)

Generated contract artifacts under `data/contract/`

SE manifest (`SE_MANIFEST.toml`) defining repository role as formal contract root

Migration scaffolding:

- `docs/migration/from-existing-formalizations.md`

Repository governance and tooling:

- `AGENTS.md`
- `CITATION.cff`

### Design constraints recorded

- Six regimes and nine profiles are distinct layers; profiles refine regimes, they do not replace them
- Semantic richness lives inside Lean only; no Python validation surface
- No operational or export layer in theory repos
- OCC/AD classified as BRK; OBL/BF as IGN; REC/BF as PRS: decisions recorded in SE-300 Section 4

---

## Notes on versioning and releases

- We use **SemVer**:
  - **MAJOR** – breaking changes to artifact structure or validation semantics
  - **MINOR** – backward-compatible additions to schema or validation rules
  - **PATCH** – fixes, documentation, tooling
- Versions are driven by git tags. Tag `vX.Y.Z` to release.
- Docs are deployed per version tag and aliased to **latest**.
- Sample commands:

```shell
# as needed
git tag -d v0.1.0
git push origin :refs/tags/v0.1.0

# new tag / release
git tag v0.1.0 -m "0.1.0"
git push origin v0.1.0
```

[Unreleased]: https://github.com/structural-explainability/se-theory-identity-regimes/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/structural-explainability/se-theory-identity-regimes/releases/tag/v0.1.0
