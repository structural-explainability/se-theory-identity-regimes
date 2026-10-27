/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import all SE.IdentityRegimes.Transform.Core
import all SE.IdentityRegimes.Reference.Core
import all SE.IdentityRegimes.Reference.ClassificationMatrix

public import SE.IdentityRegimes.Transform.Core
public import SE.IdentityRegimes.Reference.ClassificationMatrix
public import SE.IdentityRegimes.Model.ScopeEntries
public import SE.IdentityRegimes.Model.RuleEntries
public import SE.IdentityRegimes.Model.Fork

set_option autoImplicit false

/-!
File: SE/IdentityRegimes/Reference/DerivedMatrix.lean

Purpose:
The derived classification matrix, kept beside the stipulated one.

A derived cell is a presentation space, an effect model of one family, an
invariant basis with a justified (minimal) support, and
a proof of the verdict the model gives.
A cell exists only where such a model has been written.
Every other cell is `none` in `derivedVerdict`: not yet derived.
Verdicts are certified by the model's effect on the invariant basis.
Model and warrant selections remain explicit assumptions.

Derived cells (field-level models, two distinct cases, objects and branches):

  CTX_E x AD  `neu`   scope, extension basis, coverage-preserving AD
  CTX_S x AD  `brk`   scope, structure basis
  NOR_C x RF  `neu`   rule, content basis, norm-preserving RF
  NOR_S x RF  `brk`   rule, structure basis
  ENR_L x BF  `neu`   fork under the colocated and fresh-object warrants
  ENR_I x BF  `brk`   fork under the same warrants

The stipulated matrix enters `prs` for the three `neu` cells. The derived and
stipulated matrices agree on which cells are breaking
(`derived_agrees_on_breaking`). They differ on `prs` against `neu`, which depends
on the granularity of the presentation fields. Both are non-breaking.

The cells for ENR_L and ENR_I hold under the warrants named in `Model/Fork.lean`.
Without a warrant BF has verdict `mix` for both bases.
-/

namespace SE.IdentityRegimes

@[expose] public section

open SE.IdentityRegimes.Model

-- RR.DEFINES: SEIR.DEF.DERIVED_CELL
/-- A derived cell: an effect model of one family, an invariant basis, and a
proof of the verdict the model gives. -/
structure DerivedCell where
  /-- The presentations. -/
  Pres : Type
  /-- The field names. -/
  Fld : Type
  /-- The field values. -/
  Val : Type
  /-- The invariant values. -/
  Inv : Type
  /-- The value of a field. -/
  get : Fld → Pres → Val
  /-- The effect model of the family. -/
  model : EffectModel Unit get
  /-- The invariant basis of the regime. -/
  basis : InvariantBasis get Inv
  /-- The support of the basis is justified: each supported field can change the
  invariant on its own. -/
  minimal : basis.Minimal
  /-- The derived verdict. -/
  verdict : Verdict
  /-- The proof that the model gives this verdict. -/
  certificate : model.HasVerdict basis () verdict

-- RR.DEFINES: SEIR.DEF.VERDICT_TO_VALUE
/-- The classification value of a verdict, where it has one.
`na` and `mix` have none: `na` is the absence of a value and
`mix` is not a classification value.
This projection loses information; `derivedVerdict` keeps the full verdict. -/
def Verdict.toValue : Verdict → Option ClassificationValue
  | .na => none
  | .brk => some .brk
  | .mix => none
  | .prs => some .prs
  | .neu => some .ign

/-- CTX_E x AD: strict AD, extension basis, one field per pair of cases. -/
def ctxEAD : DerivedCell where
  Pres := Scope.Scope Nat
  Fld := Nat × Nat
  Val := Prop
  Inv := Nat → Prop
  get := ScopeEntries.get
  model := ScopeEntries.strictModel
  basis := ScopeEntries.extensionBasis
  minimal := ScopeEntries.extensionBasis_minimal
  verdict := .neu
  certificate := ScopeEntries.strict_extension_neu (a := 0) (b := 1) (by decide)

