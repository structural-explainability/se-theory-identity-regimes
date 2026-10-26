/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import SE.IdentityRegimes.Transform.StepIdentity

set_option autoImplicit false

/-!
File: SETest/IdentityRegimes/Model/ScopeToy.lean

Purpose:
Two finite models for the derived-classification theory.

Model 1 (`ScopeToy`): extension-fixed and structure-fixed scope bases.
  - AD is a whole-preserving restructuring: it keeps annotation and coverage
    and changes organization.
  - Derived verdicts: AD is `prs` for the extension basis and `brk` for the
    structure basis; AN is `neu` for both.
  - On `{p0, p1}` (annotation steps only) the bases collapse although the AD
    verdicts differ and AD is applicable.
  - On `{p0, p1, p2}` the AD step p0 → p2 separates them.

Model 2 (`BlockToy`): a basis reading only the block that contains `a`.
  - AD has verdict `mix` for it.
  - On `{u1, u2}` an AD step is present and preserved by both bases, so
    they collapse; on all four presentations they separate.
-/

namespace SETest.IdentityRegimes

open SE.IdentityRegimes
open SE.IdentityRegimes.EffectModel

namespace ScopeToy

inductive Fld where
  | org
  | ann
deriving DecidableEq

inductive Fam where
  | AN
  | AD
deriving DecidableEq

/-- Organization code: p0 = coarse, p1 = coarse (annotated), p2 = fine,
p3 = coarse over a smaller coverage. -/
def orgOf (x : Fin 4) : Nat :=
  match x.val with
  | 0 => 0
  | 1 => 0
  | 2 => 1
  | _ => 2

def annOf (x : Fin 4) : Nat :=
  match x.val with
  | 1 => 1
  | _ => 0

/-- Coverage is read through the organization. -/
def covOf (n : Nat) : Nat :=
  if n = 2 then 1 else 0

def get : Fld → Fin 4 → Nat
  | .org => orgOf
  | .ann => annOf

def anStep (x y : Fin 4) : Prop :=
  orgOf x = orgOf y

def adStep (x y : Fin 4) : Prop :=
  annOf x = annOf y ∧ covOf (orgOf x) = covOf (orgOf y)

instance : DecidableRel anStep := fun x y =>
  inferInstanceAs (Decidable (orgOf x = orgOf y))

instance : DecidableRel adStep := fun x y =>
  inferInstanceAs (Decidable (annOf x = annOf y ∧ covOf (orgOf x) = covOf (orgOf y)))

def model : EffectModel Fam get where
  step
    | .AN => anStep
    | .AD => adStep
  writes
    | .AN, .ann => True
    | .AD, .org => True
    | _, _ => False
  bounded := by
    intro f x y h i hc
    cases f <;> cases i
    · exact absurd h hc
    · trivial
    · trivial
    · exact absurd h.1 hc

/-- Extension-fixed basis: the invariant is coverage. -/
def invE : InvariantBasis get Nat where
  inv x := covOf (orgOf x)
  support i := i = Fld.org
  factors _ _ h := congrArg covOf (h Fld.org rfl)

/-- Structure-fixed basis: the invariant is the organization. -/
def invS : InvariantBasis get Nat where
  inv x := orgOf x
  support i := i = Fld.org
  factors _ _ h := h Fld.org rfl

def D0 (x : Fin 4) : Prop := x = 0 ∨ x = 1
def D1 (x : Fin 4) : Prop := x = 0 ∨ x = 1 ∨ x = 2

theorem an_applicable : model.Applicable Fam.AN :=
  ⟨0, 1, (by decide : anStep 0 1), Fld.ann, (by decide : annOf 0 ≠ annOf 1)⟩

theorem ad_applicable : model.Applicable Fam.AD :=
  ⟨0, 2, (by decide : adStep 0 2), Fld.org, (by decide : orgOf 0 ≠ orgOf 2)⟩

theorem an_off_support (i : Fld) (hw : model.writes Fam.AN i) :
    ¬ (i = Fld.org) := by
  cases i
  · exact hw.elim
  · intro h; cases h

/-- AN is neutral for the extension basis. -/
theorem an_neu_E : model.HasVerdict invE Fam.AN Verdict.neu :=
  ⟨an_applicable, noneBreak_of_writes_off_support an_off_support,
    not_engages_of_writes_off_support an_off_support⟩

/-- AN is neutral for the structure basis. -/
theorem an_neu_S : model.HasVerdict invS Fam.AN Verdict.neu :=
  ⟨an_applicable, noneBreak_of_writes_off_support an_off_support,
    not_engages_of_writes_off_support an_off_support⟩

/-- AD preserves the extension basis and engages it. -/
theorem ad_prs_E : model.HasVerdict invE Fam.AD Verdict.prs := by
  refine ⟨ad_applicable, ?_, ?_⟩
  · intro x y hxy
    exact hxy.1.2
  · exact ⟨0, 2, ⟨(by decide : adStep 0 2), Fld.org, (by decide : orgOf 0 ≠ orgOf 2)⟩,
      Fld.org, rfl, (by decide : orgOf 0 ≠ orgOf 2)⟩

/-- AD breaks the structure basis on every effective instance. -/
theorem ad_brk_S : model.HasVerdict invS Fam.AD Verdict.brk := by
  refine ⟨ad_applicable, ?_⟩
  intro x y hxy
  obtain ⟨hs, i, hi⟩ := hxy
  cases i
  · exact hi
  · exact absurd hs.1 hi

