<!--
Snippet for research/alignment/2026-09-30-ae-ep-cee-diagnostic.md
Part A: append as new section "7. CTX_S / SCOPE-S Comparison".
Part B: replacements for specific statements in section 6 (CTX_E) that this
        investigation shows were incomplete or wrong. Apply them if you added
        the earlier CTX_E snippet.
Part C: one sentence to sharpen in section 1 (ENR_I).
Part D: open-item list updates.
The existing note file was not edited.
-->

## Part A. New section

## 7. CTX_S / SCOPE-S Comparison

### Status

**CTX_S's classification behavior and basis agree with SE-200 SCOPE-S on all
ten transformations. The reference wording `scope-bound` is stale
reference-artifact residue from the 2026-04-29 draft. CTX_E and CTX_S can be
treated as one resolved pair at the level of behavior and basis.**

### Source of the authoritative definition

Repository `se-theory-identity-regimes`, direct clone of `main` at commit
`1d08827` (2026-09-30). Definitions were read from Lean source and committed
reference artifacts, not from README prose, AE, or SE-200.

- `SE/IdentityRegimes/Profile/Core.lean`
- `SE/IdentityRegimes/Transform/Core.lean`
- `SE/IdentityRegimes/Transform/NonCollapse.lean`
- `reference/regime-classification-matrix.toml`
- `reference/regime-profiles.toml`
- `reference/regime-profile-derivation.toml`
- `reference/regime-families.toml`

### What the Lean and reference artifacts say

| Item | Value | Source |
| --- | --- | --- |
| Parent regime | `Regime.CTX` | `Profile/Core.lean`, `RegimeProfileKind.regime` |
| `IdentityBasis` | `.structure`, comment "structural organization (CTX-S, NOR-S)"; an enum tag with no further predicate | `Profile/Core.lean` |
| Split transformation | `some .AD`, shared with CTX_E | `Profile/Core.lean`, `RegimeProfileKind.axes` |
| Lean doc comment | "Applicability context, structure-sensitive. Identity constituted by persistence of the same structure. RF=BRK, AD=BRK, RC=BRK, RA=BRK, BF=BRK: all alter applicability structure." | `Transform/Core.lean`, `ctxSRow` |
| Non-collapse witness | `noncollapse_CTX_E_CTX_S` instantiates `noncollapse_of_prs_difference` with t = AD: PRS under CTX_E, BRK under CTX_S | `Transform/NonCollapse.lean` |
| Profile label | "Applicability context, scope-bound profile" | `reference/regime-profiles.toml` |
| Family label | "Applicability context" | `reference/regime-families.toml` |
| Derivation text | "Split required: applicability contexts differentiate based on the binding axis (event-bound vs scope-bound)." (shared with CTX_E) | `reference/regime-profile-derivation.toml` |

Complete classification row, column order RE AN RF AD RC RA SU BF PV SE:

`IGN IGN BRK BRK BRK BRK BRK BRK IGN IGN`

The Lean row (`ctxSRow`) and the committed `.toml` row (`matrix.CTX_S.*`) are
identical, checked cell by cell. Basis tags in the `.toml`: `axiomatic` for
RE and SU, `paper-definition` for AN, RF, AD, RC, RA, BF and PV, and
`na-to-ign` for SE. The `.toml` notes describe the BRK cells as altering
"applicability structure" (RF, AD, RC, BF) or "the structural bearer of
applicability" (RA).

### Comparison with SE-200 SCOPE-S (historical context only)

Source: `paper-200-identity-regimes`, `sections/06_nine_regimes.tex` Table 1
(repo state at 2026-07-19), parsed mechanically from the LaTeX source and not
transcribed by hand.

SCOPE-S's column is `NEU NEU BRK BRK BRK BRK BRK BRK NEU NA`. Mapping NEU and
N/A to IGN gives `IGN IGN BRK BRK BRK BRK BRK BRK IGN IGN`, which equals the
CTX_S row on all ten cells. The four cells that required the mapping are RE,
AN and PV (NEU) and SE (N/A).

SE-200 defines SCOPE-S as the structure-fixed scope regime and states that AD
is breaking for the structure-fixed reading. Lean's `.structure` basis, `AD`
split transformation, and AD BRK cell match this.

