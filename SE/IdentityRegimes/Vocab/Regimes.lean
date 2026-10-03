/-
Copyright (c) 2026 Denise M. Case.
Released under MIT license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.IdentityRegimes.Vocab.Basic

/-!
# Identity Regimes

Canonical identity regimes derived from the six regime families.

The six regime families give rise to nine canonical identity regimes.
OBL, OCC, and REC remain unsplit. ENR, CTX, and NOR each separate into
two regimes.
-/

set_option autoImplicit false

namespace SE.IdentityRegimes

public section

-- RR.DEFINES: SEIR.DEF.REGIME
-- RR.DEFINES: SEIR.DEF.REGIME_TO_FAMILY
-- RR.DEFINES: SEIR.DEF.IS_CANONICAL_REGIME
-- RR.DEFINES: SEIR.THM.ALL_REGIMES_CANONICAL
/-- The nine canonical identity regimes. -/
inductive Regime where
  | OBL
  | OCC
  | REC
  | ENR_L
  | ENR_I
  | CTX_E
  | CTX_S
  | NOR_C
  | NOR_S
deriving DecidableEq, Repr

/-- Map each canonical identity regime to its parent regime family. -/
@[expose] def Regime.family : Regime → RegimeFamily
  | .OBL   => .OBL
  | .OCC   => .OCC
  | .REC   => .REC
  | .ENR_L => .ENR
  | .ENR_I => .ENR
  | .CTX_E => .CTX
  | .CTX_S => .CTX
  | .NOR_C => .NOR
  | .NOR_S => .NOR

/-- Predicate marking a regime as canonical. -/
def IsCanonicalRegime (_r : Regime) : Prop :=
  True

/-- Every declared identity regime is canonical. -/
theorem all_regimes_canonical (r : Regime) :
    IsCanonicalRegime r := by
  trivial

end

end SE.IdentityRegimes
