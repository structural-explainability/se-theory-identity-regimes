/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.IdentityRegimes.Model.Scope

set_option autoImplicit false

/-!
File: SE/IdentityRegimes/Model/Rule.lean

Purpose:
Model of the RF split on rules: content-fixed against structure-fixed.

A rule presentation has two fields.

  org   the organization of its provisions: a relation between cases
  norm  the norm each case receives

A case is governed when the organization relates it to itself.

  content basis    the invariant is the relation "case c is governed with norm n"
  structure basis  the invariant is the organization

RF is declared in two ways. Both split the provisions strictly and keep
coverage.

  strict  the norm of every case is unchanged
  loose   norms may change (refinement may add normative detail)

Derived verdicts of RF (given two distinct cases):

  strict  content `prs`, structure `brk`
  loose   content `mix` (given two distinct norms), structure `brk`

The content verdict depends on the declared norm-preservation condition.
The definition of RF in the transformation basis includes normative detail.
Read that way, RF is `mix` for the content basis, and the family must be
refined before it can be entered in a classification table.
-/

namespace SE.IdentityRegimes.Model.Rule

@[expose] public section

open SE.IdentityRegimes.Model.Scope

variable {Case Norm : Type}

-- RR.DEFINES: SEIR.DEF.RULE_PRESENTATION
/-- A rule presentation: the organization of its provisions and a norm per case. -/
structure Rule (Case Norm : Type) where
  /-- The organization of the provisions. -/
  org : Scope Case
  /-- The norm each case receives. -/
  norm : Case → Norm

/-- The two presentation fields. -/
inductive Fld where
  /-- The organization field. -/
  | org
  /-- The norm field. -/
  | norm
deriving DecidableEq

/-- Field values: an organization or a norm assignment. -/
abbrev Val (Case Norm : Type) : Type :=
  Sum (Scope Case) (Case → Norm)

/-- The value of a field. -/
abbrev get : Fld → Rule Case Norm → Val Case Norm
  | .org, x => Sum.inl x.org
  | .norm, x => Sum.inr x.norm

-- RR.DEFINES: SEIR.DEF.RULE_REFINES
/-- `y` splits every provision of `x` into provisions of `y`. -/
def Refines (x y : Rule Case Norm) : Prop :=
  ∀ c d, y.org c d → x.org c d

-- RR.DEFINES: SEIR.DEF.RULE_STRICTLY_REFINES
/-- `y` splits at least one provision of `x`. -/
def StrictlyRefines (x y : Rule Case Norm) : Prop :=
  ∃ c d, x.org c d ∧ ¬ y.org c d

-- RR.DEFINES: SEIR.DEF.RULE_RF_STRICT_MODEL
/-- RF declared as a strict split that keeps coverage and every norm. -/
def strictModel : EffectModel Unit (get (Case := Case) (Norm := Norm)) where
  step _ x y :=
    IsPartition x.org ∧ IsPartition y.org ∧ Refines x y ∧ StrictlyRefines x y ∧
      SameCoverage x.org y.org ∧ y.norm = x.norm
  writes _ i := i = Fld.org
  bounded _ x y h i hc := by
    cases i
    · rfl
    · exact absurd (congrArg Sum.inr h.2.2.2.2.2.symm) hc

-- RR.DEFINES: SEIR.DEF.RULE_RF_LOOSE_MODEL
/-- RF declared as a strict split that keeps coverage and may change norms. -/
def looseModel : EffectModel Unit (get (Case := Case) (Norm := Norm)) where
  step _ x y :=
    IsPartition x.org ∧ IsPartition y.org ∧ Refines x y ∧ StrictlyRefines x y ∧
      SameCoverage x.org y.org
  writes _ _ := True
  bounded _ _ _ _ _ _ := trivial

-- RR.DEFINES: SEIR.DEF.RULE_CONTENT_BASIS
/-- Content-fixed basis: the invariant relates each governed case to its norm. -/
def contentBasis : InvariantBasis (get (Case := Case) (Norm := Norm)) (Case → Norm → Prop) where
  inv x := fun c n => covers x.org c ∧ x.norm c = n
  support _ := True
  factors x y h := by
    have ho : x.org = y.org := Sum.inl.inj (h Fld.org trivial)
    have hn : x.norm = y.norm := Sum.inr.inj (h Fld.norm trivial)
    show (fun c n => covers x.org c ∧ x.norm c = n) =
      fun c n => covers y.org c ∧ y.norm c = n
    rw [ho, hn]