### History around the 2026-04-29 and 2026-05-02 commits

Repository `se-theory-identity-regimes`. This history applies to CTX_S and
sharpens the CTX_E account in section 6.

- **2026-04-28** (`329c143`, initial commit): `IdentityRegimes/Transformations.lean`
  defined `classify : RegimeProfileKind → Transformation → TransformationClass`
  over four values (IGN, PRS, BRK, NA) and a theorem
  `ctx_splits_on_AD : IsPreserving .CTX_E .AD ∧ IsBreaking .CTX_S .AD`. Its
  CTX_S row was `IGN IGN BRK BRK BRK BRK BRK BRK IGN NA`. Its header cites
  "Source: SE-300".
- **2026-04-29** (`655dc56`, "update"): added a second table,
  `IdentityRegimes/ClassificationMatrix.lean`, headed "Status: DRAFT — axiomatic
  cells are verified by definition; all other cells require theoretical
  validation against the SE papers." Its CTX_S row was
  `PRS PRS PRS PRS BRK PRS BRK BRK IGN BRK`. The same commit added the first
  `reference/` files: `regime-classification-matrix.toml` (CTX_S described as
  "scope-bound. Identity is constituted by binding to a scope", every
  non-axiomatic cell tagged `draft`, same values as the draft Lean matrix),
  `regime-profiles.toml` and `regime-profile-derivation.toml` (the
  `scope-bound` wording).
- In that April 29 state, the draft matrix had AD = PRS for **both** CTX_E and
  CTX_S. `noncollapse_CTX_E_CTX_S` at that commit was proved with
  `⟨.AD, by native_decide⟩` against `classify`, not against the draft matrix,
  and was therefore not contradicted by it. The two tables disagreed.
- **2026-05-02** (`053104d`, "Prep 0.3.0"): deleted both
  `IdentityRegimes/ClassificationMatrix.lean` and
  `IdentityRegimes/Transformations.lean`. Created `Transform/Core.lean`
  (named rows) and `Reference/ClassificationMatrix.lean`. The CTX_S row in
  `Transform/Core.lean` equals the old `classify` row with NA mapped to IGN.
  This was checked for all nine profiles at `655dc56`: the `classify` table
  equals the current matrix for every profile (NA to IGN), and the draft
  matrix differs from it for every profile.
  The commit rewrote `regime-classification-matrix.toml` and four other
  reference files. It did not touch `regime-profiles.toml`,
  `regime-profile-derivation.toml` or `regime-families.toml`. No commit since
  2026-04-29 has changed those three files.

So CTX_S did **not** undergo a change in its working definition on May 2. The
row that the changelog says was "verified against SE-300 split sections"
(`CHANGELOG.md`, 0.1.0) is the `classify` row, which survived. What May 2
removed was the draft matrix and its `.toml` counterpart, which had been
added one day earlier. The `scope-bound` label was written alongside the draft
and was not reconciled when the draft was removed.

### CTX_E and CTX_S as a pair

| Property | CTX_E | CTX_S |
| --- | --- | --- |
| Parent | `CTX` | `CTX` |
| Split transformation | `some .AD` | `some .AD` |
| `IdentityBasis` | `.extension` | `.structure` |
| Row (RE AN RF AD RC RA SU BF PV SE) | `IGN IGN PRS PRS PRS IGN BRK PRS IGN IGN` | `IGN IGN BRK BRK BRK BRK BRK BRK IGN IGN` |
| AD | PRS | BRK |

The rows differ at five cells: RF, AD, RC, RA, BF. AD is the canonical
witness in Lean and is a PRS/BRK difference. The same five cells differ
between SCOPE-E and SCOPE-S in SE-200 Table 1. SE-200's text names RC and RA
as non-canonical differences within the pair, and RF and BF are the others.

The pair corresponds cleanly to SE-200's extension-fixed and structure-fixed
scope distinction on parent, split transformation, basis, and all twenty
cells.

### Classification

- **CTX_S behavior and basis versus SCOPE-S:** terminology only. All ten
  cells agree and the basis agrees. The labels differ (CTX_S / SCOPE-S;
  family "applicability context" / carrier "scope").
