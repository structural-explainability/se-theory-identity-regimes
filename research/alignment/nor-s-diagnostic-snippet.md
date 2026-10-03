<!--
Snippet for research/alignment/2026-09-30-ae-ep-cee-diagnostic.md
Part A: append as new section "9. NOR_S / RULE-S Comparison".
Part B: open-item list updates.
No earlier statement in sections 1, 6, 7 or 8 needed correction from this pass.
The existing note file was not edited.
-->

## Part A. New section

## 9. NOR_S / RULE-S Comparison

### Status

**NOR_S's classification behavior and basis agree with SE-200 RULE-S on all
ten transformations. The reference label `scope-bound` and the derivation
wording are stale reference-artifact residue from the 2026-04-29 draft. NOR_C
and NOR_S form one resolved pair. CTX_E, CTX_S, NOR_C and NOR_S now form one
coherent cleanup case.**

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
| `IdentityBasis` | `.structure`, comment "structural organization (CTX-S, NOR-S)"; an enum tag with no further predicate, shared with CTX_S | `Profile/Core.lean` |
| Split transformation | `some .RF`, shared with NOR_C | `Profile/Core.lean`, `RegimeProfileKind.axes` |
| Lean doc comment | "Normative structure, substitution-sensitive (structural). Identity constituted by persistence of the same structure. RF=BRK, AD=BRK: refinement and decomposition alter structural organization. BF=BRK: branching breaks normative structure identity." | `Transform/Core.lean`, `norSRow` |
| Non-collapse witness | `noncollapse_NOR_C_NOR_S` instantiates `noncollapse_of_prs_difference` with t = RF: PRS under NOR_C, BRK under NOR_S | `Transform/NonCollapse.lean` |
| Profile label | "Normative structure, scope-bound profile" | `reference/regime-profiles.toml` |
| Family label | "Normative structure" | `reference/regime-families.toml` |
| Derivation text | "Split required: normative structures separate along context-bound and scope-bound applicability regimes." (shared with NOR_C) | `reference/regime-profile-derivation.toml` |
| Matrix `.toml` row comment | "Row: NOR-S (Normative structure, substitution-sensitive). Identity constituted by persistence of the same structure." | `reference/regime-classification-matrix.toml` |

Complete classification row, column order RE AN RF AD RC RA SU BF PV SE:

`IGN IGN BRK BRK IGN IGN BRK BRK IGN IGN`

The Lean row (`norSRow`) and the committed `.toml` row (`matrix.NOR_S.*`) are
identical, checked cell by cell. Basis tags in the `.toml`: `axiomatic` for RE
and SU, `paper-definition` for AN, RF, AD, RC, RA, BF and PV, and `na-to-ign`
for SE. The `.toml` notes describe RF and AD as altering "structural
organization" and RC, RA and PV as not affecting "normative structure
identity".

Wording observation: the Lean comment calls NOR-S "substitution-sensitive".
SU is BRK for every profile in the current matrix, so SU does not distinguish
NOR_S from any other profile. The `.toml` notes and the `.structure` basis
point to refinement and decomposition as the sensitive transformations. I
record the mismatch and did not trace its origin.

### Comparison with SE-200 RULE-S (historical context only)

Source: `paper-200-identity-regimes`, `sections/06_nine_regimes.tex` Table 1
(repo state at 2026-07-19), parsed mechanically from the LaTeX source and not
transcribed by hand.

RULE-S's column is `NEU NEU BRK BRK NEU NEU BRK BRK NEU NA`. Mapping NEU and
N/A to IGN gives `IGN IGN BRK BRK IGN IGN BRK BRK IGN IGN`, which equals the
NOR_S row on all ten cells. The six cells that required the mapping are RE,
AN, RC, RA and PV (NEU) and SE (N/A).

SE-200 (`sections/05_algebra.tex`, "Rule Under Refinement") defines a
structure-fixed rule as individuated by the organization of the text,
sections, clauses, delegations, or internal rule structure through which
content is expressed, and states that RF is breaking for the structure-fixed
reading. Lean's `.structure` basis, `RF` split transformation, and RF BRK
cell match this.

### History of `scope-bound`

