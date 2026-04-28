# Changelog

<!-- markdownlint-disable MD024 -->

All notable changes to this project will be documented in this file.

The format is based on **[Keep a Changelog](https://keepachangelog.com/en/1.1.0/)**
and this project adheres to **[Semantic Versioning](https://semver.org/spec/v2.0.0.html)**.

## [Unreleased]

---

## [0.1.0] - 2026-04-27

### Added

Initial Lean 4 formal contract structure (`SEFormalContract`)

- Core modules: `Basic`, `Regime`, `Neutrality`,
  `Relation`, `Export`, `ExportJson`
- Public library root with stable import surface

Canonical identity regime profile definitions:

- OBL, OCC, REC, ENR-L, ENR-I, CTX-E, CTX-S, NOR-C, NOR-S

Structural relation primitives:

- equivalent, narrower, broader, overlaps, none

Lean-based contract export layer:

- JSON export via `ExportJson`
- invariant registry
- regime registry
- relation registry
- proof registry

Python validation and CLI interface:

- validation module (`se_formal_contract.app`)
- CLI interface (`se_formal_contract.cli`, `__main__`)

Generated contract artifacts under `data/contract/`

SE manifest (`SE_MANIFEST.toml`) defining repository role as formal contract root

Migration scaffolding:

- `docs/migration/from-existing-formalizations.md`

Repository governance and tooling:

- `AGENTS.md`
- `CITATION.cff`

### Notes

- Establishes formal contract as the root dependency for the SE ecosystem.
- Lean definitions are the authoritative source of contract structure.
- Exported artifacts are generated and must not be manually edited.
- Proof surface is partial; theorem statuses are initially marked as pending.

---

## Notes on versioning and releases

- We use **SemVer**:
  - **MAJOR** – breaking changes to artifact structure or validation semantics
  - **MINOR** – backward-compatible additions to schema or validation rules
  - **PATCH** – fixes, documentation, tooling
- Versions are driven by git tags. Tag `vX.Y.Z` to release.
- Docs are deployed per version tag and aliased to **latest**.
- Sample commands:

```shell
# as needed
git tag -d v0.1.0
git push origin :refs/tags/v0.1.0

# new tag / release
git tag v0.1.0 -m "0.1.0"
git push origin v0.1.0
```

[Unreleased]: https://github.com/structural-explainability/se-theory-identity-regimes/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/structural-explainability/se-theory-identity-regimes/releases/tag/v0.1.0
