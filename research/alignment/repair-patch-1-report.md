# Repair patch 1 for `se-theory-identity-regimes`

<!-- markdownlint-disable MD036 -->

Status: **prepared, not applied.** No commit and no change to your repository. The patch was applied
only to scratch copies of `main` at `1d08827` (2026-09-30).

| Artifact | Purpose |
| --- | --- |
| `repair-patch-1.diff` | Unified diff. 7 files, 87 insertions, 51 deletions. `git apply --check --whitespace=error` passes on a pristine checkout of `1d08827`. |
| `validate-repair-patch-1.py` | 42 programmatic checks. Usage: `python validate-repair-patch-1.py <unpatched-checkout> <patched-checkout>`. |
| this report | Exact Find / Replace blocks, rationale, validation results, items withheld or flagged. |

Apply with:

```text
git switch -c docs/alignment-repair-1
git apply --check repair-patch-1.diff && git apply repair-patch-1.diff
```

## What was not changed

No `IdentityBasis`, classification row, split transformation, theorem statement or proof; no
applicability, carrier or persistence field; no CHANGELOG entry; no `SE-300` citation line; no `spec-ae`.
Both Lean files differ from `HEAD` only inside comments, and the checker confirms the code is identical
once comments are stripped.

---

## DONE Edit 1. `SE/IdentityRegimes/Transform/Core.lean` (header comment, lines 20 to 24)

Finding: diagnostic section 15. The paper (Defs 3.7 and 3.8) treats N/A as `Appl_P(f) = 0`, with
classification undefined, and IGN as a value for an applicable transformation. The accountable-records
paper's legality check treats NA and NEU differently.

**Find**

```text
NA→IGN CONVENTION
N/A entries from the paper are mapped to IGN: "not applicable" is
semantically equivalent to "identity question does not arise" (IGN).
This mapping avoids introducing a fourth value while preserving the
induced equivalence relations that determine non-collapse.
```

**Replace**

```text
NA→IGN CONVENTION
N/A entries from the paper are mapped to IGN. This is intentional: it keeps
the matrix total and three-valued, avoiding a fourth value.

In the paper's profile model, N/A marks a transformation as inapplicable to
the profile (applicability Appl_P(f) = 0), and classification is undefined
there. IGN is a classification value for an applicable transformation, so
N/A and IGN are not the same thing in the paper.

The mapping preserves the PRS-generated identity relations used by the
current non-collapse machinery, but it does not preserve the paper's
separate applicability component. This matrix does not model applicability,
persistence, or identity carrier.
```

The "Affected cells" list, "Verified counts" and the `Source: SE-300` lines are untouched.

## DONE Edit 2. `reference/regime-classification-matrix.toml` (header comment, lines 8 to 10)

Finding: same as edit 1. Keeps the file consistent with the corrected Lean header.

**Find**

```text
# N/A entries from the paper are mapped to IGN:
#   "not applicable" is semantically equivalent to
#   "identity question does not arise" (IGN).
#
```

**Replace**

```text
# N/A entries from the paper are mapped to IGN. This is intentional: the matrix
# is total and three-valued.
#   In the paper's profile model, N/A marks a transformation as inapplicable
#   to the profile (applicability Appl_P(f) = 0), and classification is
#   undefined there. IGN is a classification value for an applicable
#   transformation, so N/A and IGN are not the same thing in the paper.
#   The mapping preserves the PRS-generated identity relations used by the
#   current non-collapse machinery, but it does not preserve the paper's
#   separate applicability component. The affected cells are tagged
#   basis = "na-to-ign" below.
#
```

Checked: all 90 cells (value, basis, note) and `[meta]` are identical before and after; PRS, BRK and IGN
counts are still 22, 20 and 48; the eight `na-to-ign` tags are preserved.

## DONE Edit 3. `SE/IdentityRegimes/Transform/NonCollapse.lean` (comments only, three hunks)

Finding: diagnostic section 15. 34 of the 36 unordered profile pairs have different PRS sets. Two pairs
have equal PRS sets, so their PRS-generated relations coincide: OBL / NOR_C (rows differ only at BF) and
CTX_S / NOR_S (rows differ only at RC and RA). The paper separates them by carrier (GEN-CAR). The
numbers below are recomputed from the committed matrix, not copied from the diagnostic.

**Hunk 3a. Find** (header, lines 21 to 23)

