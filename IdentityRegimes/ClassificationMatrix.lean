import NeutralSubstrate
import IdentityRegimes.ReferenceRequirements

open SE.NeutralSubstrate

/-!
File: IdentityRegimes/ClassificationMatrix.lean

Purpose:
Lean-side certification of the 9 × 10 classification matrix.
Assigns a ClassificationValue to every (RegimeProfileKind, Transformation) pair
and verifies structural properties:

  - Totality:         the function is defined for all 90 pairs (by construction)
  - Axiomatic rows:   RE → PRS and BF → BRK for every profile
  - Value coverage:   all three values IGN/PRS/BRK appear in the matrix
  - Cell count:       cardinality of each value class is certified

Status: DRAFT — axiomatic cells are verified by definition;
        all other cells require theoretical validation against the SE papers.
-/

namespace IdentityRegimes

/- === Matrix Definition === -/

-- Each row mirrors the corresponding TOML section in regime-classification-matrix.toml.
-- Transformation column order: RE AN RF AD RC RA SU BF SE PV
def classificationMatrix : RegimeProfileKind → Transformation → ClassificationValue
  | .OBL,   .RE => .PRS  | .OBL,   .AN => .PRS  | .OBL,   .RF => .PRS
  | .OBL,   .AD => .PRS  | .OBL,   .RC => .BRK  | .OBL,   .RA => .BRK
  | .OBL,   .SU => .BRK  | .OBL,   .BF => .BRK  | .OBL,   .SE => .BRK
  | .OBL,   .PV => .IGN
  | .OCC,   .RE => .PRS  | .OCC,   .AN => .PRS  | .OCC,   .RF => .PRS
  | .OCC,   .AD => .PRS  | .OCC,   .RC => .BRK  | .OCC,   .RA => .IGN
  | .OCC,   .SU => .BRK  | .OCC,   .BF => .BRK  | .OCC,   .SE => .BRK
  | .OCC,   .PV => .IGN
  | .REC,   .RE => .PRS  | .REC,   .AN => .PRS  | .REC,   .RF => .PRS
  | .REC,   .AD => .PRS  | .REC,   .RC => .PRS  | .REC,   .RA => .PRS
  | .REC,   .SU => .BRK  | .REC,   .BF => .BRK  | .REC,   .SE => .BRK
  | .REC,   .PV => .PRS
  | .ENR_L, .RE => .PRS  | .ENR_L, .AN => .PRS  | .ENR_L, .RF => .PRS
  | .ENR_L, .AD => .PRS  | .ENR_L, .RC => .BRK  | .ENR_L, .RA => .PRS
  | .ENR_L, .SU => .BRK  | .ENR_L, .BF => .BRK  | .ENR_L, .SE => .BRK
  | .ENR_L, .PV => .IGN
  | .ENR_I, .RE => .PRS  | .ENR_I, .AN => .PRS  | .ENR_I, .RF => .PRS
  | .ENR_I, .AD => .PRS  | .ENR_I, .RC => .BRK  | .ENR_I, .RA => .BRK
  | .ENR_I, .SU => .BRK  | .ENR_I, .BF => .BRK  | .ENR_I, .SE => .BRK
  | .ENR_I, .PV => .IGN
  | .CTX_E, .RE => .PRS  | .CTX_E, .AN => .PRS  | .CTX_E, .RF => .PRS
  | .CTX_E, .AD => .PRS  | .CTX_E, .RC => .BRK  | .CTX_E, .RA => .IGN
  | .CTX_E, .SU => .BRK  | .CTX_E, .BF => .BRK  | .CTX_E, .SE => .BRK
  | .CTX_E, .PV => .IGN
  | .CTX_S, .RE => .PRS  | .CTX_S, .AN => .PRS  | .CTX_S, .RF => .PRS
  | .CTX_S, .AD => .PRS  | .CTX_S, .RC => .BRK  | .CTX_S, .RA => .PRS
  | .CTX_S, .SU => .BRK  | .CTX_S, .BF => .BRK  | .CTX_S, .SE => .BRK
  | .CTX_S, .PV => .IGN
  | .NOR_C, .RE => .PRS  | .NOR_C, .AN => .PRS  | .NOR_C, .RF => .PRS
  | .NOR_C, .AD => .PRS  | .NOR_C, .RC => .BRK  | .NOR_C, .RA => .BRK
  | .NOR_C, .SU => .BRK  | .NOR_C, .BF => .BRK  | .NOR_C, .SE => .BRK
  | .NOR_C, .PV => .IGN
  | .NOR_S, .RE => .PRS  | .NOR_S, .AN => .PRS  | .NOR_S, .RF => .PRS
  | .NOR_S, .AD => .PRS  | .NOR_S, .RC => .BRK  | .NOR_S, .RA => .PRS
  | .NOR_S, .SU => .BRK  | .NOR_S, .BF => .BRK  | .NOR_S, .SE => .BRK
  | .NOR_S, .PV => .IGN

