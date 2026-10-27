/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.IdentityRegimes.Model.Scope

set_option autoImplicit false

/-!
File: SE/IdentityRegimes/Model/ScopeEntries.lean

Purpose:
The AD split on scopes with one field per pair of cases.

`Model/Scope.lean` keeps the whole organization in a single field.
Every change to the organization then touches every field either basis reads,
so that the model cannot tell a basis that reads little from one that reads everything.

Here a presentation has one field for each pair of cases: whether the
organization relates them.

  extension basis  reads the pairs `(c, c)`: the diagonal
  structure basis  reads every pair

Both supports are justified (`InvariantBasis.Minimal`): each supported field
can change the invariant on its own.

Strict AD preserves coverage, so it leaves the diagonal fixed and writes only
off-diagonal pairs. The model proves that bound.

Derived verdicts of AD (given two distinct cases):

  strict  extension `neu`, structure `brk`
  loose   extension `mix`, structure `brk`

With the single-field model the strict extension verdict is `prs`. With
field-level supports it is `neu`. Both are non-breaking, so the generated
relations do not change. The difference between `prs` and `neu` depends on the
granularity of the fields.
-/

namespace SE.IdentityRegimes.Model.ScopeEntries

@[expose] public section

open SE.IdentityRegimes.Model.Scope

variable {Case : Type}

-- RR.DEFINES: SEIR.DEF.SCOPE_ENTRY_FIELD
/-- The field for the pair `(c, d)`: whether the organization relates them. -/
abbrev get : Case × Case → Scope Case → Prop :=
  fun p x => x p.1 p.2

-- RR.DEFINES: SEIR.DEF.SCOPE_ENTRY_STRICT_MODEL
/-- AD declared as restructuring that preserves coverage. It writes only
off-diagonal pairs. -/
def strictModel : EffectModel Unit (get (Case := Case)) where
  step _ x y := IsPartition x ∧ IsPartition y ∧ SameCoverage x y
  writes _ p := p.1 ≠ p.2
  bounded _ x y h p hc := by
    intro heq
    apply hc
    show x p.1 p.2 = y p.1 p.2
    rw [heq]
    exact propext (h.2.2 p.2)

-- RR.DEFINES: SEIR.DEF.SCOPE_ENTRY_LOOSE_MODEL
/-- AD declared as restructuring that may also change coverage. It may write
any pair. -/
def looseModel : EffectModel Unit (get (Case := Case)) where
  step _ x y := IsPartition x ∧ IsPartition y
  writes _ _ := True
  bounded _ _ _ _ _ _ := trivial

-- RR.DEFINES: SEIR.DEF.SCOPE_ENTRY_EXTENSION_BASIS
/-- Extension-fixed basis: the invariant is the set of covered cases, read from
the diagonal pairs. -/
def extensionBasis : InvariantBasis (get (Case := Case)) (Case → Prop) where
  inv x := covers x
  support p := p.1 = p.2
  factors _ _ h := funext fun c => h (c, c) rfl

-- RR.DEFINES: SEIR.DEF.SCOPE_ENTRY_STRUCTURE_BASIS
/-- Structure-fixed basis: the invariant is the organization, read from every pair. -/
def structureBasis : InvariantBasis (get (Case := Case)) (Scope Case) where
  inv x := x
  support _ := True
  factors _ _ h := funext fun c => funext fun d => h (c, d) trivial

/-- Only the pair `(c, d)` related. -/
def entry (c d : Case) : Scope Case :=
  fun c' d' => c' = c ∧ d' = d