-- RR.DEFINES: SEIR.DEF.RULE_STRUCTURE_BASIS
/-- Structure-fixed basis: the invariant is the organization of the provisions. -/
def structureBasis : InvariantBasis (get (Case := Case) (Norm := Norm)) (Scope Case) where
  inv x := x.org
  support i := i = Fld.org
  factors _ _ h := Sum.inl.inj (h Fld.org rfl)

/-- The content invariant is unchanged by a step that keeps coverage and norms. -/
theorem content_inv_eq {x y : Rule Case Norm} (hcov : SameCoverage x.org y.org)
    (hn : y.norm = x.norm) :
    (contentBasis (Case := Case) (Norm := Norm)).inv x =
      (contentBasis (Case := Case) (Norm := Norm)).inv y := by
  show (fun c n => covers x.org c ∧ x.norm c = n) =
    fun c n => covers y.org c ∧ y.norm c = n
  funext c n
  apply propext
  constructor
  · intro h
    refine ⟨(hcov c).mp h.1, ?_⟩
    rw [hn]
    exact h.2
  · intro h
    refine ⟨(hcov c).mpr h.1, ?_⟩
    rw [← hn]
    exact h.2

/-- A strict split changes the organization. -/
theorem org_ne_of_strictlyRefines {x y : Rule Case Norm} (h : StrictlyRefines x y) :
    x.org ≠ y.org := by
  intro heq
  obtain ⟨c, d, h1, h2⟩ := h
  apply h2
  rw [← heq]
  exact h1

/-- The rule with provision `{a, b}` and norm `n` everywhere. -/
def rFull (a b : Case) (n : Norm) : Rule Case Norm :=
  ⟨fullOn a b, fun _ => n⟩

/-- The rule with provisions `{a}` and `{b}` and norm `n` everywhere. -/
def rDiag (a b : Case) (n : Norm) : Rule Case Norm :=
  ⟨diagOn a b, fun _ => n⟩

