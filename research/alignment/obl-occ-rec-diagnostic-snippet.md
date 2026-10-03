<!--
Snippet for research/alignment/2026-09-30-ae-ep-cee-diagnostic.md
Part A: append as new sections "10. OBL Comparison", "11. OCC Comparison",
        "12. REC Comparison".
Part B: append as new section "13. All-Nine Conclusion and AE Gloss Audit".
Part C: replace the open-item list in section 5 with the version below.
Part D: append as new section "14. Inventory: Proven Edits and Open Investigations".
Nothing in sections 1 and 6-9 needed correction from this pass.
The existing note file was not edited. No theory, reference, AE, EP, CEE
or paper file was modified.
-->

## Part A. New sections

## 10. OBL Comparison

### Status

**OBL's classification behavior, label and derivation text agree with SE-200's
OBL. No semantic discrepancy found.** The profile and family labels were
introduced in the 2026-04-29 draft commit and survived unchanged. They are
consistent with the current definition, so they are not stale.

### Source of the authoritative definition

Repository `se-theory-identity-regimes`, direct clone of `main` at commit
`1d08827` (2026-09-30), read from Lean source and committed reference
artifacts only.

- `SE/IdentityRegimes/Profile/Core.lean`
- `SE/IdentityRegimes/Transform/Core.lean`
- `SE/IdentityRegimes/Transform/NonCollapse.lean`
- `reference/regime-classification-matrix.toml`
- `reference/regime-profiles.toml`
- `reference/regime-families.toml`
- `reference/regime-profile-derivation.toml`

### What the Lean and reference artifacts say

| Item | Value | Source |
| --- | --- | --- |
| Parent regime | `Regime.OBL` | `Profile/Core.lean`, `RegimeProfileKind.regime` |
| `IdentityBasis` | `.single`, comment "singular referential continuity (OBL, OCC, REC)" | `Profile/Core.lean` |
| Split transformation | `none`; `theorem no_split_OBL : ¬UnderSplitPressure …` | `Profile/Core.lean` |
| Lean doc comment | "Obligation-bearing entity. Identity constituted by persistence as a responsible party. BF=IGN: obligation persists independently of representation forking. SE=IGN: identity not individuated by internal state transitions." | `Transform/Core.lean`, `oblRow` |
| Distinctness | no per-pair theorem. `noncollapse_of_distinct_regime` and `noncollapse_all_pairs` cover it generically. | `Transform/NonCollapse.lean` |
| Profile label | "Obligation-bearing profile" | `reference/regime-profiles.toml` |
| Family label | "Obligation-bearing entity" | `reference/regime-families.toml` |
| Derivation text | "No split: obligation-bearing entities admit a single stable identity regime under the transformation basis." | `reference/regime-profile-derivation.toml` |

Complete classification row, column order RE AN RF AD RC RA SU BF PV SE:

`IGN IGN PRS PRS IGN IGN BRK IGN IGN IGN`

The Lean row and the `.toml` row are identical, cell by cell. Basis tags in the
`.toml`: `axiomatic` for RE and SU, `paper-definition` for the other eight. The
`.toml` BF note reads "Obligation-bearing entity persists independently of
forking". The SE note reads "State evolution does not individuate
obligation-bearing entities".

Pairwise differences in the current matrix: OBL and OCC differ at AD and SE.
OBL and REC differ at AN, BF and PV. Parent regimes also differ, which is the
route `noncollapse_of_distinct_regime` uses.

### Comparison with SE-200 OBL (historical context only)

