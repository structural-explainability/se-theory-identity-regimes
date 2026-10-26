/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.IdentityRegimes.Profile.Invariant

set_option autoImplicit false

/-!
File: SE/IdentityRegimes/Transform/Effect.lean

Purpose:
Effective instances, applicability, and derived classification verdicts.

An effect model says, for each transformation family, which presentation
steps are admissible and which fields the family may write.
Verdicts are computed from the effect model and an invariant basis.
They are not stipulated.

Applicability is a fact about the effect model (`Applicable`): the family has
an effective instance somewhere in the presentation space. It does not depend on
which finite domain of presentations is examined later, so an applicable
family may have no instance in a particular domain.

Verdicts are mutually exclusive and exhaustive (`hasVerdict_unique`,
`hasVerdict_exists`):

  na   not applicable
  brk  applicable and every effective instance changes the invariant
  mix  some effective instance changes the invariant and some preserves it
  prs  applicable, no instance changes the invariant, and the family writes a
       supported field
  neu  applicable, no instance changes the invariant, and the family writes
       no supported field

`mix` is not a classification value. A family with this verdict is too
coarse and must be refined before it can be entered in a classification table.
-/

namespace SE.IdentityRegimes

@[expose] public section

variable {T C ι ν V V' : Type}

-- RR.DEFINES: SEIR.DEF.EFFECT_MODEL
/-- Admissible steps of each family, with the fields each family may write. -/
structure EffectModel (T : Type) {C ι ν : Type} (get : ι → C → ν) where
  /-- `step f x y`: `y` is an admissible result of applying `f` to `x`. -/
  step : T → C → C → Prop
  /-- The fields family `f` may write. -/
  writes : T → ι → Prop
  /-- A step changes only fields its family may write. -/
  bounded : ∀ f x y, step f x y → ∀ i, FieldChanges get i x y → writes f i

-- RR.DEFINES: SEIR.DEF.VERDICT
/-- The derived verdict of a family relative to a basis. -/
inductive Verdict where
  /-- Not applicable: the family has no effective instance. -/
  | na
  /-- Breaking: every effective instance changes the invariant. -/
  | brk
  /-- Mixed: some effective instance changes the invariant and some preserves
  it. -/
  | mix
  /-- Preserving: no instance changes the invariant, and the family writes a
  supported field. -/
  | prs
  /-- Neutral: no instance changes the invariant, and the family writes no
  supported field. -/
  | neu
deriving DecidableEq, Repr

namespace EffectModel

variable {get : ι → C → ν} (M : EffectModel T get)

-- RR.DEFINES: SEIR.DEF.EFFECTIVE_INSTANCE
/-- An admissible step that changes at least one field. -/
def Effective (f : T) (x y : C) : Prop :=
  M.step f x y ∧ ∃ i, FieldChanges get i x y

-- RR.DEFINES: SEIR.DEF.APPLICABLE
/-- Family `f` has an effective instance in the presentation space. -/
def Applicable (f : T) : Prop :=
  ∃ x y, M.Effective f x y

/-- Some effective instance of `f` changes the invariant of `b`. -/
def BreakingInstance (b : InvariantBasis get V) (f : T) : Prop :=
  ∃ x y, M.Effective f x y ∧ b.inv x ≠ b.inv y

/-- Some effective instance of `f` preserves the invariant of `b`. -/
def PreservingInstance (b : InvariantBasis get V) (f : T) : Prop :=
  ∃ x y, M.Effective f x y ∧ b.inv x = b.inv y

/-- Every effective instance of `f` changes the invariant of `b`. -/
def AllBreak (b : InvariantBasis get V) (f : T) : Prop :=
  ∀ x y, M.Effective f x y → b.inv x ≠ b.inv y

/-- No effective instance of `f` changes the invariant of `b`. -/
def NoneBreak (b : InvariantBasis get V) (f : T) : Prop :=
  ∀ x y, M.Effective f x y → b.inv x = b.inv y

/-- Some effective instance of `f` changes a field in the support of `b`. -/
def Engages (b : InvariantBasis get V) (f : T) : Prop :=
  ∃ x y, M.Effective f x y ∧ ∃ i, b.support i ∧ FieldChanges get i x y

-- RR.DEFINES: SEIR.DEF.HAS_VERDICT
/-- `v` is the verdict of family `f` for basis `b`. -/
def HasVerdict (b : InvariantBasis get V) (f : T) : Verdict → Prop
  | .na => ¬ M.Applicable f
  | .brk => M.Applicable f ∧ M.AllBreak b f
  | .mix => M.BreakingInstance b f ∧ M.PreservingInstance b f
  | .prs => M.Applicable f ∧ M.NoneBreak b f ∧ M.Engages b f
  | .neu => M.Applicable f ∧ M.NoneBreak b f ∧ ¬ M.Engages b f

variable {M} {b : InvariantBasis get V} {f : T}

/-- A breaking instance is an effective instance, so `f` is applicable. -/
theorem applicable_of_breakingInstance (h : M.BreakingInstance b f) :
    M.Applicable f :=
  match h with
  | ⟨x, y, hxy, _⟩ => ⟨x, y, hxy⟩

/-- A preserving instance is an effective instance, so `f` is applicable. -/
theorem applicable_of_preservingInstance (h : M.PreservingInstance b f) :
    M.Applicable f :=
  match h with
  | ⟨x, y, hxy, _⟩ => ⟨x, y, hxy⟩

/-- A breaking instance cannot exist if `f` has the `NoneBreak` property. -/
theorem not_breakingInstance_of_noneBreak (h : M.NoneBreak b f) :
    ¬ M.BreakingInstance b f :=
  fun ⟨x, y, hxy, hne⟩ => hne (h x y hxy)

/-- A preserving instance cannot exist if `f` has the `AllBreak` property. -/
theorem not_preservingInstance_of_allBreak (h : M.AllBreak b f) :
    ¬ M.PreservingInstance b f := by
  intro hP
  obtain ⟨x, y, hxy, heq⟩ := hP
  have hne : b.inv x ≠ b.inv y := h x y hxy
  exact hne heq

/-- A breaking instance exists if `f` has the `AllBreak` property and is applicable. -/
theorem breakingInstance_of_allBreak (hA : M.Applicable f)
    (h : M.AllBreak b f) : M.BreakingInstance b f :=
  match hA with
  | ⟨x, y, hxy⟩ => ⟨x, y, hxy, h x y hxy⟩

/-- A preserving instance exists if `f` has the `NoneBreak` property and is applicable. -/
theorem preservingInstance_of_noneBreak (hA : M.Applicable f)
    (h : M.NoneBreak b f) : M.PreservingInstance b f :=
  match hA with
  | ⟨x, y, hxy⟩ => ⟨x, y, hxy, h x y hxy⟩

-- RR.DEFINES: SEIR.THM.HAS_VERDICT_EXISTS
/-- Every family has a verdict. -/
theorem hasVerdict_exists (b : InvariantBasis get V) (f : T) :
    ∃ v, M.HasVerdict b f v := by
  by_cases hA : M.Applicable f
  · by_cases hB : M.BreakingInstance b f
    · by_cases hP : M.PreservingInstance b f
      · exact ⟨Verdict.mix, hB, hP⟩
      · refine ⟨Verdict.brk, hA, ?_⟩
        intro x y hxy heq
        exact hP ⟨x, y, hxy, heq⟩
    · have hN : M.NoneBreak b f := by
        intro x y hxy
        apply Classical.byContradiction
        intro hne
        exact hB ⟨x, y, hxy, hne⟩
      by_cases hE : M.Engages b f
      · exact ⟨Verdict.prs, hA, hN, hE⟩
      · exact ⟨Verdict.neu, hA, hN, hE⟩
  · exact ⟨Verdict.na, hA⟩

/-- Every verdict other than `na` entails applicability. -/
theorem applicable_of_hasVerdict {v : Verdict} (h : M.HasVerdict b f v)
    (hv : v ≠ Verdict.na) : M.Applicable f := by
  cases v with
  | na => exact absurd rfl hv
  | brk => exact h.1
  | mix => exact applicable_of_breakingInstance h.1
  | prs => exact h.1
  | neu => exact h.1

-- RR.DEFINES: SEIR.THM.HAS_VERDICT_UNIQUE
/-- Verdicts are mutually exclusive. -/
theorem hasVerdict_unique {v w : Verdict} (hv : M.HasVerdict b f v)
    (hw : M.HasVerdict b f w) : v = w := by
  cases v <;> cases w
  · rfl
  · exact absurd (applicable_of_hasVerdict hw (by decide)) hv
  · exact absurd (applicable_of_hasVerdict hw (by decide)) hv
  · exact absurd (applicable_of_hasVerdict hw (by decide)) hv
  · exact absurd (applicable_of_hasVerdict hw (by decide)) hv
  · exact absurd (applicable_of_hasVerdict hv (by decide)) hw
  · rfl
  · exact absurd hw.2 (not_preservingInstance_of_allBreak hv.2)
  · exact absurd (preservingInstance_of_noneBreak hv.1 hw.2.1)
      (not_preservingInstance_of_allBreak hv.2)
  · exact absurd (preservingInstance_of_noneBreak hv.1 hw.2.1)
      (not_preservingInstance_of_allBreak hv.2)
  · exact absurd (applicable_of_hasVerdict hv (by decide)) hw
  · exact absurd hv.2 (not_preservingInstance_of_allBreak hw.2)
  · rfl
  · exact absurd hv.1 (not_breakingInstance_of_noneBreak hw.2.1)
  · exact absurd hv.1 (not_breakingInstance_of_noneBreak hw.2.1)
  · exact absurd (applicable_of_hasVerdict hv (by decide)) hw
  · exact absurd (preservingInstance_of_noneBreak hw.1 hv.2.1)
      (not_preservingInstance_of_allBreak hw.2)
  · exact absurd hw.1 (not_breakingInstance_of_noneBreak hv.2.1)
  · rfl
  · exact absurd hv.2.2 hw.2.2
  · exact absurd (applicable_of_hasVerdict hv (by decide)) hw
  · exact absurd (preservingInstance_of_noneBreak hw.1 hv.2.1)
      (not_preservingInstance_of_allBreak hw.2)
  · exact absurd hw.1 (not_breakingInstance_of_noneBreak hv.2.1)
  · exact absurd hw.2.2 hv.2.2
  · rfl

-- RR.DEFINES: SEIR.THM.NONE_BREAK_OF_WRITES_OFF_SUPPORT
/-- A family that may write no supported field never changes the invariant. -/
theorem noneBreak_of_writes_off_support
    (h : ∀ i, M.writes f i → ¬ b.support i) : M.NoneBreak b f := by
  intro x y hxy
  apply b.inv_eq_of_off_support
  intro i hi
  exact h i (M.bounded f x y hxy.1 i hi)

/-- A family that may write no supported field does not engage the basis. -/
theorem not_engages_of_writes_off_support
    (h : ∀ i, M.writes f i → ¬ b.support i) : ¬ M.Engages b f := by
  intro hE
  obtain ⟨x, y, hxy, i, hs, hc⟩ := hE
  exact h i (M.bounded f x y hxy.1 i hc) hs

end EffectModel

end

end SE.IdentityRegimes
