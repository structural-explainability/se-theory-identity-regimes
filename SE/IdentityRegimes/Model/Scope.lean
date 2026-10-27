/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.IdentityRegimes.Transform.StepIdentity

set_option autoImplicit false

/-!
File: SE/IdentityRegimes/Model/Scope.lean

Purpose:
Model of the AD split on scopes: extension-fixed against structure-fixed.

A scope presentation is its organization: a relation between cases.
Related cases lie in one provision, and a case is covered when it is related to
itself. Coverage is therefore read through the organization.

  extension basis  the invariant is the set of covered cases
  structure basis  the invariant is the organization itself

AD is declared in two ways.

  strict  restructuring that preserves coverage (the whole-preservation
          condition in the definition of AD)
  loose   restructuring that may also change coverage

Derived verdicts of AD (given two distinct cases):

  strict  extension `prs`, structure `brk`
  loose   extension `mix`, structure `brk`

The extension verdict depends on the declared whole-preservation condition.
It is not a property of the name AD.

The single field makes every change to the organization touch every field
either basis reads.
`Model/ScopeEntries.lean` splits the field by pair of cases;
there strict AD is `neu` for the extension basis.
-/

namespace SE.IdentityRegimes.Model.Scope

@[expose] public section

variable {Case : Type}

-- RR.DEFINES: SEIR.DEF.SCOPE_PRESENTATION
/-- A scope presentation: its organization, a relation between cases. -/
abbrev Scope (Case : Type) : Type :=
  Case → Case → Prop

-- RR.DEFINES: SEIR.DEF.SCOPE_IS_PARTITION
/-- The organization is a partial equivalence: symmetric and transitive. -/
def IsPartition (r : Scope Case) : Prop :=
  (∀ c d, r c d → r d c) ∧ (∀ c d e, r c d → r d e → r c e)


/-- A case is covered when it is related to itself. -/
def covers (r : Scope Case) (c : Case) : Prop :=
  r c c

-- RR.DEFINES: SEIR.DEF.SCOPE_SAME_COVERAGE
/-- Two organizations cover the same cases. -/
def SameCoverage (x y : Scope Case) : Prop :=
  ∀ c, covers x c ↔ covers y c

/-- The single presentation field is the organization. -/
abbrev get : Unit → Scope Case → Scope Case :=
  fun _ x => x

-- RR.DEFINES: SEIR.DEF.SCOPE_AD_STRICT_MODEL
/-- AD declared as restructuring that preserves coverage. -/
def strictModel : EffectModel Unit (get (Case := Case)) where
  step _ x y := IsPartition x ∧ IsPartition y ∧ SameCoverage x y
  writes _ _ := True
  bounded _ _ _ _ _ _ := trivial

-- RR.DEFINES: SEIR.DEF.SCOPE_AD_LOOSE_MODEL
/-- AD declared as restructuring that may also change coverage. -/
def looseModel : EffectModel Unit (get (Case := Case)) where
  step _ x y := IsPartition x ∧ IsPartition y
  writes _ _ := True
  bounded _ _ _ _ _ _ := trivial

-- RR.DEFINES: SEIR.DEF.SCOPE_EXTENSION_BASIS
/-- Extension-fixed basis: the invariant is the set of covered cases. -/
def extensionBasis : InvariantBasis (get (Case := Case)) (Case → Prop) where
  inv x := covers x
  support _ := True
  factors x y h := by
    have hxy : x = y := h () trivial
    subst hxy
    rfl

-- RR.DEFINES: SEIR.DEF.SCOPE_STRUCTURE_BASIS
/-- Structure-fixed basis: the invariant is the organization. -/
def structureBasis : InvariantBasis (get (Case := Case)) (Scope Case) where
  inv x := x
  support _ := True
  factors _ _ h := h () trivial

/-- Everything related to everything within `{a, b}`: one provision. -/
def fullOn (a b : Case) : Scope Case :=
  fun c d => (c = a ∨ c = b) ∧ (d = a ∨ d = b)

/-- Each of `a`, `b` related only to itself: two provisions. -/
def diagOn (a b : Case) : Scope Case :=
  fun c d => c = d ∧ (c = a ∨ c = b)

