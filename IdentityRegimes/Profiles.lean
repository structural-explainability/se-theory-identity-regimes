import IdentityRegimes.Requirements

/-!
File: IdentityRegimes/Profiles.lean

Purpose:
Regime-profile structure derived from canonical regime requirements.
-/

namespace IdentityRegimes

/-- A regime profile collects the regime structure relevant to an application. -/
structure RegimeProfile where
  regime : Regime

/-- A profile is well formed when it references a canonical regime. -/
def ProfileWellFormed (profile : RegimeProfile) : Prop :=
  IsCanonicalRegime profile.regime

end IdentityRegimes