```text
For the nine derived profiles, every matrix difference that appears in a proof
involves a PRS cell for at least one of the two profiles being compared, so
the Lean definition is operationally equivalent to the paper's ∼_P ≠ ∼_Q.
```

**Replace**

```text
For the nine derived profiles, 34 of the 36 unordered profile pairs have
different PRS sets, so the argument above applies to them. (The connection to
∼_P is documented here; ∼_P and applyTrans are not defined as Lean objects.)

The other two pairs have equal PRS sets, and therefore equal PRS-generated
relations. Their matrix rows differ only at non-PRS cells:

  OBL vs NOR-C:   PRS sets are both {RF, AD}; the rows differ only at
                  BF (IGN vs BRK).
  CTX-S vs NOR-S: PRS sets are both empty; the rows differ only at
                  RC and RA (BRK vs IGN).

For these two pairs Lean proves row-level matrix distinction (NonCollapsing),
which is not the paper's ∼_P ≠ ∼_Q. The paper separates them by identity
carrier (GEN-CAR), which this file does not model. The row-level distinction
is still strict: classification_pattern_unique shows that all nine rows are
pairwise distinct.
```

**Hunk 3b. Find** (header, line 33)

```text
    Separated by difference in classification behavior across families.
```

**Replace**

```text
    The paper separates these by difference in identity carrier. Lean
    separates them by difference in classification behavior across families
    (noncollapse_of_distinct_regime); identity carriers are not modeled in
    the profile matrix.
```

**Hunk 3c. Find** (docstring of `NonCollapsing`, lines 44 to 46)

```text
    This is sufficient for the paper's condition ∼_P ≠ ∼_Q: distinct PRS sets
    induce distinct equivalence relations on the representation space.
    See noncollapse_of_prs_difference for the operative connection. -/
```

**Replace**

```text
    This is a row-level (matrix) distinction. It gives the paper's condition
    ∼_P ≠ ∼_Q when the difference involves a PRS cell: distinct PRS sets
    induce distinct equivalence relations on the representation space.
    A difference confined to non-PRS cells does not by itself change ∼_P.
    See noncollapse_of_prs_difference for the operative connection, and the
    file header for the two profile pairs with equal PRS sets. -/
```

Not included: the tactic-replay counts from the diagnostic (27 PRS witnesses, nine non-PRS), because I did
not build Lean and they depend on elaboration order. The comments state only matrix-derived facts.
Checked: comment delimiters balance and no code token changes.

## DONE Edit 4. `reference/regime-transformations.toml` (seven `description` values)

Finding: diagnostic sections 13 and 16. The Lean comments in `Vocab/TransformBasis.lean` are verbatim
from Def 4.3 of the neutral-representation manuscript. The checker confirms each new description's text
after the colon equals the Lean gloss. Identifiers, `label`, `order` and `[meta]` are unchanged; the file
keeps its `SE = 9`, `PV = 10` order, which matches `referenceTransformations` in `Reference/Core.lean`.

| Key | Find | Replace |
| --- | --- | --- |
| RE | `Retain exact identity without alteration.` | `Re-expression: change of representation format preserving content.` |
| AN | `Alter naming or labeling while preserving identity.` | `Annotation: addition of non-identity-bearing information.` |
| AD | `Adapt representation to a different form while maintaining correspondence.` | `Aggregation/decomposition: restructuring into coarser or finer components.` |
| RC | `Reclassify into a different category or interpretation context.` | `Re-contextualization: change in applicability context.` |
| BF | `Break identity or continuity such that equivalence no longer holds.` | `Branch/fork: divergence into multiple continuations.` |
| SE | `Separate into distinct components or identities.` | `State evolution: change in state of an enduring referent over time.` |
| PV | `Project or derive a view from the original without preserving full identity.` | `Provenance extension: addition of historical or derivational information.` |

The Lean comment abbreviates the AD lead-in as "aggregation/decomp."; the replacement spells it out. The
text after the colon is identical.

## DONE Edit 5. `reference/regime-profiles.toml` (four labels)

Finding: diagnostic sections 6 to 9. `event-bound`, `scope-bound` and `context-bound` come from the
2026-04-29 draft and appear in neither the neutral-representation manuscript nor the six-kind paper. New
labels use the headline wording of each profile's own Lean doc comment (`Transform/Core.lean`), which
also matches the `.toml` matrix row headers and the manuscript's §5.3. This mirrors how the unchanged ENR
labels follow the same sources.

