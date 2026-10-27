/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

public import SE.IdentityRegimes.Transform.StepIdentity

set_option autoImplicit false

/-!
File: SE/IdentityRegimes/Model/Fork.lean

Purpose:
Model of the BF split on plain referents, with branching represented
independently of identity.

A plain-referent presentation has three fields.

  locus   where the referent is
  obj     which object it is
  branch  which branch of the record the presentation belongs to

A fork moves a presentation to a different branch.
That is all the fork declares.
It says nothing about the locus or the object.
Whether a continuation stays at the locus, or is the same object,
is a separate claim.
This file states each such claim as a named warrant
(`Colocated`, `FreshObject`, `SameObject`) and
takes it as an explicit hypothesis of the theorems that use it.

  locus basis   the invariant is the locus
  object basis  the invariant is the object

Derived verdicts of BF:

  no warrant                    locus `mix`, object `mix`
  `Colocated` and `FreshObject` locus `neu`, object `brk`
  `Colocated` and `SameObject`  locus `neu`, object `neu`

The cell for the locus and object bases is therefore
determined by the warrants, not by the name BF.
The same fork is breaking or non-breaking for the object
basis according to which warrant holds.
-/

namespace SE.IdentityRegimes.Model.Fork

@[expose] public section

variable {Loc Obj Br : Type}

-- RR.DEFINES: SEIR.DEF.FORK_PRESENTATION
/-- A presentation of a plain referent: where it is, which object it is, and
which branch of the record it belongs to. -/
structure Plain (Loc Obj Br : Type) where
  /-- Where the referent is. -/
  locus : Loc
  /-- Which object the referent is. -/
  obj : Obj
  /-- Which branch of the record the presentation belongs to. -/
  branch : Br

/-- The three presentation fields. -/
inductive Fld where
  /-- The locus field. -/
  | locus
  /-- The object field. -/
  | obj
  /-- The branch field. -/
  | branch
deriving DecidableEq

/-- Field values: a locus, an object, or a branch. -/
inductive Val (Loc Obj Br : Type) where
  /-- A locus value. -/
  | locus (l : Loc)
  /-- An object value. -/
  | obj (o : Obj)
  /-- A branch value. -/
  | branch (b : Br)

/-- The value of a field. -/
abbrev get : Fld → Plain Loc Obj Br → Val Loc Obj Br
  | .locus, x => Val.locus x.locus
  | .obj, x => Val.obj x.obj
  | .branch, x => Val.branch x.branch

-- RR.DEFINES: SEIR.DEF.FORK_MODEL
/-- BF under a warrant `W`: a continuation belongs to a different branch and
satisfies `W`. The fork itself constrains neither the locus nor the object. -/
def forkModel (W : Plain Loc Obj Br → Plain Loc Obj Br → Prop) :
    EffectModel Unit (get (Loc := Loc) (Obj := Obj) (Br := Br)) where
  step _ x y := y.branch ≠ x.branch ∧ W x y
  writes _ _ := True
  bounded _ _ _ _ _ _ := trivial

-- RR.DEFINES: SEIR.DEF.FORK_NO_WARRANT
/-- No warrant: the fork is only a change of branch. -/
def NoWarrant (_ _ : Plain Loc Obj Br) : Prop :=
  True

-- RR.DEFINES: SEIR.DEF.FORK_COLOCATED
/-- Warrant: the continuation stays at the locus of the original. It holds when
a fork copies a record in place, and fails when a continuation is placed
elsewhere. -/
def Colocated (x y : Plain Loc Obj Br) : Prop :=
  y.locus = x.locus

-- RR.DEFINES: SEIR.DEF.FORK_FRESH_OBJECT
/-- Warrant: the continuation is a different object from the original. It holds
when a fork duplicates the object, such as copying a physical artifact, and
fails when the continuations are branches of one artifact. -/
def FreshObject (x y : Plain Loc Obj Br) : Prop :=
  y.obj ≠ x.obj

-- RR.DEFINES: SEIR.DEF.FORK_SAME_OBJECT
/-- Warrant: the continuation is the same object as the original. It holds when
the branches are versions of one artifact. -/
def SameObject (x y : Plain Loc Obj Br) : Prop :=
  y.obj = x.obj

-- RR.DEFINES: SEIR.DEF.FORK_LOCUS_BASIS
/-- Locus-fixed basis: the invariant is the locus. -/
def locusBasis : InvariantBasis (get (Loc := Loc) (Obj := Obj) (Br := Br)) Loc where
  inv x := x.locus
  support i := i = Fld.locus
  factors _ _ h := Val.locus.inj (h Fld.locus rfl)

