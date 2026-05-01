import IdentityRegimes.Profiles
import IdentityRegimes.Transformations


/-!
File: IdentityRegimes/NonCollapse.lean

Purpose:
Non-collapse proofs for the derived regime profiles.

Two profiles are non-collapsing when they classify some transformation
differently, inducing distinct equivalence relations on the representation
space. Non-collapse is established in two stages:

  THM pairs: profiles sharing a parent regime, separated by split theorems.
  GEN-CAR pairs: profiles with distinct parent regimes, separated by
                 difference in identity carrier.

Source: SE-300, Section 5, pairwise non-collapse matrices.
-/

namespace IdentityRegimes

/-- Two profiles are non-collapsing if they classify some
    transformation differently. -/
def NonCollapsing (p q : RegimeProfileKind) : Prop :=
  ∃ t : Transformation, classify p t ≠ classify q t

-- ============================================================
-- THM pairs: separated by split theorems
-- ============================================================

/-- ENR_L and ENR_I are non-collapsing: they classify BF differently. -/
theorem noncollapse_ENR_L_ENR_I : NonCollapsing .ENR_L .ENR_I :=
  ⟨.BF, by decide⟩

/-- CTX_E and CTX_S are non-collapsing: they classify AD differently. -/
theorem noncollapse_CTX_E_CTX_S : NonCollapsing .CTX_E .CTX_S :=
  ⟨.AD, by decide⟩

/-- NOR_C and NOR_S are non-collapsing: they classify RF differently. -/
theorem noncollapse_NOR_C_NOR_S : NonCollapsing .NOR_C .NOR_S :=
  ⟨.RF, by decide⟩

-- ============================================================
-- GEN-CAR pairs: separated by distinct parent regimes
-- ============================================================

/-- Profiles with distinct parent regimes are non-collapsing. Order matters. -/
theorem noncollapse_of_distinct_regime
    (p q : RegimeProfileKind)
    (h : p.regime ≠ q.regime) :
    NonCollapsing p q := by
  cases p <;> cases q <;>
    simp_all [RegimeProfileKind.regime] <;>
    first
    | exact ⟨.BF, by decide⟩
    | exact ⟨.AD, by decide⟩
    | exact ⟨.SE, by decide⟩
    | exact ⟨.AN, by decide⟩
    | exact ⟨.RC, by decide⟩

/-- All 36 pairs in the derived regime set are non-collapsing. Order matters. -/
theorem noncollapse_all_pairs
    (p q : RegimeProfileKind)
    (h : p ≠ q) :
    NonCollapsing p q := by
  cases p <;> cases q <;> simp_all <;>
    first
    | exact ⟨.BF, by decide⟩
    | exact ⟨.AD, by decide⟩
    | exact ⟨.RF, by decide⟩
    | exact ⟨.SE, by decide⟩
    | exact ⟨.AN, by decide⟩
    | exact ⟨.RC, by decide⟩
    | exact ⟨.PV, by decide⟩
    | exact ⟨.RA, by decide⟩
    | exact ⟨.RE, by decide⟩

end IdentityRegimes
