/-
Copyright (c) 2026 Denise M. Case.
Released under MIT license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.NeutralSubstrate
public import SE.IdentityRegimes.Theorems

open SE.NeutralSubstrate

/-!
File: SE/IdentityRegimes/Witness.lean

Purpose:
Export-facing witness definitions.

Canonical witness: OBL yields a well-formed regime profile.
-/

namespace SE.IdentityRegimes

public section

/-- Canonical OBL regime-profile witness. -/
def oblProfile : RegimeProfile :=
  { regime  := .OBL }

end

end SE.IdentityRegimes
