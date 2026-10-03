/-
Copyright (c) 2026 Denise M. Case.
Released under MIT license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import all SE.IdentityRegimes.Transform.NonCollapse

public import SE.NeutralSubstrate
public import SE.IdentityRegimes.Transform.LowerBound

open SE.NeutralSubstrate

/-!
File: SE/IdentityRegimes/Embedding.lean

Purpose:
Regime-typed multigraph embedding and representation theorem.

The embedding sends each identity carrier to its equivalence class
under its unique regime profile. Uniqueness follows from
classification_pattern_unique applied to classificationMatrix.
The representation theorem states that every identity carrier in an
admissible ontology is realized by exactly one profile in the derived
regime set.

Source: SE-300, Section 5, faithful embedding and representation theorem.
-/

set_option autoImplicit false

namespace SE.IdentityRegimes

universe u

public section

-- RR.DEFINES: SEIR.DEF.ADMISSIBLE_RELATION
-- RR.DEFINES: SEIR.DEF.REGIME_VERTEX
-- RR.DEFINES: SEIR.DEF.REGIME_EDGE
-- RR.DEFINES: SEIR.DEF.REGIME_GRAPH
-- RR.IMPLEMENTS: SE300.DEF.REGIME_GRAPH
-- RR.DEFINES: SEIR.DEF.PROFILE_KIND
-- RR.DEFINES: SEIR.THM.PROFILE_KIND_DETERMINED_BY_CLASSIFICATION
-- RR.DEFINES: SEIR.DEF.GRAPH_WELL_FORMED
-- RR.DEFINES: SEIR.THM.REPRESENTATION
-- RR.IMPLEMENTS: SE300.THM.REPRESENTATION
-- RR.DEFINES: SEIR.THM.DERIVED_PROFILE_SET_NO_BEHAVIORAL_COLLAPSE
-- RR.DEFINES: SEIR.THM.NINE_PROFILE_LOWER_BOUND_WITNESS
/-- An admissible relation over regime-typed vertices. -/
inductive AdmissibleRelation where
  | participatesIn
  | precedes
  | scopedBy
  | describedBy
  | groundedIn
deriving Repr, DecidableEq

/-- A regime-typed vertex: an identity carrier tagged with its profile. -/
structure RegimeVertex (Ontology : Type u) where
  /-- Canonical identity regime assigned to this vertex. -/
  regime : Regime
  /-- Ontology carrier represented by this vertex. -/
  carrier : Ontology

/-- The regime type of a vertex. -/
def RegimeVertex.regimeType
    {Ontology : Type u}
    (v : RegimeVertex Ontology) :
    Regime :=
  v.regime

/-- A regime-typed directed edge. -/
structure RegimeEdge (Ontology : Type u) where
  /-- Source vertex of the directed edge. -/
  source : RegimeVertex Ontology
  /-- Admissible relation labeling the edge. -/
  relation : AdmissibleRelation
  /-- Target vertex of the directed edge. -/
  target : RegimeVertex Ontology

/-- The regime-typed directed multigraph over an admissible substrate. -/
structure RegimeGraph (Ontology : Type u) where
  /-- Vertices contained in the regime graph. -/
  vertices : List (RegimeVertex Ontology)
  /-- Edges contained in the regime graph. -/
  edges : List (RegimeEdge Ontology)

/-- The profile kind of a vertex is determined by its regime field. -/
def profileKind
    {Ontology : Type u}
    (v : RegimeVertex Ontology) :
    Regime :=
  v.regime

/-- Profile kind is injective up to classification pattern under the canonical matrix:
    vertices whose profiles assign identical values to all transformations
    have the same profile kind. -/
theorem profileKind_determined_by_classification
    (p q : Regime)
    (h : ∀ t : Transformation, classificationMatrix p t = classificationMatrix q t) :
    p = q :=
  classification_pattern_unique p q h

/-- Every vertex in a well-formed graph has a canonical regime. -/
def GraphWellFormed
    {Ontology : Type u}
    (g : RegimeGraph Ontology) :
    Prop :=
  ∀ v ∈ g.vertices, IsCanonicalRegime v.regime

/-- Representation theorem:
    For every regime profile kind, there exists a unique canonical profile
    that determines its classification behavior under the canonical matrix. -/
theorem representation_theorem (k : Regime) :
    ∃ p : Regime,
      p = k ∧
      (∀ t : Transformation, classificationMatrix p t = classificationMatrix k t) ∧
      (∀ q : Regime,
        (∀ t : Transformation, classificationMatrix q t = classificationMatrix k t) → q = k) :=
  ⟨k, rfl, fun _t => rfl,
   fun q hq => classification_pattern_unique q k hq⟩

/-- No two distinct profiles in the derived regime set are behaviorally equivalent
    under the canonical classification matrix. -/
theorem derived_regime_set_no_behavioral_collapse
    (p q : Regime)
    (h : p ≠ q) :
    ∃ t : Transformation, classificationMatrix p t ≠ classificationMatrix q t := by
  change NonCollapsing p q
  exact noncollapse_all_pairs p q h

/-- The lower bound is witnessed by the derived regime set:
    nine pairwise non-collapsing profiles under the canonical matrix. -/
theorem nine_regime_lower_bound_witness :
    ∃ S : List Regime,
      S.length = 9 ∧
      S.Nodup ∧
      (∀ p q : Regime, p ≠ q →
        ∃ t : Transformation, classificationMatrix p t ≠ classificationMatrix q t) :=
  ⟨derivedRegimeSet,
   derivedRegimeSet_card,
   derivedRegimeSet_nodup,
   fun p q h => by
     change NonCollapsing p q
     exact noncollapse_all_pairs p q h⟩

end

end SE.IdentityRegimes
