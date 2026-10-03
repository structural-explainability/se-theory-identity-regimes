<!--
Snippet for research/alignment/2026-09-30-ae-ep-cee-diagnostic.md
Replace the existing "## 1. ENR_I / OBJ Comparison" section (through the end of
its "Required Evidence" subsection) with Part A.
Replace the existing "## 5. Current Open Question" section with Part B.
Nothing else in the note is changed by this evidence.
-->

## Part A. Replacement for section 1

## 1. ENR_I / OBJ Comparison

### Status

**Resolved at the level of classification behavior: ENR_I and SE-200 OBJ
agree on all ten transformations. The label differs. Two adjacent
discrepancies are recorded below and are not resolved.**

### Source of the authoritative definition

Repository: `se-theory-identity-regimes`, read from a direct clone of `main`
at commit `1d08827` (2026-09-30).

The definitions were read from Lean source and reference artifacts, not from
README or documentation summaries. They live at:

- `SE/IdentityRegimes/Profile/Core.lean`
- `SE/IdentityRegimes/Transform/Core.lean`
- `SE/IdentityRegimes/Transform/NonCollapse.lean`
- `reference/regime-profiles.toml`
- `reference/regime-profile-derivation.toml`

Chronology of the definition:

- `instrument` as an `IdentityBasis` value is present from the first commit
  (2026-04-28).
- The ENR_I row in `Transform/Core.lean` was last changed in `Prep 0.3.0`
  (2026-05-02).
- The 2026-09-30 commit (`1d08827`) moved the Lean files from
  `IdentityRegimes/` to `SE/IdentityRegimes/`. In the ENR_I-defining files
  the only change is the `NeutralSubstrate` import line. The definition did
  not change.
- Import paths in the moved files are mixed (`SE.IdentityRegimes...` and
  `IdentityRegimes...`). The build was not run.

### What the Lean says ENR_I is

- `RegimeProfileKind.ENR_I` has parent regime `Regime.ENR`
  (`Profile/Core.lean`).
- Its axes are `identityBasis := .instrument` and
  `splitTransformation := some .BF`.
- `IdentityBasis.instrument` carries only the comment
  "artifact persistence (ENR-I)". It is an enumeration tag with no further
  semantic predicate.
- `enrIRow` in `Transform/Core.lean` is documented as
  "Enduring non-normative referent, instrument-bound. Identity constituted by
  persistence of the same artifact. BF=BRK: branching produces distinct
  artifact continuations."
- `reference/regime-profiles.toml` labels it "Enduring non-normative
  referent, instrument-bound profile".
- `reference/regime-profile-derivation.toml` says the ENR split is required
  because enduring non-normative referents admit multiple persistence
  interpretations (locus-bound vs instrument-bound).
- The Lean row, the `.toml` label, and the derivation text agree with each
  other.
- "Enduring non-normative referent" is the ENR family label. It applies
  equally to ENR_L, so it is not specific to ENR_I.

ENR_I's classification row, in the matrix column order RE AN RF AD RC RA SU BF
PV SE, is:

`IGN IGN PRS PRS IGN IGN BRK BRK IGN PRS`

### Comparison with SE-200 OBJ (historical context only)

Source: `paper-200-identity-regimes`, `sections/06_nine_regimes.tex`
Table 1 (repo at commit `a19cc53`, 2026-07-19), and
`sections/05_algebra.tex` §5.7.

OBJ's column is:

`NEU NEU PRS PRS NEU NA BRK BRK NEU PRS`

Under the Lean convention that NEU and N/A both map to IGN, the ENR_I row
equals the OBJ column on all ten transformations. This was checked
mechanically cell by cell. The same holds for ENR_L against LOC. Both
pairs are separated by BF in both sources, and PRS/BRK at BF are the same
values in both.

The basis wording differs:

- OBJ: individuated by the object, asset, instrument, sample, device,
  parcel, or thing occupying the locus.
- ENR_I: "the same artifact".

Nothing in the Lean restricts ENR_I to a subclass of objects. The repo's own
design treats a profile as determined by its classification behavior. The
earlier hypothesis that ENR_I narrows OBJ to instruments only, or replaces
object-fixed identity with a different abstraction, is not supported by the
Lean source. The phrase "durable non-normative referent" is the ENR family
label.

