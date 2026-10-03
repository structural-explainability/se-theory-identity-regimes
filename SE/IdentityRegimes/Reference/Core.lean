/-
Copyright (c) 2026 Denise M. Case.
Released under MIT license as described in the file LICENSE.
Authors: Denise M. Case
-/
module

import all SE.IdentityRegimes.Vocab.Regimes
import all SE.IdentityRegimes.Vocab.TransformBasis
public import SE.IdentityRegimes.Transform.LowerBound

/-!
File: SE/IdentityRegimes/Reference/Core.lean

Purpose:
Lean-side certification that the canonical reference sets are complete,
duplicate-free, and aligned with the derived theory.

ClassificationValue is defined in Transform/Core and available here
transitively via Transform/LowerBound.

TOML sources:
  regime-classification-values.toml  → referenceClassificationValues
  regime-families.toml               → RegimeFamily / referenceFamilies
  regime-profiles.toml               → referenceProfiles
  regime-profile-derivation.toml     → profilesForFamily / derivedProfilesFromFamilies
  regime-transformations.toml        → referenceTransformations

Note on ordering:
  regime-families.toml orders families as OBL NOR OCC CTX REC ENR.
  regime-profiles.toml orders profiles by its own `order` field (OBL OCC REC ENR_L …).
  These orderings differ; cross-list theorems assert membership equivalence, not list equality.
-/

set_option autoImplicit false

namespace SE.IdentityRegimes

public section

/- === Classification Values (regime-classification-values.toml) === -/

-- ClassificationValue is defined in Transform/Core.
-- referenceClassificationValues certifies the canonical three-value set.
-- RR.DEFINES: SEIR.DEF.REFERENCE_CLASSIFICATION_VALUES
/-- Reference enumeration of the canonical classification values. -/
def referenceClassificationValues : List ClassificationValue :=
  [.IGN, .PRS, .BRK]

-- RR.DEFINES: SEIR.THM.REFERENCE_CLASSIFICATION_VALUES_CARD
/-- The reference classification-value list has the expected cardinality. -/
theorem referenceClassificationValues_card :
    referenceClassificationValues.length = 3 := by
  decide

-- RR.DEFINES: SEIR.THM.REFERENCE_CLASSIFICATION_VALUES_NODUP
/-- The reference classification-value list contains no duplicates. -/
theorem referenceClassificationValues_nodup :
    List.Nodup referenceClassificationValues := by
  decide

-- RR.DEFINES: SEIR.THM.REFERENCE_CLASSIFICATION_VALUES_COMPLETE
/-- Every canonical classification value occurs in the reference list. -/
theorem referenceClassificationValues_complete
    (v : ClassificationValue) :
    v ∈ referenceClassificationValues := by
  cases v <;> decide

-- Order matches declaration order in regime-families.toml.
-- RR.DEFINES: SEIR.DEF.REFERENCE_FAMILIES
/-- Reference enumeration of the six identity-regime families. -/
def referenceFamilies : List RegimeFamily :=
  [.OBL, .NOR, .OCC, .CTX, .REC, .ENR]

-- RR.DEFINES: SEIR.THM.REFERENCE_FAMILIES_CARD
/-- The reference family list contains six families. -/
theorem referenceFamilies_card :
    referenceFamilies.length = 6 := by
  decide

-- RR.DEFINES: SEIR.THM.REFERENCE_FAMILIES_NODUP
/-- The reference family list contains no duplicates. -/
theorem referenceFamilies_nodup :
    List.Nodup referenceFamilies := by
  decide

-- RR.DEFINES: SEIR.THM.REFERENCE_FAMILIES_COMPLETE
/-- Every identity-regime family occurs in the reference family list. -/
theorem referenceFamilies_complete
    (f : RegimeFamily) :
    f ∈ referenceFamilies := by
  cases f <;> decide

/- === Regime Profiles (regime-profiles.toml) === -/

-- Order matches the `order` field in regime-profiles.toml:
-- OBL(1) OCC(2) REC(3) ENR_L(4) ENR_I(5) CTX_E(6) CTX_S(7) NOR_C(8) NOR_S(9)
-- RR.DEFINES: SEIR.DEF.REFERENCE_PROFILES
/-- Reference enumeration of the nine canonical identity regimes. -/
def referenceProfiles : List Regime :=
  [.OBL, .OCC, .REC, .ENR_L, .ENR_I, .CTX_E, .CTX_S, .NOR_C, .NOR_S]

-- RR.DEFINES: SEIR.THM.REFERENCE_PROFILES_CARD
/-- The reference profile list contains nine canonical regimes. -/
theorem referenceProfiles_card :
    referenceProfiles.length = 9 := by
  decide

-- RR.DEFINES: SEIR.THM.REFERENCE_PROFILES_NODUP
/-- The reference profile list contains no duplicates. -/
theorem referenceProfiles_nodup :
    List.Nodup referenceProfiles := by
  decide

-- RR.DEFINES: SEIR.THM.REFERENCE_PROFILES_COMPLETE
/-- Every canonical regime occurs in the reference profile list. -/
theorem referenceProfiles_complete
    (p : Regime) :
    p ∈ referenceProfiles := by
  cases p <;> decide

-- Membership-based alignment with derived theory (ordering differs from derivedRegimeSet).
-- RR.DEFINES: SEIR.THM.REFERENCE_PROFILES_MATCH_DERIVED
/-- Reference profiles and the derived regime set have the same membership. -/
theorem referenceProfiles_match_derived
    (p : Regime) :
    p ∈ referenceProfiles ↔ p ∈ derivedRegimeSet := by
  constructor
  · intro _
    exact derivedRegimeSet_complete p
  · intro _
    exact referenceProfiles_complete p