Source: `paper-200-identity-regimes`, `sections/06_nine_regimes.tex` Table 1,
`sections/05_algebra.tex` ("Carrier Kinds Not Split in the Core
Construction") and `sections/04_reference_inventory.tex`, repo state at
2026-07-19. The table was parsed mechanically from the LaTeX source.

SE-200's counterpart is named `OBL`, the same name. Its column is
`NEU NEU PRS PRS NEU NEU BRK NEU NEU NEU`. Mapping NEU to IGN gives the current
OBL row on all ten cells. The mapping applies to seven NEU cells (RE, AN, RC,
RA, BF, PV, SE). There are no N/A cells.

- **Behavior:** agrees on all ten cells.
- **Basis:** SE-200 says an obligation-bearer is individuated by persistence as
  the party that can bear responsibility, duty, liability, authority, or
  accountability, and the lower-bound construction uses "responsibility-bearing
  identity". Lean's comment says "persistence as a responsible party". These
  agree in substance. Lean's `IdentityBasis` value (`.single`) does not
  encode that basis (see section 13).
- **Label:** SE-200 uses "obligation-bearing entities" in its inventory
  (`04_reference_inventory.tex`). The family label matches that wording.
- **Derivation text:** "no split" matches SE-200's statement that obligation-bearers
  are "not split by the witness operations used in this construction".

### History

Repository `se-theory-identity-regimes`, rows recovered from git.

- **2026-04-28** (`329c143`): `classify` held
  `IGN IGN PRS PRS IGN IGN BRK IGN IGN IGN`, which equals the current row. It
  has no NA cells, so no NA to IGN mapping applies. The `CHANGELOG.md` 0.1.0
  entry records "OBL/BF as IGN" as a decision.
- **2026-04-29** (`655dc56`): `classify` unchanged. The draft matrix row was
  `PRS PRS PRS PRS BRK BRK BRK BRK IGN BRK`, differing from the current row at
  six cells (RE, AN, RC, RA, BF, SE). The draft's BF = BRK contradicted the
  decision recorded the day before. The draft `.toml` header read "Identity is
  constituted by the normative binding relation." The same commit created the
  label, family and derivation files with the current OBL wording.
- **2026-05-02** (`053104d`): draft matrix removed, `Transform/Core.lean`
  created from `classify`. The `.toml` header was rewritten to "persistence as
  a responsible party". The label, family and derivation files were not touched
  and have not changed since.

### Comparison with AE

Sources: `spec-ae` at `main` (latest commit 2026-05-30).

- **Normative binding:** `SPEC.md` `## AE.KIND.PER.OBL` and `CONFORMANCE.md`
  `## AE.KIND.PER.OBL` state that the kind "maps exactly to the upstream `OBL`
  profile kind". `OBL` exists in Lean as `RegimeProfileKind.OBL`.
- **Explanatory note:** `IDENTIFIERS.md` and `data/spec/requirements.json` read
  "Placeholder for the Person entity kind under the Obligatory regime." It first
  appears in `b1151fa` (2026-05-15).
- **Upstream declaration:** `SE_MANIFEST.toml` declares only `spec-se` (v1).
  `se-theory-identity-regimes` is not declared or pinned.

"Obligatory" is not used in Lean, `reference/`, `README.md` or
`CHANGELOG.md`. Among the files searched (`SE/`, `reference/`, `docs/`,
`README.md`, `CHANGELOG.md`) it appears once, in the non-authoritative
`docs/en/index.md` role table: "Obligatory identity — binding is required".
That wording means that binding is required, which differs from the Lean and
SE-200 meaning of an entity that can bear obligation, and the docs table itself
differs from the Lean label. The AE word resembles the profile name but does not
match the authoritative meaning.

Classification of the AE gloss: **downstream specification drift** in a
non-normative note (the meaning differs). The normative binding shows no
difference.

### Remaining uncertainty

- Whether anyone intended "Obligatory" to mean "obligation-bearing" is not
  determinable from the files.

## 11. OCC Comparison

### Status

**OCC's classification behavior, label and derivation text agree with
SE-200's OCC, including its two N/A cells. No semantic discrepancy found.**
Labels from the 2026-04-29 draft survived and are consistent with the current
definition.

### Source of the authoritative definition

Same repository, commit and source paths as section 10.

### What the Lean and reference artifacts say

| Item | Value | Source |
| --- | --- | --- |
| Parent regime | `Regime.OCC` | `Profile/Core.lean` |
| `IdentityBasis` | `.single` | `Profile/Core.lean` |
| Split transformation | `none`; `theorem no_split_OCC` | `Profile/Core.lean` |
| Lean doc comment | "Time-indexed occurrence. Identity constituted by temporal realization and provenance. AD=BRK: decomposition produces sub-occurrences with distinct temporal individuation. SE=PRS: an occurrence may have stages that constitute the same event. RA=IGN, BF=IGN: N/A→IGN; occurrence is fixed by its realization event." | `Transform/Core.lean`, `occRow` |
| Distinctness | generic theorems only, as for OBL | `Transform/NonCollapse.lean` |
| Profile label | "Time-indexed occurrence profile" | `reference/regime-profiles.toml` |
| Family label | "Time-indexed occurrence" | `reference/regime-families.toml` |
| Derivation text | "No split: time-indexed occurrences are uniquely determined by occurrence identity without competing persistence interpretations." | `reference/regime-profile-derivation.toml` |

Complete classification row, column order RE AN RF AD RC RA SU BF PV SE:

`IGN IGN PRS BRK IGN IGN BRK IGN IGN PRS`

The Lean row and the `.toml` row are identical. Basis tags in the `.toml`:
`axiomatic` for RE and SU, `na-to-ign` for RA and BF, and `paper-definition`
for the other six. The RA and BF notes read "N/A→IGN. Occurrence is fixed by
realization event; bearer reassignment inapplicable" and "…forking
inapplicable". OCC and REC differ at AN, AD, BF, PV and SE.

### Comparison with SE-200 OCC (historical context only)

SE-200's counterpart is named `OCC`. Its column is
`NEU NEU PRS BRK NEU NA BRK NA NEU PRS`. Mapping NEU and N/A to IGN gives the
current OCC row on all ten cells. Four NEU cells (RE, AN, RC, PV) and two N/A
cells (RA, BF).

- **Behavior:** agrees on all ten cells. The two `na-to-ign` tags sit exactly on
  SE-200's two N/A cells.
- **Basis:** SE-200 says an occurrence is individuated by temporal realization
  and provenance, and that "branching and reassignment are inapplicable to a
  fixed realization event". The Lean comment states both points.
- **Label:** SE-200's inventory says occurrences "are time-indexed referents".
  The Lean and reference wording "time-indexed occurrence" matches.
- **Derivation text:** "no split" matches SE-200.

### History

- **2026-04-28** (`329c143`): `classify` held
  `IGN IGN PRS BRK IGN NA BRK NA IGN PRS`, which equals the current row with NA
  mapped to IGN. The 0.1.0 changelog records "OCC/AD classified as BRK" as a
  decision.
- **2026-04-29** (`655dc56`): `classify` unchanged. The draft matrix row was
  `PRS PRS PRS PRS BRK IGN BRK BRK IGN BRK`, differing at six cells (RE, AN, AD,
  RC, BF, SE). The draft's AD = PRS contradicted the recorded OCC/AD = BRK
  decision, and its SE = BRK contradicted the current PRS. The draft `.toml`
  header read "Identity is constituted by occurrence at a specific time-index."
  The label, family and derivation files were created in the same commit.
- **2026-05-02** (`053104d`): draft removed, `Transform/Core.lean` created from
  `classify`, `.toml` header rewritten to "temporal realization and provenance".
  The label files were not touched and have not changed since.

### Comparison with AE

- **Normative binding:** `AE.KIND.PER.OCC` maps "exactly to the upstream `OCC`
  profile kind" (`SPEC.md`, `CONFORMANCE.md`). `OCC` exists in Lean.
- **Explanatory note:** `IDENTIFIERS.md` and `data/spec/requirements.json` read
  "Placeholder for the Person entity kind under the Occurrent regime." First
  appears in `b1151fa` (2026-05-15).
- **Upstream declaration:** only `spec-se` (v1). Theory repo not declared.

"Occurrent" does not appear in Lean, `reference/`, `README.md`, `CHANGELOG.md`
or `docs/`. The docs role table says "Occasional identity — binding is
conditionally present" for OCC, which also differs from the Lean label. The
authoritative theory uses "occurrence". "Occurrent" is a standard term for
something that occurs, so it is compatible in substance but is not
authoritative wording.

Classification of the AE gloss: **harmless terminology**, not supported
verbatim by the authoritative theory. The normative binding shows no
difference.

### Remaining uncertainty

- Whether "Occurrent" was chosen with a technical meaning (endurant versus
  occurrent) in mind is not determinable from the files.

## 12. REC Comparison

### Status

**REC's classification behavior, label and derivation text agree with SE-200's
REC. No semantic discrepancy found.** One derivation phrase echoes draft
wording and is recorded as an observation only.

### Source of the authoritative definition

Same repository, commit and source paths as section 10.

### What the Lean and reference artifacts say

| Item | Value | Source |
| --- | --- | --- |
| Parent regime | `Regime.REC` | `Profile/Core.lean` |
| `IdentityBasis` | `.single` | `Profile/Core.lean` |
| Split transformation | `none`; `theorem no_split_REC` | `Profile/Core.lean` |
| Lean doc comment | "Descriptive record. Identity constituted by persistence as a descriptive referent. AN=PRS: a descriptive record survives annotation and enrichment. BF=PRS: a descriptive record persists across copying and forking. PV=PRS: provenance-tracking bridges the identity break in recovery (resolved: operative mechanism, not passive metadata)." | `Transform/Core.lean`, `recRow` |
| Distinctness | generic theorems only | `Transform/NonCollapse.lean` |
| Profile label | "Descriptive record profile" | `reference/regime-profiles.toml` |
| Family label | "Descriptive record" | `reference/regime-families.toml` |
| Derivation text | "No split: descriptive records preserve identity through representation without requiring alternative regime interpretations." | `reference/regime-profile-derivation.toml` |

Complete classification row, column order RE AN RF AD RC RA SU BF PV SE:

`IGN PRS PRS PRS IGN IGN BRK PRS PRS IGN`

The Lean row and the `.toml` row are identical. Basis tags in the `.toml`:
`axiomatic` for RE and SU, `resolved` for PV (the only cell in the matrix with
that tag), and `paper-definition` for the other seven. The `.toml` header says
the REC × PV cell "was disputed and resolved". That note was introduced on
2026-05-02, after the draft.

### Comparison with SE-200 REC (historical context only)

SE-200's counterpart is named `REC`. Its column is
`NEU PRS PRS PRS NEU NEU BRK PRS PRS NEU`. Mapping NEU to IGN gives the current
REC row on all ten cells. Four NEU cells (RE, RC, RA, SE), no N/A cells.

- **Behavior:** agrees on all ten cells, including AN, BF and PV = PRS.
- **Basis:** SE-200 says a record is individuated by descriptive persistence
  without substrate-level causal or normative commitment, and that it survives
  "enrichment, derivation, copying, and descriptive elaboration". The Lean
  comment states the same cells for the same reasons.
- **Label:** SE-200's inventory says "descriptive records". The labels match.
- **Derivation text:** "no split" matches. The phrase "through representation"
  echoes the draft `.toml` header "Identity is constituted through
  representation", which was replaced on 2026-05-02. It is consistent with
  SE-200 only loosely, since SE-200 makes re-expression neutral for every
  regime. I record it as an observation and as not a discrepancy.

### History

- **2026-04-28** (`329c143`): `classify` held
  `IGN PRS PRS PRS IGN IGN BRK PRS PRS IGN`, which equals the current row. The
  0.1.0 changelog records "REC/BF as PRS" as a decision.
- **2026-04-29** (`655dc56`): `classify` unchanged. The draft matrix row was
  `PRS PRS PRS PRS PRS PRS BRK BRK PRS BRK`, differing at five cells (RE, RC,
  RA, BF, SE). The draft's BF = BRK contradicted the recorded REC/BF = PRS
  decision. The label, family and derivation files were created in the same
  commit.
- **2026-05-02** (`053104d`): draft removed, `Transform/Core.lean` created from
  `classify`. The label files were not touched and have not changed since.

### Comparison with AE

- **Normative binding:** `AE.KIND.PER.REC` maps "exactly to the upstream `REC`
  profile kind". `REC` exists in Lean.
- **Explanatory note:** "Placeholder for the Person entity kind under the Record
  regime." First appears in `b1151fa` (2026-05-15).
- **Upstream declaration:** only `spec-se` (v1). Theory repo not declared.

"Record" is the head noun of the authoritative label "Descriptive record" and of
SE-200's "record". The docs role table says "Recurrent identity — binding
repeats across structural positions" for REC, which is not the Lean meaning. The
AE gloss matches the Lean label and not the docs table.

Classification of the AE gloss: **supported by the authoritative theory** (head
noun of the label), a harmless truncation. The normative binding shows no
difference.

### Remaining uncertainty

- None specific to REC beyond those in section 13.

## Part B. New section

## 13. All-Nine Conclusion and AE Gloss Audit

### Conclusion at the level of classification behavior and basis

**All nine profiles are resolved at the level of classification behavior.**
For each of OBL, OCC, REC, ENR_L, ENR_I, CTX_E, CTX_S, NOR_C and NOR_S:

1. the current Lean row equals the committed `.toml` row cell by cell;
2. the row equals the SE-200 Table 1 column under the NEU and N/A to IGN
   mapping, confirmed directly for each profile;
3. the initial `classify` row of 2026-04-28 equals the current row (NA to IGN)
   and was unchanged on 2026-04-29;
4. the 2026-04-29 draft matrix differs from the current matrix for every
   profile (six, six and five cells for OBL, OCC and REC).

**Identity basis is resolved at the level of agreement with SE-200's prose,
with one qualification.** The Lean `IdentityBasis` tag agrees with the SE-200
basis for the six split profiles. For OBL, OCC and REC the tag is `.single` for
all three. SE-200 names three different bases for them (responsibility-bearing,
temporal realization and provenance, and descriptive persistence). The three
profiles therefore have identical `ProfileAxes` (basis `.single`, split `none`).
Their distinctness rests on the parent regime constructors and on the rows.
`no_split_regime_injective` (`Profile/Core.lean`) proves exactly that. The
Lean comment on `IdentityBasis.single` says "singular referential continuity".

`identityBasis` is read nowhere in Lean outside the structure field and the
`axes` table. No theorem or definition consumes it, and only
`splitTransformation` feeds `UnderSplitPressure`. Basis agreement for all nine
profiles is therefore agreement of an enum tag, its comment, and the row notes.
It is the rows that carry behavior.

This is a representational coarsening and not a discrepancy in behavior. I
found no evidence that it conflates the three regimes, because Lean keeps them
separate by constructor and by row. Whether the `IdentityBasis` axis was
intended to carry the SE-200 bases for OBL, OCC and REC is not determinable from
the files, and it is not a defect on the available evidence.

**The three standalone regimes reveal no new semantic discrepancy.** Their
labels, family labels and derivation texts are consistent with the current Lean
definitions and with SE-200's wording. The draft-era wording that survived for
these three is not stale, since it agrees with the current definition.

### The draft's contradictions of recorded decisions

The 0.1.0 changelog (2026-04-28) records three matrix decisions: OCC/AD is BRK,
OBL/BF is IGN, REC/BF is PRS. The `classify` table implements all three. The
2026-04-29 draft matrix contradicted all three (OCC/AD = PRS, OBL/BF = BRK,
REC/BF = BRK). This supports the reading that the draft was a short-lived
alternative and not a revision of the theory.

### Additional draft residue in `reference/` and `docs/`

Searched `SE/`, `reference/`, `docs/` and `README.md`.

- **The word "draft" no longer occurs** in `SE/`, `reference/`, `docs/` or
  `README.md`.
- **`reference/regime-transformations.toml`** was created in `655dc56`
  (2026-04-29) and has not been changed since. Seven of its ten transformation
  descriptions differ from the per-family definitions in
  `Vocab/TransformBasis.lean`, whose comments are the repo's own expansions
  (SE-300 §3). The differences are clearest for RE, BF, SE and PV, where the
  two sources describe different operations, and are wording-level for AN, AD
  and RC:

  | Family | `regime-transformations.toml` | `Vocab/TransformBasis.lean` |
  | --- | --- | --- |
  | RE | "Retain exact identity without alteration." | "re-expression: change of representation format preserving content" |
  | AN | "Alter naming or labeling while preserving identity." | "annotation: addition of non-identity-bearing information" |
  | AD | "Adapt representation to a different form while maintaining correspondence." | "aggregation/decomp.: restructuring into coarser or finer components" |
  | RC | "Reclassify into a different category or interpretation context." | "re-contextualization: change in applicability context" |
  | BF | "Break identity or continuity such that equivalence no longer holds." | "branch/fork: divergence into multiple continuations" |
  | SE | "Separate into distinct components or identities." | "state evolution: change in state of an enduring referent over time" |
  | PV | "Project or derive a view from the original without preserving full identity." | "provenance extension: addition of historical or derivational information" |

  These expansions match the draft matrix's note wording ("Adaptation",
  "Reclassification", "Separation", "Projection"), which also disagreed with
  Lean's comments on 2026-04-28. RF, RA and SU descriptions are broadly
  compatible. The `order` field (SE = 9, PV = 10) differs from Lean's
  declaration order but matches `referenceTransformations` in
  `Reference/Core.lean`, so it is internally consistent. Its BF description
  describes BF as inherently identity-breaking, which matches the draft axiom
  that BF is BRK for all profiles, and which the current matrix contradicts for
  REC, ENR_L and CTX_E. This is the largest remaining residue in `reference/`
  because it is semantic and not only a label.