-- RR.DEFINES: SEIR.DEF.FORK_OBJECT_BASIS
/-- Object-fixed basis: the invariant is the object. -/
def objectBasis : InvariantBasis (get (Loc := Loc) (Obj := Obj) (Br := Br)) Obj where
  inv x := x.obj
  support i := i = Fld.obj
  factors _ _ h := Val.obj.inj (h Fld.obj rfl)

/-- A fork whose branch differs has an effective instance. -/
theorem applicable_of_instance
    {W : Plain Loc Obj Br → Plain Loc Obj Br → Prop} {x y : Plain Loc Obj Br}
    (hb : y.branch ≠ x.branch) (hW : W x y) :
    (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) W).Applicable () :=
  ⟨x, y, ⟨hb, hW⟩, Fld.branch, fun h => hb (Val.branch.inj h).symm⟩

/-- If the warrant keeps the locus, no fork step changes the locus. -/
theorem locus_noneBreak
    {W : Plain Loc Obj Br → Plain Loc Obj Br → Prop}
    (hW : ∀ x y, W x y → y.locus = x.locus) :
    (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) W).NoneBreak locusBasis () :=
  fun x y hxy => (hW x y hxy.1.2).symm

/-- If the warrant keeps the locus, the fork writes no field the locus basis reads. -/
theorem locus_not_engages
    {W : Plain Loc Obj Br → Plain Loc Obj Br → Prop}
    (hW : ∀ x y, W x y → y.locus = x.locus) :
    ¬ (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) W).Engages locusBasis () := by
  rintro ⟨x, y, hxy, i, hs, hc⟩
  cases hs
  exact hc (congrArg Val.locus (hW x y hxy.1.2).symm)

/-- If the warrant gives a different object, every fork step changes the object. -/
theorem object_allBreak
    {W : Plain Loc Obj Br → Plain Loc Obj Br → Prop}
    (hW : ∀ x y, W x y → y.obj ≠ x.obj) :
    (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) W).AllBreak objectBasis () :=
  fun x y hxy e => hW x y hxy.1.2 e.symm

/-- If the warrant keeps the object, no fork step changes the object. -/
theorem object_noneBreak
    {W : Plain Loc Obj Br → Plain Loc Obj Br → Prop}
    (hW : ∀ x y, W x y → y.obj = x.obj) :
    (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) W).NoneBreak objectBasis () :=
  fun x y hxy => (hW x y hxy.1.2).symm

/-- If the warrant keeps the object, the fork writes no field the object basis reads. -/
theorem object_not_engages
    {W : Plain Loc Obj Br → Plain Loc Obj Br → Prop}
    (hW : ∀ x y, W x y → y.obj = x.obj) :
    ¬ (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) W).Engages objectBasis () := by
  rintro ⟨x, y, hxy, i, hs, hc⟩
  cases hs
  exact hc (congrArg Val.obj (hW x y hxy.1.2).symm)

-- RR.DEFINES: SEIR.THM.FORK_LOCUS_NEU_OF_COLOCATED
/-- Under the `Colocated` warrant the locus basis is neutral for BF. -/
theorem locus_neu_of_colocated
    {W : Plain Loc Obj Br → Plain Loc Obj Br → Prop}
    (hW : ∀ x y, W x y → Colocated x y)
    (happ : (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) W).Applicable ()) :
    (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) W).HasVerdict locusBasis () Verdict.neu :=
  ⟨happ, locus_noneBreak hW, locus_not_engages hW⟩

-- RR.DEFINES: SEIR.THM.FORK_OBJECT_BRK_OF_FRESH
/-- Under the `FreshObject` warrant the object basis is broken by BF. -/
theorem object_brk_of_fresh
    {W : Plain Loc Obj Br → Plain Loc Obj Br → Prop}
    (hW : ∀ x y, W x y → FreshObject x y)
    (happ : (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) W).Applicable ()) :
    (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) W).HasVerdict objectBasis () Verdict.brk :=
  ⟨happ, object_allBreak hW⟩

-- RR.DEFINES: SEIR.THM.FORK_OBJECT_NEU_OF_SAME
/-- Under the `SameObject` warrant the object basis is neutral for BF. -/
theorem object_neu_of_same
    {W : Plain Loc Obj Br → Plain Loc Obj Br → Prop}
    (hW : ∀ x y, W x y → SameObject x y)
    (happ : (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) W).Applicable ()) :
    (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) W).HasVerdict objectBasis () Verdict.neu :=
  ⟨happ, object_noneBreak hW, object_not_engages hW⟩