Repository `se-theory-identity-regimes`, rows recovered from git and compared
programmatically with the current matrix.

- **2026-04-28** (`329c143`, initial commit): `classify` in
  `IdentityRegimes/Transformations.lean` held the NOR_S row
  `IGN IGN BRK BRK IGN IGN BRK BRK IGN NA`, which **equals the current row with
  NA mapped to IGN**. `IdentityRegimes/Profiles.lean` already had
  `.NOR_S => { identityBasis := .structure, splitTransformation := .RF }`.
- **2026-04-29** (`655dc56`, "update"): the `classify` row was unchanged. The
  new draft `IdentityRegimes/ClassificationMatrix.lean` held the NOR_S row
  `PRS PRS PRS PRS BRK PRS BRK BRK IGN BRK`, which **differs from the current
  row at seven cells**: RE, AN, RF, AD, RC, RA and SE. The draft had RF = PRS
  for both NOR_C and NOR_S, so it contradicted the RF split.
  The same commit added the first `reference/` files.
  `regime-classification-matrix.toml` headed NOR_S "Row: NOR_S (Normative
  structure, scope-bound). Identity is constituted by normative applicability
  within a scope." Its notes included "Adaptation preserves scope-bound
  normative structure" and "Reclassification breaks scope binding", with
  every non-axiomatic cell tagged `draft`. The same commit created
  `regime-profiles.toml` with the label "Normative structure, scope-bound
  profile" and `regime-profile-derivation.toml` with the NOR derivation text.
  So `scope-bound` for NOR_S was introduced alongside the draft matrix.
- **2026-05-02** (`053104d`, "Prep 0.3.0"): the draft matrix and
  `Transformations.lean` were deleted, and `Transform/Core.lean` was created
  with the NOR_S row equal to the old `classify` row (NA mapped to IGN). The
  `.toml` matrix was rewritten, with the NOR_S header changed to
  "substitution-sensitive". The commit did not touch `regime-profiles.toml`,
  `regime-profile-derivation.toml` or `regime-families.toml`.
- **2026-05-02 to 2026-09-30:** no commit has changed those three files. The
  label and derivation text survived unchanged for about five months.

### NOR_C and NOR_S as a resolved pair

| Property | NOR_C | NOR_S |
| --- | --- | --- |
| Parent | `NOR` | `NOR` |
| Split transformation | `some .RF` | `some .RF` |
| `IdentityBasis` | `.content` | `.structure` |
| Row (RE AN RF AD RC RA SU BF PV SE) | `IGN IGN PRS PRS IGN IGN BRK BRK IGN IGN` | `IGN IGN BRK BRK IGN IGN BRK BRK IGN IGN` |
| RF | PRS | BRK |

Against SE-200's content-fixed and structure-fixed rule distinction:

- **Parent and carrier:** both profiles share parent `NOR`, and both RULE-C and
  RULE-S are rule regimes in SE-200. Lean uses "identity carrier" generically
  (for example `Embedding.lean`, `SU`) but names no carrier kind such as
  "rule" for NOR. The carrier correspondence therefore rests on the family
  label "Normative structure" and SE-200's text, not on a Lean statement.
- **Split transformation:** RF in both sources.
- **Basis:** content and structure in both sources.
- **Cells:** all twenty cells equal under the NEU and N/A to IGN mapping, checked
  mechanically. The pair differs at RF and AD in Lean, and RULE-C and RULE-S
  differ at the same two cells.

The pair corresponds cleanly on all four points.

### Classification

- **NOR_S behavior and basis versus RULE-S:** terminology only. All ten cells
  agree and the basis agrees. The labels differ (NOR_S / RULE-S; family
  "normative structure" / carrier "rule").
- **`scope-bound` in the profile label and derivation text:** stale
  reference-artifact residue from the 04-29 draft, whose NOR_S semantics
  ("normative applicability within a scope", RF = PRS) were removed on
  2026-05-02 without updating these files. It is not stated in the Lean
  basis, the Lean doc comment, or the current matrix notes.
- **Additional observation:** in SE-200, "scope" is the carrier kind of the
  CTX regimes, not of rules. In the current reference files, the label
  `scope-bound` appears on two profiles in different families (CTX_S and
  NOR_S), so it does not identify either. This observation uses SE-200 as
  historical context only.