| Profile | Find | Replace |
| --- | --- | --- |
| CTX_E | `label = "Applicability context, event-bound profile"` | `label = "Applicability context, extension-sensitive profile"` |
| CTX_S | `label = "Applicability context, scope-bound profile"` | `label = "Applicability context, structure-sensitive profile"` |
| NOR_C | `label = "Normative structure, context-bound profile"` | `label = "Normative structure, composition-sensitive profile"` |
| NOR_S | `label = "Normative structure, scope-bound profile"` | `label = "Normative structure, substitution-sensitive profile"` |

OBL, OCC, REC, ENR_L and ENR_I are untouched. See decision point 1 below.

## DONE Edit 6. `reference/regime-profile-derivation.toml` (CTX and NOR sentences)

Finding: diagnostic sections 6 to 9. The new sentences keep the AD and RF split logic, which the Lean
records as `splitTransformation`, and follow the shape of the unchanged ENR sentence. `split` flags and
`profiles` lists are unchanged.

**Find**

```text
description = "Split required: applicability contexts differentiate based on the binding axis (event-bound vs scope-bound)."
```

**Replace**

```text
description = "Split required: applicability contexts admit multiple identity interpretations (e.g., extension-sensitive vs structure-sensitive), forced under decomposition (AD)."
```

**Find**

```text
description = "Split required: normative structures separate along context-bound and scope-bound applicability regimes."
```

**Replace**

```text
description = "Split required: normative structures admit multiple identity interpretations (e.g., composition-sensitive vs substitution-sensitive), forced under refinement (RF)."
```

## Edit 7. `docs/en/index.md`

Finding: diagnostic section 13. The page says it is non-authoritative and that Lean is correct. The role
table uses wording that appears nowhere in Lean, and the module names use the pre-2026-09-30 layout.

### 7a. Role table (lines 94 to 101)

The new values are the family labels in `reference/regime-families.toml`. The column header is unchanged.

**Find**

```text
| Regime | Role                                                                 |
| ------ | -------------------------------------------------------------------- |
| OBL    | Obligatory identity — binding is required                            |
| NOR    | Normal identity — binding follows default structural rules           |
| OCC    | Occasional identity — binding is conditionally present               |
| CTX    | Contextual identity — binding depends on structural context          |
| REC    | Recurrent identity — binding repeats across structural positions     |
| ENR    | Enriched identity — binding carries additional structural annotation |
```

**Replace**

```text
| Regime | Role                            |
| ------ | ------------------------------- |
| OBL    | Obligation-bearing entity       |
| NOR    | Normative structure             |
| OCC    | Time-indexed occurrence         |
| CTX    | Applicability context           |
| REC    | Descriptive record              |
| ENR    | Enduring non-normative referent |
```

### 7b. Module paths (17 replacements; one of them spans two lines)

I used the dotted form that the docs already use and that `source_module` uses in `reference/`. Each
dotted name maps to `SE/IdentityRegimes/...` by replacing dots with slashes. The checker confirms all 13
distinct modules cited exist as files.

| Line | Old | New |
| --- | --- | --- |
| 15 | `` under `IdentityRegimes/`. `` | `` under `SE/IdentityRegimes/`. `` |
| 72 | `IdentityRegimes.Basic` | `SE.IdentityRegimes.Vocab.Basic` |
| 79 | `import IdentityRegimes` | `import SE.IdentityRegimes` |
| 106 | `IdentityRegimes.Vocab.Regimes` | `SE.IdentityRegimes.Vocab.Regimes` |
| 121 | `IdentityRegimes.Requirements` | `SE.IdentityRegimes.Vocab.Requirements` |
| 144 | `IdentityRegimes.Profiles` | `SE.IdentityRegimes.Profile.Core` |
| 165 | `IdentityRegimes.Transformations` | `SE.IdentityRegimes.Vocab.TransformBasis` and `SE.IdentityRegimes.Transform.Core` (two lines) |
| 178 | `IdentityRegimes.Admissibility` | `SE.IdentityRegimes.Profile.Admissibility` |
| 194 | `IdentityRegimes.Embedding` | `SE.IdentityRegimes.Embedding` |
| 209 | `IdentityRegimes.LowerBound` | `SE.IdentityRegimes.Transform.LowerBound` |
| 225 | `IdentityRegimes.NonCollapse` | `SE.IdentityRegimes.Transform.NonCollapse` |
| 241 | `IdentityRegimes.Theorems` | `SE.IdentityRegimes.Theorems` |
| 254 | `IdentityRegimes.Witness` | `SE.IdentityRegimes.Witness` |
| 263 to 265 | `IdentityRegimes.Requirements`, `.Admissibility`, `.Theorems` | the three `SE.IdentityRegimes...` equivalents |
| 267 | `IdentityRegimes.ReferenceRequirements` | `SE.IdentityRegimes.Reference.Core` |

