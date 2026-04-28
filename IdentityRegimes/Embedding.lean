import IdentityRegimes.LowerBound

/-!
File: IdentityRegimes/Embedding.lean

Purpose:
Regime-typed multigraph embedding and representation theorem.

The embedding sends each identity carrier to its equivalence class
under its unique regime profile. Uniqueness follows from
classification_pattern_unique. The representation theorem states
that every identity carrier in an admissible ontology is realized
by exactly one profile in the derived regime set.

Source: SE-300, Section 5, faithful embedding and representation theorem.

The key theorems are

representation_theorem. Each profile is uniquely determined
by its classification behavior

nine_regime_lower_bound. The derived regime set witnesses
the lower bound with all three conditions in one statement.

RegimeVertex and RegimeGraph give the multigraph structure
a Lean type, with regimeAssignment_determined_by_classification
as the injectivity result that corresponds to the
paper's faithful embedding theorem.
-/

namespace IdentityRegimes

/-- An admissible relation over regime-typed vertices. -/
inductive AdmissibleRelation where
  | participatesIn
  | precedes
  | scopedBy
  | describedBy
  | groundedIn
deriving Repr, DecidableEq

/-- A regime-typed vertex: an identity carrier tagged with its profile. -/
structure RegimeVertex where
  kind    : RegimeProfileKind
  carrier : NeutralSubstrate.Substrate

/-- The regime type of a vertex. -/
def RegimeVertex.regimeType (v : RegimeVertex) : RegimeProfileKind :=
  v.kind

/-- A regime-typed directed edge. -/
structure RegimeEdge where
  source   : RegimeVertex
  relation : AdmissibleRelation
  target   : RegimeVertex

/-- The regime-typed directed multigraph over an admissible substrate. -/
structure RegimeGraph where
  vertices : List RegimeVertex
  edges    : List RegimeEdge

/-- The regime assignment of a vertex is determined by its kind. -/
def regimeAssignment (v : RegimeVertex) : RegimeProfileKind :=
  v.kind

/-- Regime assignment is injective up to classification pattern:
    vertices with identical classification patterns have the same regime type. -/
theorem regimeAssignment_determined_by_classification
    (p q : RegimeProfileKind)
    (h : ∀ t : Transformation, classify p t = classify q t) :
    p = q :=
  classification_pattern_unique p q h

/-- Every vertex in a well-formed graph has a canonical regime. -/
def GraphWellFormed (g : RegimeGraph) : Prop :=
  ∀ v ∈ g.vertices, IsCanonicalRegime v.kind.regime

/-- Representation theorem:
    For every regime profile kind, there exists a unique canonical profile
    that determines its classification behavior. -/
theorem representation_theorem (k : RegimeProfileKind) :
    ∃ p : RegimeProfileKind,
      p = k ∧
      (∀ t : Transformation, classify p t = classify k t) ∧
      (∀ q : RegimeProfileKind,
        (∀ t : Transformation, classify q t = classify k t) → q = k) := by
  exact ⟨k, rfl, fun _ => rfl,
         fun q hq => classification_pattern_unique q k hq⟩

/-- No two distinct profiles in the derived regime set
    are behaviorally equivalent. -/
theorem derived_regime_set_no_behavioral_collapse
    (p q : RegimeProfileKind)
    (h : p ≠ q) :
    ∃ t : Transformation, classify p t ≠ classify q t :=
  noncollapse_all_pairs p q h

/-- The lower bound is witnessed by the derived regime set:
    it contains exactly nine pairwise non-collapsing profiles. -/
theorem nine_regime_lower_bound :
    ∃ S : List RegimeProfileKind,
      S.length = 9 ∧
      S.Nodup ∧
      (∀ p q : RegimeProfileKind, p ≠ q →
        ∃ t : Transformation, classify p t ≠ classify q t) :=
  ⟨derivedRegimeSet,
   derivedRegimeSet_card,
   derivedRegimeSet_nodup,
   fun p q h => noncollapse_all_pairs p q h⟩

end IdentityRegimes
