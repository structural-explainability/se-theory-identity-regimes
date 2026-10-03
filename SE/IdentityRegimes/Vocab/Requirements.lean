/-
Copyright (c) 2026 Denise M. Case.
Released under MIT license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.NeutralSubstrate
public import SE.IdentityRegimes.Vocab.Regimes

/-!
# Identity Regime Requirements

Requirement structure for applying identity regimes over a substrate.
-/

set_option autoImplicit false

namespace SE.IdentityRegimes

open SE.Logic.Language
open SE.Referent
open SE.Substrate

universe u v w

public section

-- RR.DEFINES: SEIR.DEF.REQUIREMENT
-- RR.DEFINES: SEIR.DEF.REQUIREMENT_SATISFIED
/-- A requirement associated with applying an identity regime. -/
structure Requirement where
  -- RR.DEFINES: SEIR.DEF.REQUIREMENT_REGIME
  /-- The canonical identity regime associated with this requirement. -/
  regime : Regime

/--
Predicate asserting that a requirement is satisfied over a substrate.

This predicate is intentionally minimal. Downstream regime implementations
may refine it with domain-specific conditions.
-/
def RequirementSatisfied
    {L : PropositionalLanguage.{u}}
    {R : ReferentCarriers.{v}}
    (S : SubstrateSystem.{u, v, w} L R)
    (_s : S.Carrier)
    (_req : Requirement) :
    Prop :=
  True

end

end SE.IdentityRegimes