variable {l l' : Loc} {o o' : Obj} {b b' : Br}

-- RR.DEFINES: SEIR.THM.FORK_LOCUS_MINIMAL
/-- The locus support is justified: the locus can change the invariant on its own,
given two distinct loci. -/
theorem locusBasis_minimal (hl : l ≠ l') (o : Obj) (b : Br) :
    (locusBasis (Loc := Loc) (Obj := Obj) (Br := Br)).Minimal := by
  intro i hi
  cases hi
  refine ⟨⟨l, o, b⟩, ⟨l', o, b⟩, fun h => hl (Val.locus.inj h), ?_, hl⟩
  intro j hj
  cases j
  · exact absurd rfl hj
  · rfl
  · rfl

-- RR.DEFINES: SEIR.THM.FORK_OBJECT_MINIMAL
/-- The object support is justified: the object can change the invariant on its
own, given two distinct objects. -/
theorem objectBasis_minimal (ho : o ≠ o') (l : Loc) (b : Br) :
    (objectBasis (Loc := Loc) (Obj := Obj) (Br := Br)).Minimal := by
  intro i hi
  cases hi
  refine ⟨⟨l, o, b⟩, ⟨l, o', b⟩, fun h => ho (Val.obj.inj h), ?_, ho⟩
  intro j hj
  cases j
  · rfl
  · exact absurd rfl hj
  · rfl

-- RR.DEFINES: SEIR.THM.FORK_LOCUS_MIX_WITHOUT_WARRANT
/-- Without a warrant, BF has verdict `mix` for the locus basis: a continuation
can move and it can stay. -/
theorem locus_mix_without_warrant (hl : l ≠ l') (hb : b ≠ b') (o : Obj) :
    (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) NoWarrant).HasVerdict
      locusBasis () Verdict.mix :=
  ⟨⟨⟨l, o, b⟩, ⟨l', o, b'⟩,
      ⟨⟨hb.symm, trivial⟩, Fld.branch, fun h => hb (Val.branch.inj h)⟩, hl⟩,
    ⟨⟨l, o, b⟩, ⟨l, o, b'⟩,
      ⟨⟨hb.symm, trivial⟩, Fld.branch, fun h => hb (Val.branch.inj h)⟩, rfl⟩⟩

-- RR.DEFINES: SEIR.THM.FORK_OBJECT_MIX_WITHOUT_WARRANT
/-- Without a warrant, BF has verdict `mix` for the object basis: a continuation
can be a different object and it can be the same object. -/
theorem object_mix_without_warrant (ho : o ≠ o') (hb : b ≠ b') (l : Loc) :
    (forkModel (Loc := Loc) (Obj := Obj) (Br := Br) NoWarrant).HasVerdict
      objectBasis () Verdict.mix :=
  ⟨⟨⟨l, o, b⟩, ⟨l, o', b'⟩,
      ⟨⟨hb.symm, trivial⟩, Fld.branch, fun h => hb (Val.branch.inj h)⟩, ho⟩,
    ⟨⟨l, o, b⟩, ⟨l, o, b'⟩,
      ⟨⟨hb.symm, trivial⟩, Fld.branch, fun h => hb (Val.branch.inj h)⟩, rfl⟩⟩

/-- The two presentations before and after a fork. -/
def forkDomain (l : Loc) (o o' : Obj) (b b' : Br) : Plain Loc Obj Br → Prop :=
  fun x => x = ⟨l, o, b⟩ ∨ x = ⟨l, o', b'⟩

-- RR.DEFINES: SEIR.THM.FORK_SEPARATES_UNDER_WARRANTS
/-- Under `Colocated` and `FreshObject`, a domain containing the fork separates
the locus and object bases. -/
theorem separates_under_warrants (hb : b ≠ b') (ho : o ≠ o') (l : Loc) :
    ¬ (forkModel (Loc := Loc) (Obj := Obj) (Br := Br)
        (fun x y => Colocated x y ∧ FreshObject x y)).Collapse
      locusBasis objectBasis (forkDomain l o o' b b') :=
  EffectModel.not_collapse_of_step (f := ()) (x := ⟨l, o, b⟩) (y := ⟨l, o', b'⟩)
    (Or.inl rfl) (Or.inr rfl) ⟨hb.symm, rfl, fun h => ho h.symm⟩ rfl ho

-- RR.DEFINES: SEIR.THM.FORK_COLLAPSES_UNDER_SAME_OBJECT
/-- Under `Colocated` and `SameObject`, the locus and object bases collapse on
every domain. -/
theorem collapses_under_same_object (D : Plain Loc Obj Br → Prop) :
    (forkModel (Loc := Loc) (Obj := Obj) (Br := Br)
        (fun x y => Colocated x y ∧ SameObject x y)).Collapse
      locusBasis objectBasis D := by
  rw [EffectModel.collapse_iff_stepAgree]
  intro _ x y _ _ hs
  exact ⟨fun _ => hs.2.2.symm, fun _ => hs.2.1.symm⟩

end

end SE.IdentityRegimes.Model.Fork
