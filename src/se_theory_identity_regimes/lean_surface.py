"""lean_surface.py - Expected Lean public surface for se-theory-identity-regimes.

Owns:
  - SURFACE_TYPES          - exported public Lean types
  - SURFACE_PREDICATES     - exported public Lean predicates
  - SURFACE_VOCABULARY     - exported classification/transformation vocabulary
  - SURFACE_WITNESSES      - exported public Lean witness objects (def only)
  - SURFACE_THEOREMS       - exported public Lean theorems
  - SURFACE_SYMBOLS        - combined exported public Lean symbols

Does not own:
  - parsing Lean files
  - validating reference artifacts
  - loading TOML or JSON files
  - CLI or orchestration behavior

This module mirrors IdentityRegimes/Surface.lean so Python validation can check
that reference artifacts cover the public Lean surface.

Current strategy:
  Keep this file aligned manually with IdentityRegimes/Surface.lean.
  Surface.lean is the authoritative export list. Internal theorems
  (NonCollapse.lean, ClassificationMatrix.lean helpers) are not listed here
  even if they are individually correct — they are not part of the public
  surface contract.

Future strategy:
  Replace or supplement these constants by parsing Surface.lean directly.

Call chain:
  __main__.py -> cli.main()
              -> orchestrate.run_validate()
              -> validate_reference.validate_reference()
              -> lean_surface.SURFACE_SYMBOLS

Witness vs theorem convention:
  SURFACE_WITNESSES contains only Lean `def` declarations (concrete objects).
  SURFACE_THEOREMS contains all Lean `theorem` declarations re-exported
  through Surface.lean.

Internal symbols omitted (not re-exported through Surface.lean):
  noncollapse_of_prs_difference, noncollapse_ENR_L_ENR_I,
  noncollapse_CTX_E_CTX_S, noncollapse_NOR_C_NOR_S,
  noncollapse_of_distinct_regime, noncollapse_all_pairs,
  matrix_RE_always_IGN, matrix_SU_always_BRK,
  matrix_IGN_nonempty, matrix_PRS_nonempty, matrix_BRK_nonempty,
  matrix_counts, matrix_PRS_count, matrix_BRK_count, matrix_IGN_count,
  matrix_enr_split_on_BF, matrix_ctx_split_on_AD, matrix_nor_split_on_RF,
  allCells, countValue, IsPreserving, IsBreaking
  RegimeVertex.regimeType, profileKind,
  profileKind_determined_by_classification,
  derived_regime_set_no_behavioral_collapse,
  nine_regime_lower_bound_witness
"""

SURFACE_TYPES: frozenset[str] = frozenset(
    {
        "Regime",
        "RegimeProfile",
        "RegimeProfileKind",
        "Requirement",
        "Transformation",
        "ClassificationValue",
        "IdentityBasis",
        "ProfileAxes",
        "RegimeFamily",
        "RegimeVertex",
        "RegimeEdge",
        "RegimeGraph",
        "AdmissibleRelation",
    }
)


SURFACE_PREDICATES: frozenset[str] = frozenset(
    {
        "IsCanonicalRegime",
        "NonCollapsing",
        "ProfileWellFormed",
        "RequirementSatisfied",
        "RegimeApplicationAdmissible",
        "UnderSplitPressure",
        "GraphWellFormed",
    }
)


SURFACE_VOCABULARY: frozenset[str] = frozenset(
    {
        "classificationMatrix",
        "derivedRegimeSet",
        "referenceProfiles",
        "referenceTransformations",
        "referenceFamilies",
        "referenceClassificationValues",
        "profilesForFamily",
        "derivedProfilesFromFamilies",
    }
)


SURFACE_WITNESSES: frozenset[str] = frozenset(
    {
        "oblProfile",
    }
)


SURFACE_THEOREMS: frozenset[str] = frozenset(
    {
        "all_regimes_canonical",
        "classification_pattern_unique",
        "derivedRegimeSet_card",
        "derivedRegimeSet_nodup",
        "derivedRegimeSet_complete",
        "derivedRegimeSet_pairwise_noncollapse",
        "nine_regime_lower_bound",
        "regime_application_admissible_of_neutral",
        "representation_theorem",
    }
)


SURFACE_SYMBOLS: frozenset[str] = frozenset(
    {
        *SURFACE_TYPES,
        *SURFACE_PREDICATES,
        *SURFACE_VOCABULARY,
        *SURFACE_WITNESSES,
        *SURFACE_THEOREMS,
    }
)


SURFACE_BY_KIND: dict[str, frozenset[str]] = {
    "type": SURFACE_TYPES,
    "predicate": SURFACE_PREDICATES,
    "vocabulary": SURFACE_VOCABULARY,
    "witness": SURFACE_WITNESSES,
    "theorem": SURFACE_THEOREMS,
}


def expected_symbols_for_kind(kind: str) -> frozenset[str]:
    """Return expected public Lean symbols for a surface kind.

    Args:
        kind: Surface kind. Expected values are type, predicate, vocabulary,
            witness, theorem.

    Returns:
        The expected exported Lean symbols for the requested kind.

    Raises:
        ValueError: If kind is not a known surface kind.
    """
    try:
        return SURFACE_BY_KIND[kind]
    except KeyError as e:
        valid_kinds = ", ".join(sorted(SURFACE_BY_KIND))
        raise ValueError(
            f"Unknown Lean surface kind: {kind}. Expected one of: {valid_kinds}"
        ) from e