/- === Axiomatic Constraints === -/

-- RE retains exact identity: must be PRS for every profile.
theorem matrix_RE_always_PRS
    (p : RegimeProfileKind) :
    classificationMatrix p .RE = .PRS := by
  cases p <;> native_decide

-- BF breaks identity by definition: must be BRK for every profile.
theorem matrix_BF_always_BRK
    (p : RegimeProfileKind) :
    classificationMatrix p .BF = .BRK := by
  cases p <;> native_decide

/- === Value Coverage === -/

-- All three classification values appear somewhere in the matrix.
theorem matrix_IGN_nonempty :
    ∃ p t, classificationMatrix p t = .IGN := by
  exact ⟨.OBL, .PV, by native_decide⟩

theorem matrix_PRS_nonempty :
    ∃ p t, classificationMatrix p t = .PRS := by
  exact ⟨.OBL, .RE, by native_decide⟩

theorem matrix_BRK_nonempty :
    ∃ p t, classificationMatrix p t = .BRK := by
  exact ⟨.OBL, .BF, by native_decide⟩

/- === Cell Count Certification === -/

-- Enumerate all 90 cells as a flat list for counting.
def allCells : List (RegimeProfileKind × Transformation) :=
  referenceProfiles.flatMap (fun p =>
    referenceTransformations.map (fun t => (p, t)))

theorem allCells_card :
    allCells.length = 90 := by
  native_decide

-- Count of each value across all 90 cells.
-- These counts are DRAFT — they will change as cell values are revised.
def countValue (v : ClassificationValue) : Nat :=
  (allCells.filter (fun ⟨p, t⟩ => classificationMatrix p t == v)).length

theorem matrix_counts :
    countValue .PRS + countValue .BRK + countValue .IGN = 90 := by
  native_decide

-- Debug: inspect computed counts
-- #eval countValue .PRS
-- #eval countValue .BRK
-- #eval countValue .IGN
-- 42 + 38 + 10 = 90 = complete matrix coverage
-- TODO: Verify counts manually against the SE papers and update as needed.

-- Individual counts (change freely as theory is refined).
theorem matrix_PRS_count :
    countValue .PRS = 42 := by
  native_decide

theorem matrix_BRK_count :
    countValue .BRK = 38 := by
  native_decide

theorem matrix_IGN_count :
    countValue .IGN = 10 := by
  native_decide

/- === Structural Properties === -/

-- SU (Substitute) is BRK for every profile.
theorem matrix_SU_always_BRK
    (p : RegimeProfileKind) :
    classificationMatrix p .SU = .BRK := by
  cases p <;> native_decide

-- SE (Separate) is BRK for every profile.
theorem matrix_SE_always_BRK
    (p : RegimeProfileKind) :
    classificationMatrix p .SE = .BRK := by
  cases p <;> native_decide

-- AN (Alter naming) is PRS for every profile.
theorem matrix_AN_always_PRS
    (p : RegimeProfileKind) :
    classificationMatrix p .AN = .PRS := by
  cases p <;> native_decide

-- RF (Refine) is PRS for every profile.
theorem matrix_RF_always_PRS
    (p : RegimeProfileKind) :
    classificationMatrix p .RF = .PRS := by
  cases p <;> native_decide

-- AD (Adapt) is PRS for every profile.
theorem matrix_AD_always_PRS
    (p : RegimeProfileKind) :
    classificationMatrix p .AD = .PRS := by
  cases p <;> native_decide

-- RC (Reclassify) is BRK for every profile except REC.
theorem matrix_RC_BRK_except_REC
    (p : RegimeProfileKind)
    (h : p ≠ .REC) :
    classificationMatrix p .RC = .BRK := by
  cases p <;> simp_all [classificationMatrix]

end IdentityRegimes
