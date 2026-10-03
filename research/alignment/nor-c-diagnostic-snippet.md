<!--
Snippet for research/alignment/2026-09-30-ae-ep-cee-diagnostic.md
Part A: append as new section "8. NOR_C / RULE-C Comparison".
Part B: open-item list updates.
No earlier statement in sections 1, 6 or 7 needed correction from this pass.
The existing note file was not edited.
-->

## Part A. New section

## 8. NOR_C / RULE-C Comparison

### Status

**NOR_C's classification behavior and basis agree with SE-200 RULE-C on all
ten transformations. The reference label `context-bound` and the derivation
wording "context-bound and scope-bound applicability regimes" are stale
reference-artifact residue from the 2026-04-29 draft. NOR_C repeats the
pattern established for CTX_E and CTX_S.**

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
| Parent regime | `Regime.NOR` | `Profile/Core.lean`, `RegimeProfileKind.regime` |
| `IdentityBasis` | `.content`, comment "normative content (NOR-C)"; an enum tag with no further predicate | `Profile/Core.lean` |
| Split transformation | `some .RF`, shared with NOR_S | `Profile/Core.lean`, `RegimeProfileKind.axes` |
| Lean doc comment | "Normative structure, composition-sensitive (content-preserving). Identity constituted by persistence of the same normative content. RF=PRS, AD=PRS: refinement and decomposition preserve normative content. BF=BRK: branching breaks normative structure identity." | `Transform/Core.lean`, `norCRow` |
| Non-collapse witness | `noncollapse_NOR_C_NOR_S` instantiates `noncollapse_of_prs_difference` with t = RF: PRS under NOR_C, BRK under NOR_S | `Transform/NonCollapse.lean` |
| Profile label | "Normative structure, context-bound profile" | `reference/regime-profiles.toml` |
| Family label | "Normative structure" | `reference/regime-families.toml` |
| Derivation text | "Split required: normative structures separate along context-bound and scope-bound applicability regimes." | `reference/regime-profile-derivation.toml` |
| Matrix `.toml` row comment | "Row: NOR-C (Normative structure, composition-sensitive). Identity constituted by persistence of the same normative content." | `reference/regime-classification-matrix.toml` |

Complete classification row, column order RE AN RF AD RC RA SU BF PV SE:

`IGN IGN PRS PRS IGN IGN BRK BRK IGN IGN`

The Lean row (`norCRow`) and the committed `.toml` row (`matrix.NOR_C.*`) are
identical, checked cell by cell. Basis tags in the `.toml`: `axiomatic` for
RE and SU, `paper-definition` for AN, RF, AD, RC, RA, BF and PV, and
`na-to-ign` for SE. The `.toml` notes describe RF and AD as preserving
"normative content", and RC, RA and PV as not affecting "normative content
identity".

Three different wordings describe NOR_C in current artifacts: the Lean doc
comment and `.toml` row comment say "composition-sensitive (content-preserving)",
the Lean basis is `.content`, and the profile label says "context-bound". The
first two agree in substance. The label is the outlier.

### Comparison with SE-200 RULE-C (historical context only)

Source: `paper-200-identity-regimes`, `sections/06_nine_regimes.tex` Table 1
(repo state at 2026-07-19), parsed mechanically from the LaTeX source and not
transcribed by hand.

RULE-C's column is `NEU NEU PRS PRS NEU NEU BRK BRK NEU NA`. Mapping NEU and
N/A to IGN gives `IGN IGN PRS PRS IGN IGN BRK BRK IGN IGN`, which equals the
NOR_C row on all ten cells. The six cells that required the mapping are RE,
AN, RC, RA and PV (NEU) and SE (N/A).

SE-200 (`sections/05_algebra.tex`, "Rule Under Refinement") defines a
content-fixed rule as individuated by its requirements, permissions,
prohibitions, authorizations, or definitions, and states that RF is
non-breaking for the content-fixed reading and breaking for the
structure-fixed reading. Lean's `.content` basis, `RF` split transformation,
and RF PRS/BRK pair match this.

### History of `context-bound`

Repository `se-theory-identity-regimes`, rows recovered from git and compared
programmatically with the current matrix.

- **2026-04-28** (`329c143`, initial commit): `IdentityRegimes/Transformations.lean`
  defined `classify` over four values (IGN, PRS, BRK, NA) and a theorem
  `nor_splits_on_RF : IsPreserving .NOR_C .RF ∧ IsBreaking .NOR_S .RF`. The
  NOR_C row was `IGN IGN PRS PRS IGN IGN BRK BRK IGN NA`, which **equals the
  current row with NA mapped to IGN**. `IdentityRegimes/Profiles.lean` already
  had `.NOR_C => { identityBasis := .content, splitTransformation := .RF }`.
