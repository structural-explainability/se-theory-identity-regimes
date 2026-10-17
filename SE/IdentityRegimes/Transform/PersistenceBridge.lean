module

import all SE.IdentityRegimes.Transform.Core

public import SE.IdentityRegimes.Profile.Core
public import SE.IdentityRegimes.Transform.Core
public import SE.IdentityRegimes.Transform.NonCollapse
public import SE.Persistence.Relation.NonCollapse

set_option autoImplicit false

/-!
File: SE/IdentityRegimes/Transform/PersistenceBridge.lean

Purpose:
Connect the canonical 9 x 10 classification matrix to
`SE.Persistence.Classification`.

Assumes `Transformation` and `Regime` are defined in the
`SE.IdentityRegimes` namespace (Vocab/TransformBasis.lean and Profile/Core.lean
were not seen).

Applicability is restored at exactly the 8 cells that the header of
Transform/Core.lean lists as N/A mapped to IGN. That list comes from Core.lean,
not from SE-300.

`persist` is the empty set because IdentityRegimes does not model persistence.

Results:
  - the matrix is recovered as the `coarse` form of the Persistence
    classification;
  - Persistence preservation coincides with PRS in the matrix;
  - the row-level `NonCollapsing` of this namespace is strictly weaker than
    identity-level non-collapse for OBL/NOR-C and CTX-S/NOR-S, on every
    dynamics.
-/

namespace SE.IdentityRegimes

@[expose] public section

-- RR.DEFINES: SEIR.DEF.REGIME_APPLICABLE
/-- The cells that Transform/Core.lean documents as N/A mapped to IGN. -/
def regimeApplicable : Regime → Transformation → Bool
  | .OCC,   .RA => false
  | .OCC,   .BF => false
  | .ENR_L, .RA => false
  | .ENR_I, .RA => false
  | .CTX_E, .SE => false
  | .CTX_S, .SE => false
  | .NOR_C, .SE => false
  | .NOR_S, .SE => false
  | _,      _   => true

-- RR.DEFINES: SEIR.THM.REGIME_APPLICABLE_FALSE_IMP_MATRIX_IGN
/-- Every inapplicable cell holds IGN in the matrix. -/
theorem regimeApplicable_false_imp_matrix_ign (p : Regime) (t : Transformation)
    (h : regimeApplicable p t = false) : classificationMatrix p t = .ign := by
  revert h
  cases p <;> cases t <;> decide

-- RR.DEFINES: SEIR.DEF.PERSISTENCE_CLASSIFICATION
/-- The Persistence classification of a regime: the matrix with applicability
restored. -/
def persistenceClassification (p : Regime) :
    SE.Persistence.Classification Transformation where
  pattern t :=
    if regimeApplicable p t = true then
      some (classificationMatrix p t)
    else
      none
  persist _ := False

-- RR.DEFINES: SEIR.THM.PERSISTENCE_CLASSIFICATION_APPLICABLE_IFF
/-- Persistence classification is applicable exactly when the regime is applicable. -/
theorem persistenceClassification_applicable_iff (p : Regime) (t : Transformation) :
    (persistenceClassification p).Applicable t ↔ regimeApplicable p t = true := by
  cases p <;> cases t <;> decide

-- RR.DEFINES: SEIR.THM.PERSISTENCE_CLASSIFICATION_IS_PRS_IFF
/-- Persistence preservation coincides with PRS in the matrix. -/
theorem persistenceClassification_isPrs_iff (p : Regime) (t : Transformation) :
    (persistenceClassification p).IsPrs t ↔ classificationMatrix p t = .prs := by
  cases p <;> cases t <;> decide

-- RR.DEFINES: SEIR.THM.PERSISTENCE_CLASSIFICATION_COARSE
/-- Forgetting applicability recovers the matrix. -/
theorem persistenceClassification_coarse (p : Regime) (t : Transformation) :
    (persistenceClassification p).coarse t =
      (classificationMatrix p t) := by
  cases p <;> cases t <;> decide

