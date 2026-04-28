import IdentityRegimes.Theorems

/-!
File: IdentityRegimes/Witness.lean

Purpose:
Export-facing witness definitions.

Canonical witness: OBL yields a well-formed regime profile.
-/

namespace IdentityRegimes

def oblProfile : RegimeProfile :=
  { kind  := .OBL }

end IdentityRegimes