### Classification

**Terminology only**, for the plain-referent object-side regime. The
behavioral content agrees on every cell, and the label differs
(OBJ / ENR_I; family label "plain referent" / ENR).

### Adjacent discrepancies (not ENR_I/OBJ identity-basis differences)

1. **Three-valued coarsening.** SE-200 distinguishes NEU (transformation
   does not act on the basis) from N/A (transformation cannot arise).
   Lean's `ClassificationValue` has only IGN, PRS, BRK. The `Transform/Core.lean` header documents the
   N/A to IGN convention and says it preserves the induced equivalence
   relations that determine non-collapse. In the ENR_I row, RE, AN, RC
   and PV are NEU in SE-200 and RA is N/A. Whether the coarsening matters
   outside the non-collapse proofs is unresolved. This is not established
   as a conflation.
2. **Source citation label.** Lean source comments cite "SE-300" for the
   classification tables and split proofs. The same repo's README lists
   path grammar and expressive adequacy as SE-300 (not owned). I did not
   locate an SE-300 identity-regimes paper. The rows match SE-200
   Table 1, so the label may be stale. This is unverified.

### Comparison with AE

Sources: `spec-ae` at `main` (latest commit 2026-05-30), `SPEC.md`,
`IDENTIFIERS.md`, `CONFORMANCE.md`, `data/spec/requirements.json`.

- `AE.IDENTITY.REGIME.MAPPING` requires each accountable entity kind to map
  to exactly one upstream SE profile kind. It says the upstream kind
  determines identity-and-persistence behavior, and AE must not redefine it.
- `AE.KIND.PER.ENR_I` states that the kind "maps exactly to the upstream
  `ENR_I` profile kind." That name exists in Lean as
  `RegimeProfileKind.ENR_I`. The binding is by name only. AE states no
  identity basis for ENR_I.
- The AE note for `AE.KIND.PER.ENR_I` in `IDENTIFIERS.md` and in
  `requirements.json` reads "Placeholder for the Person entity kind under
  the Enactment-Instrumental regime." The ENR_L note reads
  "Enactment-Legal." Neither matches Lean's "locus-bound" or
  "instrument-bound" for these profiles.
- `IDENTIFIERS.md` states that notes are explanatory only and introduce no
  requirements. The string first appears in commit `b1151fa` (2026-05-15,
  `prep 0.9.1`), after the Lean initial commit (2026-04-28).
- `SE_MANIFEST.toml` in `spec-ae` lists only `spec-se` (v1) as a required
  dependency. `se-theory-identity-regimes` is not declared, so the
  upstream that defines ENR_I is not named or pinned.

Classification of the AE gloss: **downstream specification drift** in a
non-normative note. The Lean definition is coherent, and the AE text
disagrees with it. The normative mapping itself (name binding) shows no
difference.

### Remaining uncertainty

- `IdentityBasis.instrument` has no predicate in Lean beyond its row. If a
  narrower meaning than "artifact persistence" is intended, the Lean source
  does not state it.
- Whether the AE glosses "Enactment-Instrumental" and "Enactment-Legal"
  reflect a different intended meaning or are placeholder text is not
  determinable from the files. Only their disagreement with Lean is
  established.
- The Lean build state at `1d08827` was not checked.

### Adjacent observation for the remaining regimes

The labels in `reference/regime-profiles.toml` for CTX_E ("event-bound"),
NOR_C ("context-bound") and NOR_S ("scope-bound") do not match the Lean
`IdentityBasis` values (`extension`, `content`, `structure`) or SE-200's
SCOPE-E, RULE-C and RULE-S bases. ENR_L and ENR_I labels are consistent
across all three sources. This should be examined with the CTX and NOR
comparisons.

## Part B. Replacement for section 5

## 5. Current Open Question

The ENR_I / OBJ question is resolved at the classification-behavior level
(section 1). Open items carried forward:

- whether the NEU / N/A to IGN coarsening in Lean matters outside the
  non-collapse proofs;
- the source of the "SE-300" citations in the Lean files;
- the CTX_E, NOR_C and NOR_S label mismatches in
  `reference/regime-profiles.toml`;
- the AE note glosses for the nine kinds, which section 1 shows disagree
  with Lean for ENR_I and ENR_L and which have not been checked for the
  other seven.