/-- The structure basis has a justified support. -/
theorem invS_minimal : invS.Minimal := by
  intro i hi
  cases hi
  refine ⟨0, 2, (by decide : orgOf 0 ≠ orgOf 2), ?_, (by decide : orgOf 0 ≠ orgOf 2)⟩
  intro j hj
  cases j
  · exact absurd rfl hj
  · decide

/-- The extension basis has a justified support. -/
theorem invE_minimal : invE.Minimal := by
  intro i hi
  cases hi
  refine ⟨0, 3, (by decide : orgOf 0 ≠ orgOf 3), ?_,
    (by decide : covOf (orgOf 0) ≠ covOf (orgOf 3))⟩
  intro j hj
  cases j
  · exact absurd rfl hj
  · decide

/-- With annotation steps only, the bases collapse although the AD verdicts
differ and AD is applicable. -/
theorem collapse_D0 : model.Collapse invE invS D0 := by
  rw [collapse_iff_stepAgree]
  intro f x y hx hy _
  rcases hx with rfl | rfl <;> rcases hy with rfl | rfl <;> decide

/-- Adding the fine presentation adds the AD step that separates them. -/
theorem not_collapse_D1 : ¬ model.Collapse invE invS D1 :=
  not_collapse_of_step (f := Fam.AD) (x := 0) (y := 2)
    (Or.inl rfl) (Or.inr (Or.inr rfl))
    (show adStep 0 2 by decide)
    (by decide) (by decide)

theorem D0_sub_D1 : ∀ x, D0 x → D1 x := by
  intro x hx
  rcases hx with h | h
  · exact Or.inl h
  · exact Or.inr (Or.inl h)

/-- Collapse on `D0` and separation on `D1 ⊇ D0`. -/
theorem collapse_then_separate :
    model.Collapse invE invS D0 ∧ ¬ model.Collapse invE invS D1 :=
  ⟨collapse_D0, not_collapse_D1⟩

end ScopeToy

namespace BlockToy

/-- Presentations are partitions of {a,b,c}, coded: 0 = {ab|c}, 1 = {abc},
2 = {a|bc}, 3 = {a|b|c}. -/
def org (x : Fin 4) : Nat := x.val

def get : Unit → Fin 4 → Nat := fun _ => org

/-- AD merges {ab|c} into {abc} or splits {bc} into {b|c}, and inverses. -/
def adStep (x y : Fin 4) : Prop :=
  (x.val = 0 ∧ y.val = 1) ∨ (x.val = 1 ∧ y.val = 0) ∨
  (x.val = 2 ∧ y.val = 3) ∨ (x.val = 3 ∧ y.val = 2)

def model : EffectModel Unit get where
  step _ := adStep
  writes _ _ := True
  bounded _ _ _ _ _ _ := trivial

/-- The block containing `a`, coded: {ab} = 1, {abc} = 2, {a} = 0. -/
def blockA (x : Fin 4) : Nat :=
  match x.val with
  | 0 => 1
  | 1 => 2
  | _ => 0

instance : DecidableRel adStep := fun x y =>
  inferInstanceAs (Decidable ((x.val = 0 ∧ y.val = 1) ∨ (x.val = 1 ∧ y.val = 0) ∨
    (x.val = 2 ∧ y.val = 3) ∨ (x.val = 3 ∧ y.val = 2)))

def invB : InvariantBasis get Nat where
  inv := blockA
  support _ := True
  factors x y h := by
    have h1 : x.val = y.val := h () trivial
    have h2 : x = y := Fin.ext h1
    subst h2
    rfl

/-- Coverage: every presentation here covers {a,b,c}. -/
def invC : InvariantBasis get Nat where
  inv _ := 0
  support _ := False
  factors _ _ _ := rfl

def D (x : Fin 4) : Prop := x = 2 ∨ x = 3
def Dall (_ : Fin 4) : Prop := True

/-- AD is neutral for the coverage basis. -/
theorem ad_neu_C : model.HasVerdict invC () Verdict.neu :=
  ⟨⟨0, 1, (show adStep 0 1 by decide), (), (by decide : org 0 ≠ org 1)⟩,
    noneBreak_of_writes_off_support (fun _ _ hs => hs),
    not_engages_of_writes_off_support (fun _ _ hs => hs)⟩

/-- AD has verdict `mix` for the basis reading the block of `a`. -/
theorem ad_mix_B : model.HasVerdict invB () Verdict.mix :=
  ⟨⟨0, 1, ⟨(show adStep 0 1 by decide), (), (by decide : org 0 ≠ org 1)⟩,
      (by decide : blockA 0 ≠ blockA 1)⟩,
    ⟨2, 3, ⟨(show adStep 2 3 by decide), (), (by decide : org 2 ≠ org 3)⟩,
      (by decide : blockA 2 = blockA 3)⟩⟩

/-- The domain `{u1, u2}` contains an AD step and the bases still collapse. -/
theorem collapse_D : model.Collapse invC invB D := by
  rw [collapse_iff_stepAgree]
  intro f x y hx hy _
  rcases hx with rfl | rfl <;> rcases hy with rfl | rfl <;> decide

/-- On all four presentations the AD step {ab|c} → {abc} separates them. -/
theorem not_collapse_Dall : ¬ model.Collapse invC invB Dall :=
  not_collapse_of_step (f := ()) (x := 0) (y := 1) trivial trivial
    (show adStep 0 1 by decide) (by decide) (by decide)

theorem step_in_D : model.step () 2 3 :=
  show adStep 2 3 by decide

end BlockToy

end SETest.IdentityRegimes