- **Theory evolution and theoretical conflation exposed by implementation:**
  no evidence. The final row was in `classify` from the initial commit and
  did not change.

### The four-profile cleanup case

Established for CTX_E, CTX_S, NOR_C and NOR_S (sections 6 to 9), verified
programmatically for each:

| Profile | `classify` at `329c143` equals current (NA to IGN) | `classify` unchanged 04-28 to 04-29 | Draft matrix at `655dc56` equals current | SE-200 column equals current (NEU, N/A to IGN) | Draft header text (04-29 `.toml`) | Label from `655dc56`, unchanged since |
| --- | --- | --- | --- | --- | --- | --- |
| CTX_E | yes | yes | no | yes | "binding to a specific event" | "event-bound" |
| CTX_S | yes | yes | no | yes | "binding to a scope" | "scope-bound" |
| NOR_C | yes | yes | no | yes | "normative applicability within a context" | "context-bound" |
| NOR_S | yes | yes | no | yes | "normative applicability within a scope" | "scope-bound" |

The same holds for ENR_L and ENR_I on the first four columns (the draft matrix
differs for every profile). Their labels ("locus-bound" and "instrument-bound")
match the current definitions, so no label residue arises for them.

For all four profiles:

1. The Lean behavior and bases are internally consistent: parent, `.AD` or
   `.RF` split, basis, row, and non-collapse witness agree across
   `Profile/Core.lean`, `Transform/Core.lean`, `Transform/NonCollapse.lean`
   and the committed `.toml` matrix.
2. They agree with SE-200 on all twenty cells for each pair, under the
   NEU and N/A to IGN mapping.
3. The human-facing `label` and `derivation` wording in `regime-profiles.toml`
   and `regime-profile-derivation.toml` was introduced in the 04-29 draft
   commit, alongside draft semantics that the 05-02 commit removed from the
   matrix and Lean, and the wording was not updated afterward.

Draft axiom claims were also not carried forward. The 04-29 `.toml` header
said RE is PRS and BF is BRK for all profiles. The current header says RE is
IGN and SU is BRK for all profiles. In the current matrix RE is IGN and SU is
BRK for all nine profiles, and BF is PRS for three profiles (REC, ENR_L,
CTX_E) and BRK for four (ENR_I, CTX_S, NOR_C, NOR_S), so the draft's
BF-is-BRK-for-all claim does not hold in the current matrix. This was checked
programmatically. I note it as a further draft residue and did not check
which current `.toml` comments still describe draft behavior.

I found no evidence that any of these four cases is a theoretical
conflation.

### Comparison with AE

Sources: `spec-ae` at `main` (latest commit 2026-05-30), `SPEC.md`,
`CONFORMANCE.md`, `IDENTIFIERS.md`, `data/spec/requirements.json`,
`SE_MANIFEST.toml`.

Normative name binding:

- `SPEC.md`, `## AE.KIND.PER.NOR_S`: the kind "is defined explicitly" and "maps
  exactly to the upstream `NOR_S` profile kind"; the identifier is structural
  and must not be interpreted as defining domain meaning, epistemic authority,
  legal status, social role, or enforcement effect.
- `CONFORMANCE.md`, `## AE.KIND.PER.NOR_S`: same mapping, with a check that it
  is not renamed, merged, split, or reinterpreted.
- `AE.IDENTITY.REGIME.MAPPING` (`SPEC.md`): each kind maps to exactly one
  upstream SE profile kind, and the upstream kind determines
  identity-and-persistence behavior.
- `NOR_S` exists in Lean as `RegimeProfileKind.NOR_S`. The binding holds by
  name only. AE states no identity basis for NOR_S.

Explanatory note (non-normative):

- `IDENTIFIERS.md`, entry `AE.KIND.PER.NOR_S`, and `data/spec/requirements.json`
  read "Placeholder for the Person entity kind under the Normative-Social
  regime."
- `IDENTIFIERS.md` states notes are explanatory only and introduce no
  requirements. The string first appears in `b1151fa` (2026-05-15,
  "prep 0.9.1").
