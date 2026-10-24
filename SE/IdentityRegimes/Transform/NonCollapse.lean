module

import all SE.IdentityRegimes.Transform.Core

public import SE.IdentityRegimes.Profile.Core
public import SE.IdentityRegimes.Transform.Core

/-!
File: SE/IdentityRegimes/Transform/NonCollapse.lean

Purpose:
ROW-LEVEL NON-COLLAPSE

NonCollapsing p q means that the canonical classification matrix assigns
different values to at least one transformation for profiles p and q.

noncollapse_of_prs_difference proves that a difference in preserving
classifications is sufficient for this row-level distinction.

An identity-level distinction follows from different preserving sets
on the free dynamics, using Persistence's free-dynamics characterization.
It does not follow on arbitrary dynamics without additional assumptions.

For the nine profiles, 34 of the 36 unordered pairs have different
preserving sets. Two pairs do not:

  OBL vs NOR-C
  CTX-S vs NOR-S

PersistenceBridge.lean proves that these two pairs generate identical
identity relations on every shared dynamics.

The nine rows are pairwise distinct, but their distinctness does not
establish nine different generated identity relations or nine
scientifically necessary referent kinds.
-/

namespace SE.IdentityRegimes

public section

-- RR.DEFINES: SEIR.DEF.NONCOLLAPSING
/-- Two profiles are non-collapsing when the canonical classification
    matrix assigns different values to some transformation.

    This is a row-level distinction.
    Different preserving sets yield distinct generated identity relations
    on free dynamics, but not necessarily on arbitrary dynamics.

    Differences confined to non-preserving classifications do not
    distinguish the generated identity relations.

    See PersistenceBridge.lean for the two profile pairs with equal
    preserving sets. -/
def NonCollapsing (p q : Regime) : Prop :=
  ∃ t : Transformation, classificationMatrix p t ≠ classificationMatrix q t

-- ============================================================
-- PRESERVING-CLASSIFICATION WITNESS (ROW LEVEL)
-- ============================================================

-- RR.DEFINES: SEIR.THM.NONCOLLAPSE_OF_PRS_DIFFERENCE
/-- A difference in preserving classifications establishes row-level
    non-collapse under the canonical classification matrix.

    This theorem does not establish that the profiles generate different
    identity relations on arbitrary dynamics. -/
theorem noncollapse_of_prs_difference
    (p q : Regime)
    (t : Transformation)
    (hp : classificationMatrix p t = .prs)
    (hq : classificationMatrix q t ≠ .prs) :
    NonCollapsing p q :=
    ⟨t, by
      rw [hp]
      intro h
      exact hq h.symm
    ⟩

-- ============================================================
-- THM pairs: split-theorem witnesses from the paper
-- ============================================================

-- RR.DEFINES: SEIR.THM.NONCOLLAPSE_ENR_L_ENR_I
/-- ENR-L and ENR-I are non-collapsing.
    BF: PRS under ENR-L (locus persists through branching),
        BRK under ENR-I (branching produces distinct artifacts).
    Instantiates noncollapse_of_prs_difference with t = BF.
    Source: SE-300 Prop. ENR non-collapse. -/
theorem noncollapse_ENR_L_ENR_I : NonCollapsing .ENR_L .ENR_I :=
  noncollapse_of_prs_difference .ENR_L .ENR_I .BF (by decide) (by decide)

-- RR.DEFINES: SEIR.THM.NONCOLLAPSE_CTX_E_CTX_S
/-- CTX-E and CTX-S are non-collapsing.
    AD: PRS under CTX-E (applicability extension preserved under decomposition),
        BRK under CTX-S (decomposition alters structural organization).
    Instantiates noncollapse_of_prs_difference with t = AD.
    Source: SE-300 Prop. CTX non-collapse. -/
theorem noncollapse_CTX_E_CTX_S : NonCollapsing .CTX_E .CTX_S :=
  noncollapse_of_prs_difference .CTX_E .CTX_S .AD (by decide) (by decide)

-- RR.DEFINES: SEIR.THM.NONCOLLAPSE_NOR_C_NOR_S
/-- NOR-C and NOR-S are non-collapsing.
    RF: PRS under NOR-C (refinement preserves normative content),
        BRK under NOR-S (refinement alters structural organization).
    Instantiates noncollapse_of_prs_difference with t = RF.
    Source: SE-300 Prop. NOR non-collapse. -/
theorem noncollapse_NOR_C_NOR_S : NonCollapsing .NOR_C .NOR_S :=
  noncollapse_of_prs_difference .NOR_C .NOR_S .RF (by decide) (by decide)

-- ============================================================
-- ALL-PAIR AND CROSS-FAMILY ROW DISTINCTIONS
-- ============================================================

-- RR.DEFINES: SEIR.THM.NONCOLLAPSE_ALL_PAIRS
/-- All 72 ordered pairs of distinct regimes in the derived regime set
    are non-collapsing under the canonical classification matrix. -/
theorem noncollapse_all_pairs
    (p q : Regime)
    (h : p ≠ q) :
    NonCollapsing p q := by
  cases p <;> cases q <;> simp at h <;>
    first
    | exact ⟨.BF, by decide⟩
    | exact ⟨.AD, by decide⟩
    | exact ⟨.RF, by decide⟩
    | exact ⟨.SE, by decide⟩
    | exact ⟨.AN, by decide⟩
    | exact ⟨.RC, by decide⟩


-- RR.DEFINES: SEIR.THM.NONCOLLAPSE_OF_DISTINCT_REGIME
/-- Regimes with distinct parent families have different
    classification rows under the canonical matrix. -/
theorem noncollapse_of_distinct_regime
    (p q : Regime)
    (h : p.family ≠ q.family) :
    NonCollapsing p q := by
  apply noncollapse_all_pairs p q
  intro hpq
  subst q
  exact h rfl

end

end SE.IdentityRegimes