Evidence for the less obvious rows: `ReferenceRequirements.lean` was renamed to `Reference/Core.lean`
(git rename R090 in `053104d`); there is no file named for "Transformations", and the content is split
between `Vocab/TransformBasis.lean` and `Transform/Core.lean`; `README.md` line 34, the file
`SE/IdentityRegimes.lean` and `lakefile.toml` (`defaultTargets`) all give `SE.IdentityRegimes` as the
import surface.

Lines 15 and 79 go slightly beyond the "Formal definitions:" lines you listed. They are the same class of
stale module path and are verified against the README and lakefile. Drop those two hunks if you want the
patch strictly limited to the listed lines.

---

## Validation

| Check | Result |
| --- | --- |
| `git apply --check --whitespace=error` on pristine `1d08827` | passes |
| 42 programmatic checks (`validate-repair-patch-1.py`) | all pass |
| Same checker on an unpatched tree (negative control) | fails on exactly the intended items (stale descriptions, labels, module names, role table) |
| `markdownlint-cli2 docs/en/index.md` before and after | 0 errors both |
| Python smoke test (`tests/test_smoke.py`) | 1 passed (`-o addopts=""`, because the coverage plugin does not load on the Python 3.15 alpha available here) |

The 42 checks cover: Lean code identical outside comments and comment delimiters balanced; all four edited
TOML files parse; the matrix is unchanged (cells, tags, meta, 22/20/48); exactly the intended keys changed
in `regime-transformations`, `regime-profiles` and `regime-profile-derivation`; new descriptions equal the
Lean glosses; new labels equal the Lean doc-comment headlines plus "profile"; the PRS-set facts asserted in
the new comments (34 of 36 pairs, two equal-PRS pairs, their differing cells, 66 cross-family ordered pairs,
nine pairwise-distinct rows); the four named theorems exist; docs modules exist; docs role table equals
`regime-families.toml`.

**Commands to run before you commit** (from the repo root):

```text
git apply --check repair-patch-1.diff && git apply repair-patch-1.diff
python validate-repair-patch-1.py <unpatched-checkout> .
lake build
uv run se-ref-validate          # see "Tooling state at HEAD"
uv run se-validate --strict
uv run python -m pytest
markdownlint-cli2 docs/en/index.md
```

### Tooling state at HEAD (independent of this patch)

I could not run these, and they fail the same way on an unpatched copy. I did not investigate further.

- `se-ref-validate` stops with "reference/index.toml not found". `reference/index.toml` was deleted in
  `1d08827`.
- `se-theory-reference validate` (kit 0.3.1) stops with "Unable to read TOML file
  reference/substrate-axioms.toml". `reference/theory-reference.toml`, added in `1d08827`, declares seven
  `substrate-*.toml` and registry paths that do not exist in `reference/`: `dependency-registry`,
  `substrate-axioms`, `substrate-predicates`, `substrate-requirements`, `substrate-theorems`,
  `substrate-types` and `traceability-registry`. They look carried over from another repo's template.
- `lake build` was not run. The Lean files import a mix of `SE.IdentityRegimes.X` and `IdentityRegimes.X`
  while `lakefile.toml` names the library `SE.IdentityRegimes`, so the build may already fail at `HEAD`. The
  patch changes no code, so it cannot change that outcome.
- `lakefile.toml` (version `0.4.0`) requires `SETheoryTransformation` v0.3.0, but `lake-manifest.json`
  lists only `NeutralSubstrate`, and `pyproject.toml` says `0.3.0`.
- `uv sync --extra dev --extra docs` (README) fails because `pyproject.toml` defines dependency groups and
  not those extras. The docs group also failed to build on the Python 3.15 alpha, so the Zensical docs
  build was not run.

---

## Where the current files differ from the diagnostic, or the edit needs your decision