/-- `rDiag a b n'` splits every provision of `rFull a b n`. -/
theorem refines_rFull_rDiag (a b : Case) (n n' : Norm) :
    Refines (rFull a b n) (rDiag a b n') := by
  intro c d h
  rcases h with ⟨rfl, h2⟩
  exact ⟨h2, h2⟩

/-- With two distinct cases, `rDiag a b n'` splits the provision of `rFull a b n`. -/
theorem strictlyRefines_rFull_rDiag {a b : Case} (hab : a ≠ b) (n n' : Norm) :
    StrictlyRefines (rFull a b n) (rDiag a b n') :=
  ⟨a, b, ⟨Or.inl rfl, Or.inr rfl⟩, fun h => hab h.1⟩

/-- The organization field differs between `rFull a b n` and `rDiag a b n`. -/
theorem rFull_org_ne_rDiag_org {a b : Case} (hab : a ≠ b) (n : Norm) :
    FieldChanges (get (Case := Case) (Norm := Norm)) Fld.org
      (rFull a b n) (rDiag a b n) :=
  fun h => fullOn_ne_diagOn hab (Sum.inl.inj h)

variable {a b : Case} {n n' : Norm}

/-- The strict RF step from `rFull a b n` to `rDiag a b n`. -/
theorem strict_step (hab : a ≠ b) :
    (strictModel (Case := Case) (Norm := Norm)).step ()
      (rFull a b n) (rDiag a b n) :=
  ⟨isPartition_fullOn a b, isPartition_diagOn a b, refines_rFull_rDiag a b n n,
    strictlyRefines_rFull_rDiag hab n n, sameCoverage_fullOn_diagOn a b, rfl⟩

/-- The loose RF step from `rFull a b n` to `rDiag a b n'`. -/
theorem loose_step (hab : a ≠ b) :
    (looseModel (Case := Case) (Norm := Norm)).step ()
      (rFull a b n) (rDiag a b n') :=
  ⟨isPartition_fullOn a b, isPartition_diagOn a b, refines_rFull_rDiag a b n n',
    strictlyRefines_rFull_rDiag hab n n', sameCoverage_fullOn_diagOn a b⟩

/-- Strict RF has an effective instance when there are two distinct cases. -/
theorem strict_applicable (hab : a ≠ b) (n : Norm) :
    (strictModel (Case := Case) (Norm := Norm)).Applicable () :=
  ⟨rFull a b n, rDiag a b n, strict_step hab, Fld.org, rFull_org_ne_rDiag_org hab n⟩

-- RR.DEFINES: SEIR.THM.RULE_RF_STRICT_CONTENT_PRS
/-- Strict RF preserves the content basis and engages it. -/
theorem strict_content_prs (hab : a ≠ b) (n : Norm) :
    (strictModel (Case := Case) (Norm := Norm)).HasVerdict contentBasis () Verdict.prs := by
  refine ⟨strict_applicable hab n, ?_, ?_⟩
  · intro x y hxy
    exact content_inv_eq hxy.1.2.2.2.2.1 hxy.1.2.2.2.2.2
  · exact ⟨rFull a b n, rDiag a b n,
      ⟨strict_step hab, Fld.org, rFull_org_ne_rDiag_org hab n⟩,
      Fld.org, trivial, rFull_org_ne_rDiag_org hab n⟩

-- RR.DEFINES: SEIR.THM.RULE_RF_STRICT_STRUCTURE_BRK
/-- Strict RF breaks the structure basis on every effective instance. -/
theorem strict_structure_brk (hab : a ≠ b) (n : Norm) :
    (strictModel (Case := Case) (Norm := Norm)).HasVerdict structureBasis () Verdict.brk :=
  ⟨strict_applicable hab n, fun _ _ hxy => org_ne_of_strictlyRefines hxy.1.2.2.2.1⟩

-- RR.DEFINES: SEIR.THM.RULE_RF_LOOSE_CONTENT_MIX
/-- Loose RF has an effective instance when there are two distinct cases. -/
theorem loose_applicable (hab : a ≠ b) (n : Norm) :
    (looseModel (Case := Case) (Norm := Norm)).Applicable () :=
  ⟨rFull a b n, rDiag a b n, loose_step hab, Fld.org, rFull_org_ne_rDiag_org hab n⟩

/-- Loose RF has verdict `mix` for the content basis: it can change a norm
and it can keep every norm. -/
theorem loose_content_mix (hab : a ≠ b) (hn : n ≠ n') :
    (looseModel (Case := Case) (Norm := Norm)).HasVerdict contentBasis () Verdict.mix := by
  refine ⟨⟨rFull a b n, rDiag a b n', ⟨loose_step hab, Fld.org, rFull_org_ne_rDiag_org hab n⟩, ?_⟩,
    ⟨rFull a b n, rDiag a b n, ⟨loose_step hab, Fld.org, rFull_org_ne_rDiag_org hab n⟩, ?_⟩⟩
  · intro h
    have h1 : (covers (fullOn a b) a ∧ n = n) = (covers (diagOn a b) a ∧ n' = n) :=
      congrFun (congrFun h a) n
    have h2 : covers (diagOn a b) a ∧ n' = n :=
      Eq.mp h1 ⟨⟨Or.inl rfl, Or.inl rfl⟩, rfl⟩
    exact hn h2.2.symm
  · exact content_inv_eq (sameCoverage_fullOn_diagOn a b) rfl

-- RR.DEFINES: SEIR.THM.RULE_RF_LOOSE_STRUCTURE_BRK
/-- Loose RF breaks the structure basis on every effective instance. -/
theorem loose_structure_brk (hab : a ≠ b) (n : Norm) :
    (looseModel (Case := Case) (Norm := Norm)).HasVerdict structureBasis () Verdict.brk :=
  ⟨loose_applicable hab n, fun _ _ hxy => org_ne_of_strictlyRefines hxy.1.2.2.2.1⟩

/-- The two presentations `rFull a b n` and `rDiag a b n`. -/
def pairDomain (a b : Case) (n : Norm) : Rule Case Norm → Prop :=
  fun x => x = rFull a b n ∨ x = rDiag a b n

-- RR.DEFINES: SEIR.THM.RULE_RF_STRICT_SEPARATES
/-- A domain containing the strict refinement step separates the content and
structure bases. -/
theorem strict_separates (hab : a ≠ b) (n : Norm) :
    ¬ (strictModel (Case := Case) (Norm := Norm)).Collapse contentBasis structureBasis
      (pairDomain a b n) :=
  EffectModel.not_collapse_of_step (f := ()) (x := rFull a b n) (y := rDiag a b n)
    (Or.inl rfl) (Or.inr rfl) (strict_step hab)
    (content_inv_eq (sameCoverage_fullOn_diagOn a b) rfl)
    (fun h => fullOn_ne_diagOn hab h)

end

end SE.IdentityRegimes.Model.Rule
