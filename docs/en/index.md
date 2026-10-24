# SE Theory: Identity Regimes

> Lean 4 formalization of the identity-regime theory of Structural Explainability.

This repository defines the identity-regime theory used by Structural
Explainability.

Lean source files under `SE/` are authoritative for formal definitions,
predicates, assumptions, theorems, and proof obligations.

- [Lean API Reference](https://structural-explainability.github.io/se-theory-identity-regimes/lean/)
- [GitHub Repository](https://github.com/structural-explainability/se-theory-identity-regimes)
- [Citation Metadata](https://github.com/structural-explainability/se-theory-identity-regimes/blob/main/CITATION.cff)

## Authority

This documentation is informative only.

Formal definitions, identifiers, invariants, theorem statements, and proofs
are defined in the Lean source under `SE/IdentityRegimes/`.

The public Lean surface is:

```lean
import SE.IdentityRegimes
```

If documentation and Lean differ, the Lean source is authoritative.

## Scope

This repository formalizes six canonical identity-regime families,
nine named profiles, and their classification behavior over
ten identity transformations.

The formal results establish that the nine profiles have pairwise
distinct rows in the canonical classification matrix.

These results concern the specified finite taxonomy.
They do not establish that nine distinct identity criteria
are scientifically necessary, that
the taxonomy is exhaustive for intended referent kinds, or
that all nine profiles generate distinct identity relations.

## Classification and Identity-Relation Limits

`NonCollapsing` in this repository denotes a difference between
classification rows.
It does not, by itself, establish a difference between generated identity relations.

Two pairs of profiles have equal preserving-transformation sets:

- OBL and NOR-C
- CTX-S and NOR-S

`PersistenceBridge.lean` proves that each pair generates identical
identity relations on every shared Persistence dynamics.

Consequently, the nine classification rows produce at most seven
distinct generated identity relations on a common dynamics.
The formal results do not establish that exactly seven are distinct
on arbitrary dynamics.

The original classification matrix also maps eight inapplicable
(N/A) cells to IGN.
`PersistenceBridge.lean` restores their applicability distinctions
using Persistence's richer classification representation.
This preserves the existing preserving sets but
does not establish a substantive persistence criterion.

The distinction between identity carriers is not represented
by classification-row differences or
by comparisons using one shared dynamics.
Carrier-sensitive identity claims require separate justification.

## Scientific Grounding

The classification matrix and its profile distinctions are
formalized assumptions about the specified identity regimes.
They are not independently derived from accepted identity
criteria for real-world referent kinds.

Scientific adequacy requires justification of:

- the intended referent kinds and their individuation criteria;
- the identity basis assigned to each regime;
- the interpretation of transformations and their effects;
- the preservation and breakage classifications;
- the connection between modeled identity relations and
  strict identity of intended referents;
- the completeness and necessity of the proposed regime taxonomy.

The ten identity transformations are distinct from
Transformation theory's operator taxonomy.
Declared partial correspondences do not establish a complete semantic mapping
or transfer preservation classifications automatically.

`RegimeApplicationAdmissible` currently requires neutrality
of the substrate.
It does not independently validate a regime's identity criterion or
its applicability to a particular referent kind.

The nine-profile result is therefore a valid row-level
mathematical result, not an independently established
scientific lower bound on identity regimes.

## Relationship to Other Theory Repositories

- Neutral Substrate supplies the referential interfaces and neutrality conditions.
- Persistence supplies generic commitment, continuation, and induced-relation
  machinery.
- Transformation supplies operator effect semantics.
- Transformation Persistence connects transformation effects with persistence
  classifications and observations.

Future work on identity regimes can use the formal distinctions
developed in Individuation, Coreference, and Persistence.
Any proposed regime construction must independently justify its
referent kinds, identity criteria, and required semantic connections.
Whether these grounds support the existing regime distinctions,
a different classification, or any particular number of regimes
remains an open scientific question.

Operational Identity has a separate responsibility: comparing a supplied
declared identity relation with the relation induced by an examined
implementation surface.

Dependency declarations are recorded in `lakefile.toml` and
`SE_MANIFEST.toml`.
Resolved Lean dependency revisions are recorded in `lake-manifest.json`.

## Formal Theory

See the Lean source under `SE/IdentityRegimes/`.

## Import

Downstream Lean projects should import the public surface:

```lean
import SE.IdentityRegimes
```

The curated public import surface is declared in:

```text
SE/IdentityRegimes.lean
```

## Validation

Build and validate the Lean theory:

```shell
lake build
lake test
lake lint
```

Validate reference artifacts:

```shell
uv run se-theory-reference validate
uv run se-theory-reference validate --strict
uv run se-theory-reference export --check
uv run se-theory-reference catalog --check
uv run se-theory-reference inspect
```

Validate the repository manifest:

```shell
uvx se-manifest-schema validate-manifest --strict
```

Build the narrative documentation:

```shell
uv run python -m zensical build
```

The deployment workflow builds the generated Lean API documentation from
`docbuild/` and publishes it with the Zensical site.

## Tooling Boundary

Python and other tooling may be used for:

- documentation generation
- formatting and linting
- repository automation
- reference-artifact validation
- generated-artifact export checks

Tooling must not:

- define formal correctness
- replace Lean definitions or proofs
- validate theory semantics independently of Lean
- introduce downstream theory dependencies
