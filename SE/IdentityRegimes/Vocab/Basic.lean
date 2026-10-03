/-
Copyright (c) 2026 Denise M. Case.
Released under MIT license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

/-!
# Identity Regime Families

Basic vocabulary for Identity Regimes theory.

The six canonical regime families are:

- OBL
- NOR
- OCC
- CTX
- REC
- ENR

The canonical identity regimes derived from these families are defined
separately in `SE.IdentityRegimes.Vocab.Regimes`.
-/

set_option autoImplicit false

namespace SE.IdentityRegimes

public section

-- RR.DEFINES: SEIR.DEF.REGIME_FAMILY
/-- The six canonical identity-regime families. -/
inductive RegimeFamily where
  | OBL
  | NOR
  | OCC
  | CTX
  | REC
  | ENR
deriving DecidableEq, Repr

end

end SE.IdentityRegimes
