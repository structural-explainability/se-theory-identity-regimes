# Identity Regime Vocabulary

**Identity Regimes** uses a different vocabulary to ask if
something is "still the same thing?" after a change.

The identity transformations are identity-relevant change scenarios,
not another level of Transformation theory's
kind → family → operation taxonomy.

## Six Identity-Regime Families

[**Identity-regime families**](https://github.com/structural-explainability/se-theory-identity-regimes/blob/main/reference/regime-families.toml)
are the six parent categories from which the canonical identity regimes
are derived.

- **Obligation-bearing entity (`OBL`)**
- **Normative structure (`NOR`)**
- **Time-indexed occurrence (`OCC`)**
- **Applicability context (`CTX`)**
- **Descriptive record (`REC`)**
- **Enduring non-normative referent (`ENR`)**

## Nine Canonical Identity Regimes

[**Canonical identity regimes**](https://github.com/structural-explainability/se-theory-identity-regimes/blob/main/reference/regime-profiles.toml)
are the nine identity profiles derived from the six parent families.

Three families remain unsplit.
Three families split into two regimes because
different identity bases respond differently to a
particular identity transformation.

## Obligation-Bearing Entity Family (1 regime)

- **Obligation-bearing profile (`OBL`)**
  - identity basis: single
  - no split-forcing identity transformation

## Time-Indexed Occurrence Family (1 regime)

- **Time-indexed occurrence profile (`OCC`)**
  - identity basis: single
  - no split-forcing identity transformation

## Descriptive Record Family (1 regime)

- **Descriptive record profile (`REC`)**
  - identity basis: single
  - no split-forcing identity transformation

## Enduring Non-Normative Referent Family (2 regimes)

The Enduring non-normative referent family splits under
branching (`BF`).

- **Enduring non-normative referent, locus-bound profile (`ENR_L`)**
  - identity basis: locus
- **Enduring non-normative referent, instrument-bound profile (`ENR_I`)**
  - identity basis: instrument

## Applicability Context Family (2 regimes)

The Applicability context family splits under
aggregation/decomposition (`AD`).

- **Applicability context, extension-sensitive profile (`CTX_E`)**
  - identity basis: extension
- **Applicability context, structure-sensitive profile (`CTX_S`)**
  - identity basis: structure

## Normative Structure Family (2 regimes)

The Normative structure family splits under
refinement (`RF`).

- **Normative structure, content-sensitive profile (`NOR_C`)**
  - identity basis: content
- **Normative structure, structure-sensitive profile (`NOR_S`)**
  - identity basis: structure

## Ten Identity Transformations

[**Identity transformations**](https://github.com/structural-explainability/se-theory-identity-regimes/blob/main/reference/regime-transformations.toml)
are the ten identity-relevant change scenarios used to ask
whether identity is preserved, broken, ignored, or not applicable
under a particular regime.

- **Re-expression (`RE`)**:
  changes representation format while preserving content.
- **Annotation (`AN`)**:
  adds annotation or non-identity-bearing information.
- **Refinement (`RF`)**:
  increases descriptive or structural detail.
- **Aggregation/decomposition (`AD`)**:
  restructures into coarser or finer components.
- **Re-contextualization (`RC`)**:
  changes applicability context.
- **Reassignment (`RA`)**:
  changes an association, bearer, or assignment.
- **Substitution (`SU`)**:
  replaces the identity carrier.
- **Branching (`BF`)**:
  creates a branch or fork.
- **State evolution (`SE`)**:
  changes state over an evolution step.
- **Provenance extension (`PV`)**:
  adds historical or derivational information.

These ten identity transformations do not form a fourth level
under Transformation theory's operations, families, or kinds.

They have different semantic boundaries because they are designed
to ask identity questions.

## Three Declared Transformation Links

Transformation theory and Identity Regimes therefore use
two distinct vocabularies with a partial correspondence between them.

We currently declare three links where a Transformation-theory operation
has an instance that clearly fits an identity-transformation scenario.

- **branch (`BR`) → Branching (`BF`)**
  - a branch operation is an instance of the branch-or-fork identity scenario
- **split (`SP`) → Aggregation/decomposition (`AD`)**
  - when a referent is divided into components of the same referent
- **expand (`EX`) → Refinement (`RF`)**
  - when expansion adds structural detail without adding new requirements

"Declared" means that we state the correspondence
and record the argument for it.
It does not mean that the relationship is derived from
a complete formal semantics of both operations.

## Other Transformation Operations

Several Transformation-theory operations are deliberately
not assigned an Identity Regimes correspondence.

- **copy (`CP`)** is not declared to realize Branching (`BF`).
  Copying can preserve content or structure in cases where
  branching creates divergent continuations.

- **merge (`MG`)** is not declared to realize
  Aggregation/decomposition (`AD`).
  The current `AD` realization is specifically a decomposition case,
  while merging can introduce content or extension that decomposition does not.

- **bind (`BD`)** and **unbind (`UB`)** are not declared to realize
  Re-contextualization (`RC`).
  Changing a contextual binding can also change extension or scope.

- **shift (`SH`)** is not declared to realize
  Re-contextualization (`RC`) or Reassignment (`RA`).
  Its identity interpretation depends on whether the context,
  bearer, association, or structural position is what moved.

- **version (`VS`)** and **revert (`RV`)** are not declared to realize
  State evolution (`SE`).
  Versioning or reverting does not by itself establish
  continuation of the same enduring referent.

These non-declarations do not mean that such correspondences
can never hold.
They record only that the theory does not currently assert them.

## Three Split Checks

Three regime families split because a particular
identity transformation gives the two resulting regimes
different identity classifications.

## Enduring Non-Normative Referent Split

Branching (`BF`) distinguishes:

- **Enduring non-normative referent, locus-bound (`ENR_L`)**: preserve
- **Enduring non-normative referent, instrument-bound (`ENR_I`)**: break

Branch (`BR`) is the declared Transformation-theory operation
behind the relevant Branching (`BF`) case.

## Applicability Context Split

Aggregation/decomposition (`AD`) distinguishes:

- **Applicability context, extension-sensitive (`CTX_E`)**: preserve
- **Applicability context, structure-sensitive (`CTX_S`)**: break

Split (`SP`) is the declared Transformation-theory operation
behind the relevant decomposition case.

## Normative Structure Split

Refinement (`RF`) distinguishes:

- **Normative structure, content-sensitive (`NOR_C`)**: preserve
- **Normative structure, structure-sensitive (`NOR_S`)**: break

Expand (`EX`) is the declared Transformation-theory operation
behind the relevant refinement case.

## One General Coverage Theorem

Every regime currently under split pressure
has at least one declared Transformation-theory operation
behind its split-forcing identity transformation.

If another split is introduced later without such a declaration,
the formal development must be updated rather than silently
accepting the missing correspondence.

This theorem does not transfer identity classifications
to Transformation-theory operations.

For example, declaring

`branch (BR) → Branching (BF)`

does not mean that the Transformation-theory operator `BR`
automatically receives every identity verdict assigned to `BF`.

Such transfer would require separate,
regime-specific semantic results.

## Persistence Semantics

**Persistence theory** supplies the formal semantics
of the identity classifications.

For a particular identity regime and identity-transformation scenario,
the richer classification distinguishes four cases:

- **not applicable (`NA`)**:
  the identity-transformation scenario does not apply;
- **ignore (`IGN`)**:
  the scenario applies but does not determine an
  identity-preservation distinction for the regime;
- **preserve (`PRS`)**:
  identity is preserved under the identity transformation;
- **break (`BRK`)**:
  the identity transformation breaks identity under the regime.

Persistence therefore answers a different question from either
Transformation theory or Identity Regimes:

- **Transformation theory** describes what operation occurred.
- **Identity Regimes** identifies the identity-relevant scenario
  and the identity basis being tested.
- **Persistence theory** gives formal meaning to the resulting
  preserve/break classification and the identity relation it induces.

This distinction matters because two regimes can have
different classification rows without necessarily generating
different identity relations.

The Identity Regimes classification matrix is therefore best understood
as a coarse view of a richer applicability-aware Persistence classification.

## Three Links Declared

These are places where an operation has an instance that fits an identity scenario.

- Branch (BR) is an instance of branch-or-fork (BF).
- Split (SP) is an instance of aggregation-or-decomposition (AD), when a thing is divided into parts of the same thing.
- Expand (EX) is an instance of refinement (RF), when it adds detail without adding new requirements.

"Declared" means we state the link and give the argument for it.
It is not proven from deeper principles,
because neither side has a formal model
of the operation's full semantics.

## Other Operations

- Copy (CP) is not treated as branch-or-fork (BF).
  Copying can preserve content or structure in cases where branching creates divergent continuations.
- Merge (MG) is not treated as aggregation-or-decomposition (AD).
  The current AD reasoning is about decomposition, and merging can introduce content or extension that decomposition does not.
- Bind (BD) and Unbind (UB) are not treated as re-contextualization (RC).
  Changing what something applies to can also change its extension or scope.
- Shift (SH) is not treated as re-contextualization (RC) or reassignment (RA).
  It depends on whether the context, bearer, or association is what moved.
- Version (VS) and Revert (RV) are not treated as state evolution (SE).
  Versioning or reverting does not establish that the enduring thing continues.

We do not claim that these operations can never fit.
It records that we have not asserted the correspondence, and the code makes those non-declarations explicit.

## Regime Checks

Some regime families split into two identity regimes because
one identity-transformation scenario
gives the two regimes different answers.

- Enduring things (ENR) split into
  locus-bound (ENR_L) and instrument-bound (ENR_I),
  distinguished by branch-or-fork (BF).
  Branch (BR) is the declared Transformation-theory operation behind that scenario.
- Applicability contexts (CTX) split into
  extension-sensitive (CTX_E) and structure-sensitive (CTX_S), distinguished by aggregation-or-decomposition (AD).
  Split (SP) is the declared operation behind the relevant decomposition case.
- Normative structures, meaning rules (NOR), split into
  content-preserving (NOR_C) and structural (NOR_S),
  distinguished by refinement (RF).
  Expand (EX) is the declared operation behind the relevant refinement case.

For each split, we check that a
Transformation-theory operation is declared
for the split-forcing identity scenario
and that the Identity Regimes classification table
gives the two regimes different answers on that scenario.

## One General Theorem

Every regime currently under split pressure
has at least one declared Transformation-theory operation
behind its split-forcing identity transformation.
If a new split is introduced later without such a declaration,
the formal development has to be updated rather than silently accepting the gap.

It does not say that Branch (BR), for example,
automatically inherits the identity verdict
assigned to branch-or-fork (BF).
It says only that
the operation and the identity scenario
are linked in a stated class of cases.
Transferring identity classifications to
Transformation-theory operators would require separate, regime-specific work that we have not undertaken.