- **2026-04-29** (`655dc56`, "update"): added the draft
  `IdentityRegimes/ClassificationMatrix.lean`, headed "Status: DRAFT".
  - Its NOR_C row was `PRS PRS PRS PRS BRK BRK BRK BRK IGN BRK`, which
    **differs from the current row** at RE, AN, RC, RA and SE.
  - Its NOR_S row was `PRS PRS PRS PRS BRK PRS BRK BRK IGN BRK`. RF = PRS for
    both NOR_C and NOR_S in the draft, so the draft contradicted the RF split.
    The `classify` table was unchanged between 04-28 and 04-29, and
    `noncollapse_NOR_C_NOR_S` was still proved against `classify`.
  - The same commit added the first `reference/` files.
    `regime-classification-matrix.toml` headed NOR_C "Row: NOR_C (Normative
    structure, context-bound). Identity is constituted by normative
    applicability within a context." Every non-axiomatic cell was tagged
    `draft`, and the RA note read "Context-bound normative structure is
    constituted by its associations".
  - The same commit created `regime-profiles.toml` with the NOR_C label
    "Normative structure, context-bound profile", and
    `regime-profile-derivation.toml` with the NOR derivation text. These are
    the first appearances of `context-bound` in the repo, and they are in the
    same commit as the draft matrix.
- **2026-05-02** (`053104d`, "Prep 0.3.0"): deleted the draft
  `ClassificationMatrix.lean` and `Transformations.lean`, and created
  `Transform/Core.lean`. The NOR_C row there equals the old `classify` row (NA
  mapped to IGN). The commit rewrote `regime-classification-matrix.toml`, with
  the NOR_C header changed to "composition-sensitive". It did not touch
  `regime-profiles.toml`, `regime-profile-derivation.toml` or
  `regime-families.toml`.
- **2026-05-02 to 2026-09-30:** no commit has changed those three files. The
  label and derivation text survived unchanged for about five months.

For NOR_C, the draft matrix row differs from the current row at five cells.
Across all nine profiles, the `classify` table at `329c143` equals the current
matrix (NA to IGN) and the draft matrix differs from it. This was checked for
every profile in section 7 and again here for NOR_C and NOR_S.

### NOR_C and NOR_S as a pair (split only)

| Property | NOR_C | NOR_S |
| --- | --- | --- |
| Parent | `NOR` | `NOR` |
| Split transformation | `some .RF` | `some .RF` |
| `IdentityBasis` | `.content` | `.structure` |
| Row (RE AN RF AD RC RA SU BF PV SE) | `IGN IGN PRS PRS IGN IGN BRK BRK IGN IGN` | `IGN IGN BRK BRK IGN IGN BRK BRK IGN IGN` |
| RF | PRS | BRK |

The rows differ at two cells, RF and AD. RF is the canonical witness in Lean
and is a PRS/BRK difference. SE-200's RULE-C and RULE-S columns differ at the
same two cells. Parent, split transformation, basis and all twenty cells
correspond between the two sources. NOR_S's label and its `.structure` basis
are not examined further here.

### Classification

- **NOR_C behavior and basis versus RULE-C:** terminology only. All ten
  cells agree and the basis agrees. The labels differ (NOR_C / RULE-C; family
  "normative structure" / carrier "rule").
- **`context-bound` in the profile label and derivation text:** stale
  reference-artifact residue. It originates in the 2026-04-29 draft, whose
  NOR_C semantics ("normative applicability within a context", RF = PRS,
  RA = BRK) were removed on 2026-05-02 without updating these two files. It
  is not stated in the Lean basis, the Lean doc comment, or the current
  matrix notes.
- **The pattern:** NOR_C repeats the CTX_E and CTX_S pattern. The initial
  `classify` row was already the current row, the 04-29 draft diverged, the
  draft semantics were removed on 05-02, and the human-facing label and
  derivation text from the draft were left behind unchanged.
- **Overlap with CTX vocabulary:** the draft wording "normative applicability
  within a context" uses the vocabulary of the CTX family ("applicability
  context"). That is an observation about the stale wording. This pass did
  not test whether the draft conflated NOR with CTX, and no source states it.
- **Theory evolution and theoretical conflation exposed by implementation:**
  no evidence. The final row was in `classify` from the initial commit and
  did not change.

### Comparison with AE

Sources: `spec-ae` at `main` (latest commit 2026-05-30), `SPEC.md`,
`CONFORMANCE.md`, `IDENTIFIERS.md`, `data/spec/requirements.json`,
`SE_MANIFEST.toml`.

Normative name binding:

- `SPEC.md`, `## AE.KIND.PER.NOR_C`: the kind "is defined explicitly" and "maps
  exactly to the upstream `NOR_C` profile kind"; the identifier is structural
  and must not be interpreted as defining domain meaning, epistemic authority,
  legal status, social role, or enforcement effect.
- `CONFORMANCE.md`, `## AE.KIND.PER.NOR_C`: same mapping, with a check that it
  is not renamed, merged, split, or reinterpreted.
- `AE.IDENTITY.REGIME.MAPPING` (`SPEC.md`): each kind maps to exactly one
  upstream SE profile kind, and the upstream kind determines
  identity-and-persistence behavior.
- `NOR_C` exists in Lean as `RegimeProfileKind.NOR_C`. The binding holds by
  name only. AE states no identity basis for NOR_C.

Explanatory note (non-normative):

- `IDENTIFIERS.md`, entry `AE.KIND.PER.NOR_C`, and `data/spec/requirements.json`
  read "Placeholder for the Person entity kind under the Normative-Contractual
  regime."
- `IDENTIFIERS.md` states notes are explanatory only and introduce no
  requirements. The string first appears in `b1151fa` (2026-05-15,
  "prep 0.9.1").
- A word-level search for `contract`, `contractual` and `contracts` over
  `SE/`, `reference/`, `docs/`, `README.md` and `CHANGELOG.md` in
  `se-theory-identity-regimes` found only software uses: "contract artifact
  generation" (`README.md`), `SEFormalContract` and "contract export layer"
  (`CHANGELOG.md`). None refers to a regime or a normative profile. The
  Lean doc comment and the SE-200 text describe rule content as
  "requirements, permissions, prohibitions, authorizations, or definitions".
  The word "Normative" is supported as the NOR family name. "Contractual" is
  not supported by the authoritative theory.

Upstream declaration:

- `SE_MANIFEST.toml` in `spec-ae` declares only `spec-se` (v1) as a required
  dependency. `se-theory-identity-regimes` is not declared or pinned.

Classification of the AE gloss: **downstream specification drift** in a
non-normative note, separate from the NOR_C theory finding above. The
normative name binding shows no difference.

### Remaining uncertainty

- `IdentityBasis.content` has no predicate in Lean beyond the row and its
  comment. It is the only profile using `.content`.
- Whether `se-ref-validate` checks profile labels or derivation text against
  Lean is not verified.
- The origin of the "composition-sensitive" wording (it is not "content")
  was not traced. It first appears in `Transform/Core.lean` and the `.toml`
  header on 2026-05-02.
- I compared only the SE-200 repo state at 2026-07-19. The January 2026 arXiv
  version was not examined.
- Why the draft matrix was added and removed is still not recorded in commit
  messages or the changelog.

## Part B. Open-item list updates

- **ENR_I / OBJ, CTX_E / SCOPE-E, CTX_S / SCOPE-S, NOR_C / RULE-C: resolved at
  the level of classification behavior and basis.**
- **Label drift in `reference/`:** the stale April 29 residue is now
  characterized for CTX_E (`event-bound`), CTX_S (`scope-bound`) and NOR_C
  (`context-bound`) and for the shared derivation sentences for CTX and NOR.
  ENR_L and ENR_I labels are consistent with their definitions.
  - **NOR_S** label `scope-bound` vs Lean basis `.structure`: still carried
    forward, not investigated. Its label came from the same commit and was not
    touched afterward. Its split pairing with NOR_C is confirmed (RF,
    PRS/BRK), and its row equals SE-200 RULE-S under the NEU and N/A to IGN
    mapping, checked mechanically in this pass.
- **NEU / N/A → IGN coarsening: evidence recorded, not investigated.** For
  NOR_C, RE, AN, RC, RA and PV are NEU in SE-200 and SE is N/A. The Lean
  `classify` table already stored the NEU cells as IGN on 2026-04-28.
- **Stale `SE-300` citations: evidence recorded, not investigated.**
  `Transform/NonCollapse.lean` still cites "SE-300 Prop. NOR non-collapse"
  for `noncollapse_NOR_C_NOR_S`. The `classify` table cited "SE-300" from the
  initial commit and equals the SE-200 columns for RULE-C and RULE-S.
- **AE explanatory glosses:** ENR_I, ENR_L, CTX_E, CTX_S and NOR_C are now
  checked. All five disagree with Lean and none of the five qualifiers
  (Instrumental, Legal, Epistemic, Social, Contractual) appears in the
  authoritative theory. OBL, OCC, REC and NOR_S are unchecked. The `spec-ae`
  manifest declares no upstream theory repository, as found in every
  comparison so far.
