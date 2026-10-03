<!--
Snippet for research/alignment/2026-09-30-ae-ep-cee-diagnostic.md
Part A: append as a new section "6. CTX_E / SCOPE-E Comparison"
        (after section 5, or after section 1 if you prefer regime order).
Part B: append these bullets to the "Open items carried forward" list in
        section 5. If section 5 is still the original text, add them as a
        new list under it.
The existing note file was not edited.
-->

## Part A. New section

## 6. CTX_E / SCOPE-E Comparison

### Status

**CTX_E's classification behavior agrees with SE-200 SCOPE-E on all ten
transformations. The reference label `event-bound` is stale reference-artifact
residue from an April 29 draft and does not describe the current definition.
The reason the draft row was rewritten on May 2 is not recorded.**

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

### What the Lean and reference artifacts say

| Item | Value | Source |
| --- | --- | --- |
| Parent regime | `Regime.CTX` | `Profile/Core.lean`, `RegimeProfileKind.regime` |
| `IdentityBasis` | `.extension`, comment "applicability extension (CTX-E)"; an enum tag with no further predicate | `Profile/Core.lean`, `IdentityBasis` and `RegimeProfileKind.axes` |
| Split transformation | `some .AD` (aggregation/decomposition); shared with CTX_S | `Profile/Core.lean`, `RegimeProfileKind.axes` |
| Non-collapse witness | AD: PRS under CTX_E, BRK under CTX_S | `Transform/NonCollapse.lean`, `noncollapse_CTX_E_CTX_S` |
| Lean doc comment | "Applicability context, extension-sensitive. Identity constituted by persistence of the same applicability extension." | `Transform/Core.lean`, `ctxERow` |
| Profile label | "Applicability context, event-bound profile" | `reference/regime-profiles.toml` |
| Family label | "Applicability context" | `reference/regime-families.toml` |
| Derivation text | "Split required: applicability contexts differentiate based on the binding axis (event-bound vs scope-bound)." | `reference/regime-profile-derivation.toml` |

Complete classification row, column order RE AN RF AD RC RA SU BF PV SE:

`IGN IGN PRS PRS PRS IGN BRK PRS IGN IGN`

The Lean row (`ctxERow`) and the committed `.toml` row
(`matrix.CTX_E.*`) are identical, checked cell by cell. Basis tags in the
`.toml` are `axiomatic` for RE and SU, `paper-definition` for AN, RF, AD, RC,
RA, BF and PV, and `na-to-ign` for SE.

### Comparison with SE-200 SCOPE-E (historical context only)

Source: `paper-200-identity-regimes`, `sections/06_nine_regimes.tex` Table 1
and `sections/05_algebra.tex` (scope split), repo state at 2026-07-19.

SCOPE-E's column is `NEU NEU PRS PRS PRS NEU BRK PRS NEU NA`. Mapping NEU and
N/A to IGN, it equals the CTX_E row on all ten cells, checked mechanically.

The basis agrees: SE-200 says a scope is individuated by its extension
(extension-fixed) or its structure (structure-fixed), and that AD is
non-breaking for the extension reading and breaking for the structure
reading. Lean's `.extension` basis, `AD` split transformation, and AD
PRS/BRK pair match this.

SE-200 does not contain an "event-bound" regime or basis anywhere in
`sections/`. Its occurrences of "event" concern occurrences and enactment,
not applicability contexts.

### History of the `event-bound` label

- **2026-04-29** (`655dc56`, "update"): the first commit containing
  `reference/`. `regime-profiles.toml` and `regime-profile-derivation.toml`
  gained the `event-bound` wording. At the same commit
  `reference/regime-classification-matrix.toml` described CTX_E as
  "event-bound: identity is constituted by binding to a specific event".
  Its row was `PRS PRS PRS PRS BRK IGN BRK BRK IGN BRK` (column order above,
  so RC, BF and SE were BRK). Every non-axiomatic cell was tagged
  `basis = "draft"`. The Lean matrix at that commit had the identical row.
