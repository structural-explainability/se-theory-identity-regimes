"""lean_surface.py - Expected Lean public surface for se-theory-identity-regimes.

Owns:
  - SURFACE_TYPES          - exported public Lean types
  - SURFACE_PREDICATES     - exported public Lean predicates
  - SURFACE_VOCABULARY     - exported classification/transformation vocabulary
  - SURFACE_THEOREMS       - exported public Lean theorems
  - SURFACE_SYMBOLS        - combined exported public Lean symbols

Does not own:
  - parsing Lean files
  - validating reference artifacts
  - loading TOML or JSON files
  - CLI or orchestration behavior

This module mirrors IdentityRegimes.lean so Python validation can check
that reference artifacts cover the public Lean surface.

Current strategy:
  Keep this file aligned manually with IdentityRegimes.lean.

Future strategy:
  Replace or supplement these constants by parsing IdentityRegimes.lean directly.

Call chain:
  __main__.py -> cli.main()
              -> orchestrate.run_validate()
              -> validate_reference.validate_reference()
              -> lean_surface.SURFACE_SYMBOLS
"""

SURFACE_TYPES: frozenset[str] = frozenset(
    {
        "Regime",
        "RegimeProfile",
        "RegimeProfileKind",
        "Requirement",
        "Transformation",
        "TransformationClassification",
    }
)


SURFACE_PREDICATES: frozenset[str] = frozenset(
    {
        "IsCanonicalRegime",
        "NonCollapsing",
        "ProfileWellFormed",
        "RequirementSatisfied",
        "RegimeApplicationAdmissible",
    }
)


SURFACE_VOCABULARY: frozenset[str] = frozenset(
    {
        "classify",
        "derivedRegimeSet",
        "IsPreserving",
        "IsBreaking",
    }
)


SURFACE_THEOREMS: frozenset[str] = frozenset(
    {
        "all_regimes_canonical",
        "classification_pattern_unique",
        "derivedRegimeSet_card",
        "derivedRegimeSet_nodup",
        "nine_regime_lower_bound",
        "regime_application_admissible_of_neutral",
    }
)


SURFACE_SYMBOLS: frozenset[str] = frozenset(
    {
        *SURFACE_TYPES,
        *SURFACE_PREDICATES,
        *SURFACE_VOCABULARY,
        *SURFACE_THEOREMS,
    }
)


SURFACE_BY_KIND: dict[str, frozenset[str]] = {
    "type": SURFACE_TYPES,
    "predicate": SURFACE_PREDICATES,
    "vocabulary": SURFACE_VOCABULARY,
    "theorem": SURFACE_THEOREMS,
}


def expected_symbols_for_kind(kind: str) -> frozenset[str]:
    """Return expected public Lean symbols for a surface kind.

    Args:
        kind: Surface kind. Expected values are type, predicate, vocabulary,
            theorem.

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
