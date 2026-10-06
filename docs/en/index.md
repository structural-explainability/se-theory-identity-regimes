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

This repository formalizes identity regimes and their derived profile behavior
over admissible neutral substrates.

It depends on upstream Structural Explainability theory for concepts that it
does not own, including neutral-substrate and transformation theory.

It does not define domain-specific entity names, application semantics,
operational validation, or runtime behavior.

## Relationship to Other Theory Repositories

- `se-theory-neutral-substrate` provides the neutral-substrate foundation.
- `se-theory-transformation` provides generic transformation theory. Lake pins
  `v0.5.1`, resolved to commit `350c7ff01aa7bf9a7119f0a44ce652d7a6933154`.
  The manifest and dependency registry record that version. Identity Regimes
  retains its separately defined ten-element transformation basis; its Lean
  modules do not currently import `SE.Transformation` or derive regime
  classifications from Transformation effect laws.
- `se-theory-structural-explainability` integrates this theory with other
  Structural Explainability foundations.

For exact dependencies, see `SE_MANIFEST.toml`.

## Formal Theory

See the Lean source under `SE/IdentityRegimes/`.

## Import

Downstream Lean projects should import the public surface:

```lean
import SE
```

The curated public import surface is declared in:

```text
SE.lean
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
