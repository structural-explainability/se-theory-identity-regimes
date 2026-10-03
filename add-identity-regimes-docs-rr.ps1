<#
Adds missing Lean docstrings and Research Registry (RR) comments for
se-theory-identity-regimes.

Default mode is dry-run. Use -Write to apply changes.

RR placement:
  -- RR....
  /-- Docstring. -/
  declaration

Compiler-generated *.ofNat_ctorIdx declarations are suppressed narrowly in the
repo-local lint driver because there is no source declaration to document.

The three pair-level SE300.THM.*_NONCOLLAPSE IMPLEMENTS links are intentionally
not added unless -IncludeUnverifiedPairImplements is supplied.
#>

[CmdletBinding()]
param(
    [switch]$Write,
    [switch]$IncludeUnverifiedPairImplements
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$Root = $PSScriptRoot
if (-not (Test-Path (Join-Path $Root 'SE/IdentityRegimes'))) {
    $Root = (Get-Location).Path
}
if (-not (Test-Path (Join-Path $Root 'SE/IdentityRegimes'))) {
    throw "Run this script from the se-theory-identity-regimes repository root."
}

function S {
    param(
        [string]$Path,
        [string]$Name,
        [string]$Doc,
        [string[]]$RR = @()
    )
    [pscustomobject]@{
        Path = $Path
        Name = $Name
        Doc  = $Doc
        RR   = @($RR)
    }
}

function F {
    param(
        [string]$Path,
        [string]$Structure,
        [string]$Field,
        [string]$Doc,
        [string[]]$RR = @()
    )
    [pscustomobject]@{
        Path      = $Path
        Structure = $Structure
        Field     = $Field
        Doc       = $Doc
        RR        = @($RR)
    }
}

$Specs = @(

    (S 'SE/IdentityRegimes/Vocab/Basic.lean' 'RegimeFamily' 'The six canonical identity-regime families.' @('RR.DEFINES: SEIR.DEF.REGIME_FAMILY'))
    (S 'SE/IdentityRegimes/Vocab/Regimes.lean' 'Regime' 'The nine canonical identity regimes.' @('RR.DEFINES: SEIR.DEF.REGIME'))
    (S 'SE/IdentityRegimes/Vocab/Regimes.lean' 'Regime.family' 'Map a canonical identity regime to its parent regime family.' @('RR.DEFINES: SEIR.DEF.REGIME_TO_FAMILY'))
    (S 'SE/IdentityRegimes/Vocab/Regimes.lean' 'IsCanonicalRegime' 'Predicate marking an identity regime as canonical.' @('RR.DEFINES: SEIR.DEF.IS_CANONICAL_REGIME'))
    (S 'SE/IdentityRegimes/Vocab/Regimes.lean' 'all_regimes_canonical' 'Every declared identity regime is canonical.' @('RR.DEFINES: SEIR.THM.ALL_REGIMES_CANONICAL'))
    (S 'SE/IdentityRegimes/Vocab/Requirements.lean' 'Requirement' 'A requirement associated with applying an identity regime.' @('RR.DEFINES: SEIR.DEF.REQUIREMENT'))
    (S 'SE/IdentityRegimes/Vocab/Requirements.lean' 'RequirementSatisfied' 'Predicate asserting that a requirement is satisfied over a substrate.' @('RR.DEFINES: SEIR.DEF.REQUIREMENT_SATISFIED'))
    (S 'SE/IdentityRegimes/Vocab/TransformBasis.lean' 'Transformation' 'The ten canonical transformations used by the identity-regime classification matrix.' @('RR.DEFINES: SEIR.DEF.TRANSFORMATION', 'RR.IMPLEMENTS: SE300.DEF.TRANSFORMATION_FAMILY'))
    (S 'SE/IdentityRegimes/Vocab/TransformBasis.lean' 'ClassificationValue' 'Classification assigned to a regime-transformation pair.' @('RR.DEFINES: SEIR.DEF.CLASSIFICATION_VALUE'))
    (S 'SE/IdentityRegimes/Profile/Admissibility.lean' 'RegimeApplicationAdmissible' 'An identity-regime application is admissible when the substrate element is neutral relative to the consequence system and interpretive framework.' @('RR.DEFINES: SEIR.DEF.REGIME_APPLICATION_ADMISSIBLE'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'IdentityBasis' 'Identity basis used to distinguish canonical identity regimes.' @('RR.DEFINES: SEIR.DEF.IDENTITY_BASIS'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'ProfileAxes' 'Canonical identity basis and split-transformation metadata for a regime.' @('RR.DEFINES: SEIR.DEF.PROFILE_AXES'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'Regime.axes' 'Return the canonical profile axes for an identity regime.' @('RR.DEFINES: SEIR.DEF.REGIME_AXES'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'UnderSplitPressure' 'Predicate indicating that a regime belongs to a family refined by a split transformation.' @('RR.DEFINES: SEIR.DEF.UNDER_SPLIT_PRESSURE'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'no_split_OBL' 'OBL is not under split pressure.' @('RR.DEFINES: SEIR.THM.NO_SPLIT_OBL'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'no_split_OCC' 'OCC is not under split pressure.' @('RR.DEFINES: SEIR.THM.NO_SPLIT_OCC'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'no_split_REC' 'REC is not under split pressure.' @('RR.DEFINES: SEIR.THM.NO_SPLIT_REC'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'split_ENR_L' 'ENR_L is under split pressure.' @('RR.DEFINES: SEIR.THM.SPLIT_ENR_L'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'split_ENR_I' 'ENR_I is under split pressure.' @('RR.DEFINES: SEIR.THM.SPLIT_ENR_I'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'split_CTX_E' 'CTX_E is under split pressure.' @('RR.DEFINES: SEIR.THM.SPLIT_CTX_E'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'split_CTX_S' 'CTX_S is under split pressure.' @('RR.DEFINES: SEIR.THM.SPLIT_CTX_S'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'split_NOR_C' 'NOR_C is under split pressure.' @('RR.DEFINES: SEIR.THM.SPLIT_NOR_C'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'split_NOR_S' 'NOR_S is under split pressure.' @('RR.DEFINES: SEIR.THM.SPLIT_NOR_S'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'splitPressure_iff_refined_family' 'Split pressure holds exactly for regimes in the ENR, CTX, or NOR families.' @('RR.DEFINES: SEIR.THM.SPLIT_PRESSURE_IFF_REFINED_FAMILY'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'family_map_not_injective' 'The regime-to-family map is not injective because refined families contain distinct regimes.' @('RR.DEFINES: SEIR.THM.FAMILY_MAP_NOT_INJECTIVE'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'no_split_family_injective' 'Regimes without split pressure are determined uniquely by their parent family.' @())
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'RegimeProfile' 'A regime profile identified by its canonical identity regime.' @('RR.DEFINES: SEIR.DEF.REGIME_PROFILE'))
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'RegimeProfile.axes' 'Return the canonical axes associated with a regime profile.' @())
    (S 'SE/IdentityRegimes/Profile/Core.lean' 'ProfileWellFormed' 'A regime profile is well formed when its regime is canonical.' @('RR.DEFINES: SEIR.DEF.PROFILE_WELL_FORMED'))
    (S 'SE/IdentityRegimes/Theorems.lean' 'regime_application_admissible_of_neutral' 'A neutral substrate supports admissible identity-regime application.' @('RR.DEFINES: SEIR.THM.REGIME_APPLICATION_ADMISSIBLE_OF_NEUTRAL'))
    (S 'SE/IdentityRegimes/Transform/Core.lean' 'classificationMatrix' 'Canonical classification matrix mapping each regime and transformation to its classification value.' @('RR.DEFINES: SEIR.DEF.CLASSIFICATION_MATRIX', 'RR.IMPLEMENTS: SE300.DEF.CLASSIFICATION_MAP'))
    (S 'SE/IdentityRegimes/Transform/LowerBound.lean' 'derivedRegimeSet' 'The complete list of nine derived canonical identity regimes.' @('RR.DEFINES: SEIR.DEF.DERIVED_PROFILE_SET'))
    (S 'SE/IdentityRegimes/Transform/LowerBound.lean' 'derivedRegimeSet_card' 'The derived regime set contains exactly nine regimes.' @('RR.DEFINES: SEIR.THM.DERIVED_PROFILE_SET_CARD'))
    (S 'SE/IdentityRegimes/Transform/LowerBound.lean' 'derivedRegimeSet_nodup' 'The derived regime set contains no duplicate regimes.' @('RR.DEFINES: SEIR.THM.DERIVED_PROFILE_SET_NODUP'))
    (S 'SE/IdentityRegimes/Transform/LowerBound.lean' 'derivedRegimeSet_complete' 'Every canonical regime occurs in the derived regime set.' @('RR.DEFINES: SEIR.THM.DERIVED_PROFILE_SET_COMPLETE'))
    (S 'SE/IdentityRegimes/Transform/LowerBound.lean' 'derivedRegimeSet_pairwise_noncollapse' 'Every distinct pair of canonical regimes is non-collapsing.' @('RR.DEFINES: SEIR.THM.DERIVED_PROFILE_SET_PAIRWISE_NONCOLLAPSE'))
    (S 'SE/IdentityRegimes/Transform/LowerBound.lean' 'classification_pattern_unique' 'Equal classification patterns determine the same regime.' @('RR.DEFINES: SEIR.THM.CLASSIFICATION_PATTERN_UNIQUE', 'RR.IMPLEMENTS: SE300.DEF.FAITHFUL_EMBEDDING'))
    (S 'SE/IdentityRegimes/Transform/LowerBound.lean' 'nine_regime_lower_bound' 'The nine canonical regimes satisfy the pairwise non-collapse lower-bound condition.' @('RR.DEFINES: SEIR.THM.NINE_PROFILE_LOWER_BOUND', 'RR.IMPLEMENTS: SE300.THM.NINE_PROFILE_LOWER_BOUND'))
    (S 'SE/IdentityRegimes/Transform/NonCollapse.lean' 'NonCollapsing' 'Two regimes are non-collapsing when some transformation distinguishes their classification rows.' @('RR.DEFINES: SEIR.DEF.NONCOLLAPSING'))
    (S 'SE/IdentityRegimes/Transform/NonCollapse.lean' 'noncollapse_of_prs_difference' 'A PRS classification difference witnesses non-collapse.' @('RR.DEFINES: SEIR.THM.NONCOLLAPSE_OF_PRS_DIFFERENCE'))
    (S 'SE/IdentityRegimes/Transform/NonCollapse.lean' 'noncollapse_ENR_L_ENR_I' 'ENR_L and ENR_I are non-collapsing.' @('RR.DEFINES: SEIR.THM.NONCOLLAPSE_ENR_L_ENR_I'))
    (S 'SE/IdentityRegimes/Transform/NonCollapse.lean' 'noncollapse_CTX_E_CTX_S' 'CTX_E and CTX_S are non-collapsing.' @('RR.DEFINES: SEIR.THM.NONCOLLAPSE_CTX_E_CTX_S'))
    (S 'SE/IdentityRegimes/Transform/NonCollapse.lean' 'noncollapse_NOR_C_NOR_S' 'NOR_C and NOR_S are non-collapsing.' @('RR.DEFINES: SEIR.THM.NONCOLLAPSE_NOR_C_NOR_S'))
    (S 'SE/IdentityRegimes/Transform/NonCollapse.lean' 'noncollapse_of_distinct_regime' 'Regimes from distinct parent families are non-collapsing.' @('RR.DEFINES: SEIR.THM.NONCOLLAPSE_OF_DISTINCT_REGIME'))
    (S 'SE/IdentityRegimes/Transform/NonCollapse.lean' 'noncollapse_all_pairs' 'Every ordered pair of distinct canonical regimes is non-collapsing.' @('RR.DEFINES: SEIR.THM.NONCOLLAPSE_ALL_PAIRS'))
    (S 'SE/IdentityRegimes/Embedding.lean' 'AdmissibleRelation' 'Admissible relation labels for edges in a regime-typed graph.' @('RR.DEFINES: SEIR.DEF.ADMISSIBLE_RELATION'))
    (S 'SE/IdentityRegimes/Embedding.lean' 'RegimeVertex' 'A regime-typed graph vertex carrying an ontology element.' @('RR.DEFINES: SEIR.DEF.REGIME_VERTEX'))
    (S 'SE/IdentityRegimes/Embedding.lean' 'RegimeVertex.regimeType' 'Return the regime assigned to a regime vertex.' @())
    (S 'SE/IdentityRegimes/Embedding.lean' 'RegimeEdge' 'A directed admissible relation between two regime-typed vertices.' @('RR.DEFINES: SEIR.DEF.REGIME_EDGE'))
    (S 'SE/IdentityRegimes/Embedding.lean' 'RegimeGraph' 'A regime-typed multigraph of vertices and admissible-relation edges.' @('RR.DEFINES: SEIR.DEF.REGIME_GRAPH', 'RR.IMPLEMENTS: SE300.DEF.REGIME_GRAPH'))
    (S 'SE/IdentityRegimes/Embedding.lean' 'profileKind' 'Return the canonical regime represented by a regime vertex.' @('RR.DEFINES: SEIR.DEF.PROFILE_KIND'))
    (S 'SE/IdentityRegimes/Embedding.lean' 'profileKind_determined_by_classification' 'Equal classification patterns determine the same profile kind.' @('RR.DEFINES: SEIR.THM.PROFILE_KIND_DETERMINED_BY_CLASSIFICATION'))
    (S 'SE/IdentityRegimes/Embedding.lean' 'GraphWellFormed' 'A regime graph is well formed when every listed vertex has a canonical regime.' @('RR.DEFINES: SEIR.DEF.GRAPH_WELL_FORMED'))
    (S 'SE/IdentityRegimes/Embedding.lean' 'representation_theorem' 'Every canonical regime has a unique representative classification pattern.' @('RR.DEFINES: SEIR.THM.REPRESENTATION', 'RR.IMPLEMENTS: SE300.THM.REPRESENTATION'))
    (S 'SE/IdentityRegimes/Embedding.lean' 'derived_regime_set_no_behavioral_collapse' 'Distinct canonical regimes differ on at least one transformation classification.' @('RR.DEFINES: SEIR.THM.DERIVED_PROFILE_SET_NO_BEHAVIORAL_COLLAPSE'))
    (S 'SE/IdentityRegimes/Embedding.lean' 'nine_regime_lower_bound_witness' 'The derived regime set witnesses a nine-regime pairwise non-collapse lower bound.' @('RR.DEFINES: SEIR.THM.NINE_PROFILE_LOWER_BOUND_WITNESS'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'allCells' 'Flatten the canonical regime-transformation matrix into its ninety classification cells.' @('RR.DEFINES: SEIR.DEF.MATRIX_ALL_CELLS'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'countValue' 'Count occurrences of a classification value in the canonical matrix.' @('RR.DEFINES: SEIR.DEF.MATRIX_COUNT_VALUE'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'allCells_card' 'The canonical classification matrix contains ninety cells.' @('RR.DEFINES: SEIR.THM.MATRIX_ALL_CELLS_CARD'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'matrix_counts' 'The canonical matrix contains the expected PRS, BRK, and IGN totals.' @('RR.DEFINES: SEIR.THM.MATRIX_COUNTS'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'matrix_PRS_count' 'The canonical matrix contains twenty-two PRS cells.' @('RR.DEFINES: SEIR.THM.MATRIX_PRS_COUNT'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'matrix_BRK_count' 'The canonical matrix contains twenty BRK cells.' @('RR.DEFINES: SEIR.THM.MATRIX_BRK_COUNT'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'matrix_IGN_count' 'The canonical matrix contains forty-eight IGN cells.' @('RR.DEFINES: SEIR.THM.MATRIX_IGN_COUNT'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'matrix_PRS_nonempty' 'The canonical matrix contains at least one PRS cell.' @('RR.DEFINES: SEIR.THM.MATRIX_PRS_NONEMPTY'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'matrix_BRK_nonempty' 'The canonical matrix contains at least one BRK cell.' @('RR.DEFINES: SEIR.THM.MATRIX_BRK_NONEMPTY'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'matrix_IGN_nonempty' 'The canonical matrix contains at least one IGN cell.' @('RR.DEFINES: SEIR.THM.MATRIX_IGN_NONEMPTY'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'matrix_RE_always_IGN' 'RE is classified IGN for every canonical regime.' @('RR.DEFINES: SEIR.THM.MATRIX_RE_ALWAYS_IGN'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'matrix_SU_always_BRK' 'SU is classified BRK for every canonical regime.' @('RR.DEFINES: SEIR.THM.MATRIX_SU_ALWAYS_BRK'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'matrix_enr_split_on_BF' 'BF distinguishes the two ENR regimes.' @('RR.DEFINES: SEIR.THM.MATRIX_ENR_SPLIT_ON_BF'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'matrix_nor_split_on_RF' 'RF distinguishes the two NOR regimes.' @('RR.DEFINES: SEIR.THM.MATRIX_NOR_SPLIT_ON_RF'))
    (S 'SE/IdentityRegimes/Reference/ClassificationMatrix.lean' 'matrix_ctx_split_on_AD' 'AD distinguishes the two CTX regimes.' @('RR.DEFINES: SEIR.THM.MATRIX_CTX_SPLIT_ON_AD'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceClassificationValues' 'Reference enumeration of the canonical classification values.' @('RR.DEFINES: SEIR.DEF.REFERENCE_CLASSIFICATION_VALUES'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceFamilies' 'Reference enumeration of the six identity-regime families.' @('RR.DEFINES: SEIR.DEF.REFERENCE_FAMILIES'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceProfiles' 'Reference enumeration of the nine canonical identity regimes.' @('RR.DEFINES: SEIR.DEF.REFERENCE_PROFILES'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'profilesForFamily' 'Return the canonical regimes derived from a regime family.' @('RR.DEFINES: SEIR.DEF.PROFILES_FOR_FAMILY'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'derivedProfilesFromFamilies' 'Canonical regimes obtained by expanding the reference family list.' @('RR.DEFINES: SEIR.DEF.DERIVED_PROFILES_FROM_FAMILIES'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceTransformations' 'Reference enumeration of the ten canonical transformations.' @('RR.DEFINES: SEIR.DEF.REFERENCE_TRANSFORMATIONS'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceClassificationValues_card' 'The reference classification-value list has the expected cardinality.' @('RR.DEFINES: SEIR.THM.REFERENCE_CLASSIFICATION_VALUES_CARD'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceClassificationValues_nodup' 'The reference classification-value list contains no duplicates.' @('RR.DEFINES: SEIR.THM.REFERENCE_CLASSIFICATION_VALUES_NODUP'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceClassificationValues_complete' 'Every canonical classification value occurs in the reference list.' @('RR.DEFINES: SEIR.THM.REFERENCE_CLASSIFICATION_VALUES_COMPLETE'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceFamilies_card' 'The reference family list contains six families.' @('RR.DEFINES: SEIR.THM.REFERENCE_FAMILIES_CARD'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceFamilies_nodup' 'The reference family list contains no duplicates.' @('RR.DEFINES: SEIR.THM.REFERENCE_FAMILIES_NODUP'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceFamilies_complete' 'Every identity-regime family occurs in the reference family list.' @('RR.DEFINES: SEIR.THM.REFERENCE_FAMILIES_COMPLETE'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceProfiles_card' 'The reference profile list contains nine canonical regimes.' @('RR.DEFINES: SEIR.THM.REFERENCE_PROFILES_CARD'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceProfiles_nodup' 'The reference profile list contains no duplicates.' @('RR.DEFINES: SEIR.THM.REFERENCE_PROFILES_NODUP'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceProfiles_complete' 'Every canonical regime occurs in the reference profile list.' @('RR.DEFINES: SEIR.THM.REFERENCE_PROFILES_COMPLETE'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceProfiles_match_derived' 'Reference profiles and the derived regime set have the same membership.' @('RR.DEFINES: SEIR.THM.REFERENCE_PROFILES_MATCH_DERIVED'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'derivedProfilesFromFamilies_card' 'Family expansion yields nine canonical regimes.' @('RR.DEFINES: SEIR.THM.DERIVED_PROFILES_FROM_FAMILIES_CARD'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'derivedProfilesFromFamilies_nodup' 'Family expansion yields no duplicate regimes.' @('RR.DEFINES: SEIR.THM.DERIVED_PROFILES_FROM_FAMILIES_NODUP'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'derivedProfilesFromFamilies_complete' 'Every canonical regime occurs in the family-derived list.' @('RR.DEFINES: SEIR.THM.DERIVED_PROFILES_FROM_FAMILIES_COMPLETE'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'derivedProfilesFromFamilies_match_reference' 'Family-derived profiles and reference profiles have the same membership.' @('RR.DEFINES: SEIR.THM.DERIVED_PROFILES_FROM_FAMILIES_MATCH_REFERENCE'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'derivedProfilesFromFamilies_match_derived' 'Family-derived profiles and the derived regime set have the same membership.' @('RR.DEFINES: SEIR.THM.DERIVED_PROFILES_FROM_FAMILIES_MATCH_DERIVED'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'profilesForFamily_split_count' 'Exactly three reference families split into more than one canonical regime.' @('RR.DEFINES: SEIR.THM.PROFILES_FOR_FAMILY_SPLIT_COUNT'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'profilesForFamily_nosplit_singleton' 'Every unsplit family produces a singleton regime list.' @('RR.DEFINES: SEIR.THM.PROFILES_FOR_FAMILY_NOSPLIT_SINGLETON'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceTransformations_card' 'The reference transformation list contains ten transformations.' @('RR.DEFINES: SEIR.THM.REFERENCE_TRANSFORMATIONS_CARD'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceTransformations_nodup' 'The reference transformation list contains no duplicates.' @('RR.DEFINES: SEIR.THM.REFERENCE_TRANSFORMATIONS_NODUP'))
    (S 'SE/IdentityRegimes/Reference/Core.lean' 'referenceTransformations_complete' 'Every canonical transformation occurs in the reference list.' @('RR.DEFINES: SEIR.THM.REFERENCE_TRANSFORMATIONS_COMPLETE'))
    (S 'SE/IdentityRegimes/Witness.lean' 'oblProfile' 'Canonical OBL regime-profile witness.' @())
)

if ($IncludeUnverifiedPairImplements) {
    foreach ($spec in $Specs) {
        switch ($spec.Name) {
            'noncollapse_ENR_L_ENR_I' {
                $spec.RR += 'RR.IMPLEMENTS: SE300.THM.ENR_NONCOLLAPSE'
            }
            'noncollapse_CTX_E_CTX_S' {
                $spec.RR += 'RR.IMPLEMENTS: SE300.THM.CTX_NONCOLLAPSE'
            }
            'noncollapse_NOR_C_NOR_S' {
                $spec.RR += 'RR.IMPLEMENTS: SE300.THM.NOR_NONCOLLAPSE'
            }
        }
    }
}

$FieldSpecs = @(

    (F 'SE/IdentityRegimes/Vocab/Requirements.lean' 'Requirement' 'regime' 'The canonical identity regime associated with this requirement.' @('RR.DEFINES: SEIR.DEF.REQUIREMENT_REGIME'))
    (F 'SE/IdentityRegimes/Profile/Core.lean' 'ProfileAxes' 'identityBasis' 'Identity basis used by the regime.' @())
    (F 'SE/IdentityRegimes/Profile/Core.lean' 'ProfileAxes' 'splitTransformation' 'Transformation that witnesses family refinement, when the family is split.' @())
    (F 'SE/IdentityRegimes/Profile/Core.lean' 'RegimeProfile' 'regime' 'Canonical identity regime represented by this profile.' @())
    (F 'SE/IdentityRegimes/Embedding.lean' 'RegimeVertex' 'regime' 'Canonical identity regime assigned to this vertex.' @())
    (F 'SE/IdentityRegimes/Embedding.lean' 'RegimeVertex' 'carrier' 'Ontology carrier represented by this vertex.' @())
    (F 'SE/IdentityRegimes/Embedding.lean' 'RegimeEdge' 'source' 'Source vertex of the directed edge.' @())
    (F 'SE/IdentityRegimes/Embedding.lean' 'RegimeEdge' 'relation' 'Admissible relation labeling the edge.' @())
    (F 'SE/IdentityRegimes/Embedding.lean' 'RegimeEdge' 'target' 'Target vertex of the directed edge.' @())
    (F 'SE/IdentityRegimes/Embedding.lean' 'RegimeGraph' 'vertices' 'Vertices contained in the regime graph.' @())
    (F 'SE/IdentityRegimes/Embedding.lean' 'RegimeGraph' 'edges' 'Edges contained in the regime graph.' @())
)

$GeneratedDocBlameSuppressions = @(
    'SE.IdentityRegimes.AdmissibleRelation.ofNat_ctorIdx'
    'SE.IdentityRegimes.IdentityBasis.ofNat_ctorIdx'
    'SE.IdentityRegimes.RegimeFamily.ofNat_ctorIdx'
    'SE.IdentityRegimes.Regime.ofNat_ctorIdx'
    'SE.IdentityRegimes.ClassificationValue.ofNat_ctorIdx'
    'SE.IdentityRegimes.Transformation.ofNat_ctorIdx'
)

$FileText = @{}
$Changed = [System.Collections.Generic.HashSet[string]]::new()
$Missing = [System.Collections.Generic.List[string]]::new()

function Get-RepoText {
    param([string]$RelativePath)

    if (-not $FileText.ContainsKey($RelativePath)) {
        $full = Join-Path $Root $RelativePath
        if (-not (Test-Path $full)) {
            $Missing.Add("$RelativePath :: file not found")
            $FileText[$RelativePath] = $null
            return $null
        }
        $FileText[$RelativePath] = [IO.File]::ReadAllText($full)
    }
    return $FileText[$RelativePath]
}

function Set-RepoText {
    param(
        [string]$RelativePath,
        [string]$Text
    )
    $FileText[$RelativePath] = $Text
    [void]$Changed.Add($RelativePath)
}

function Get-Newline {
    param([string]$Text)
    if ($Text.Contains("`r`n")) { return "`r`n" }
    return "`n"
}

function Get-DocStartBefore {
    param(
        [string]$Text,
        [int]$Index
    )

    if ($Index -le 0) { return -1 }
    $prefix = $Text.Substring(0, $Index)
    $m = [regex]::Match($prefix, '(?s)(/--.*?-/)\s*$')
    if ($m.Success) { return $m.Index }
    return -1
}

function Ensure-DeclarationMetadata {
    param([pscustomobject]$Spec)

    $text = Get-RepoText $Spec.Path
    if ($null -eq $text) { return }

    $escaped = [regex]::Escape($Spec.Name)

    # Match the declaration line itself.
    $pattern = "(?m)^(?<indent>[ \t]*)(?:(?:public|private|protected)\s+)?(?:inductive|structure|def|theorem|abbrev)\s+$escaped(?=\s|:|\()"
    $m = [regex]::Match($text, $pattern)

    # Also allow an attribute and declaration on the same source line.
    if (-not $m.Success) {
        $pattern = "(?m)^(?<indent>[ \t]*)@\[[^\r\n]*\][ \t]+(?:(?:public|private|protected)\s+)?(?:inductive|structure|def|theorem|abbrev)\s+$escaped(?=\s|:|\()"
        $m = [regex]::Match($text, $pattern)
    }

    if (-not $m.Success) {
        $Missing.Add("$($Spec.Path) :: declaration $($Spec.Name)")
        return
    }

    $newline = Get-Newline $text
    $indent = $m.Groups['indent'].Value
    $docStart = Get-DocStartBefore $text $m.Index
    $hasDoc = $docStart -ge 0

    $missingRR = @()
    foreach ($rr in $Spec.RR) {
        if (-not $text.Contains("-- $rr")) {
            $missingRR += $rr
        }
    }

    if ($hasDoc -and $missingRR.Count -eq 0) {
        return
    }

    $insertAt = if ($hasDoc) { $docStart } else { $m.Index }
    $parts = [System.Collections.Generic.List[string]]::new()

    foreach ($rr in $missingRR) {
        $parts.Add("$indent-- $rr")
    }

    if (-not $hasDoc) {
        $parts.Add("$indent/-- $($Spec.Doc) -/")
    }

    if ($parts.Count -eq 0) { return }

    $insert = ($parts -join $newline) + $newline
    $newText = $text.Insert($insertAt, $insert)
    Set-RepoText $Spec.Path $newText
}

function Ensure-FieldMetadata {
    param([pscustomobject]$Spec)

    $text = Get-RepoText $Spec.Path
    if ($null -eq $text) { return }

    $escapedStructure = [regex]::Escape($Spec.Structure)
    $structurePattern = "(?m)^[ \t]*(?:(?:public|private|protected)\s+)?structure\s+$escapedStructure(?=[\s(:])"
    $sm = [regex]::Match($text, $structurePattern)
    if (-not $sm.Success) {
        $Missing.Add("$($Spec.Path) :: structure $($Spec.Structure)")
        return
    }

    $headerEnd = $text.IndexOf("`n", $sm.Index)
    if ($headerEnd -lt 0) { $headerEnd = $text.Length - 1 }
    $bodyStart = $headerEnd + 1

    $tail = $text.Substring($bodyStart)
    $nextTop = [regex]::Match($tail, '(?m)^(?=\S)')
    $bodyEnd = if ($nextTop.Success) { $bodyStart + $nextTop.Index } else { $text.Length }

    $block = $text.Substring($bodyStart, $bodyEnd - $bodyStart)
    $escapedField = [regex]::Escape($Spec.Field)
    $fm = [regex]::Match($block, "(?m)^(?<indent>[ \t]+)$escapedField\s*:")
    if (-not $fm.Success) {
        $Missing.Add("$($Spec.Path) :: $($Spec.Structure).$($Spec.Field)")
        return
    }

    $absoluteField = $bodyStart + $fm.Index
    $newline = Get-Newline $text
    $indent = $fm.Groups['indent'].Value
    $docStart = Get-DocStartBefore $text $absoluteField
    $hasDoc = $docStart -ge $bodyStart

    $missingRR = @()
    foreach ($rr in $Spec.RR) {
        if (-not $text.Contains("-- $rr")) {
            $missingRR += $rr
        }
    }

    if ($hasDoc -and $missingRR.Count -eq 0) {
        return
    }

    $insertAt = if ($hasDoc) { $docStart } else { $absoluteField }
    $parts = [System.Collections.Generic.List[string]]::new()

    foreach ($rr in $missingRR) {
        $parts.Add("$indent-- $rr")
    }

    if (-not $hasDoc) {
        $parts.Add("$indent/-- $($Spec.Doc) -/")
    }

    if ($parts.Count -eq 0) { return }

    $insert = ($parts -join $newline) + $newline
    $newText = $text.Insert($insertAt, $insert)
    Set-RepoText $Spec.Path $newText
}

function Ensure-GeneratedDocBlameSuppressions {
    $relative = $null
    foreach ($candidate in @('SELint.lean', 'SEIdentityRegimesLint.lean')) {
        if (Test-Path (Join-Path $Root $candidate)) {
            $relative = $candidate
            break
        }
    }

    if ($null -eq $relative) {
        $Missing.Add('SELint.lean :: lint driver not found')
        return
    }

    $text = Get-RepoText $relative
    if ($null -eq $text) { return }

    $newline = Get-Newline $text
    $missingLines = @()

    foreach ($name in $GeneratedDocBlameSuppressions) {
        $line = "attribute [nolint docBlame] $name"
        if (-not $text.Contains($line)) {
            $missingLines += $line
        }
    }

    if ($missingLines.Count -eq 0) { return }

    $lintMatch = [regex]::Match($text, '(?m)^#lint(?:[-+*])?(?:\s|$).*$')
    if (-not $lintMatch.Success) {
        $Missing.Add("$relative :: #lint command")
        return
    }

    $prefix = @(
        '-- Compiler-generated enum helpers have no source declaration on which to place a docstring.'
    )
    $allLines = @()
    if (-not $text.Contains($prefix[0])) {
        $allLines += $prefix
    }
    $allLines += $missingLines
    $allLines += ''

    $insert = ($allLines -join $newline) + $newline
    $newText = $text.Insert($lintMatch.Index, $insert)
    Set-RepoText $relative $newText
}

foreach ($spec in $Specs) {
    Ensure-DeclarationMetadata $spec
}

foreach ($spec in $FieldSpecs) {
    Ensure-FieldMetadata $spec
}

Ensure-GeneratedDocBlameSuppressions

if ($Missing.Count -gt 0) {
    Write-Host ''
    Write-Host 'ANCHORS NOT FOUND:' -ForegroundColor Red
    foreach ($item in $Missing) {
        Write-Host "  - $item"
    }
    Write-Host ''
    Write-Host 'No files were written.' -ForegroundColor Yellow
    exit 1
}

Write-Host ''
if ($Changed.Count -eq 0) {
    Write-Host 'No changes needed.'
    exit 0
}

Write-Host ("Files to update: {0}" -f $Changed.Count)
foreach ($path in ($Changed | Sort-Object)) {
    Write-Host "  - $path"
}

if (-not $Write) {
    Write-Host ''
    Write-Host 'DRY RUN ONLY. Re-run with -Write to apply.' -ForegroundColor Yellow
    Write-Host 'Optional: add -IncludeUnverifiedPairImplements only after confirming the three SE300 pair-level theorem IDs.'
    exit 0
}

$utf8NoBom = [Text.UTF8Encoding]::new($false)

foreach ($path in $Changed) {
    $full = Join-Path $Root $path
    [IO.File]::WriteAllText($full, $FileText[$path], $utf8NoBom)
}

Write-Host ''
Write-Host 'Updated Lean documentation and RR comments.' -ForegroundColor Green
Write-Host ''
Write-Host 'Next:'
Write-Host '  lake build'
Write-Host '  lake test'
Write-Host '  lake lint'
Write-Host '  git diff -- SE SELint.lean SEIdentityRegimesLint.lean'
