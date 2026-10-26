/-
Copyright (c) 2026 Denise M. Case. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

set_option autoImplicit false

/-!
File: SE/IdentityRegimes/Profile/Invariant.lean

Purpose:
Invariant-defined identity bases and their justified supports.

A presentation space is a type `C` of presentations with named fields
`get : ι → C → ν`. An identity basis is a function `inv : C → V` of
presentations together with the fields it reads (its support).

A basis is not stipulated through its classifications. Classifications are
computed from the basis and the transformation model
(see `Transform/Effect.lean`).

Scope:
This file fixes no carrier kind, no transformation family and no
classification. It states only what it means for a basis to read a set of fields.
-/

namespace SE.IdentityRegimes

@[expose] public section

variable {C ι ν V : Type}

-- RR.DEFINES: SEIR.DEF.FIELD_CHANGES
/-- Field `i` takes different values at `x` and `y`. -/
def FieldChanges (get : ι → C → ν) (i : ι) (x y : C) : Prop :=
  get i x ≠ get i y

-- RR.DEFINES: SEIR.DEF.INVARIANT_BASIS
/-- An invariant-defined identity basis.

`inv` is the identity invariant. `support` is the set of fields it reads.
`factors` says `inv` depends on presentations only through `support`. -/
structure InvariantBasis (get : ι → C → ν) (V : Type) where
  /-- The identity invariant: presentations are the same on this basis when
  their invariants agree. -/
  inv : C → V
  /-- The fields the invariant reads. -/
  support : ι → Prop
  /-- Presentations that agree on the support have equal invariants. -/
  factors : ∀ x y, (∀ i, support i → get i x = get i y) → inv x = inv y

-- RR.DEFINES: SEIR.DEF.SUPPORT_MINIMAL
/-- The support is justified when no supported field is idle: each supported
field `i` has two presentations that agree on every other field and have
different invariants. -/
def InvariantBasis.Minimal {get : ι → C → ν} (b : InvariantBasis get V) : Prop :=
  ∀ i, b.support i →
    ∃ x y, FieldChanges get i x y ∧
      (∀ j, j ≠ i → get j x = get j y) ∧ b.inv x ≠ b.inv y

-- RR.DEFINES: SEIR.THM.INV_EQ_OF_OFF_SUPPORT
/-- A change that touches no supported field preserves the invariant. -/
theorem InvariantBasis.inv_eq_of_off_support {get : ι → C → ν}
    (b : InvariantBasis get V) {x y : C}
    (h : ∀ i, FieldChanges get i x y → ¬ b.support i) :
    b.inv x = b.inv y := by
  apply b.factors
  intro i hi
  apply Classical.byContradiction
  intro hne
  exact h i hne hi

end

end SE.IdentityRegimes
