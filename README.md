# SE Theory: Identity Regimes

[![Docs Site](https://img.shields.io/badge/docs-site-blue?logo=github)](https://structural-explainability.github.io/se-theory-identity-regimes/)
[![Repo](https://img.shields.io/badge/repo-GitHub-black?logo=github)](https://github.com/structural-explainability/se-theory-identity-regimes)
[![Tooling](https://img.shields.io/badge/python-3.15%2B-blue?logo=python)](./pyproject.toml)
[![License](https://img.shields.io/badge/license-MIT-yellow.svg)](./LICENSE)

[![CI-Lean](https://github.com/structural-explainability/se-theory-identity-regimes/actions/workflows/ci-lean.yml/badge.svg?branch=main)](https://github.com/structural-explainability/se-theory-identity-regimes/actions/workflows/ci-lean.yml)
[![CI](https://github.com/structural-explainability/se-theory-identity-regimes/actions/workflows/ci-python-zensical.yml/badge.svg?branch=main)](https://github.com/structural-explainability/se-theory-identity-regimes/actions/workflows/ci-python-zensical.yml)
[![Docs](https://github.com/structural-explainability/se-theory-identity-regimes/actions/workflows/deploy-zensical.yml/badge.svg?branch=main)](https://github.com/structural-explainability/se-theory-identity-regimes/actions/workflows/deploy-zensical.yml)
[![Links](https://github.com/structural-explainability/se-theory-identity-regimes/actions/workflows/links.yml/badge.svg?branch=main)](https://github.com/structural-explainability/se-theory-identity-regimes/actions/workflows/links.yml)

> Lean 4 formalization of the identity regimes of Structural Explainability.

Defines the six canonical identity regimes and the derived regime-profile structure
over admissible neutral substrates.

## Provides Reference Files

Files are manually generated and verified by Lean.

```text
regime-classification-matrix.toml
regime-classification-values.toml
regime-families.toml
regime-profile-derivation.toml
regime-profiles.toml
regime-transformations.toml
```

## Imports

- Neutral substrate interface (imported from `se-theory-neutral-substrate`)

## Covers

- 6 regimes, 9 profile kinds, refinement map
- Transformation basis and full classification function (with matrix-form reference)
- Split pressure predicates and theorems
- Three split witness theorems (ENR/BF, CTX/AD, NOR/RF)
- All 36 pairwise non-collapse proofs
- Lower bound and classification uniqueness
- Regime-typed multigraph structure (`RegimeVertex`, `RegimeEdge`, `RegimeGraph`)
- Representation theorem: each profile uniquely determined by classification behavior

## Owns

- Six canonical identity regimes:
  - OBL
  - NOR
  - OCC
  - CTX
  - REC
  - ENR
- Nine canonical regime profile kinds after splits:
  - OBL
  - OCC
  - REC
  - ENR_L
  - ENR_I
  - CTX_E
  - CTX_S
  - NOR_C
  - NOR_S
- Regime requirement structure
- Regime-profile structure (currently a thin wrapper over RegimeProfileKind, designed for extension)
- Admissibility conditions for regime application over neutral substrates
- Necessity and sufficiency theorem structure
- Machine-checked theorems

## Does not own

- Neutral substrate primitives (see `se-theory-neutral-substrate`)
- Path grammar and expressive adequacy (SE-400)
- Domain mappings or operational validation
- Runtime systems

## Design Constraints

- Lean is the only source of truth for correctness
- No executable entry points
- No exported runtime artifacts
- No cross-repo coupling beyond imports
- All guarantees are expressed as theorems

## Documentation Constraints

- The documentation layer is descriptive only.
- Documentation sections must mirror Lean module structure.

### Authority

- Lean source files are the only authoritative definition of:
  - types
  - predicates
  - theorems
  - proof obligations

- Documentation must not introduce or redefine formal semantics.

### Prohibited in docs

- Restating formal definitions in alternative form
- Introducing new terminology not present in Lean
- Encoding rules or invariants not present in Lean
- Diverging naming from Lean modules

### Allowed in docs

- Explanatory summaries
- Structural descriptions
- Navigation and orientation
- Non-authoritative theorem descriptions

## Import

Single import surface:

```lean
import IdentityRegimes
```

## Build

```shell
elan self update
lake update
lake build
lake build TestImport
lake build TestExport
```

## Tooling

Python and other tooling may be used for:

- documentation generation
- formatting and linting
- repository automation

They must not:

- define correctness
- validate theory semantics
- replace Lean proofs

## Command Reference

<details>
<summary>Show command reference</summary>

### In a machine terminal

Open a machine terminal where you want the project:

```shell
git clone https://github.com/structural-explainability/se-theory-identity-regimes

cd se-theory-identity-regimes
code .
```

### In a VS Code terminal

```shell
uv self update
uv python pin 3.15
uv sync --extra dev --extra docs --upgrade

uvx pre-commit install

git add -A
uvx pre-commit run --all-files
# repeat if changes were made
git add -A
uvx pre-commit run --all-files

# validate
uv run python -m se_theory_identity_regimes validate --strict

# do chores
uv run python -m pyright
uv run python -m pytest
uv run python -m zensical build

# save progress
git add -A
git commit -m "update"
git push -u origin main
```

</details>

## Citation

[CITATION.cff](./CITATION.cff)

## License

[MIT](./LICENSE)

## Manifest

[SE_MANIFEST.toml](./SE_MANIFEST.toml)
