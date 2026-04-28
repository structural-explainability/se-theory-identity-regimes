import IdentityRegimes.Profiles

/-!
File: IdentityRegimes/Admissibility.lean

Purpose:
Admissibility of regime application over neutral substrates.

This file depends on the neutral substrate but does not redefine it.
-/

namespace IdentityRegimes

/-- A regime may be applied only over an admissible neutral substrate. -/
def RegimeApplicationAdmissible
    (S : NeutralSubstrate.Substrate)
    (_profile : RegimeProfile) : Prop :=
  NeutralSubstrate.Admissible S

end IdentityRegimes