-- RR.DEFINES: SEIR.THM.IDENTITY_NONCOLLAPSING_FREE_IFF
/-- On the free dynamics, identity-level non-collapse of two regimes holds
exactly when their PRS cells differ. -/
theorem identityNonCollapsing_free_iff (p q : Regime) :
    SE.Persistence.Classification.NonCollapsing
        (SE.Persistence.freeDynamics Transformation)
        (persistenceClassification p) (persistenceClassification q) ↔
      ∃ t, ¬ (classificationMatrix p t = .prs ↔ classificationMatrix q t = .prs) := by
  refine (SE.Persistence.Classification.nonCollapsing_free_iff _ _).trans ?_
  constructor
  · rintro ⟨t, ht⟩
    exact ⟨t, fun h => ht
      ((persistenceClassification_isPrs_iff p t).trans
        (h.trans (persistenceClassification_isPrs_iff q t).symm))⟩
  · rintro ⟨t, ht⟩
    exact ⟨t, fun h => ht
      ((persistenceClassification_isPrs_iff p t).symm.trans
        (h.trans (persistenceClassification_isPrs_iff q t)))⟩

-- RR.DEFINES: SEIR.THM.MATRIX_PRS_IFF_OBL_NOR_C
/-- OBL and NOR-C classify exactly the same transformations as preserving. -/
theorem matrix_prs_iff_OBL_NOR_C (t : Transformation) :
    classificationMatrix .OBL t = .prs ↔ classificationMatrix .NOR_C t = .prs := by
  cases t <;> decide

-- RR.DEFINES: SEIR.THM.MATRIX_PRS_IFF_CTX_S_NOR_S
/-- CTX-S and NOR-S classify exactly the same transformations as preserving. -/
theorem matrix_prs_iff_CTX_S_NOR_S (t : Transformation) :
    classificationMatrix .CTX_S t = .prs ↔ classificationMatrix .NOR_S t = .prs := by
  cases t <;> decide

-- RR.DEFINES: SEIR.THM.IDENTITY_REL_OBL_EQ_NOR_C
/-- OBL and NOR-C generate the same identity relation on every dynamics. -/
theorem identityRel_OBL_eq_NOR_C {C : Type}
    (d : SE.Persistence.Dynamics Transformation C) :
    (persistenceClassification .OBL).identityRel d =
      (persistenceClassification .NOR_C).identityRel d :=
  SE.Persistence.Classification.identityRel_eq_of_prs_iff d fun t =>
    (persistenceClassification_isPrs_iff .OBL t).trans
      ((matrix_prs_iff_OBL_NOR_C t).trans
        (persistenceClassification_isPrs_iff .NOR_C t).symm)

-- RR.DEFINES: SEIR.THM.IDENTITY_REL_CTX_S_EQ_NOR_S
/-- CTX-S and NOR-S generate the same identity relation on every dynamics. -/
theorem identityRel_CTX_S_eq_NOR_S {C : Type}
    (d : SE.Persistence.Dynamics Transformation C) :
    (persistenceClassification .CTX_S).identityRel d =
      (persistenceClassification .NOR_S).identityRel d :=
  SE.Persistence.Classification.identityRel_eq_of_prs_iff d fun t =>
    (persistenceClassification_isPrs_iff .CTX_S t).trans
      ((matrix_prs_iff_CTX_S_NOR_S t).trans
        (persistenceClassification_isPrs_iff .NOR_S t).symm)

-- RR.DEFINES: SEIR.THM.ROW_DISTINCT_BUT_IDENTITY_COLLAPSED
/-- Row-level non-collapse is strictly weaker than identity-level non-collapse:
OBL and NOR-C differ as rows but generate the same identity relation on every
dynamics. -/
theorem rowDistinct_but_identityCollapsed_OBL_NOR_C :
    NonCollapsing .OBL .NOR_C ∧
      ∀ (C : Type) (d : SE.Persistence.Dynamics Transformation C),
        ¬ SE.Persistence.Classification.NonCollapsing d
            (persistenceClassification .OBL) (persistenceClassification .NOR_C) :=
  ⟨noncollapse_all_pairs .OBL .NOR_C (by decide),
   fun _ d h => h (identityRel_OBL_eq_NOR_C d)⟩

-- RR.DEFINES: SEIR.THM.ROW_DISTINCT_BUT_IDENTITY_COLLAPSED_CTX_S_NOR_S
/-- The same for CTX-S and NOR-S. -/
theorem rowDistinct_but_identityCollapsed_CTX_S_NOR_S :
    NonCollapsing .CTX_S .NOR_S ∧
      ∀ (C : Type) (d : SE.Persistence.Dynamics Transformation C),
        ¬ SE.Persistence.Classification.NonCollapsing d
            (persistenceClassification .CTX_S) (persistenceClassification .NOR_S) :=
  ⟨noncollapse_all_pairs .CTX_S .NOR_S (by decide),
   fun _ d h => h (identityRel_CTX_S_eq_NOR_S d)⟩

end

end SE.IdentityRegimes
