/-
Copyright (c) 2026 Denise M. Case.
Released under MIT license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import all SE.IdentityRegimes.Profile.Admissibility

public import SE.NeutralSubstrate
public import SE.IdentityRegimes.Profile.Admissibility

/-!
# Identity Regimes Theorems

Export-facing theorem statements for Identity Regimes theory.
-/

set_option autoImplicit false

namespace SE.IdentityRegimes

open SE.Framework
open SE.Logic
open SE.Logic.Language
open SE.NeutralSubstrate.Neutrality
open SE.Referent
open SE.Substrate

universe u v w x

public section

-- RR.DEFINES: SEIR.THM.REGIME_APPLICATION_ADMISSIBLE_OF_NEUTRAL
/--
A neutral substrate supports admissible identity-regime application.
-/
theorem regime_application_admissible_of_neutral
    {L : PropositionalLanguage.{u}}
    {R : ReferentCarriers.{v}}
    {C : ConsequenceSystem L}
    {S : SubstrateSystem.{u, v, w} L R}
    {s : S.Carrier}
    {M : FrameworkSystem.{u, x} L.carrier}
    (hS : Neutral C S s M)
    (profile : RegimeProfile) :
    RegimeApplicationAdmissible C S s M profile := by
  exact hS

end

end SE.IdentityRegimes
