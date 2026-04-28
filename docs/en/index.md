# SE Theory: Identity Regimes

> Lean 4 formalization of the identity regimes of Structural Explainability.

This repository defines the six canonical identity regimes and the
derived regime-profile structure over admissible neutral substrates.

It does not define substrate primitives, persistence behavior,
domain semantics, or operational validation.

## Boundary

This documentation is non-authoritative.
All formal definitions, invariants, and theorems are defined exclusively
in Lean source files under `IdentityRegimes/`.

If documentation and Lean diverge, **Lean is correct**.

## Purpose

The identity regimes establish the **structure of identity binding**
over admissible substrates.

They answer:

- What kinds of identity bindings are permitted?
- What structural roles do identities play?
- What requirements govern valid regime application?
- How are regime profiles derived from regimes?

They do not define the substrate on which they operate.

## Scope

### Includes

- Six canonical identity regimes
- Regime requirement structure
- Regime-profile structure
- Admissibility conditions for regime application over neutral substrates
- Necessity and sufficiency theorem structure
- Machine-checked Lean theorems

### Excludes

- Neutral substrate primitives
- Substrate well-formedness
- Substrate separation constraints
- Persistence behavior
- Mapping semantics
- Domain-specific data or examples
- Operational validation logic
- Runtime systems

## Structure

The root file provides a single import surface:

```lean
import IdentityRegimes
```

## Design Principles

### Regime Primacy

The six regimes are canonical and not derived:

- OBL
- NOR
- OCC
- CTX
- REC
- ENR

They define identity-binding structure, not implementation.

### Profiles as Derived Structure

Regime profiles are constructed over regimes.

- Profiles are not additional regimes
- Profiles encode requirement configurations
- Profile structure is derived, not primitive

### Admissibility

Regimes apply only over admissible neutral substrates.

This repository assumes admissibility but does not define it.

### Separation

Identity regime definitions remain independent from:

- substrate construction
- persistence behavior
- interpretation
- operational concerns

### Lean as Authority

All correctness is expressed and verified in Lean.

No external system defines or validates theory semantics.

## Relationship to Other Theory Repositories

### se-theory-neutral-substrate

Defines the admissible structural substrate.

This repository imports it.

### se-theory-structural-explainability

Integrates substrate and regimes into cross-cutting theorems.

Imports both this repository and the neutral substrate repository.

## Build

```shell
elan self update
lake update
lake build
```

## Tooling

Python tooling is used for:

- documentation generation (Zensical)
- repository hygiene (pre-commit, ruff)

Python tooling must not:

- define correctness
- validate theory semantics
- replace Lean proofs
