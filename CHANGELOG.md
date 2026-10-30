# Changelog

<!-- markdownlint-disable MD024 -->

All notable changes to this project will be documented in this file.

The format is based on **[Keep a Changelog](https://keepachangelog.com/en/1.1.0/)**
and this project adheres to **[Semantic Versioning](https://semver.org/spec/v2.0.0.html)**.

---

## [Unreleased]

### Planned

- Evaluate removal of the direct Neutral Substrate dependency.
  - Separate substrate-specific admissibility from the core identity-regime
    theory, potentially through a downstream integration layer.
  - Reassess `RequirementSatisfied`, currently defined as `True`, and
    `RegimeApplicationAdmissible`, currently defined by substrate neutrality.
  - Preserve any scientifically meaningful connections and account for
    changes to public Lean interfaces, tests, and reference registries.

- Reconcile legacy classification declarations with derived verdicts.
  - Distinguish stipulated matrix entries from model-derived results.
  - Review claims that transformation families necessarily force
    identity distinctions; such claims may require explicit warrants.
  - Preserve the distinctions among NA, MIX, NEU, PRS, and BRK and
    between family-level and step-level identity relations.

- Investigate coherence across the derived classification matrix.
  - Establish when separately certified cells admit a compatible
    interpretation of their transformation families and identity bases.
  - Make field granularity, applicability, and additional warrants explicit.
  - Extend derivations selectively where adequate models can be justified,
    rather than treating completion of all 90 cells as a scientific goal.

- Investigate formal interoperability with Transformation theory.
  - Establish justified correspondences between structural operators,
    presentation effects, and identity-regime transformation families.
  - Prefer a downstream bridge that preserves the independence of both
    theories and proves conditional results.

- Evaluate scientific adequacy against concrete transformation cases.
  - Identify intended referents and independently justified identity criteria.
  - Compare modeled steps and verdicts with observable system behavior.
  - Distinguish formal correctness, model conformance, and warranted
    real-world identity judgments.

- Strengthen Lean-to-reference traceability.
  - Detect missing or stale reference entries for public definitions
    and theorems in both directions.
  - Preserve Lean source and hand-maintained RR annotations as authoritative.

---

## [0.7.1] - 2026-10-30

### Updated

- Updated the Lean toolchain (see `lean-toolchain`).
- `rel.ps1`: added `lake clean`, `CITATION.cff` validation, and Markdown lint.
- `ci-lean.yml`: added `CITATION.cff` validation, SE manifest validation,
  Markdown lint, and cancellation of superseded runs on the same branch.
- `leanchecker` and the axiom audit are skipped in this repo because it
  depends on other SE theory packages. A source scan for `axiom`
  declarations and `native_decide` runs instead.

---

## [0.7.0] - 2026-10-27

### Added

- `Model/Scope`: AD on scopes with the whole organization in a single field.
  - AD is declared in two ways: strict (preserves coverage) and loose (may also
    change coverage).
  - Extension-fixed and structure-fixed bases.
  - Derived verdicts: strict AD is `prs` for the extension basis and `brk` for
    the structure basis; loose AD is `mix` for the extension basis.
  - A domain containing the AD step separates the bases; a domain without it
    collapses them.
- `Model/ScopeEntries`: AD on scopes with one field per pair of cases.
  - The extension basis reads the diagonal pairs; the structure basis reads every
    pair. Both supports are proven minimal.
  - Strict AD is proven to write only off-diagonal pairs, so its verdict for the
    extension basis is `neu`.
- `Model/Rule` and `Model/RuleEntries`: RF on rules, with the same two
  granularities.
  - Strict RF keeps coverage and every norm; loose RF may change norms.
  - Content-fixed and structure-fixed bases.
  - Strict RF is `neu` for the content basis with field-level supports, `prs`
    with a single field, and `brk` for the structure basis.
  - Loose RF is `mix` for the content basis.
  - The content and structure supports are proven minimal.
- `Model/Fork`: BF on plain referents, with branching represented independently
  of identity.
  - A fork changes only the branch. Whether a continuation stays at the locus or
    is the same object is a named warrant (`Colocated`, `FreshObject`,
    `SameObject`) taken as an explicit hypothesis.
  - Without a warrant BF is `mix` for both the locus and object bases.
  - Under `Colocated` and `FreshObject`: locus `neu`, object `brk`.
  - Under `Colocated` and `SameObject`: locus `neu`, object `neu`, and the two
    bases collapse on every domain.
- `Reference/DerivedMatrix`: the derived classification matrix, kept beside the
  stipulated one.
  - A derived cell is an effect model of one family, an invariant basis, and a
    proof of the verdict the model gives.
  - Six cells are derived: CTX_E, CTX_S, NOR_C, NOR_S, ENR_L and ENR_I at the
    families AD, RF and BF respectively. Every other cell is `none`.
  - Derived and stipulated cells agree on breaking for the six derived cells;
    84 remain unexamined (`derived_agrees_on_breaking`).
- RR annotations and reference registry entries for the new models and the
  derived matrix.
- A derived cell requires a justified (minimal) support for its basis. The fork
  bases have minimality proofs.
- `derivedVerdict` exposes the full five-valued verdict: `none` means no model has
  been written, and `some .na` and `some .mix` are modeled results.

### Notes

- The stipulated matrix in `Transform/Core` is unchanged.
- The three derived `neu` cells are `prs` in the stipulated matrix. The
  difference comes from field granularity; both are non-breaking.
- The ENR_L and ENR_I cells hold only under the named fork warrants.
- RF as defined in the transformation basis includes normative detail. Read that
  way it is `mix` for the content basis, and the family must be refined before it
  can be entered in a classification table.
- The remaining cells have no derived model yet.

---

## [0.6.0] - 2026-10-26

### Added

- `Profile/Invariant`: invariant-defined identity bases (`InvariantBasis`),
  each with a declared support, a `Minimal` justification predicate for the
  support, and `inv_eq_of_off_support`.
- `Transform/Effect`: effect models (`EffectModel`) whose steps are bounded by
  declared write sets; effective instances; applicability as a property of the
  presentation space rather than of a finite domain.
- Derived classification verdicts relative to a basis: `na`, `brk`, `mix`,
  `prs`, `neu`. Verdicts are mutually exclusive and exhaustive
  (`hasVerdict_unique`, `hasVerdict_exists`).
  `mix` is not a classification value; it marks a family that must be refined.
- A family that may write no supported field is neutral for the basis
  (`noneBreak_of_writes_off_support`, `not_engages_of_writes_off_support`).
- `Transform/StepIdentity`: identity relation generated by the
  invariant-preserving steps inside a domain, built from steps rather than from
  family verdicts.
- Soundness of the generated relation (`stepIdentity_sound`).
- Collapse holds exactly when the two bases agree on every step in the domain
  (`collapse_iff_stepAgree`).
- A single step that one basis preserves and the other changes separates the
  generated relations (`separation_of_step`, `not_collapse_of_step`).
- Separation persists on every larger domain (`not_collapse_mono`).
- A split between verdicts supplies a witnessing instance
  (`exists_instance_of_split`, `not_collapse_of_split`).
- Relation to the Persistence identity relation: it is always contained in the
  step-level relation, and equal to it when every family is uniform
  (`identityRel_le_stepIdentity`, `stepIdentity_eq_identityRel_of_uniform`).
- `SETest/IdentityRegimes/Model/ScopeToy`: two finite models.
  - Extension-fixed and structure-fixed scope bases: the AD verdicts differ
    (`prs` and `brk`), the bases collapse on a domain with annotation steps
    only, and they separate when one AD step is added.
  - A basis reading only the block that contains `a`: AD has verdict `mix`, and
    the bases still collapse on a domain that contains an AD step.

### Notes

- The 9 x 10 classification matrix in `Transform/Core` remains stipulated.
  The new modules define how classifications can be derived;
  they do not yet certify that matrix.
- The new results apply to identity bases given as invariants of presentations.
- The new modules depend only on Lean core and `SE.Persistence`.

## Earlier changes also included (not actually tagged as 0.5.0)

### Updated

- Clarified that nine distinct classification rows do not establish nine distinct generated identity relations.
- Documented the OBL/NOR-C and CTX-S/NOR-S identity-relation collapses.
- Corrected the scope of non-collapse, lower-bound, and representation theorem descriptions.
- Recorded unresolved scientific grounding obligations for identity-regime classification.
- Corrected repository scope and public import documentation.
- moved out lint/
- replaced Mathlib with MathlibMini
- minor documentation updates
- partial uvx pup-up of supporting files
- clarifications
- Updated license notice.
- Added headers to Lean files.

### Removed

- Historical identity-foundations research drafts after
  transferring findings to authoritative theory documentation.

---

## [0.4.0] - 2026-10-16

### Added

- Added a dependency on Persistence `v0.4.0`, reusing its canonical `ClassificationValue` type.
- Added `PersistenceBridge.lean` to connect the nine-regime classification matrix to `SE.Persistence.Classification`.
- Restored applicability distinctions for the eight cells previously mapped from N/A to IGN.
- Added theorems showing that the original classification matrix is recovered when applicability is forgotten and that preserving classifications agree with Persistence.
- Added identity-level non-collapse analysis, including two pairs of regimes with distinct classification rows but identical generated identity relations on every shared dynamics.

### Removed

- Removed the duplicate Identity Regimes `ClassificationValue` inductive type and its separate classification-value reference registry.

### Changed

- Updated Lean classification references to use Persistence's `.ign`, `.prs`, and `.brk` constructors.
- Updated the dependency declarations, reference registries, and generated artifacts to reflect Persistence ownership of classification values.
- Depends on se-theory-persistence; no longer depends directly on
  se-theory-transformation, which no module imported
- Documented that `nine_regime_lower_bound` and `NonCollapsing` hold at row level
  only
- Distinguished classification-row non-collapse from non-collapse of generated identity relations.
- Preserved the nine canonical regimes, ten transformations, 9 × 10 classification matrix, and existing classification counts.

### Fixed

- Aligned the Transformation manifest and dependency registry with the existing
  `v0.5.1` Lake pin and refreshed the upstream vocabulary documentation,
  including effect semantics and the `splitAndMerge` orthogonality rule.
- Corrected reference-tool command names, upstream package paths in the docs
  workflow, and the Lean CI test-driver command.
- Regime definitions, counts, classification rows, preserving sets, and
  non-collapse claims are unchanged.

---

## [0.3.1] - 2026-10-06

### Fixed

- Aligned the Transformation manifest and dependency registry with the existing `v0.5.1` Lake pin and refreshed the upstream vocabulary documentation, including effect semantics and the `splitAndMerge` orthogonality rule.
- Corrected reference-tool command names, upstream package paths in the docs workflow, and the Lean CI test-driver command.
- Regime definitions, counts, classification rows, preserving sets, and non-collapse claims are unchanged.

---

## [0.3.0] - 2026-05-02

### Added

ClassificationMatrix as named rows.
Each row is independently readable and testable.
NA→IGN CONVENTION block added at top of Transform/Core.lean.

Non-Collapsing def linked to paper:

1. A lemma noncollapse_of_prs_difference.
   If one profile classifies t as PRS and the other doesn't,
   they are non-collapsing.
   Operative step in every paper proof.

2. A note that for the 9 profiles, every matrix difference
   that appears in a proof involves a PRS cell for
   one of the profiles, so Lean definition is sufficient.

Scaffolding and verification for:

- .\reference\index.toml
- .\reference\proof-registry.json
- .\reference\regime-classification-matrix.toml
- .\reference\regime-classification-values.toml
- .\reference\regime-families.toml
- .\reference\regime-predicates.toml
- .\reference\regime-profile-derivation.toml
- .\reference\regime-profiles.toml
- .\reference\regime-theorems.toml
- .\reference\regime-transformations.toml
- .\reference\regime-types.toml
- .\reference\regime-vocabulary.toml

- `reference.py` - scaffold and validate reference artifacts against
  Lean 4 source
- `se-ref-scaffold` CLI command - adds stubs for new Lean symbols,
  preserves existing descriptions and cite_ids
- `se-ref-validate` CLI command - validates reference artifacts
  against Lean source, writes nothing
- `se-manifest-validate` and `se-manifest-version-sync` CLI entry points

### Changed

- README.md workflow commands
- pyproject.toml [project.scripts]
- `run_validate()` extended to include reference artifact validation
  as final step
- Release procedure simplified and updated to use CLI entry points.

---

## [0.2.0] - 2026-05-01

### Added

- Added curated public Lean surface via `IdentityRegimes.Surface`.
- Added single downstream import boundary:

  ```lean
  import IdentityRegimes
  open IdentityRegimes
  ```

- Added public exports for:
  - `Regime`
  - `RegimeProfile`
  - `RegimeProfileKind`
  - `Requirement`
  - `Transformation`
  - `TransformationClassification`
  - `IsCanonicalRegime`
  - `IsPreserving`
  - `IsBreaking`
  - `NonCollapsing`
  - `ProfileWellFormed`
  - `RequirementSatisfied`
  - `RegimeApplicationAdmissible`
  - `classify`
  - `derivedRegimeSet`
  - `classification_pattern_unique`
  - `nine_regime_lower_bound`

reference/ files (manual creation / Lean checking):

- regime-classification-values.toml
- regime-families.toml
- regime-profile-derivation.toml
- regime-profiles.toml
- regime-transformations.toml

### Changed

- Migrated Identity Regimes from the previous Neutral Substrate API
  to new public `NeutralSubstrate` import surface.
- Replaced legacy substrate references with `Ontology`.
- Replaced ontology-level `Admissible` usage with `Neutral`.
- Renamed transformation classification vocabulary to `TransformationClassification`.
- Clarified distinction between:
  - six canonical `Regime` values
  - nine derived `RegimeProfileKind` values
  - structured `RegimeProfile` objects

### Fixed

- Fixed Lean theorem binders incorrectly treating `Neutral S` as a typeclass.
- Fixed recursive proof error in `regime_application_admissible_of_neutral`.
- Corrected public surface exports to include only valid, stable identifiers.
- Restored successful `lake build` after Neutral Substrate interface migration.

### Notes

This release establishes a stable public Lean interface for identity-regime theory.

- the canonical classification matrix may be refined
- the reference certification layer may expand

---

## [0.4.0] - 2026-10-16

### Added

- dependency on Persistence 0.3.0 and its ClassificationValue

---

## [0.3.1] - 2026-10-06

### Fixed

- Aligned the Transformation manifest and dependency registry with the existing
  `v0.5.1` Lake pin and refreshed the upstream vocabulary documentation,
  including effect semantics and the `splitAndMerge` orthogonality rule.
- Corrected reference-tool command names, upstream package paths in the docs
  workflow, and the Lean CI test-driver command.
- Regime definitions, counts, classification rows, preserving sets, and
  non-collapse claims are unchanged.

---

## [0.3.0] - 2026-05-02

### Added

ClassificationMatrix as named rows.
Each row is independently readable and testable.
NA→IGN CONVENTION block added at top of Transform/Core.lean.

Non-Collapsing def linked to paper:

1. A lemma noncollapse_of_prs_difference.
   If one profile classifies t as PRS and the other doesn't,
   they are non-collapsing.
   Operative step in every paper proof.

2. A note that for the 9 profiles, every matrix difference
   that appears in a proof involves a PRS cell for
   one of the profiles, so Lean definition is sufficient.

Scaffolding and verification for:

- .\reference\index.toml
- .\reference\proof-registry.json
- .\reference\regime-classification-matrix.toml
- .\reference\regime-classification-values.toml
- .\reference\regime-families.toml
- .\reference\regime-predicates.toml
- .\reference\regime-profile-derivation.toml
- .\reference\regime-profiles.toml
- .\reference\regime-theorems.toml
- .\reference\regime-transformations.toml
- .\reference\regime-types.toml
- .\reference\regime-vocabulary.toml

- `reference.py` - scaffold and validate reference artifacts against
  Lean 4 source
- `se-ref-scaffold` CLI command - adds stubs for new Lean symbols,
  preserves existing descriptions and cite_ids
- `se-ref-validate` CLI command - validates reference artifacts
  against Lean source, writes nothing
- `se-manifest-validate` and `se-manifest-version-sync` CLI entry points

### Changed

- README.md workflow commands
- pyproject.toml [project.scripts]
- `run_validate()` extended to include reference artifact validation
  as final step
- Release procedure simplified and updated to use CLI entry points.

---

## [0.2.0] - 2026-05-01

### Added

- Added curated public Lean surface via `IdentityRegimes.Surface`.
- Added single downstream import boundary:

  ```lean
  import IdentityRegimes
  open IdentityRegimes
  ```

- Added public exports for:
  - `Regime`
  - `RegimeProfile`
  - `RegimeProfileKind`
  - `Requirement`
  - `Transformation`
  - `TransformationClassification`
  - `IsCanonicalRegime`
  - `IsPreserving`
  - `IsBreaking`
  - `NonCollapsing`
  - `ProfileWellFormed`
  - `RequirementSatisfied`
  - `RegimeApplicationAdmissible`
  - `classify`
  - `derivedRegimeSet`
  - `classification_pattern_unique`
  - `nine_regime_lower_bound`

reference/ files (manual creation / Lean checking):

- regime-classification-values.toml
- regime-families.toml
- regime-profile-derivation.toml
- regime-profiles.toml
- regime-transformations.toml

### Changed

- Migrated Identity Regimes from the previous Neutral Substrate API
  to new public `NeutralSubstrate` import surface.
- Replaced legacy substrate references with `Ontology`.
- Replaced ontology-level `Admissible` usage with `Neutral`.
- Renamed transformation classification vocabulary to `TransformationClassification`.
- Clarified distinction between:
  - six canonical `Regime` values
  - nine derived `RegimeProfileKind` values
  - structured `RegimeProfile` objects

### Fixed

- Fixed Lean theorem binders incorrectly treating `Neutral S` as a typeclass.
- Fixed recursive proof error in `regime_application_admissible_of_neutral`.
- Corrected public surface exports to include only valid, stable identifiers.
- Restored successful `lake build` after Neutral Substrate interface migration.

### Notes

This release establishes a stable public Lean interface for identity-regime theory.

- the canonical classification matrix may be refined
- the reference certification layer may expand

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

Regime predicates (`IdentityRegimes.Vocab.Regimes`):

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

## Design Constraints

Lean source files are authoritative for formal semantics and proofs.

Reference registries describe the registered public surface and
must correspond to that Lean surface.

Python and generated data may mirror, validate, export, or document the Lean surface.
They must not define theory semantics independently of Lean.

---

## Notes on versioning and releases

- We use **SemVer**:
  - **MAJOR** - breaking changes
  - **MINOR** - backward-compatible additions
  - **PATCH** - fixes, documentation, tooling
- Versions are driven by git tags.
- Tag `vX.Y.Z` to release.
- During `0.x` development, breaking formal-surface changes
  may occur in a **MINOR** release.

## Release Procedure (Required)

Follow these steps exactly when creating a new release.

### One-Time Zenodo Authorization

1. Sign in to Zenodo.
2. Open your profile menu in the upper-right.
3. Select GitHub.
4. Click Sync now.
5. Find structural-explainability/ this repo.
6. Turn on the repository toggle/slider.
7. Refresh the page and confirm it appears as enabled.
8. Zenodo will ingest future GitHub Releases from this repo.

### Task 1. Update release metadata (manual edits)

1.1. CITATION.cff: update version and date-released
1.2. lakefile.toml: update version
1.3. CHANGELOG.md: add section, move unreleased entries, update links, update release command
1.4. pyproject.toml: update version (near top of the file)

### Task 2. Set up and Validate

```pwsh
# set up or update Python environment
# Run repository checks.
.\sit.ps1

# Update GitHub Actions and pin all action references to immutable SHAs.
uvx gha-tools autoupdate --pin=all --write .github/workflows

# Audit the resulting GitHub configuration for security findings.
# NO .github\workflows\deploy-zensical.yml
# YES  .github\workflows\deploy-zensical-lean.yml
uvx zizmor@latest .github/
# Some suppressed are still okay

# Validate.
uvx cffconvert --validate
uvx se-manifest-schema validate-manifest --strict

# Format Markdown.
npx markdownlint-cli2 --fix

.\rel.ps1
.\sit.ps1
```

Review all generated and modified files before committing.

### Task 3. Commit, tag, push

```shell
git add -A
git commit -m "Prep X.Y.Z"
git push -u origin main
```

Verify actions run on GitHub. After success:

```shell
git tag vX.Y.Z -m "X.Y.Z"
git push origin vX.Y.Z
```

## Only As Needed (delete a tag)

```shell
git tag -d vX.Y.Z
git push origin :refs/tags/vX.Y.Z
```

## Links

[Unreleased]: https://github.com/structural-explainability/se-theory-identity-regimes/compare/v0.7.1...HEAD
[0.7.1]: https://github.com/structural-explainability/se-theory-identity-regimes/releases/tag/v0.7.1
[0.7.0]: https://github.com/structural-explainability/se-theory-identity-regimes/releases/tag/v0.7.0
[0.6.0]: https://github.com/structural-explainability/se-theory-identity-regimes/releases/tag/v0.6.0
[0.4.0]: https://github.com/structural-explainability/se-theory-identity-regimes/releases/tag/v0.4.0
[0.3.1]: https://github.com/structural-explainability/se-theory-identity-regimes/releases/tag/v0.3.1
[0.3.0]: https://github.com/structural-explainability/se-theory-identity-regimes/releases/tag/v0.3.0
[0.2.0]: https://github.com/structural-explainability/se-theory-identity-regimes/releases/tag/v0.2.0
[0.1.0]: https://github.com/structural-explainability/se-theory-identity-regimes/releases/tag/v0.1.0
