# Transformation Vocabulary

**Transformation theory** describes change independently of identity.
It provides several related vocabularies.

This page describes the Transformation `v0.5.1` contract selected by this
repository. That theory names and groups kinds of change and formalizes atomic
operator effects through `footprint`, `requirements`, and `StateModel`.
Footprints bound the dimensions a step may change; required-change clauses
specify changes every step must make. A state model supplies operator step
relations with frame and required-change laws.

Composition and orthogonality lookups remain declared and partial.
Effect theorems establish consistency and necessary conditions at their stated
strength; they do not derive every declared relation or establish restoration
from an inverse-like label. Identity Regimes does not derive its regime
classifications from these effect laws.

## Seven Transformation Kinds

[**Transformation kinds**](https://github.com/structural-explainability/se-theory-transformation/blob/v0.5.1/data/transformation/transformation-kind-registry.json)
are the broadest categories of change:
contextual,
normative,
observational,
organizational,
relational,
structural, and
temporal.

## 17 Operations (named transformations)

- [**Operations**](https://github.com/structural-explainability/se-theory-transformation/blob/v0.5.1/data/transformation/operator-registry.json)
  are the concrete named transformations:
  attest (`AT`),
  authorize (`AZ`),
  bind (`BD`),
  branch (`BR`),
  collapse (`CL`),
  copy (`CP`),
  embed (`EM`),
  expand (`EX`),
  link (`LK`),
  merge (`MG`),
  project (`PR`),
  reorder (`RO`),
  revert (`RV`),
  shift (`SH`),
  split (`SP`),
  unbind (`UB`), and
  version (`VS`).
  Each operator belongs to exactly one family and therefore one kind.

## 14 Transformation Families

[**Transformation families**](https://github.com/structural-explainability/se-theory-transformation/blob/v0.5.1/data/transformation/transformation-family-registry.json)
group operations by shared behavior within the broad transformation kinds.

Each operation belongs to exactly one transformation family,
and each transformation family belongs to exactly one transformation kind.

### Contextual Kind (1 family, 2 operations)

- **Family: Contextual**: transformations that bind, unbind, or otherwise alter
  contextual placement or applicability.
  - **bind (`BD`)**: associates a referent with a context,
    bearer, scope, or applicability setting.
  - **unbind (`UB`)**: removes, releases, or severs a contextual binding
    between a referent and its current context, bearer, or scope.

### Normative Kind (1 family, 1 operation)

- **Family: Normative**: transformations that apply, alter, or record
  normative authority, permission, or standing.
  - **authorize (`AZ`)**: grants permission, authority,
    or normative standing to a subject or referent within a defined scope.

### Observational Kind (3 families, 3 operations)

- **Family: Attestation**: transformations that record evidence,
  verification, or claims about a referent.
  - **attest (`AT`)**: records a verified claim about a referent
    and adds attestation metadata or evidence.

- **Family: Projection**: transformations that derive a partial view,
  selected representation, or projection of a referent.
  - **project (`PR`)**: Derives a representation from a source referent
    without modifying the source. The representation may be partial or a
    selected form.

- **Family: Replication**: transformations that produce a duplicate,
  replica, copy, or copied representation of a referent.
  - **copy (`CP`)**: Produces a faithful duplicate of a referent or of a
    representation of a referent, identical to its source in content,
    arrangement, and composition and derived from it.

### Organizational Kind (2 families, 2 operations)

- **Family: Containment**: transformations that place a referent
  within a containing structure or organizational enclosure.
  - **embed (`EM`)**: Places a referent inside a containing structure,
    establishing containment.

- **Family: Reorganization**: transformations that alter arrangement,
  ordering, or organizational placement without
  changing membership.
  - **reorder (`RO`)**: Changes the ordering or arrangement of a referent's
    components without changing which components it has.

### Relational Kind (2 families, 2 operations)

- **Family: Association**: transformations that establish, alter, or represent
  relations among referents without implying containment.
  - **link (`LK`)**: establishes an association or relation
    between referents without by itself implying containment or persistence.

- **Family: Migration**: transformations that relocate a referent across
  a relation, bearer, context, or structural position while
  maintaining linkage.
  - **shift (`SH`)**: Moves a referent from one relation, bearer, context, or
    structural position to another, leaving its other relations in place.

### Structural Kind (3 families, 4 operations)

- **Family: Aggregation**: transformations that combine multiple referents
  or structural components into a unified whole.
  - **merge (`MG`)**: Combines two or more referents or components into a
    single unified referent.

- **Family: Decomposition**: transformations that divide a referent into
  constituent components, parts, branches, or sub-referents.
  - **split (`SP`)**: Divides a referent into two or more constituent
    components, each of which may itself be a referent.

- **Family: Scaling**: transformations that increase or decrease structural
  scale, detail, complexity, or elaboration.
  - **collapse (`CL`)**: reduces structural scale or complexity
    by collapsing nested, redundant, or expanded structure.
  - **expand (`EX`)**: increases structural scale, detail,
    or complexity by expanding a referent into a more elaborated form.

### Temporal Kind (2 families, 3 operations)

- **Family: Branching**: transformations that produce divergent
  continuations from a referent.
  - **branch (`BR`)**: Creates a divergent continuation path from a referent,
    along which later changes may proceed independently of the original path.

- **Family: Versioning**: transformations that produce, identify, restore,
  or relate temporally ordered versions of a referent.
  - **revert (`RV`)**: Restores a referent to the state of a prior version
    along a version chain, moving its position in that chain.
  - **version (`VS`)**: Establishes a temporally ordered version or successor
    position for a referent and may materialize that version as a new referent
    or representation.

### Three Defined Composition Relations

[**Composition relations**](https://github.com/structural-explainability/se-theory-transformation/blob/v0.5.1/data/transformation/composition-registry.json)
describe selected ordered pairs of operations.

- **authorize then attest (`AZ → AT`)**: composable.
- **bind then unbind (`BD → UB`)**: inverse-like.
- **split then merge (`SP → MG`)**: inverse-like.

Composition relations describe sequencing between operations.
They do not say that persistence or identity is restored.

Only these ordered pairs are classified.
Every other pair is unclassified,
which does not mean unrelated.
The relation vocabulary also includes
absorbing, conditionally composable, non-composable, and redundant;
none is used yet.

### Three Declared Orthogonality Pairs

[**Orthogonality relations**](https://github.com/structural-explainability/se-theory-transformation/blob/v0.5.1/data/transformation/orthogonality-matrix.json)
describe three selected unordered pairs of operations
in terms of structural independence. The lookup is symmetric.

**Composition** and **orthogonality** are independent ways
of describing relationships among operations.

- **authorize and attest (`AZ`, `AT`)**: orthogonal.
- **project and collapse (`PR`, `CL`)**: overlapping.
- **split and merge (`SP`, `MG`)**: overlapping (`splitAndMerge`).

Only these unordered pairs are classified; each is specified in both orders.
Every other pair returns `none`, meaning no canonical rule is specified.
Overlapping effects include containment of one effect domain by another.
The relation vocabulary also includes
conflicting and dependent; none is used yet.

## Summary

Transformation theory provides a structured vocabulary for
**what kind of change occurred**,
**how concrete operations are grouped**,
**what atomic effects operations may and must have**, and
**how some operations relate to one another**.

Transformation does not select an identity criterion or assign Identity Regimes
classifications.