- A word-level, case-insensitive search for `social` over `SE/`, `reference/`,
  `docs/`, `README.md`, `CHANGELOG.md`, `AGENTS.md`, `CITATION.cff` and
  `SE_MANIFEST.toml` in `se-theory-identity-regimes` returned no hits. "Social"
  is not used as a regime, profile, basis or transformation term. In SE-200
  the word appears only in related-work discussion of social objects and
  institutions. "Normative" is supported as the NOR family name. "Social" is
  not supported by the authoritative theory.
- The qualifier is also in tension with AE's own normative text, which says the
  identifier must not be interpreted as defining a social role. I record the
  tension and do not evaluate it further.

Upstream declaration:

- `SE_MANIFEST.toml` in `spec-ae` declares only `spec-se` (v1) as a required
  dependency. `se-theory-identity-regimes` is not declared or pinned.

Classification of the AE gloss: **downstream specification drift** in a
non-normative note, separate from the NOR_S theory finding above. The
normative name binding shows no difference.

### Remaining uncertainty

- `IdentityBasis.structure` has no predicate in Lean beyond the row and its
  comment, and is shared by CTX_S and NOR_S. Whether the two uses denote the
  same basis was not examined. Their rows differ, and the two are not
  required to share a basis semantics by anything I read.
- Whether `se-ref-validate` checks profile labels or derivation text against
  Lean is not verified.
- I did not trace the origin of "substitution-sensitive" in the Lean comment
  and `.toml` header. It first appears on 2026-05-02.
- I compared only the SE-200 repo state at 2026-07-19. The January 2026 arXiv
  version was not examined.
- Why the draft matrix was added and removed is still not recorded in commit
  messages or the changelog.
- The remaining draft residue claim above (stale `.toml` header or comment
  wording) was observed in the matrix header only, and the rest of the
  `reference/` files were not audited for it.

## Part B. Open-item list updates

- **Label drift in `reference/`:** characterized for all four affected
  profiles (CTX_E, CTX_S, NOR_C, NOR_S) and for the two shared derivation
  sentences. The item is now a bounded set: four profile labels and two
  derivation descriptions, all introduced in `655dc56` and unchanged since.
  The earlier NOR_S carry-forward item is resolved at the level of
  classification and history.
- **ENR_I / OBJ, CTX_E / SCOPE-E, CTX_S / SCOPE-S, NOR_C / RULE-C,
  NOR_S / RULE-S: resolved at the level of classification behavior and
  basis.** OBL, OCC and REC were not examined as regimes. In the programmatic
  check their SE-200 columns also equal the current matrix rows under the
  NEU and N/A to IGN mapping, so all nine profiles match SE-200 Table 1.
- **NEU / N/A → IGN coarsening: evidence recorded, not investigated.** For
  NOR_S, RE, AN, RC, RA and PV are NEU in SE-200 and SE is N/A. The
  `classify` table already stored the NEU cells as IGN on 2026-04-28. The
  coarsening affects every one of the six split profiles: 31 of their 60
  cells are NEU or N/A in SE-200 (ENR_L 5, ENR_I 5, CTX_E 5, CTX_S 4,
  NOR_C 6, NOR_S 6), and 48 of all 90 cells across the nine profiles.
- **Stale `SE-300` citations: evidence recorded, not investigated.**
  `Transform/NonCollapse.lean` cites "SE-300 Prop. NOR non-collapse" for the
  witness covering NOR_S. The `classify` table cited "SE-300" from the
  initial commit and equals the SE-200 RULE-S column.
- **AE explanatory glosses:** six of nine are now checked (ENR_I, ENR_L,
  CTX_E, CTX_S, NOR_C, NOR_S). All six disagree with Lean, and none of the
  five distinct qualifiers (Instrumental, Legal, Epistemic, Social,
  Contractual) appears in the authoritative theory. The other three glosses ("Obligatory",
  "Occurrent", "Record") are single words and are unchecked. "Social" appears
  twice (`CTX_S`, `NOR_S`), which mirrors the duplicated `scope-bound` label.
  The `spec-ae` manifest declares no upstream theory repository, as found in
  every comparison so far.