- **`scope-bound` in the profile label and derivation text:** stale
  reference-artifact residue. It originates in the 2026-04-29 draft, whose
  CTX_S semantics ("binding to a scope", AD = PRS) were removed on 2026-05-02
  without updating these two files. It is not stated anywhere in the Lean
  basis, doc comment, or current matrix notes. The word "scope" is not false
  in itself, because SE-200 uses "scope" as the carrier kind for both CTX_E
  and CTX_S. It therefore does not distinguish CTX_S from CTX_E, which is what
  the label purports to do.
- **Theory evolution:** no evidence. The final row existed in `classify` from
  the initial commit and was not changed. The draft was a short-lived
  alternative.
- **Theoretical conflation exposed by implementation:** no evidence.

### Comparison with AE

Sources: `spec-ae` at `main` (latest commit 2026-05-30), `SPEC.md`,
`CONFORMANCE.md`, `IDENTIFIERS.md`, `data/spec/requirements.json`,
`SE_MANIFEST.toml`.

Normative name binding:

- `SPEC.md`, `## AE.KIND.PER.CTX_S`: the kind "is defined explicitly" and "maps
  exactly to the upstream `CTX_S` profile kind"; the identifier is structural
  and must not be interpreted as defining domain meaning, epistemic authority,
  legal status, social role, or enforcement effect.
- `CONFORMANCE.md`, `## AE.KIND.PER.CTX_S`: same mapping, with a check that it
  is not renamed, merged, split, or reinterpreted.
- `AE.IDENTITY.REGIME.MAPPING` (`SPEC.md`): each kind maps to exactly one
  upstream SE profile kind, and the upstream kind determines
  identity-and-persistence behavior.
- `CTX_S` exists in Lean as `RegimeProfileKind.CTX_S`. The binding holds by
  name only. AE states no identity basis for CTX_S.

Explanatory note (non-normative):

- `IDENTIFIERS.md`, entry `AE.KIND.PER.CTX_S`, and `data/spec/requirements.json`
  read "Placeholder for the Person entity kind under the Contextual-Social
  regime."
- `IDENTIFIERS.md` states notes are explanatory only and introduce no
  requirements.
- The word-level search `social` or `epistemic` over `SE/`, `reference/`,
  `docs/`, `README.md`, `CHANGELOG.md` and `AGENTS.md` in
  `se-theory-identity-regimes` returned no hits. "Contextual" appears only as
  a descriptive gloss for the CTX family in the non-authoritative docs, as in
  "Contextual identity — binding depends on structural context". Lean and the
  reference artifacts do not use it as a regime name. No source in the
  authoritative theory supports "Contextual-Social".

Upstream declaration:

- `SE_MANIFEST.toml` in `spec-ae` declares only `spec-se` (v1) as a required
  dependency. `se-theory-identity-regimes` is not declared or pinned.

Classification of the AE gloss: **downstream specification drift** in a
non-normative note, separate from the CTX_S theory finding above. The
normative name binding shows no difference.

### Remaining uncertainty

- `IdentityBasis.structure` has no predicate in Lean beyond the row and its
  comment, and is shared by CTX_S and NOR_S. Whether the two uses denote the
  same basis was not examined.
- Whether `se-ref-validate` checks profile labels or derivation text against
  Lean is not verified.
- The `classify` table's own provenance before the initial commit is not
  recorded. Its header cites "SE-300".
- I compared only the SE-200 repo state at 2026-07-19. The January 2026 arXiv
  version was not examined.
- Why the draft matrix was added on 2026-04-29 and removed on 2026-05-02 is
  not recorded in commit messages ("update", "Prep 0.3.0") or the changelog.

## Part B. Replacements in section 6 (CTX_E)

Section 6 was written before the second April table was found. Replace these
statements.

**Replace** (under "History of the `event-bound` label", first bullet), the
sentence "The Lean matrix at that commit had the identical row." with:

"The draft `IdentityRegimes/ClassificationMatrix.lean` added at that commit
had the identical row. A second table, `classify` in
`IdentityRegimes/Transformations.lean`, had been in the repo since the initial
commit (2026-04-28). Its CTX_E row was `IGN IGN PRS PRS PRS IGN BRK PRS IGN NA`,
which equals the current row with NA mapped to IGN."

