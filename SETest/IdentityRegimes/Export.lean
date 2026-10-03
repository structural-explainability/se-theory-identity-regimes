/-
Copyright (c) 2026 Denise M. Case.
Released under MIT license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import SE.IdentityRegimes.Theorems

/-!
# Identity Regimes Export Test

Tests that the intended public declarations are exported from the
Identity Regimes public surface.

Run with `lake test`.
-/

#check SE.IdentityRegimes.Regime
#check SE.IdentityRegimes.RegimeProfile
#check SE.IdentityRegimes.Requirement
#check SE.IdentityRegimes.IsCanonicalRegime
#check SE.IdentityRegimes.ProfileWellFormed
#check SE.IdentityRegimes.RequirementSatisfied
#check SE.IdentityRegimes.RegimeApplicationAdmissible
#check SE.IdentityRegimes.all_regimes_canonical
#check SE.IdentityRegimes.regime_application_admissible_of_neutral