1. **The repo's copy of the diagnostic has only sections 1 to 5.** `research/alignment/2026-09-30-ae-ep-cee-diagnostic.md`
   at `1d08827` does not contain sections 6 to 17 or the final inventory. I treated the findings as
   recorded in the snippets from this conversation, and re-verified each against the primary files in
   this pass rather than relying on the note. If your local note differs, check it against the findings
   cited above.

2. **Decision point 1: the NOR labels.** "composition-sensitive" and "substitution-sensitive" are the Lean
   doc-comment headlines and the manuscript's §5.3 wording, so they are Lean-supported. They also disagree
   with the bases `.content` and `.structure`, and "substitution-sensitive" does not distinguish NOR_S
   because SU is BRK for every profile. If you prefer labels that follow the bases, the alternatives are
   `Normative structure, content-sensitive profile` and `Normative structure, structure-sensitive profile`.
   "content-sensitive" is the manuscript's §7.1 wording, but it appears in Lean only as the basis name
   `.content`. I chose the first set so the profile label, the matrix row header and the Lean comment agree.
   If you switch, the derivation sentence in edit 6 needs the same two words.

3. **Edit 4 is narrower than the stale file.** The diagnostic called RF, RA and SU "broadly compatible". On
   re-reading, two of them embed identity claims that the matrix contradicts:
   - RF says "while preserving identity", but RF is BRK for CTX_S and NOR_S.
   - RA says "while preserving referential linkage", but RA is BRK for CTX_S.
   - SU ("Substitute with a different entity or structure.") is compatible.

   Optional extra hunks, not in the patch:
   RF to `Refinement: increase in descriptive or structural detail.` and
   RA to `Reassignment: change in association or bearer.` I held them because you listed seven keys.

4. **Edit 7 corrects only what you listed; the page has more stale content.** After 7a and 7b the page
   still describes a design that predates the current Lean, for example:
   - lines 65 to 67: `Regime` as a typeclass, `RegimeKind`, `RegimeBinding` (Lean has an enumeration
     `Regime` and no such types);
   - lines 85 to 88: the "dependency order" block uses the old module names;
   - lines 110 to 119, 185 to 192, 198 to 207, 213 to 223, 231 to 239, 247 to 252, 258 to 265: requirements,
     loci embeddings, per-regime lower bounds, "six regimes" non-collapse, and a "ReferenceRequirements"
     index, none of which match the current theorems (nine profiles, matrix-based);
   - lines 103 to 104 and 282: "identity-binding structure".

   A corrected role table and corrected paths next to this prose is an improvement but not a reconciliation.
   Decide whether to land edit 7 on its own or hold it for a fuller docs pass.

5. **`SE-300` lines were not touched**, per your instruction. The `Source: SE-300` lines remain in
   `Transform/Core.lean`, `NonCollapse.lean` and the matrix `.toml` header.

6. **Noticed, not edited (outside the seven files):** `Surface.lean` line 23 comment says
   `import IdentityRegimes`; the `README.md` and `lakefile.toml` say `SE.IdentityRegimes`. The upstream
   package `se-theory-transformation`, which the lakefile now requires, uses a different taxonomy
   (operator codes such as `BR`) and not the ten-family basis, so it does not conflict with edit 4. The
   version fields differ across files (`pyproject` 0.3.0, `lakefile` 0.4.0, matrix `.toml` 0.2.0).

7. **CHANGELOG.** Not edited. If you want an entry, an `[Unreleased]` bullet such as "Documentation and
   reference wording aligned with the Lean source (N/A to IGN note, non-collapse note, transformation
   descriptions, four profile labels, two derivation sentences, docs role table and module paths); no
   theorem, row, basis or split changed" would not rewrite history.

## Evidence map

| Edit | Diagnostic section | Primary source re-checked in this pass |
| --- | --- | --- |
| 1, 2 | 15 | neutral-representation Defs 3.7, 3.8; accountable-records Check 3; matrix `.toml` tags |
| 3 | 15 | committed matrix (PRS sets, differing cells); `LowerBound.lean`, `NonCollapse.lean` |
| 4 | 13, 16 | `Vocab/TransformBasis.lean`; neutral-representation Def 4.3 |
| 5, 6 | 6 to 9, 16 | `Transform/Core.lean` doc comments; matrix `.toml` row headers; `Profile/Core.lean` splits |
| 7 | 13 | `reference/regime-families.toml`; file tree; git rename `053104d`; `README.md`; `lakefile.toml` |

<!-- markdownlint-enable MD036 -->
