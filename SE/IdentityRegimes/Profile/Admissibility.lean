/-
Copyright (c) 2026 Denise M. Case.
Released under MIT license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.NeutralSubstrate
public import SE.IdentityRegimes.Profile.Core

/-!
# Identity Regime Admissibility

Admissibility of applying an identity regime profile to a neutral substrate.
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

-- RR.DEFINES: SEIR.DEF.REGIME_APPLICATION_ADMISSIBLE
/--
An identity-regime application is admissible when the substrate element is
neutral relative to the consequence system and interpretive framework.
-/
@[expose] def RegimeApplicationAdmissible
    {L : PropositionalLanguage.{u}}
    {R : ReferentCarriers.{v}}
    (C : ConsequenceSystem L)
    (S : SubstrateSystem.{u, v, w} L R)
    (s : S.Carrier)
    (M : FrameworkSystem.{u, x} L.carrier)
    (_profile : RegimeProfile) :
    Prop :=
  Neutral C S s M

end

end SE.IdentityRegimes