/-- CTX_S x AD: strict AD, structure basis, one field per pair of cases. -/
def ctxSAD : DerivedCell where
  Pres := Scope.Scope Nat
  Fld := Nat × Nat
  Val := Prop
  Inv := Scope.Scope Nat
  get := ScopeEntries.get
  model := ScopeEntries.strictModel
  basis := ScopeEntries.structureBasis
  minimal := ScopeEntries.structureBasis_minimal
  verdict := .brk
  certificate := ScopeEntries.strict_structure_brk (a := 0) (b := 1) (by decide)

/-- NOR_C x RF: strict RF, content basis, fields for pairs and norms. -/
def norCRF : DerivedCell where
  Pres := Rule.Rule Nat Bool
  Fld := (Nat × Nat) ⊕ Nat
  Val := Prop ⊕ Bool
  Inv := Nat → Bool → Prop
  get := RuleEntries.get
  model := RuleEntries.strictModel
  basis := RuleEntries.contentBasis
  minimal := RuleEntries.contentBasis_minimal (n := false) (n' := true) (by decide)
  verdict := .neu
  certificate := RuleEntries.strict_content_neu (a := 0) (b := 1) (by decide) false

/-- NOR_S x RF: strict RF, structure basis, fields for pairs and norms. -/
def norSRF : DerivedCell where
  Pres := Rule.Rule Nat Bool
  Fld := (Nat × Nat) ⊕ Nat
  Val := Prop ⊕ Bool
  Inv := Scope.Scope Nat
  get := RuleEntries.get
  model := RuleEntries.strictModel
  basis := RuleEntries.structureBasis
  minimal := RuleEntries.structureBasis_minimal false
  verdict := .brk
  certificate := RuleEntries.strict_structure_brk (a := 0) (b := 1) (by decide) false

/-- The fork step from `⟨0, 0, 0⟩` to `⟨0, 1, 1⟩` satisfies both warrants. -/
theorem fork_warrants_applicable :
    (Fork.forkModel (Loc := Nat) (Obj := Nat) (Br := Nat)
      (fun x y => Fork.Colocated x y ∧ Fork.FreshObject x y)).Applicable () :=
  Fork.applicable_of_instance (x := ⟨0, 0, 0⟩) (y := ⟨0, 1, 1⟩)
    (by decide) ⟨rfl, (by decide : (1 : Nat) ≠ 0)⟩

/-- ENR_L x BF: fork under the colocated and fresh-object warrants, locus basis. -/
def enrLBF : DerivedCell where
  Pres := Fork.Plain Nat Nat Nat
  Fld := Fork.Fld
  Val := Fork.Val Nat Nat Nat
  Inv := Nat
  get := Fork.get
  model := Fork.forkModel (fun x y => Fork.Colocated x y ∧ Fork.FreshObject x y)
  basis := Fork.locusBasis
  minimal := Fork.locusBasis_minimal (l := 0) (l' := 1) (by decide) 0 0
  verdict := .neu
  certificate :=
    Fork.locus_neu_of_colocated (fun _ _ h => h.1) fork_warrants_applicable

/-- ENR_I x BF: fork under the colocated and fresh-object warrants, object basis. -/
def enrIBF : DerivedCell where
  Pres := Fork.Plain Nat Nat Nat
  Fld := Fork.Fld
  Val := Fork.Val Nat Nat Nat
  Inv := Nat
  get := Fork.get
  model := Fork.forkModel (fun x y => Fork.Colocated x y ∧ Fork.FreshObject x y)
  basis := Fork.objectBasis
  minimal := Fork.objectBasis_minimal (o := 0) (o' := 1) (by decide) 0 0
  verdict := .brk
  certificate :=
    Fork.object_brk_of_fresh (fun _ _ h => h.2) fork_warrants_applicable

-- RR.DEFINES: SEIR.DEF.DERIVED_MATRIX
/-- The derived classification matrix. `none` means no model has been written for
the cell. -/
def derivedMatrix : Regime → Transformation → Option DerivedCell
  | .CTX_E, .AD => some ctxEAD
  | .CTX_S, .AD => some ctxSAD
  | .NOR_C, .RF => some norCRF
  | .NOR_S, .RF => some norSRF
  | .ENR_L, .BF => some enrLBF
  | .ENR_I, .BF => some enrIBF
  | _, _ => none

-- RR.DEFINES: SEIR.DEF.DERIVED_VERDICT
/-- The full derived verdict of a cell. `none` means no model has been written for
the cell. `some .na` and `some .mix` are modeled results. -/
def derivedVerdict (p : Regime) (t : Transformation) : Option Verdict :=
  (derivedMatrix p t).map fun c => c.verdict

-- RR.DEFINES: SEIR.DEF.DERIVED_VALUE
/-- The classification value of a derived cell, where there is one. It is `none`
for a cell with no model and for a modeled cell whose verdict is `na` or `mix`. -/
def derivedValue (p : Regime) (t : Transformation) : Option ClassificationValue :=
  (derivedVerdict p t).bind Verdict.toValue

/-- A cell is derived. -/
def IsDerived (p : Regime) (t : Transformation) : Bool :=
  (derivedVerdict p t).isSome

-- RR.DEFINES: SEIR.THM.DERIVED_VERDICT_CELLS
/-- The derived verdicts of the six modeled cells. -/
theorem derivedVerdict_cells :
    derivedVerdict .CTX_E .AD = some .neu ∧
    derivedVerdict .CTX_S .AD = some .brk ∧
    derivedVerdict .NOR_C .RF = some .neu ∧
    derivedVerdict .NOR_S .RF = some .brk ∧
    derivedVerdict .ENR_L .BF = some .neu ∧
    derivedVerdict .ENR_I .BF = some .brk := by
  decide

/-- The derived and stipulated cells agree on whether the cell is breaking. -/
def agreesOnBreaking (p : Regime) (t : Transformation) : Bool :=
  match derivedValue p t with
  | none => true
  | some v => (v == .brk) == (classificationMatrix p t == .brk)

-- RR.DEFINES: SEIR.THM.DERIVED_AGREES_ON_BREAKING
/-- Wherever a cell is derived, it is breaking exactly when the stipulated cell is
breaking. -/
theorem derived_agrees_on_breaking (p : Regime) (t : Transformation) :
    agreesOnBreaking p t = true := by
  cases p <;> cases t <;> decide

-- RR.DEFINES: SEIR.THM.DERIVED_CELL_COUNT
/-- Six of the ninety cells are derived. -/
theorem derivedCell_count :
    (allCells.filter fun c => IsDerived c.1 c.2).length = 6 := by
  decide

-- RR.DEFINES: SEIR.THM.DERIVED_PRS_NEU_DIFFERENCES
/-- The three derived `neu` cells are `prs` in the stipulated matrix. -/
theorem derived_neu_cells_are_stipulated_prs :
    (derivedValue .CTX_E .AD = some .ign ∧ classificationMatrix .CTX_E .AD = .prs) ∧
    (derivedValue .NOR_C .RF = some .ign ∧ classificationMatrix .NOR_C .RF = .prs) ∧
    (derivedValue .ENR_L .BF = some .ign ∧ classificationMatrix .ENR_L .BF = .prs) := by
  decide

-- RR.DEFINES: SEIR.THM.DERIVED_BRK_CELLS_EQUAL_STIPULATED
/-- The three derived `brk` cells equal the stipulated cells. -/
theorem derived_brk_cells_equal_stipulated :
    (derivedValue .CTX_S .AD = some (classificationMatrix .CTX_S .AD)) ∧
    (derivedValue .NOR_S .RF = some (classificationMatrix .NOR_S .RF)) ∧
    (derivedValue .ENR_I .BF = some (classificationMatrix .ENR_I .BF)) := by
  decide

end

end SE.IdentityRegimes