**Replace** the bullet beginning "The `CHANGELOG.md` entry for 0.1.0
(2026-04-28)" with:

"The `CHANGELOG.md` entry for 0.1.0 (2026-04-28) says CTX_E was "verified
against SE-300 split sections". That statement is consistent with the
`classify` row, which survived. It is not consistent with the draft matrix
added the next day."

**Replace** the bullet beginning "2026-05-02 (`053104d`" with:

"**2026-05-02** (`053104d`, "Prep 0.3.0"): deleted the draft
`ClassificationMatrix.lean` and `Transformations.lean`, and created
`Transform/Core.lean` with the CTX_E row equal to the old `classify` row (NA
mapped to IGN). The same commit rewrote `regime-classification-matrix.toml`
to match, with `paper-definition` basis tags. It did not touch
`regime-profiles.toml` or `regime-profile-derivation.toml`."

**Replace** the Classification bullet "April draft row to current row" with:

"**April draft row to current row:** the draft was a short-lived alternative
table that the `classify` table had already superseded in substance. The
current row is the `classify` row, unchanged since 2026-04-28 apart from NA to
IGN. It is not a revision of the theory."

**Replace** the first Remaining-uncertainty bullet with:

"Why the draft matrix was added on 2026-04-29 and removed on 2026-05-02 is
not recorded in commit messages or the changelog."

## Part C. Sharpening in section 1 (ENR_I)

In "Chronology of the definition", replace "The ENR_I row in
`Transform/Core.lean` was last changed in `Prep 0.3.0` (2026-05-02)." with:

"The ENR_I row in `Transform/Core.lean` was created in `Prep 0.3.0`
(2026-05-02) from the `classify` table that had been in the repo since
2026-04-28. At `655dc56` the `classify` ENR_I row equals the current row with
NA mapped to IGN. The draft matrix added on 2026-04-29 differed."

## Part D. Open-item list updates

- **ENR_I / OBJ, CTX_E / SCOPE-E, CTX_S / SCOPE-S: resolved at the level of
  classification behavior and basis.** Remaining label drift in `reference/`
  is isolated to the April 29 draft files.
- **Label drift in `reference/`:** now characterized for CTX_E (`event-bound`)
  and CTX_S (`scope-bound`) as residue of the 2026-04-29 draft. NOR_C
  (`context-bound`) and NOR_S (`scope-bound`) carry the same commit
  provenance. Carried forward, not investigated.
  - NOR_C label `context-bound` vs Lean basis `.content`.
  - NOR_S label `scope-bound` vs Lean basis `.structure`. The wording is
    identical to the CTX_S label.
- **NEU / N/A → IGN coarsening: new evidence, not investigated.**
  - Lean had four classification values (IGN, PRS, BRK, NA) from 2026-04-28
    until 2026-05-02. `Transformations.lean` carried NA as a distinct value
    in the `classify` rows (OCC.RA, OCC.BF, ENR_L.RA, ENR_I.RA and the four
    SE cells). `053104d` collapsed NA to IGN and added the convention block.
  - NEU never existed in Lean. NEU cells were IGN in `classify` from the
    initial commit.
  - So the N/A to IGN step is documented in a commit and a header, and the
    NEU to IGN step is not.
- **Stale `SE-300` citations: new evidence, not investigated.**
  - The `classify` table cited "SE-300" from the initial commit
    (2026-04-28). Its rows equal the SE-200 Table 1 columns for all nine
    profiles (NEU and N/A to IGN), checked for CTX_E and CTX_S directly from
    the LaTeX source in this pass.
  - SE-200's table text was restructured in the `paper-200-identity-regimes`
    repo on 2026-07-08 and later. This pass did not determine whether
    "SE-300" was a working name for the same table, a separate paper, or a
    citation to something that does not exist.
- **AE explanatory glosses:** ENR_I, ENR_L, CTX_E and CTX_S are now checked.
  All four disagree with Lean. The remaining five (OBL, OCC, REC, NOR_C,
  NOR_S) are unchecked. The `spec-ae` manifest declares no upstream theory
  repository, as found in each comparison so far.
