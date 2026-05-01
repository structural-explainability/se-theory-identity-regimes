import IdentityRegimes.Basic
import IdentityRegimes.Regimes
import IdentityRegimes.Requirements
import IdentityRegimes.Profiles
import IdentityRegimes.Admissibility
import IdentityRegimes.Transformations
import IdentityRegimes.LowerBound
import IdentityRegimes.NonCollapse
import IdentityRegimes.Theorems

/-!
# Identity Regimes Surface

Curated public surface for downstream Structural Explainability regime users.

Downstream users should write:

```lean
import IdentityRegimes
open IdentityRegimes
```
This file is the public boundary. Internal files may be reorganized without
changing downstream code, provided the names exported here remain stable.
-/

-- ============================================================
-- TYPES
-- ============================================================

export IdentityRegimes (Regime)
export IdentityRegimes (RegimeProfile)
export IdentityRegimes (RegimeProfileKind)
export IdentityRegimes (Requirement)
export IdentityRegimes (Transformation)
export IdentityRegimes (TransformationClassification)

-- ============================================================
-- PREDICATES (PROPOSITIONS)
-- ============================================================

export IdentityRegimes (IsCanonicalRegime)
export IdentityRegimes (NonCollapsing)
export IdentityRegimes (ProfileWellFormed)
export IdentityRegimes (RequirementSatisfied)
export IdentityRegimes (RegimeApplicationAdmissible)

-- ============================================================
-- CLASSIFICATION / TRANSFORMATION VOCABULARY
-- ============================================================

export IdentityRegimes (classify)         -- core function (semantics)
export IdentityRegimes (derivedRegimeSet) -- canonical data domain
export IdentityRegimes (IsPreserving)     -- derived classifier view
export IdentityRegimes (IsBreaking)       -- derived classifier view

-- ============================================================
-- THEOREMS
-- ============================================================

export IdentityRegimes (all_regimes_canonical)
export IdentityRegimes (classification_pattern_unique)
export IdentityRegimes (derivedRegimeSet_card)
export IdentityRegimes (derivedRegimeSet_nodup)
export IdentityRegimes (nine_regime_lower_bound)
export IdentityRegimes (regime_application_admissible_of_neutral)
