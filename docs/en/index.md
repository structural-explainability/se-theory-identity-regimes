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

This repository formalizes identity regimes,
their classification behavior under transformation, and
the identity relations those classifications generate.

The formal results are relative to the identity bases,
transformation effect models, and classifications declared in Lean.
They do not establish that any particular set of identity criteria is
scientifically necessary or exhaustive for intended referent kinds, or that
distinct classifications generate distinct identity relations.

### Stipulated and Derived Classification Matrices

The original classification matrix records proposed assignments
for nine candidate identity profiles and ten transformation families.

`Reference/DerivedMatrix.lean` separately records model-derived
classifications.
Six of the 90 cells currently have proof-carrying derivations:

- Scope profiles under decomposition (AD).
- Rule profiles under refinement (RF).
- Plain-referent profiles under branching (BF).

Three derived verdicts are `brk`; three are `neu`.
The other 84 cells have not yet been derived.

Each derived verdict is conditional on its specified presentation
model, identity invariant, admissible transformation steps, and
any additional warrants. In particular, the fork classifications
require explicit colocated and fresh-object warrants.

These derivations establish mathematical consequences of the models.
They do not independently establish that the selected criteria
correctly identify real-world referents.

## Vocabulary

These pages introduce the terminology and distinguish the responsibilities
of the related theories:

- [Identity Regimes](vocabulary-identity-regimes.md) — identity criteria,
  transformation classifications, and regime profiles.
- [Persistence](vocabulary-persistence.md) — applicability, continuation
  licences, identity commitments, and induced relations.
- [Transformation](vocabulary-transformation.md) — structural operators,
  effect semantics, and their relationship to identity classifications.

## Classification and Identity-Relation Limits

A difference between classifications does not, by itself, establish a
difference between the identity relations they generate, and the converse
needs its own justification.
Which steps generate identity, and the theorems relating classifications to
generated relations, are defined in the Lean source.

A representation that maps inapplicable cases to an identity-ignoring value does
not establish a substantive persistence criterion.

Carrier differences are not represented by differences between classifications
or by comparisons on one shared dynamics.
Carrier-sensitive identity claims require separate justification.

## Scientific Grounding

Classifications are formalized from declared inputs:
they are either stipulated, or derived from
declared identity bases and transformation effect models.
Neither is independently derived from accepted identity
criteria for real-world referent kinds.

Scientific adequacy requires justification of:

- the intended referent kinds and their individuation criteria;
- the identity basis assigned to each regime;
- the interpretation of transformations and their effects;
- the preservation and breakage classifications;
- the connection between modeled identity relations and
  strict identity of intended referents;
- the completeness and necessity of the proposed regime taxonomy.

The transformation families used here are distinct from
Transformation theory's operator taxonomy.
Declared correspondences do not transfer preservation classifications
automatically.

Admissibility of a regime application, as defined in Lean, concerns
neutrality of the substrate.
It does not independently validate a regime's identity criterion or
its applicability to a particular referent kind.

Whether such grounds support the regime distinctions formalized here,
a different classification, or any particular number of regimes remains an
open scientific question.

## Where to Look

- Definitions, predicates, and theorems: the
  [Lean API Reference](https://structural-explainability.github.io/se-theory-identity-regimes/lean/)
  and the Lean source under `SE/IdentityRegimes/`.
- Reference registries: `reference/` (source) and `data/` (generated mirror).
- Change history: `CHANGELOG.md`.
- Dependencies: `lakefile.toml` and `SE_MANIFEST.toml`.
  Resolved Lean dependency revisions: `lake-manifest.json`.

The roles of related theory repositories are documented in those repositories.

## Formal Theory

See the Lean source under `SE/IdentityRegimes/`.

## Import

Downstream Lean projects should import the public surface:

`import SE.IdentityRegimes`