- **Other `reference/` files** last changed in `655dc56` are
  `regime-classification-values.toml`, `regime-families.toml`,
  `regime-profile-derivation.toml` and `regime-profiles.toml`. Their content was
  checked in this and earlier sections, with the stale items already listed for
  CTX_E, CTX_S, NOR_C and NOR_S.
- **`docs/en/index.md`** (non-authoritative per the repo's own Documentation
  Constraints) carries a role table that differs from the Lean labels for OBL
  ("Obligatory identity — binding is required"), NOR ("Normal identity"), OCC
  ("Occasional identity"), REC ("Recurrent identity") and ENR ("Enriched
  identity"). The repo's constraints prohibit docs from "introducing new
  terminology not present in Lean". Its `Formal definitions:` lines name
  modules such as `IdentityRegimes.Vocab.Regimes`, `.Profiles`, `.Transformations`,
  `.Requirements`, `.ReferenceRequirements`, `.Basic`, `.Admissibility`,
  `.LowerBound` and `.NonCollapse`. These names correspond to the April file
  layout. Nine of its eleven module references do not match the current layout,
  and only `Embedding` and `Witness` remain (without the `SE.` prefix added on
  2026-09-30).
- **`Reference/ClassificationMatrix.lean`** header says "Status: Cell values
  are verified against SE-300 paper definitions." (see open items on SE-300).
- **Version fields:** `regime-classification-matrix.toml` is `0.2.0` and the
  other versioned reference files are `0.1.0`, while `pyproject.toml` is
  `0.3.0`. I did not determine whether these fields are meant to track the
  package version.
- **Tooling note (recorded only):** `src/se_theory_identity_regimes/reference.py`
  states that human-authored fields (`description`, `name`, `cite_id`) are
  never overwritten by `se-ref-scaffold` without `--overwrite`. This is
  consistent with prose surviving unchanged but does not show whether
  `se-ref-validate` checks that prose against Lean. That question was not
  investigated.

### AE gloss audit: all nine `AE.KIND.PER.*` notes

All nine normative bindings (`SPEC.md`, `CONFORMANCE.md`) state "maps exactly
to the upstream `<X>` profile kind", and all nine names exist as
`RegimeProfileKind` constructors in Lean. The explanatory notes in
`IDENTIFIERS.md` and `data/spec/requirements.json` all follow the template
"Placeholder for the Person entity kind under the <gloss> regime" and all
first appear in `b1151fa` (2026-05-15). `SE_MANIFEST.toml` declares only
`spec-se` (v1) for every kind, and does not declare or pin
`se-theory-identity-regimes`.

| AE kind | AE gloss | Authoritative theory (Lean and `reference/`) | Classification |
| --- | --- | --- | --- |
| `OBL` | Obligatory | "Obligation-bearing entity"; "Obligatory" absent | **downstream drift** (meaning differs) |
| `OCC` | Occurrent | "Time-indexed occurrence"; "Occurrent" absent | **harmless terminology** (compatible near-synonym, not authoritative wording) |
| `REC` | Record | "Descriptive record" | **supported** (head noun of the label) |
| `ENR_L` | Enactment-Legal | "locus-bound" | **downstream drift** |
| `ENR_I` | Enactment-Instrumental | "instrument-bound" | **downstream drift** |
| `CTX_E` | Contextual-Epistemic | `.extension` | **downstream drift** |
| `CTX_S` | Contextual-Social | `.structure` | **downstream drift** |
| `NOR_C` | Normative-Contractual | `.content` | **downstream drift** |
| `NOR_S` | Normative-Social | `.structure` | **downstream drift** |

Summary: 1 supported, 1 harmless terminology, 7 downstream drift, 0
unresolved. All seven drift cases are non-normative notes that the AE spec
itself says introduce no requirements.

Observations that apply to all nine:

- Every note says "regime". In Lean, the six are "regimes" (OBL, NOR, OCC, CTX,
  REC, ENR) and the nine are "profile kinds". AE's normative text uses
  "profile kind" correctly. The note wording is a harmless terminology
  mismatch.
- The three non-split glosses are single words. The six split glosses use a
  family adjective and a qualifier (Enactment, Contextual, Normative, plus
  Legal, Instrumental, Epistemic, Social, Contractual). None of the five
  distinct qualifiers appears in the authoritative theory, and "Social" appears
  twice.
- The only repo location that uses "Obligatory" is the non-authoritative docs
  table, so the one non-split gloss that is classified as drift matches an
  already-divergent docs gloss.

## Part C. Replacement for the open-item list in section 5

### Resolved

- **All nine profiles are resolved at the level of classification behavior.**
  Each current row equals both the committed `.toml` row and the SE-200
  Table 1 column (NEU and N/A to IGN). No theoretical conflation was found for
  any of the nine.
- **All nine profiles are resolved at the level of identity-basis agreement
  with SE-200 prose**, with the qualification in section 13: `IdentityBasis` is
  an unconsumed tag, and OBL, OCC and REC share `.single`.
- **The label and derivation drift is bounded** to four profile labels (CTX_E,
  CTX_S, NOR_C, NOR_S), the CTX and NOR derivation sentences, and the
  `regime-transformations.toml` descriptions, all introduced in `655dc56`.
- **All nine AE notes are classified** (section 13 table).

### Carried forward, not investigated

- **NEU / N/A → IGN coarsening.** Counted programmatically: 48 of 90 cells are
  NEU or N/A in SE-200, which equals the Lean IGN count of 48. N/A cells are 8
  (OCC.RA, OCC.BF, ENR_L.RA, ENR_I.RA, and the four SE cells of the CTX and NOR
  profiles), all tagged `na-to-ign`. The 40 NEU cells carry no tag or note.
  `classify` stored NEU as IGN from 2026-04-28.
- **Stale `SE-300` citations.** Cited in `Transform/Core.lean`,
  `Transform/NonCollapse.lean`, `Transform/LowerBound.lean`, `Embedding.lean`,
  `Vocab/TransformBasis.lean`, `Reference/ClassificationMatrix.lean`, the matrix
  `.toml`, `regime-theorems.toml` and `CHANGELOG.md`. The tables cited equal
  SE-200 Table 1. Origin of the label was not determined.
- **Whether `se-ref-validate` checks labels and derivation prose against
  Lean.** Not investigated. Only the scaffold's preservation of human-authored
  fields was observed.
- **NOR_S "substitution-sensitive" and NOR_C "composition-sensitive" Lean
  comment wording.** SU is BRK for all nine profiles, so it does not
  distinguish NOR_S. Origin not traced.
- **Remaining draft-era comments or headers:** the `regime-transformations.toml`
  descriptions and the stale module names in `docs/en/index.md` (above). The
  rest of `reference/` was not audited line by line.
- **Whether `IdentityBasis` was intended to distinguish OBL, OCC and REC.**
- **SE-200's January 2026 arXiv version** was not compared. Only the repo state
  at 2026-07-19 was used.
- **Why the draft matrix was added and removed.** Not recorded.

## Part D. New section

## 14. Inventory: Proven Edits and Open Investigations

No edits have been made.

### Proven by evidence in this note (candidate future edits)

Each item below is a contradiction between files, established by direct
comparison, whose resolution target is determined by the authoritative Lean
source. The choice to make the edit is the repository owner's.

In `se-theory-identity-regimes`:

1. `reference/regime-profiles.toml`: the labels for `CTX_E` ("event-bound"),
   `CTX_S` ("scope-bound"), `NOR_C` ("context-bound") and `NOR_S`
   ("scope-bound") do not describe the current Lean definitions (sections 6 to
   9).
2. `reference/regime-profile-derivation.toml`: the `CTX` and `NOR` derivation
   sentences repeat the same stale wording.
3. `reference/regime-transformations.toml`: the descriptions for RE, AN, AD,
   RC, BF, SE and PV differ from `Vocab/TransformBasis.lean`, clearly so for
   RE, BF, SE and PV (section 13).
4. `docs/en/index.md`: the role table for OBL, NOR, OCC, REC and ENR and the
   `Formal definitions:` module names contradict the repo's own Documentation
   Constraints and the current layout (section 13).

In `spec-ae`:

5. `IDENTIFIERS.md` and `data/spec/requirements.json`: seven non-normative
   notes (OBL, ENR_L, ENR_I, CTX_E, CTX_S, NOR_C, NOR_S) do not match the
   authoritative theory. OCC and REC are compatible.
6. `SE_MANIFEST.toml`: the upstream theory repo is not declared or pinned. The
   absence is established. Whether a dependency belongs there is a design
   decision that this note does not settle.

No edit is indicated for: any Lean row, basis tag, split transformation, or
non-collapse theorem; the committed `.toml` matrix rows; the OBL, OCC, REC,
ENR_L and ENR_I profile labels, family labels and derivation texts; or the
`AE.KIND.PER.*` normative bindings.

### Open investigations (evidence incomplete)

1. NEU / N/A to IGN coarsening: whether it affects any theorem or consumer
   beyond the non-collapse proofs.
2. The `SE-300` citations: working name, separate paper, or stale label.
3. Whether `se-ref-validate` validates `label`, `description` or derivation
   prose against Lean.
4. The origin and meaning of "substitution-sensitive" (NOR_S) and
   "composition-sensitive" (NOR_C).
5. Whether `IdentityBasis` is meant to separate OBL, OCC and REC, and whether
   it should be consumed by any theorem.
6. Whether the `.structure` basis denotes the same thing for CTX_S and NOR_S.
7. Whether the January 2026 arXiv version of SE-200 differs from the repo state
   used here.
8. Why the draft matrix was added on 2026-04-29 and removed on 2026-05-02.
9. The meaning intended by the AE glosses "Obligatory" and "Occurrent".
10. Whether version fields in `reference/` should track the package version.
11. The remaining `reference/` files, the Lean comments and the docs, which were
    not audited line by line for further draft-era wording.
