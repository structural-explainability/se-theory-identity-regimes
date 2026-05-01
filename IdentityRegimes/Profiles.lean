import NeutralSubstrate
import IdentityRegimes.Requirements

open SE.NeutralSubstrate

/-!
File: IdentityRegimes/Profiles.lean

Purpose:
Regime-profile structure derived from canonical regime requirements.

The nine derived regime profiles refine the six canonical regimes.
They do not replace them.

OBL, OCC, REC carry no split pressure.
ENR refines into ENR_L / ENR_I under BF (branching).
CTX refines into CTX_E / CTX_S under AD (decomposition).
NOR refines into NOR_C / NOR_S under RF (refinement).
-/

namespace IdentityRegimes

/-- The nine derived regime profiles. -/
inductive RegimeProfileKind where
  | OBL
  | OCC
  | REC
  | ENR_L
  | ENR_I
  | CTX_E
  | CTX_S
  | NOR_C
  | NOR_S
deriving Repr, DecidableEq

/-- Map each profile back to its parent canonical regime. -/
def RegimeProfileKind.regime : RegimeProfileKind -> Regime
  | .OBL   => Regime.OBL
  | .OCC   => Regime.OCC
  | .REC   => Regime.REC
  | .ENR_L => Regime.ENR
  | .ENR_I => Regime.ENR
  | .CTX_E => Regime.CTX
  | .CTX_S => Regime.CTX
  | .NOR_C => Regime.NOR
  | .NOR_S => Regime.NOR

inductive IdentityBasis where
  | single
  | content
  | structure
  | extension
  | locus
  | instrument
deriving DecidableEq, Repr

inductive SplitTransformation where
  | none
  | RF
  | AD
  | BF
deriving DecidableEq, Repr

structure ProfileAxes where
  identityBasis       : IdentityBasis
  splitTransformation : SplitTransformation

/-- Canonical axes for each derived profile. -/
def RegimeProfileKind.axes : RegimeProfileKind -> ProfileAxes
  | .OBL   => { identityBasis := .single,     splitTransformation := .none }
  | .OCC   => { identityBasis := .single,     splitTransformation := .none }
  | .REC   => { identityBasis := .single,     splitTransformation := .none }
  | .ENR_L => { identityBasis := .locus,      splitTransformation := .BF   }
  | .ENR_I => { identityBasis := .instrument, splitTransformation := .BF   }
  | .CTX_E => { identityBasis := .extension,  splitTransformation := .AD   }
  | .CTX_S => { identityBasis := .structure,  splitTransformation := .AD   }
  | .NOR_C => { identityBasis := .content,    splitTransformation := .RF   }
  | .NOR_S => { identityBasis := .structure,  splitTransformation := .RF   }

def UnderSplitPressure (axes : ProfileAxes) : Prop :=
  axes.splitTransformation ≠ SplitTransformation.none

instance (axes : ProfileAxes) : Decidable (UnderSplitPressure axes) :=
  inferInstanceAs (Decidable (axes.splitTransformation ≠ SplitTransformation.none))

/-- OBL, OCC, REC are not under split pressure. -/
theorem no_split_OBL : ¬UnderSplitPressure (RegimeProfileKind.axes .OBL) := by decide
theorem no_split_OCC : ¬UnderSplitPressure (RegimeProfileKind.axes .OCC) := by decide
theorem no_split_REC : ¬UnderSplitPressure (RegimeProfileKind.axes .REC) := by decide

/-- The six refined profiles are under split pressure. -/
theorem split_ENR_L : UnderSplitPressure (RegimeProfileKind.axes .ENR_L) := by decide
theorem split_ENR_I : UnderSplitPressure (RegimeProfileKind.axes .ENR_I) := by decide
theorem split_CTX_E : UnderSplitPressure (RegimeProfileKind.axes .CTX_E) := by decide
theorem split_CTX_S : UnderSplitPressure (RegimeProfileKind.axes .CTX_S) := by decide
theorem split_NOR_C : UnderSplitPressure (RegimeProfileKind.axes .NOR_C) := by decide
theorem split_NOR_S : UnderSplitPressure (RegimeProfileKind.axes .NOR_S) := by decide


/-- Split pressure holds iff the parent regime is ENR, CTX, or NOR. -/
theorem splitPressure_iff_refined_regime (k : RegimeProfileKind) :
    UnderSplitPressure k.axes ↔
    k.regime = Regime.ENR ∨ k.regime = Regime.CTX ∨ k.regime = Regime.NOR := by
  cases k <;>
    simp [UnderSplitPressure, RegimeProfileKind.axes,
          RegimeProfileKind.regime]

/-- The regime map is not injective: distinct profiles can share a parent regime. -/
theorem regime_map_not_injective :
    ∃ p q : RegimeProfileKind, p ≠ q ∧ p.regime = q.regime :=
  ⟨.ENR_L, .ENR_I, by decide, by decide⟩

/-- Profiles without split pressure have distinct parent regimes. -/
theorem no_split_regime_injective (p q : RegimeProfileKind)
    (hp : ¬UnderSplitPressure p.axes)
    (hq : ¬UnderSplitPressure q.axes)
    (h  : p.regime = q.regime) : p = q := by
  cases p <;> cases q <;>
    simp_all [UnderSplitPressure, RegimeProfileKind.axes,
              RegimeProfileKind.regime]

/-- Every profile kind maps to a canonical regime. -/
theorem all_profiles_canonical (k : RegimeProfileKind) :
    IsCanonicalRegime k.regime :=
  all_regimes_canonical k.regime

/-- A regime profile is identified by its derived kind. -/
structure RegimeProfile where
  kind : RegimeProfileKind

/-- The canonical axes for a profile. -/
def RegimeProfile.axes (profile : RegimeProfile) : ProfileAxes :=
  profile.kind.axes

/-- A profile is well formed when its parent regime is canonical. -/
def ProfileWellFormed (profile : RegimeProfile) : Prop :=
  IsCanonicalRegime profile.kind.regime

end IdentityRegimes
