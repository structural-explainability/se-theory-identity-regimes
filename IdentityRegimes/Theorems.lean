import IdentityRegimes.Admissibility

/-!
File: IdentityRegimes/Theorems.lean

Purpose:
Export-facing theorem statements for identity-regime theory.
-/

namespace IdentityRegimes

/-- A well-formed profile references a canonical regime. -/
theorem canonical_of_profile_well_formed
    (profile : RegimeProfile)
    (h : ProfileWellFormed profile) :
    IsCanonicalRegime profile.kind.regime := by
  exact h

/-- A neutral substrate supports admissible regime application. -/
theorem regime_application_admissible_of_neutral
    (S : NeutralSubstrate.Substrate)
    [NeutralSubstrate.Neutral S]
    (profile : RegimeProfile) :
    RegimeApplicationAdmissible S profile := by
  exact NeutralSubstrate.admissible_of_neutral S

end IdentityRegimes