/-- Only `a` covered, in one provision. -/
def onlyOn (a : Case) : Scope Case :=
  fun c d => c = d ∧ c = a

/-- Nothing covered. -/
def emptyScope : Scope Case :=
  fun _ _ => False

/-- `fullOn a b` is a partition. -/
theorem isPartition_fullOn (a b : Case) : IsPartition (fullOn a b) :=
  ⟨fun _ _ h => ⟨h.2, h.1⟩, fun _ _ _ h1 h2 => ⟨h1.1, h2.2⟩⟩

/-- `diagOn a b` is a partition. -/
theorem isPartition_diagOn (a b : Case) : IsPartition (diagOn a b) :=
  ⟨fun _ _ h => by
      rcases h with ⟨rfl, h2⟩
      exact ⟨rfl, h2⟩,
    fun _ _ _ h1 h2 => ⟨h1.1.trans h2.1, h1.2⟩⟩

/-- `onlyOn a` is a partition. -/
theorem isPartition_onlyOn (a : Case) : IsPartition (onlyOn a) :=
  ⟨fun _ _ h => by
      rcases h with ⟨rfl, h2⟩
      exact ⟨rfl, h2⟩,
    fun _ _ _ h1 h2 => ⟨h1.1.trans h2.1, h1.2⟩⟩

/-- The empty scope is a partition. -/
theorem isPartition_emptyScope : IsPartition (emptyScope (Case := Case)) :=
  ⟨fun _ _ h => h, fun _ _ _ h _ => h⟩

/-- `fullOn a b` and `diagOn a b` cover the same cases. -/
theorem sameCoverage_fullOn_diagOn (a b : Case) :
    SameCoverage (fullOn a b) (diagOn a b) :=
  fun _ => ⟨fun h => ⟨rfl, h.1⟩, fun h => ⟨h.2, h.2⟩⟩

/-- With two distinct cases, one provision differs from two. -/
theorem fullOn_ne_diagOn {a b : Case} (hab : a ≠ b) :
    fullOn a b ≠ diagOn a b := by
  intro h
  have h1 : diagOn a b a b := by
    rw [← h]
    exact ⟨Or.inl rfl, Or.inr rfl⟩
  exact hab h1.1

/-- The empty scope differs from `onlyOn a`. -/
theorem emptyScope_ne_onlyOn (a : Case) : emptyScope ≠ onlyOn a := by
  intro h
  have h1 : onlyOn a a a := ⟨rfl, rfl⟩
  rw [← h] at h1
  exact h1

/-- The empty scope and `onlyOn a` cover different cases. -/
theorem covers_emptyScope_ne_onlyOn (a : Case) :
    covers (emptyScope (Case := Case)) ≠ covers (onlyOn a) := by
  intro h
  have h1 : covers (onlyOn a) a := ⟨rfl, rfl⟩
  rw [← h] at h1
  exact h1

variable {a b : Case}

/-- Strict AD has an effective instance when there are two distinct cases. -/
theorem strict_applicable (hab : a ≠ b) :
    (strictModel (Case := Case)).Applicable () :=
  ⟨fullOn a b, diagOn a b,
    ⟨isPartition_fullOn a b, isPartition_diagOn a b, sameCoverage_fullOn_diagOn a b⟩,
    (), fullOn_ne_diagOn hab⟩

-- RR.DEFINES: SEIR.THM.SCOPE_AD_STRICT_EXTENSION_PRS
/-- Strict AD preserves the extension basis and engages it. -/
theorem strict_extension_prs (hab : a ≠ b) :
    (strictModel (Case := Case)).HasVerdict extensionBasis () Verdict.prs := by
  refine ⟨strict_applicable hab, ?_, ?_⟩
  · intro x y hxy
    show covers x = covers y
    exact funext fun c => propext (hxy.1.2.2 c)
  · exact ⟨fullOn a b, diagOn a b,
      ⟨⟨isPartition_fullOn a b, isPartition_diagOn a b, sameCoverage_fullOn_diagOn a b⟩,
        (), fullOn_ne_diagOn hab⟩,
      (), trivial, fullOn_ne_diagOn hab⟩