- At that same commit the Lean `IdentityBasis` for CTX_E was already
  `.extension` (`IdentityRegimes/Profiles.lean`). The draft event-bound row
  and the Lean basis were therefore already inconsistent on 2026-04-29.
- **2026-05-02** (`053104d`, "Prep 0.3.0"): the CTX_E row was rewritten in
  both Lean and the `.toml` to the current extension-sensitive row, with
  `paper-definition` basis tags and notes such as "Re-contextualization
  preserves applicability extension by definition of CTX-E." The commit
  touched `reference/regime-classification-matrix.toml` and four other
  reference files. It did not touch `regime-profiles.toml` or
  `regime-profile-derivation.toml`.
- No commit since 2026-04-29 has changed those two files, so the
  `event-bound` and `scope-bound` wording has persisted unchanged through the
  rewrite and through the 2026-09-30 move.
- The `.extension` basis was not changed to `event`. The resolution moved
  the row toward the basis, not the basis toward the label.
- The `CHANGELOG.md` entry for 0.1.0 (2026-04-28) says the CTX_E row was
  "verified against SE-300 split sections". That row was later rewritten,
  and the changelog does not record why.

### Classification

- **Current CTX_E definition versus SE-200 SCOPE-E:** terminology only.
  Behavior agrees on every cell, and the basis agrees. The labels differ
  (CTX_E / SCOPE-E; family "applicability context" / carrier "scope").
- **`event-bound` label and derivation text:** downstream or
  reference-artifact drift, internal to the theory repo. The two files
  carry an April draft description that the May 2 revision superseded and
  did not update. Both files are in the repo's committed `reference/` set.
  Whether the repo's `se-ref-validate` checks labels against Lean is not
  verified.
- **April draft row to current row:** a revision during development. The old
  cells were tagged `draft`. The reason for the rewrite is not recorded in
  the commit message or changelog.
- **Theoretical conflation:** no evidence. The draft event-bound semantics
  were replaced, not merged with the extension semantics. No source I read
  describes event-bound identity as a distinct regime that should survive.

### Comparison with AE

Sources: `spec-ae` at `main` (latest commit 2026-05-30), `SPEC.md`,
`CONFORMANCE.md`, `IDENTIFIERS.md`, `data/spec/requirements.json`,
`SE_MANIFEST.toml`.

Normative name binding:

- `SPEC.md`, `## AE.KIND.PER.CTX_E`: the kind "is defined explicitly" and
  "maps exactly to the upstream `CTX_E` profile kind". The identifier is
  structural and must not be interpreted as defining domain meaning,
  epistemic authority, legal status, social role, or enforcement effect.
- `CONFORMANCE.md`, `## AE.KIND.PER.CTX_E`: the same mapping with a check
  that the kind is not renamed, merged, split, or reinterpreted.
- `AE.IDENTITY.REGIME.MAPPING` (`SPEC.md`): each kind maps to exactly one
  upstream SE profile kind, and the upstream kind determines
  identity-and-persistence behavior.
- `CTX_E` exists in Lean as `RegimeProfileKind.CTX_E`. The binding holds by
  name only. AE states no identity basis for CTX_E.

Explanatory note (non-normative):

- `IDENTIFIERS.md`, entry `AE.KIND.PER.CTX_E`, and
  `data/spec/requirements.json` read "Placeholder for the Person entity kind
  under the Contextual-Epistemic regime."
- `IDENTIFIERS.md` states notes are explanatory only and introduce no
  requirements. The string first appears in `b1151fa` (2026-05-15,
  "prep 0.9.1"), after the Lean 0.3.0 rewrite.
- The gloss does not match Lean's "applicability extension". It also sits in
  tension with AE's own normative text, which says the identifier must not be
  read as defining epistemic authority. I record the tension and do not
  evaluate it further.

Upstream declaration:

