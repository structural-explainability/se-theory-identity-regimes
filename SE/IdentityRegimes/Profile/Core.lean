/-
Copyright (c) 2026 Denise M. Case.
Released under MIT license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.NeutralSubstrate
public import SE.IdentityRegimes.Vocab.Regimes
public import SE.IdentityRegimes.Vocab.Requirements
public import SE.IdentityRegimes.Vocab.TransformBasis

open SE.NeutralSubstrate

/-!
File: SE/IdentityRegimes/Profile/Core.lean

Purpose:
Identity-regime structure derived from the six canonical regime families.

Identity regimes are derived from canonical regime families.
Some families remain unsplit, while others separate under specific transformation pressures.
The constructors and family mapping below are the authoritative formalization.

OBL, OCC, and REC carry no split pressure.
ENR separates into ENR_L and ENR_I under Transformation.BF.
CTX separates into CTX_E and CTX_S under Transformation.AD.
NOR separates into NOR_C and NOR_S under Transformation.RF.

ProfileAxes.splitTransformation records the transformation responsible
for any family split; none denotes an unsplit regime.
-/

namespace SE.IdentityRegimes

public section

-- RR.DEFINES: SEIR.DEF.IDENTITY_BASIS
-- RR.DEFINES: SEIR.DEF.PROFILE_AXES
-- RR.DEFINES: SEIR.DEF.REGIME_AXES
-- RR.DEFINES: SEIR.DEF.UNDER_SPLIT_PRESSURE
-- RR.DEFINES: SEIR.THM.NO_SPLIT_OBL
-- RR.DEFINES: SEIR.THM.SPLIT_ENR_L
-- RR.DEFINES: SEIR.THM.SPLIT_PRESSURE_IFF_REFINED_FAMILY
-- RR.DEFINES: SEIR.THM.FAMILY_MAP_NOT_INJECTIVE
-- RR.DEFINES: SEIR.DEF.REGIME_PROFILE
-- RR.DEFINES: SEIR.DEF.PROFILE_WELL_FORMED
/-- The six identity-basis kinds used by the canonical regimes. -/
inductive IdentityBasis where
  | single
  | content
  | structure
  | extension
  | locus
  | instrument
deriving DecidableEq, Repr

/-- Structural axes associated with an identity regime. -/
structure ProfileAxes where
  /-- Identity basis used by the regime. -/
  identityBasis : IdentityBasis
  /-- Transformation that witnesses family refinement, when the family is split. -/
  splitTransformation : Option Transformation

/-- Canonical structural axes for each identity regime. -/
def Regime.axes : Regime → ProfileAxes
  | .OBL   => { identityBasis := .single,     splitTransformation := none }
  | .OCC   => { identityBasis := .single,     splitTransformation := none }
  | .REC   => { identityBasis := .single,     splitTransformation := none }
  | .ENR_L => { identityBasis := .locus,      splitTransformation := some .BF }
  | .ENR_I => { identityBasis := .instrument, splitTransformation := some .BF }
  | .CTX_E => { identityBasis := .extension,  splitTransformation := some .AD }
  | .CTX_S => { identityBasis := .structure,  splitTransformation := some .AD }
  | .NOR_C => { identityBasis := .content,    splitTransformation := some .RF }
  | .NOR_S => { identityBasis := .structure,  splitTransformation := some .RF }

/-- A regime is under split pressure when its family is distinguished by a
    forcing transformation. -/
def UnderSplitPressure (regime : Regime) : Prop :=
  regime.axes.splitTransformation.isSome

instance (regime : Regime) : Decidable (UnderSplitPressure regime) :=
  inferInstanceAs (Decidable (regime.axes.splitTransformation.isSome))

/-- OBL, OCC, and REC are not under split pressure. -/
theorem no_split_OBL : ¬UnderSplitPressure .OBL := by decide
-- RR.DEFINES: SEIR.THM.NO_SPLIT_OCC
/-- OCC is not under split pressure. -/
theorem no_split_OCC : ¬UnderSplitPressure .OCC := by decide
-- RR.DEFINES: SEIR.THM.NO_SPLIT_REC
/-- REC is not under split pressure. -/
theorem no_split_REC : ¬UnderSplitPressure .REC := by decide

/-- The six regimes produced by family splitting are under split pressure. -/
theorem split_ENR_L : UnderSplitPressure .ENR_L := by decide
-- RR.DEFINES: SEIR.THM.SPLIT_ENR_I
/-- ENR_I is under split pressure. -/
theorem split_ENR_I : UnderSplitPressure .ENR_I := by decide
-- RR.DEFINES: SEIR.THM.SPLIT_CTX_E
/-- CTX_E is under split pressure. -/
theorem split_CTX_E : UnderSplitPressure .CTX_E := by decide
-- RR.DEFINES: SEIR.THM.SPLIT_CTX_S
/-- CTX_S is under split pressure. -/
theorem split_CTX_S : UnderSplitPressure .CTX_S := by decide
-- RR.DEFINES: SEIR.THM.SPLIT_NOR_C
/-- NOR_C is under split pressure. -/
theorem split_NOR_C : UnderSplitPressure .NOR_C := by decide
-- RR.DEFINES: SEIR.THM.SPLIT_NOR_S
/-- NOR_S is under split pressure. -/
theorem split_NOR_S : UnderSplitPressure .NOR_S := by decide

/-- Split pressure holds exactly for regimes belonging to the ENR, CTX, or NOR
    families. -/
theorem splitPressure_iff_refined_family (regime : Regime) :
    UnderSplitPressure regime ↔
    regime.family = RegimeFamily.ENR ∨
    regime.family = RegimeFamily.CTX ∨
    regime.family = RegimeFamily.NOR := by
  cases regime <;>
    simp [UnderSplitPressure, Regime.axes, Regime.family]

/-- Distinct regimes may belong to the same regime family. -/
theorem family_map_not_injective :
    ∃ p q : Regime, p ≠ q ∧ p.family = q.family :=
  ⟨.ENR_L, .ENR_I, by decide, by decide⟩

/-- Regimes without split pressure belong to distinct regime families. -/
theorem no_split_family_injective
    (p q : Regime)
    (hp : ¬UnderSplitPressure p)
    (hq : ¬UnderSplitPressure q)
    (h : p.family = q.family) :
    p = q := by
  cases p <;> cases q <;>
    simp_all [UnderSplitPressure, Regime.axes, Regime.family]

/-- A regime profile associates profile structure with one canonical regime. -/
structure RegimeProfile where
  /-- Canonical identity regime represented by this profile. -/
  regime : Regime

/-- The canonical axes associated with a regime profile. -/
def RegimeProfile.axes (profile : RegimeProfile) : ProfileAxes :=
  profile.regime.axes

/-- A regime profile is well-formed if it is associated with a canonical regime. -/
public def ProfileWellFormed (profile : RegimeProfile) : Prop :=
  IsCanonicalRegime profile.regime

end

end SE.IdentityRegimes
