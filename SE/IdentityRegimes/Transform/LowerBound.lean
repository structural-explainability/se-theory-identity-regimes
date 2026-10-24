module

import all SE.IdentityRegimes.Transform.Core

public import SE.IdentityRegimes.Transform.NonCollapse
public import SE.IdentityRegimes.Transform.Core
public import SE.IdentityRegimes.Profile.Core

/-!
File: SE/IdentityRegimes/Transform/LowerBound.lean

Purpose:
Lower bound and determinacy theorems for the derived regime set.

Results:
  - The derived regime set has exactly nine elements.
  - All nine profiles are pairwise non-collapsing at row level (`NonCollapsing`).
  - Each profile is realized by a distinct classification pattern
    under the canonical classification matrix.
  - The fixed nine-profile enumeration has pairwise distinct matrix rows.
  - No general theorem establishes that nine profiles are necessary
    or realized in every admissible substrate or intended referent domain.

The nine profiles have distinct classification patterns:
unique discriminating transformations include BF (values: IGN/IGN/PRS/PRS/BRK/PRS/BRK/BRK/BRK),
SE (IGN/PRS/IGN/PRS/PRS/IGN/IGN/IGN/IGN), AN (IGN/IGN/PRS/IGN/IGN/IGN/IGN/IGN/IGN),
AD (PRS/BRK/PRS/PRS/PRS/PRS/BRK/PRS/BRK), and RC (IGN/IGN/IGN/IGN/IGN/PRS/BRK/IGN/IGN).

ROW-LEVEL SCOPE
Every statement here is about the rows of `classificationMatrix`.
None is a statement about the identity relations those rows generate.
By `PersistenceBridge.lean`, OBL and NOR-C generate the same identity relation on
every dynamics, as do CTX-S and NOR-S (`identityRel_OBL_eq_NOR_C`,
`identityRel_CTX_S_eq_NOR_S`), so the nine rows yield at most seven distinct
identity relations.
The paper separates those two pairs by identity carrier (GEN-CAR),
which neither the classification matrix nor `SE.Persistence` models.

Source: SE-300, Section 5, lower bound and determinacy.
-/

namespace SE.IdentityRegimes

public section

-- RR.DEFINES: SEIR.DEF.DERIVED_PROFILE_SET
-- RR.DEFINES: SEIR.THM.DERIVED_PROFILE_SET_CARD
-- RR.DEFINES: SEIR.THM.DERIVED_PROFILE_SET_NODUP
-- RR.DEFINES: SEIR.THM.DERIVED_PROFILE_SET_COMPLETE
-- RR.DEFINES: SEIR.THM.DERIVED_PROFILE_SET_PAIRWISE_NONCOLLAPSE
-- RR.DEFINES: SEIR.THM.CLASSIFICATION_PATTERN_UNIQUE
-- RR.IMPLEMENTS: SE300.DEF.FAITHFUL_EMBEDDING
-- RR.DEFINES: SEIR.THM.NINE_PROFILE_LOWER_BOUND
-- RR.IMPLEMENTS: SE300.THM.NINE_PROFILE_LOWER_BOUND
/-- The derived regime set as a list. -/
def derivedRegimeSet : List Regime :=
  [.OBL, .OCC, .REC, .ENR_L, .ENR_I, .CTX_E, .CTX_S, .NOR_C, .NOR_S]

/-- The derived regime set has exactly nine elements. -/
theorem derivedRegimeSet_card : derivedRegimeSet.length = 9 := by
  decide

/-- The derived regime set has no duplicates. -/
theorem derivedRegimeSet_nodup : derivedRegimeSet.Nodup := by
  decide

/-- Every profile kind appears in the derived regime set. -/
theorem derivedRegimeSet_complete (k : Regime) :
    k ∈ derivedRegimeSet := by
  cases k <;> decide

/-- All profiles in the derived regime set are pairwise non-collapsing
    under the canonical classification matrix. -/
theorem derivedRegimeSet_pairwise_noncollapse :
    ∀ p q : Regime, p ≠ q → NonCollapsing p q :=
  noncollapse_all_pairs

/-- Each profile has a unique classification pattern under the canonical matrix:
    no two distinct profiles assign identical values to all transformations.
    This is the injectivity result corresponding to the faithful embedding
    theorem in SE-300 Section 5. -/
theorem classification_pattern_unique
    (p q : Regime)
    (h : ∀ t : Transformation, classificationMatrix p t = classificationMatrix q t) :
    p = q := by
  cases p <;> cases q <;>
    first
    | rfl
    | exact absurd (h .BF) (by decide)
    | exact absurd (h .AD) (by decide)
    | exact absurd (h .RF) (by decide)
    | exact absurd (h .SE) (by decide)
    | exact absurd (h .AN) (by decide)
    | exact absurd (h .RC) (by decide)

/-- Lower bound: any substrate realizing all derived profiles must realize
    at least nine row-distinct profiles under the canonical matrix (row level;
    see ROW-LEVEL SCOPE in the file header).
    Source: SE-300 Section 5. -/
theorem nine_regime_lower_bound :
    ∀ p q : Regime, p ≠ q → NonCollapsing p q :=
  derivedRegimeSet_pairwise_noncollapse

end

end SE.IdentityRegimes