- `SE_MANIFEST.toml` in `spec-ae` declares only `spec-se` (v1) as a required
  dependency. `se-theory-identity-regimes` is not declared or pinned.
  `SPEC.md` refers to "upstream SE profile kinds" without naming a
  repository or version.

Classification of the AE gloss: **downstream specification drift** in a
non-normative note. The normative name binding shows no difference. This
classification is separate from the CTX_E theory finding above.

### Remaining uncertainty

- Why the CTX_E row was rewritten on 2026-05-02 is not recorded anywhere I
  read.
- Whether the reference validator checks labels and derivation text against
  Lean is not verified.
- `IdentityBasis.extension` has no predicate in Lean beyond the row and its
  comment.
- AE's "Contextual-Epistemic" is not shown to carry any intended meaning
  beyond placeholder text.
- Whether arXiv 2601.16152 (January 2026 by ID) already had the SCOPE-E
  formulation before the repo's July restructure was not checked. In the
  `paper-200-identity-regimes` repo, `se200_identity_regimes.tex` on
  2026-05-02 held the six-regime paper (a single CTX regime, no
  CTX_E/CTX_S split), and `sections/06_nine_regimes.tex` first appears on
  2026-07-08. The Lean split therefore predates the nine-regime text in that
  repo.

### Adjacent observations (recorded, not investigated)

- **CTX_S, NOR_C and NOR_S labels:** `regime-profiles.toml` and the
  derivation file use "scope-bound" for CTX_S and "context-bound" and
  "scope-bound" for NOR_C and NOR_S. Their Lean bases are `structure`,
  `content` and `structure`. All came from the same 2026-04-29 commit.
- **CTX_E.SE rationale text:** the `.toml` note and Lean header say
  "normative structures do not undergo state evolution". CTX_E is an
  applicability context. SE-200 gives a different reason for the N/A at
  SE: a scope is an applicability domain and not an enduring referent. The
  cell value agrees. Only the rationale wording differs.

## Part B. Items to append in section 5

- **NEU / N/A to IGN coarsening: evidence recorded, not investigated.**
  - `reference/regime-classification-matrix.toml` tags exactly eight cells
    `basis = "na-to-ign"`: OCC.RA, OCC.BF, ENR_L.RA, ENR_I.RA, CTX_E.SE,
    CTX_S.SE, NOR_C.SE, NOR_S.SE. These match the eight N/A cells in
    SE-200 Table 1.
  - The string `NEU` does not appear in `SE/`, `reference/`, `docs/`,
    `CHANGELOG.md` or `README.md`. NEU cells are mapped to IGN without a
    tag or note recording the source value.
  - In the CTX_E row, RE, AN, RA and PV are NEU in SE-200, and SE is N/A.
  - The `Transform/Core.lean` header states the N/A to IGN convention and
    says it preserves the induced equivalence relations that determine
    non-collapse.
  - `regime-classification-values.toml` defines IGN as "Transformation does
    not affect identity." It does not define IGN as covering "not
    applicable".
- **Stale `SE-300` source citations: evidence recorded, not investigated.**
  - `SE-300` is cited in `Transform/Core.lean`, `Transform/NonCollapse.lean`
    (including `Prop. CTX non-collapse`), `Transform/LowerBound.lean`,
    `Embedding.lean`, `Vocab/TransformBasis.lean`, the matrix `.toml`,
    `regime-theorems.toml` and `CHANGELOG.md`.
  - The 0.1.0 changelog entry (2026-04-28) claims rows "verified against
    SE-300 split sections". The CTX_E row changed after that date.
  - In `paper-200-identity-regimes`, the six-regime paper was in place on
    2026-05-02 and the nine-regime sections appear on 2026-07-08, so the
    paper that the Lean cites as "SE-300" in April and May may not be the
    current SE-200. I did not locate a paper named SE-300 that contains
    these tables.
- **Label drift in `reference/` after 2026-04-29:** CTX_E, CTX_S, NOR_C and
  NOR_S are affected. ENR_L and ENR_I labels remain consistent.