/-- A pair differs between the empty scope and `entry c d`. -/
theorem emptyScope_entry_changes (c d : Case) :
    FieldChanges (get (Case := Case)) (c, d) emptyScope (entry c d) := by
  intro h
  have h' : emptyScope c d = entry c d c d := h
  have h1 : entry c d c d := ⟨rfl, rfl⟩
  rw [← h'] at h1
  exact h1

/-- The empty scope and `entry c d` agree on every other pair. -/
theorem emptyScope_entry_agree (c d : Case) :
    ∀ j, j ≠ (c, d) →
      get (Case := Case) j emptyScope = get (Case := Case) j (entry c d) := by
  rintro ⟨c', d'⟩ hj
  show emptyScope c' d' = entry c d c' d'
  apply propext
  constructor
  · exact False.elim
  · rintro ⟨h1, h2⟩
    apply hj
    rw [h1, h2]

-- RR.DEFINES: SEIR.THM.SCOPE_ENTRY_STRUCTURE_MINIMAL
/-- The structure support is justified: every pair can change the organization
on its own. -/
theorem structureBasis_minimal : (structureBasis (Case := Case)).Minimal := by
  rintro ⟨c, d⟩ _
  refine ⟨emptyScope, entry c d, emptyScope_entry_changes c d,
    emptyScope_entry_agree c d, ?_⟩
  intro h
  have h1 : entry c d c d := ⟨rfl, rfl⟩
  have h' : (emptyScope : Scope Case) = entry c d := h
  rw [← h'] at h1
  exact h1

-- RR.DEFINES: SEIR.THM.SCOPE_ENTRY_EXTENSION_MINIMAL
/-- The extension support is justified: every diagonal pair can change coverage
on its own. -/
theorem extensionBasis_minimal : (extensionBasis (Case := Case)).Minimal := by
  rintro ⟨c, d⟩ hp
  have hcd : c = d := hp
  subst hcd
  refine ⟨emptyScope, entry c c, emptyScope_entry_changes c c,
    emptyScope_entry_agree c c, ?_⟩
  intro h
  have h' : covers (emptyScope : Scope Case) = covers (entry c c) := h
  have h1 : covers (entry c c) c := ⟨rfl, rfl⟩
  rw [← h'] at h1
  exact h1

variable {a b : Case}

/-- With two distinct cases, one provision differs from two at the pair `(a, b)`. -/
theorem fullOn_diagOn_changes (hab : a ≠ b) :
    FieldChanges (get (Case := Case)) (a, b) (fullOn a b) (diagOn a b) := by
  intro h
  have h' : fullOn a b a b = diagOn a b a b := h
  have h1 : fullOn a b a b := ⟨Or.inl rfl, Or.inr rfl⟩
  rw [h'] at h1
  exact hab h1.1

/-- Strict AD has an effective instance when there are two distinct cases. -/
theorem strict_applicable (hab : a ≠ b) :
    (strictModel (Case := Case)).Applicable () :=
  ⟨fullOn a b, diagOn a b,
    ⟨isPartition_fullOn a b, isPartition_diagOn a b, sameCoverage_fullOn_diagOn a b⟩,
    (a, b), fullOn_diagOn_changes hab⟩

-- RR.DEFINES: SEIR.THM.SCOPE_ENTRY_STRICT_EXTENSION_NEU
/-- Strict AD writes no diagonal pair, so it is neutral for the extension basis. -/
theorem strict_extension_neu (hab : a ≠ b) :
    (strictModel (Case := Case)).HasVerdict extensionBasis () Verdict.neu := by
  refine ⟨strict_applicable hab, ?_, ?_⟩
  · intro x y hxy
    show covers x = covers y
    exact funext fun c => propext (hxy.1.2.2 c)
  · exact EffectModel.not_engages_of_writes_off_support (fun _ hw hs => hw hs)

-- RR.DEFINES: SEIR.THM.SCOPE_ENTRY_STRICT_STRUCTURE_BRK
/-- Strict AD breaks the structure basis on every effective instance. -/
theorem strict_structure_brk (hab : a ≠ b) :
    (strictModel (Case := Case)).HasVerdict structureBasis () Verdict.brk :=
  ⟨strict_applicable hab, fun x y hxy e => by
    obtain ⟨_, p, hp⟩ := hxy
    exact hp (congrArg (fun r => r p.1 p.2) e)⟩

/-- Loose AD has an effective instance when there are two distinct cases. -/
theorem loose_applicable (hab : a ≠ b) :
    (looseModel (Case := Case)).Applicable () :=
  ⟨fullOn a b, diagOn a b, ⟨isPartition_fullOn a b, isPartition_diagOn a b⟩,
    (a, b), fullOn_diagOn_changes hab⟩

/-- The pair `(a, a)` differs between the empty scope and `onlyOn a`. -/
theorem emptyScope_onlyOn_changes (a : Case) :
    FieldChanges (get (Case := Case)) (a, a) emptyScope (onlyOn a) := by
  intro h
  have h' : emptyScope a a = onlyOn a a a := h
  have h1 : onlyOn a a a := ⟨rfl, rfl⟩
  rw [← h'] at h1
  exact h1

-- RR.DEFINES: SEIR.THM.SCOPE_ENTRY_LOOSE_EXTENSION_MIX
/-- Loose AD has verdict `mix` for the extension basis: it can change coverage
and it can preserve it. -/
theorem loose_extension_mix (hab : a ≠ b) :
    (looseModel (Case := Case)).HasVerdict extensionBasis () Verdict.mix :=
  ⟨⟨emptyScope, onlyOn a,
      ⟨⟨isPartition_emptyScope, isPartition_onlyOn a⟩, (a, a), emptyScope_onlyOn_changes a⟩,
      covers_emptyScope_ne_onlyOn a⟩,
    ⟨fullOn a b, diagOn a b,
      ⟨⟨isPartition_fullOn a b, isPartition_diagOn a b⟩, (a, b), fullOn_diagOn_changes hab⟩,
      funext fun c => propext (sameCoverage_fullOn_diagOn a b c)⟩⟩

-- RR.DEFINES: SEIR.THM.SCOPE_ENTRY_LOOSE_STRUCTURE_BRK
/-- Loose AD breaks the structure basis on every effective instance. -/
theorem loose_structure_brk (hab : a ≠ b) :
    (looseModel (Case := Case)).HasVerdict structureBasis () Verdict.brk :=
  ⟨loose_applicable hab, fun x y hxy e => by
    obtain ⟨_, p, hp⟩ := hxy
    exact hp (congrArg (fun r => r p.1 p.2) e)⟩

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

end

end SE.IdentityRegimes.Model.ScopeEntries
