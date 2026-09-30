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

This repository defines the six canonical identity regimes and derived
regime-profile structure over admissible neutral substrates.

For the full documentation, see [`docs/en/index.md`](./docs/en/index.md).

## Authority

Lean source files are authoritative for formal definitions, predicates, axioms,
theorems, proof obligations, and reference rules.

Reference artifacts under `reference/` and generated artifacts under
`data/identity-regimes/` mirror the Lean public surface.
They do not define theory semantics independently of Lean.

## Import

Downstream Lean projects should import the public surface:

```text
import SE.IdentityRegimes
```

The public import surface is curated in:

```text
SE.IdentityRegimes.lean
SE.IdentityRegimes/Surface.lean
```

## Scope

This repository covers:

- six canonical identity regimes,
- nine canonical regime profile kinds after splits,
- regime requirement structure,
- regime-profile structure,
- admissibility conditions for regime application over neutral substrates,
- transformation basis and classification structure,
- split pressure predicates and theorems,
- pairwise non-collapse proofs,
- lower-bound and classification-uniqueness theorem structure,
- regime-typed multigraph structure,
- representation theorem structure,
- machine-checked Lean theorems.

## Owns

This repository owns the identity-regime theory layer, including:

- six canonical identity regimes:
  - OBL
  - NOR
  - OCC
  - CTX
  - REC
  - ENR
- nine canonical regime profile kinds after splits:
  - OBL
  - OCC
  - REC
  - ENR_L
  - ENR_I
  - CTX_E
  - CTX_S
  - NOR_C
  - NOR_S
- transformations:
  - RE
  - AN
  - RF
  - AD
  - RC
  - RA
  - SU
  - BF
  - PV
  - SE

## Does not own

This repository does not own:

- neutral substrate primitives; see `se-theory-identity-regimes`,
- path grammar and expressive adequacy,
- domain mappings,
- operational validation,
- runtime systems,
- contract artifact generation.

## Command Reference

### Clone and Open in VS Code

Open a machine terminal where you want the project:

```shell
git clone https://github.com/structural-explainability/se-theory-identity-regimes

cd se-theory-identity-regimes
code .
```

### In a VS Code Terminal

Use VS Code Menu:
View / Command Palette / `Developer: Reload Window` to refresh.

```shell
# set up or update Python environment
uvx pup-clean --delete
uv self update
uv python install
uv lock --upgrade
uv sync
uv audit

# set up and run git hooks
uv run prek install --force
uv run prek update
git add -A
uv run prek run --all-files
# repeat if changes were made
uv run prek run --all-files

# build Lean source of truth
elan self update
lake update
lake build
lake build TestAll

# inspect shared theory-reference command surface
uv run se-theory-reference --help
uv run se-theory-reference validate --help
uv run se-theory-reference scaffold --help
uv run se-theory-reference export --help
uv run se-theory-reference catalog --help
uv run se-theory-reference inspect --help

# validate reference artifacts against the declared Lean public surface
uv run se-theory-reference validate
uv run se-theory-reference validate --strict

# scaffold reference artifacts from Lean public declarations
uv run se-theory-reference scaffold
uv run se-theory-reference scaffold --dry-run
uv run se-theory-reference scaffold --overwrite

# regenerate or check generated JSON artifacts from reference TOML
uv run se-theory-reference export
uv run se-theory-reference export --check

# build or verify the generated reference catalog
uv run se-theory-reference catalog
uv run se-theory-reference catalog --check

# inspect resolved repository configuration and reference declarations
uv run se-theory-reference inspect

# validate SE manifest file
uvx se-manifest-schema validate-manifest --path SE_MANIFEST.toml --strict

# run common chores
uv run ruff format .
uv run ruff check . --fix
uv run ty check
uv run python -m pytest
uv run python -m zensical build

# save progress
git add -A
git commit -m "update"
git push -u origin main
```

## Authority Manifest

[.accountability/surfaces.toml](./.accountability/surfaces.toml)

## Changelog

[CHANGELOG.md](./CHANGELOG.md)

## Citation

[CITATION.cff](./CITATION.cff)

## Documentation

[Documentation](https://structural-explainability.github.io/se-theory-identity-regimes/)

## License

[MIT](./LICENSE)

## Repository Manifest

[SE_MANIFEST.toml](./SE_MANIFEST.toml)
