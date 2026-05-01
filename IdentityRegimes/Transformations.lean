import NeutralSubstrate
import IdentityRegimes.Profiles

/-!
File: IdentityRegimes/Transformations.lean

Purpose:
Transformation basis and classification vocabulary.

The transformation basis F is fixed. Each transformation family is
classified under a regime profile as IGN, PRS, BRK, or NA.
The induced identity relation ∼_P is defined by PRS-classified
transformations.

Source: SE-300, Section on transformation basis and regime profiles.
-/

namespace IdentityRegimes

/-- The fixed transformation basis. -/
inductive Transformation where
  | RE  -- re-expression
  | AN  -- annotation
  | RF  -- refinement
  | AD  -- decomposition
  | RC  -- re-contextualization
  | RA  -- reassignment
  | SU  -- substitution
  | BF  -- branching
  | PV  -- provenance
  | SE  -- state evolution
deriving Repr, DecidableEq

/-- Classification of a transformation under a regime profile. -/
inductive TransformationClassification where
  | IGN  -- identity-ignoring: transformation does not affect identity
  | PRS  -- identity-preserving: transformation preserves identity
  | BRK  -- identity-breaking: transformation breaks identity
  | NA   -- not applicable under this profile
deriving Repr, DecidableEq

/-- Classification function: maps each profile and transformation
    to its classification, as fixed by the paper. -/
def classify : RegimeProfileKind → Transformation → TransformationClassification
-- OBL: verified against SE-300 Section 4 canonical classification tables
  | .OBL, .RE => .IGN  | .OBL, .AN => .IGN  | .OBL, .RF => .PRS
  | .OBL, .AD => .PRS  | .OBL, .RC => .IGN  | .OBL, .RA => .IGN
  | .OBL, .SU => .BRK  | .OBL, .BF => .IGN  | .OBL, .PV => .IGN
  | .OBL, .SE => .IGN
  -- OCC: verified against SE-300 Section 4 canonical classification tables
  | .OCC, .RE => .IGN  | .OCC, .AN => .IGN  | .OCC, .RF => .PRS
  | .OCC, .AD => .BRK  | .OCC, .RC => .IGN  | .OCC, .RA => .NA
  | .OCC, .SU => .BRK  | .OCC, .BF => .NA   | .OCC, .PV => .IGN
  | .OCC, .SE => .PRS
  -- REC: verified against SE-300 Section 4 canonical classification tables
  | .REC, .RE => .IGN  | .REC, .AN => .PRS  | .REC, .RF => .PRS
  | .REC, .AD => .PRS  | .REC, .RC => .IGN  | .REC, .RA => .IGN
  | .REC, .SU => .BRK  | .REC, .BF => .PRS  | .REC, .PV => .PRS
  | .REC, .SE => .IGN
  -- ENR_L
  | .ENR_L, .RE => .IGN  | .ENR_L, .AN => .IGN  | .ENR_L, .RF => .PRS
  | .ENR_L, .AD => .PRS  | .ENR_L, .RC => .IGN  | .ENR_L, .RA => .NA
  | .ENR_L, .SU => .BRK  | .ENR_L, .BF => .PRS  | .ENR_L, .PV => .IGN
  | .ENR_L, .SE => .PRS
  -- ENR_I
  | .ENR_I, .RE => .IGN  | .ENR_I, .AN => .IGN  | .ENR_I, .RF => .PRS
  | .ENR_I, .AD => .PRS  | .ENR_I, .RC => .IGN  | .ENR_I, .RA => .NA
  | .ENR_I, .SU => .BRK  | .ENR_I, .BF => .BRK  | .ENR_I, .PV => .IGN
  | .ENR_I, .SE => .PRS
  -- CTX_E
  | .CTX_E, .RE => .IGN  | .CTX_E, .AN => .IGN  | .CTX_E, .RF => .PRS
  | .CTX_E, .AD => .PRS  | .CTX_E, .RC => .PRS  | .CTX_E, .RA => .IGN
  | .CTX_E, .SU => .BRK  | .CTX_E, .BF => .PRS  | .CTX_E, .PV => .IGN
  | .CTX_E, .SE => .NA
  -- CTX_S
  | .CTX_S, .RE => .IGN  | .CTX_S, .AN => .IGN  | .CTX_S, .RF => .BRK
  | .CTX_S, .AD => .BRK  | .CTX_S, .RC => .BRK  | .CTX_S, .RA => .BRK
  | .CTX_S, .SU => .BRK  | .CTX_S, .BF => .BRK  | .CTX_S, .PV => .IGN
  | .CTX_S, .SE => .NA
  -- NOR_C
  | .NOR_C, .RE => .IGN  | .NOR_C, .AN => .IGN  | .NOR_C, .RF => .PRS
  | .NOR_C, .AD => .PRS  | .NOR_C, .RC => .IGN  | .NOR_C, .RA => .IGN
  | .NOR_C, .SU => .BRK  | .NOR_C, .BF => .BRK  | .NOR_C, .PV => .IGN
  | .NOR_C, .SE => .NA
  -- NOR_S
  | .NOR_S, .RE => .IGN  | .NOR_S, .AN => .IGN  | .NOR_S, .RF => .BRK
  | .NOR_S, .AD => .BRK  | .NOR_S, .RC => .IGN  | .NOR_S, .RA => .IGN
  | .NOR_S, .SU => .BRK  | .NOR_S, .BF => .BRK  | .NOR_S, .PV => .IGN
  | .NOR_S, .SE => .NA

/-- A transformation is identity-preserving under a profile. -/
def IsPreserving (k : RegimeProfileKind) (t : Transformation) : Prop :=
  classify k t = TransformationClassification.PRS

/-- A transformation is identity-breaking under a profile. -/
def IsBreaking (k : RegimeProfileKind) (t : Transformation) : Prop :=
  classify k t = TransformationClassification.BRK

/-- Both are decidable since classify is a total function into a type
    with DecidableEq. -/
instance (k : RegimeProfileKind) (t : Transformation) :
    Decidable (IsPreserving k t) :=
  show Decidable (classify k t = TransformationClassification.PRS) from inferInstance

instance (k : RegimeProfileKind) (t : Transformation) :
    Decidable (IsBreaking k t) :=
  show Decidable (classify k t = TransformationClassification.BRK) from inferInstance

/-- The split-forcing transformation for ENR is BF. -/
theorem enr_splits_on_BF :
    IsPreserving .ENR_L .BF ∧ IsBreaking .ENR_I .BF := by
  constructor <;> decide

/-- The split-forcing transformation for CTX is AD. -/
theorem ctx_splits_on_AD :
    IsPreserving .CTX_E .AD ∧ IsBreaking .CTX_S .AD := by
  constructor <;> decide

/-- The split-forcing transformation for NOR is RF. -/
theorem nor_splits_on_RF :
    IsPreserving .NOR_C .RF ∧ IsBreaking .NOR_S .RF := by
  constructor <;> decide

end IdentityRegimes
