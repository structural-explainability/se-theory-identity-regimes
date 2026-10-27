/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.IdentityRegimes.Model.Rule
public import SE.IdentityRegimes.Model.ScopeEntries

set_option autoImplicit false

/-!
File: SE/IdentityRegimes/Model/RuleEntries.lean

Purpose:
The RF split on rules with one field per dependency.

`Model/Rule.lean` keeps the whole organization in a single field. Here a rule
presentation has one field for each pair of cases (whether the organization
relates them) and one field for each case (its norm).

  content basis    reads the diagonal pairs and every norm
  structure basis  reads every pair, and no norm

Both supports are justified (`InvariantBasis.Minimal`).

Strict RF splits provisions, keeps coverage, and keeps every norm. It leaves the
diagonal pairs and every norm fixed, so it writes only off-diagonal pairs.
The model proves that bound.

Derived verdicts of RF (given two distinct cases):

  strict  content `neu`, structure `brk`
  loose   content `mix` (given two distinct norms), structure `brk`

With the single-field model the strict content verdict is `prs`. With
field-level supports it is `neu`. Both are non-breaking.
-/

namespace SE.IdentityRegimes.Model.RuleEntries

@[expose] public section

open SE.IdentityRegimes.Model.Scope
  (IsPartition SameCoverage covers fullOn diagOn emptyScope
    fullOn_ne_diagOn isPartition_fullOn isPartition_diagOn sameCoverage_fullOn_diagOn)
open SE.IdentityRegimes.Model.Rule (Rule Refines StrictlyRefines rFull rDiag)
open SE.IdentityRegimes.Model.ScopeEntries (entry emptyScope_entry_changes emptyScope_entry_agree)

variable {Case Norm : Type}

-- RR.DEFINES: SEIR.DEF.RULE_ENTRY_FIELD
/-- The fields of a rule presentation: a pair of cases (whether the organization
relates them) or a case (its norm). -/
abbrev get : (Case × Case) ⊕ Case → Rule Case Norm → Prop ⊕ Norm
  | Sum.inl p, x => Sum.inl (x.org p.1 p.2)
  | Sum.inr c, x => Sum.inr (x.norm c)

-- RR.DEFINES: SEIR.DEF.RULE_ENTRY_STRICT_MODEL
/-- RF declared as a strict split that keeps coverage and every norm. It writes
only off-diagonal pairs. -/
def strictModel : EffectModel Unit (get (Case := Case) (Norm := Norm)) where
  step _ x y :=
    IsPartition x.org ∧ IsPartition y.org ∧ Refines x y ∧ StrictlyRefines x y ∧
      SameCoverage x.org y.org ∧ y.norm = x.norm
  writes _ i :=
    match i with
    | Sum.inl p => p.1 ≠ p.2
    | Sum.inr _ => False
  bounded _ x y h i hc := by
    cases i with
    | inl p =>
      intro heq
      apply hc
      show Sum.inl (x.org p.1 p.2) = Sum.inl (y.org p.1 p.2)
      rw [heq]
      exact congrArg Sum.inl (propext (h.2.2.2.2.1 p.2))
    | inr c =>
      apply absurd _ hc
      show Sum.inr (x.norm c) = Sum.inr (y.norm c)
      rw [h.2.2.2.2.2]

-- RR.DEFINES: SEIR.DEF.RULE_ENTRY_LOOSE_MODEL
/-- RF declared as a strict split that keeps coverage and may change norms. It may
write any field. -/
def looseModel : EffectModel Unit (get (Case := Case) (Norm := Norm)) where
  step _ x y :=
    IsPartition x.org ∧ IsPartition y.org ∧ Refines x y ∧ StrictlyRefines x y ∧
      SameCoverage x.org y.org
  writes _ _ := True
  bounded _ _ _ _ _ _ := trivial

-- RR.DEFINES: SEIR.DEF.RULE_ENTRY_CONTENT_BASIS
/-- Content-fixed basis: the invariant relates each governed case to its norm. It
reads the diagonal pairs and every norm. -/
def contentBasis :
    InvariantBasis (get (Case := Case) (Norm := Norm)) (Case → Norm → Prop) where
  inv x := fun c n => covers x.org c ∧ x.norm c = n
  support i :=
    match i with
    | Sum.inl p => p.1 = p.2
    | Sum.inr _ => True
  factors x y h := by
    have hc : ∀ c, x.org c c = y.org c c := fun c => Sum.inl.inj (h (Sum.inl (c, c)) rfl)
    have hn : ∀ c, x.norm c = y.norm c := fun c => Sum.inr.inj (h (Sum.inr c) trivial)
    funext c n
    show (x.org c c ∧ x.norm c = n) = (y.org c c ∧ y.norm c = n)
    rw [hc c, hn c]

-- RR.DEFINES: SEIR.DEF.RULE_ENTRY_STRUCTURE_BASIS
/-- Structure-fixed basis: the invariant is the organization. It reads every pair
and no norm. -/
def structureBasis :
    InvariantBasis (get (Case := Case) (Norm := Norm)) (Scope.Scope Case) where
  inv x := x.org
  support i :=
    match i with
    | Sum.inl _ => True
    | Sum.inr _ => False
  factors _ _ h :=
    funext fun c => funext fun d => Sum.inl.inj (h (Sum.inl (c, d)) trivial)