-- RR.DEFINES: SEIR.THM.SCOPE_AD_STRICT_STRUCTURE_BRK
/-- Strict AD breaks the structure basis on every effective instance. -/
theorem strict_structure_brk (hab : a ≠ b) :
    (strictModel (Case := Case)).HasVerdict structureBasis () Verdict.brk :=
  ⟨strict_applicable hab, fun _ _ hxy => by
    obtain ⟨_, _, hi⟩ := hxy
    exact hi⟩

/-- Loose AD has an effective instance when there are two distinct cases. -/
theorem loose_applicable (hab : a ≠ b) :
    (looseModel (Case := Case)).Applicable () :=
  ⟨fullOn a b, diagOn a b, ⟨isPartition_fullOn a b, isPartition_diagOn a b⟩,
    (), fullOn_ne_diagOn hab⟩

-- RR.DEFINES: SEIR.THM.SCOPE_AD_LOOSE_EXTENSION_MIX
/-- Loose AD has verdict `mix` for the extension basis: it can change coverage
and it can preserve it. -/
theorem loose_extension_mix (hab : a ≠ b) :
    (looseModel (Case := Case)).HasVerdict extensionBasis () Verdict.mix :=
  ⟨⟨emptyScope, onlyOn a,
      ⟨⟨isPartition_emptyScope, isPartition_onlyOn a⟩, (), emptyScope_ne_onlyOn a⟩,
      covers_emptyScope_ne_onlyOn a⟩,
    ⟨fullOn a b, diagOn a b,
      ⟨⟨isPartition_fullOn a b, isPartition_diagOn a b⟩, (), fullOn_ne_diagOn hab⟩,
      funext fun c => propext (sameCoverage_fullOn_diagOn a b c)⟩⟩

-- RR.DEFINES: SEIR.THM.SCOPE_AD_LOOSE_STRUCTURE_BRK
/-- Loose AD breaks the structure basis on every effective instance. -/
theorem loose_structure_brk (hab : a ≠ b) :
    (looseModel (Case := Case)).HasVerdict structureBasis () Verdict.brk :=
  ⟨loose_applicable hab, fun _ _ hxy => by
    obtain ⟨_, _, hi⟩ := hxy
    exact hi⟩

/-- The two presentations `fullOn a b` and `diagOn a b`. -/
def pairDomain (a b : Case) : Scope Case → Prop :=
  fun x => x = fullOn a b ∨ x = diagOn a b

/-- The single presentation `fullOn a b`. -/
def singleDomain (a b : Case) : Scope Case → Prop :=
  fun x => x = fullOn a b

-- RR.DEFINES: SEIR.THM.SCOPE_AD_STRICT_SEPARATES
/-- A domain containing the AD step from `fullOn a b` to `diagOn a b`
separates the extension and structure bases. -/
theorem strict_separates (hab : a ≠ b) :
    ¬ (strictModel (Case := Case)).Collapse extensionBasis structureBasis
      (pairDomain a b) :=
  EffectModel.not_collapse_of_step (f := ()) (x := fullOn a b) (y := diagOn a b)
    (Or.inl rfl) (Or.inr rfl)
    ⟨isPartition_fullOn a b, isPartition_diagOn a b, sameCoverage_fullOn_diagOn a b⟩
    (funext fun c => propext (sameCoverage_fullOn_diagOn a b c))
    (fullOn_ne_diagOn hab)

-- RR.DEFINES: SEIR.THM.SCOPE_AD_STRICT_COLLAPSES_ON_SINGLE
/-- On a domain with no restructuring step the bases collapse, although
the verdicts of AD differ. -/
theorem strict_collapses_on_single (a b : Case) :
    (strictModel (Case := Case)).Collapse extensionBasis structureBasis
      (singleDomain a b) := by
  rw [EffectModel.collapse_iff_stepAgree]
  intro _ x y hx hy _
  have hx' : x = fullOn a b := hx
  have hy' : y = fullOn a b := hy
  subst hx'
  subst hy'
  exact ⟨fun _ => rfl, fun _ => rfl⟩

end

end SE.IdentityRegimes.Model.Scope