/- === Profile Derivation (regime-profile-derivation.toml) === -/

-- Mirrors the `profiles` arrays in regime-profile-derivation.toml exactly.
-- split = false: OBL, OCC, REC
-- split = true:  ENR → [ENR_L, ENR_I], CTX → [CTX_E, CTX_S], NOR → [NOR_C, NOR_S]
-- RR.DEFINES: SEIR.DEF.PROFILES_FOR_FAMILY
/-- Return the canonical regimes derived from a regime family. -/
def profilesForFamily : RegimeFamily → List Regime
  | .OBL => [.OBL]
  | .NOR => [.NOR_C, .NOR_S]
  | .OCC => [.OCC]
  | .CTX => [.CTX_E, .CTX_S]
  | .REC => [.REC]
  | .ENR => [.ENR_L, .ENR_I]

-- flatMap over referenceFamilies (family-declaration order).
-- Produces: OBL, NOR_C, NOR_S, OCC, CTX_E, CTX_S, REC, ENR_L, ENR_I
-- RR.DEFINES: SEIR.DEF.DERIVED_PROFILES_FROM_FAMILIES
/-- Canonical regimes obtained by expanding the reference family list. -/
def derivedProfilesFromFamilies : List Regime :=
  referenceFamilies.flatMap profilesForFamily

-- RR.DEFINES: SEIR.THM.DERIVED_PROFILES_FROM_FAMILIES_CARD
/-- Family expansion yields nine canonical regimes. -/
theorem derivedProfilesFromFamilies_card :
    derivedProfilesFromFamilies.length = 9 := by
  decide

-- RR.DEFINES: SEIR.THM.DERIVED_PROFILES_FROM_FAMILIES_NODUP
/-- Family expansion yields no duplicate regimes. -/
theorem derivedProfilesFromFamilies_nodup :
    List.Nodup derivedProfilesFromFamilies := by
  decide

-- RR.DEFINES: SEIR.THM.DERIVED_PROFILES_FROM_FAMILIES_COMPLETE
/-- Every canonical regime occurs in the family-derived list. -/
theorem derivedProfilesFromFamilies_complete
    (p : Regime) :
    p ∈ derivedProfilesFromFamilies := by
  cases p <;> decide

-- Membership-based alignment with referenceProfiles.
-- RR.DEFINES: SEIR.THM.DERIVED_PROFILES_FROM_FAMILIES_MATCH_REFERENCE
/-- Family-derived profiles and reference profiles have the same membership. -/
theorem derivedProfilesFromFamilies_match_reference
    (p : Regime) :
    p ∈ derivedProfilesFromFamilies ↔ p ∈ referenceProfiles := by
  cases p <;> decide

-- Membership-based alignment with the derived theory set.
-- RR.DEFINES: SEIR.THM.DERIVED_PROFILES_FROM_FAMILIES_MATCH_DERIVED
/-- Family-derived profiles and the derived regime set have the same membership. -/
theorem derivedProfilesFromFamilies_match_derived
    (p : Regime) :
    p ∈ derivedProfilesFromFamilies ↔ p ∈ derivedRegimeSet := by
  constructor
  · intro _
    exact derivedRegimeSet_complete p
  · intro _
    exact derivedProfilesFromFamilies_complete p

-- Exactly 3 families split (ENR, CTX, NOR) and 3 do not (OBL, OCC, REC).
-- RR.DEFINES: SEIR.THM.PROFILES_FOR_FAMILY_SPLIT_COUNT
/-- Exactly three reference families split into more than one canonical regime. -/
theorem profilesForFamily_split_count :
    (referenceFamilies.filter (fun f => (profilesForFamily f).length > 1)).length = 3 := by
  decide

-- Every unsplit family produces exactly one profile.
-- RR.DEFINES: SEIR.THM.PROFILES_FOR_FAMILY_NOSPLIT_SINGLETON
/-- Every unsplit family produces a singleton regime list. -/
theorem profilesForFamily_nosplit_singleton
    (f : RegimeFamily)
    (h : (profilesForFamily f).length = 1) :
    ∃ p, profilesForFamily f = [p] := by
  cases f <;> simp_all [profilesForFamily]

/- === Transformations (regime-transformations.toml) === -/

-- Order matches `order` field in regime-transformations.toml (1 .. 10).
-- RR.DEFINES: SEIR.DEF.REFERENCE_TRANSFORMATIONS
/-- Reference enumeration of the ten canonical transformations. -/
def referenceTransformations : List Transformation :=
  [.RE, .AN, .RF, .AD, .RC, .RA, .SU, .BF, .SE, .PV]

-- RR.DEFINES: SEIR.THM.REFERENCE_TRANSFORMATIONS_CARD
/-- The reference transformation list contains ten transformations. -/
theorem referenceTransformations_card :
    referenceTransformations.length = 10 := by
  decide

-- RR.DEFINES: SEIR.THM.REFERENCE_TRANSFORMATIONS_NODUP
/-- The reference transformation list contains no duplicates. -/
theorem referenceTransformations_nodup :
    List.Nodup referenceTransformations := by
  decide

-- RR.DEFINES: SEIR.THM.REFERENCE_TRANSFORMATIONS_COMPLETE
/-- Every canonical transformation occurs in the reference list. -/
theorem referenceTransformations_complete
    (t : Transformation) :
    t ∈ referenceTransformations := by
  cases t <;> decide

end

end SE.IdentityRegimes