/-- The norm `n` everywhere except `n'` at the case `c`. -/
def normAt [DecidableEq Case] (c : Case) (n n' : Norm) : Case → Norm :=
  fun d => if d = c then n' else n

/-- `normAt c n n'` gives `n'` at `c`. -/
theorem normAt_self [DecidableEq Case] (c : Case) (n n' : Norm) :
    normAt c n n' c = n' := by
  simp [normAt]

/-- `normAt c n n'` gives `n` away from `c`. -/
theorem normAt_ne [DecidableEq Case] {c d : Case} (h : d ≠ c) (n n' : Norm) :
    normAt c n n' d = n := by
  simp [normAt, h]

/-- The rule with organization `entry c d` and norm `n` everywhere. -/
def ruleEntry (c d : Case) (n : Norm) : Rule Case Norm :=
  ⟨entry c d, fun _ => n⟩

/-- The rule with the empty organization and norm `n` everywhere. -/
def ruleEmpty (n : Norm) : Rule Case Norm :=
  ⟨emptyScope, fun _ => n⟩

-- RR.DEFINES: SEIR.THM.RULE_ENTRY_STRUCTURE_MINIMAL
/-- The structure support is justified: every pair can change the organization
on its own. -/
theorem structureBasis_minimal (n : Norm) :
    (structureBasis (Case := Case) (Norm := Norm)).Minimal := by
  intro i hi
  cases i with
  | inl p =>
    obtain ⟨c, d⟩ := p
    refine ⟨ruleEmpty n, ruleEntry c d n, ?_, ?_, ?_⟩
    · exact fun h => emptyScope_entry_changes c d (Sum.inl.inj h)
    · intro j hj
      cases j with
      | inl q =>
        have hq : q ≠ (c, d) := fun e => hj (by rw [e])
        exact congrArg Sum.inl (emptyScope_entry_agree c d q hq)
      | inr c' => rfl
    · intro h
      have h1 : entry c d c d := ⟨rfl, rfl⟩
      have h' : (emptyScope : Scope.Scope Case) = entry c d := h
      rw [← h'] at h1
      exact h1
  | inr c => exact hi.elim

-- RR.DEFINES: SEIR.THM.RULE_ENTRY_CONTENT_MINIMAL
/-- The content support is justified: every diagonal pair can change coverage on
its own, and every norm can change a governed case's norm on its own. -/
theorem contentBasis_minimal [DecidableEq Case] {n n' : Norm} (hn : n ≠ n') :
    (contentBasis (Case := Case) (Norm := Norm)).Minimal := by
  intro i hi
  cases i with
  | inl p =>
    obtain ⟨c, d⟩ := p
    have hcd : c = d := hi
    subst hcd
    refine ⟨ruleEmpty n, ruleEntry c c n, ?_, ?_, ?_⟩
    · exact fun h => emptyScope_entry_changes c c (Sum.inl.inj h)
    · intro j hj
      cases j with
      | inl q =>
        have hq : q ≠ (c, c) := fun e => hj (by rw [e])
        exact congrArg Sum.inl (emptyScope_entry_agree c c q hq)
      | inr c' => rfl
    · intro h
      have h1 : covers (entry c c) c ∧ n = n := ⟨⟨rfl, rfl⟩, rfl⟩
      have h' : (fun c' n'' => covers (emptyScope : Scope.Scope Case) c' ∧ n = n'') =
          fun c' n'' => covers (entry c c) c' ∧ n = n'' := h
      have h2 := congrFun (congrFun h' c) n
      rw [← h2] at h1
      exact h1.1
  | inr c =>
    refine ⟨ruleEntry c c n, ⟨entry c c, normAt c n n'⟩, ?_, ?_, ?_⟩
    · intro h
      have h2 : n = normAt c n n' c := Sum.inr.inj h
      rw [normAt_self] at h2
      exact hn h2
    · intro j hj
      cases j with
      | inl q => rfl
      | inr c' =>
        have hc' : c' ≠ c := fun e => hj (by rw [e])
        show Sum.inr n = Sum.inr (normAt c n n' c')
        rw [normAt_ne hc']
    · intro h
      have h2 : (entry c c c c ∧ n = n) = (entry c c c c ∧ normAt c n n' c = n) :=
        congrFun (congrFun h c) n
      have h3 : entry c c c c ∧ n = n := ⟨⟨rfl, rfl⟩, rfl⟩
      have h4 : entry c c c c ∧ normAt c n n' c = n := Eq.mp h2 h3
      rw [normAt_self] at h4
      exact hn h4.2.symm

variable {a b : Case} {n n' : Norm}

/-- Strict RF has an effective instance when there are two distinct cases. -/
theorem strict_applicable (hab : a ≠ b) (n : Norm) :
    (strictModel (Case := Case) (Norm := Norm)).Applicable () :=
  ⟨rFull a b n, rDiag a b n, Rule.strict_step hab, Sum.inl (a, b),
    fun h => ScopeEntries.fullOn_diagOn_changes hab (Sum.inl.inj h)⟩

-- RR.DEFINES: SEIR.THM.RULE_ENTRY_STRICT_CONTENT_NEU
/-- Strict RF writes no diagonal pair and no norm, so it is neutral for the
content basis. -/
theorem strict_content_neu (hab : a ≠ b) (n : Norm) :
    (strictModel (Case := Case) (Norm := Norm)).HasVerdict contentBasis () Verdict.neu := by
  have hoff : ∀ i, (strictModel (Case := Case) (Norm := Norm)).writes () i →
      ¬ (contentBasis (Case := Case) (Norm := Norm)).support i := by
    intro i hw hs
    cases i with
    | inl p => exact hw hs
    | inr c => exact hw
  refine ⟨strict_applicable hab n, ?_, EffectModel.not_engages_of_writes_off_support hoff⟩
  intro x y hxy
  exact Rule.content_inv_eq hxy.1.2.2.2.2.1 hxy.1.2.2.2.2.2

-- RR.DEFINES: SEIR.THM.RULE_ENTRY_STRICT_STRUCTURE_BRK
/-- Strict RF breaks the structure basis on every effective instance. -/
theorem strict_structure_brk (hab : a ≠ b) (n : Norm) :
    (strictModel (Case := Case) (Norm := Norm)).HasVerdict structureBasis () Verdict.brk :=
  ⟨strict_applicable hab n,
    fun _ _ hxy => Rule.org_ne_of_strictlyRefines hxy.1.2.2.2.1⟩

/-- Loose RF has an effective instance when there are two distinct cases. -/
theorem loose_applicable (hab : a ≠ b) (n : Norm) :
    (looseModel (Case := Case) (Norm := Norm)).Applicable () :=
  ⟨rFull a b n, rDiag a b n, Rule.loose_step hab, Sum.inl (a, b),
    fun h => ScopeEntries.fullOn_diagOn_changes hab (Sum.inl.inj h)⟩

-- RR.DEFINES: SEIR.THM.RULE_ENTRY_LOOSE_CONTENT_MIX
/-- Loose RF has verdict `mix` for the content basis: it can change a norm and it
can keep every norm. -/
theorem loose_content_mix (hab : a ≠ b) (hn : n ≠ n') :
    (looseModel (Case := Case) (Norm := Norm)).HasVerdict contentBasis () Verdict.mix := by
  have hf : FieldChanges (get (Case := Case) (Norm := Norm)) (Sum.inl (a, b))
      (rFull a b n) (rDiag a b n) :=
    fun h => ScopeEntries.fullOn_diagOn_changes hab (Sum.inl.inj h)
  have hf' : FieldChanges (get (Case := Case) (Norm := Norm)) (Sum.inl (a, b))
      (rFull a b n) (rDiag a b n') :=
    fun h => ScopeEntries.fullOn_diagOn_changes hab (Sum.inl.inj h)
  refine ⟨⟨rFull a b n, rDiag a b n', ⟨Rule.loose_step hab, Sum.inl (a, b), hf'⟩, ?_⟩,
    ⟨rFull a b n, rDiag a b n, ⟨Rule.loose_step hab, Sum.inl (a, b), hf⟩, ?_⟩⟩
  · intro h
    have h1 : (covers (fullOn a b) a ∧ n = n) = (covers (diagOn a b) a ∧ n' = n) :=
      congrFun (congrFun h a) n
    have h2 : covers (diagOn a b) a ∧ n' = n :=
      Eq.mp h1 ⟨⟨Or.inl rfl, Or.inl rfl⟩, rfl⟩
    exact hn h2.2.symm
  · exact Rule.content_inv_eq (sameCoverage_fullOn_diagOn a b) rfl

-- RR.DEFINES: SEIR.THM.RULE_ENTRY_LOOSE_STRUCTURE_BRK
/-- Loose RF breaks the structure basis on every effective instance. -/
theorem loose_structure_brk (hab : a ≠ b) (n : Norm) :
    (looseModel (Case := Case) (Norm := Norm)).HasVerdict structureBasis () Verdict.brk :=
  ⟨loose_applicable hab n,
    fun _ _ hxy => Rule.org_ne_of_strictlyRefines hxy.1.2.2.2.1⟩

/-- A domain containing the strict refinement step separates the content and
structure bases. -/
theorem strict_separates (hab : a ≠ b) (n : Norm) :
    ¬ (strictModel (Case := Case) (Norm := Norm)).Collapse contentBasis structureBasis
      (Rule.pairDomain a b n) :=
  EffectModel.not_collapse_of_step (f := ()) (x := rFull a b n) (y := rDiag a b n)
    (Or.inl rfl) (Or.inr rfl) (Rule.strict_step hab)
    (Rule.content_inv_eq (sameCoverage_fullOn_diagOn a b) rfl)
    (fun h => fullOn_ne_diagOn hab h)

end

end SE.IdentityRegimes.Model.RuleEntries
