# Persistence Vocabulary

Persistence supplies generic machinery for continuation, identity commitments,
and the relations they induce over a supplied carrier.

## Applicability and Classification

A persistence classification records applicability and, when applicable,
one of three values:
identity-ignoring (IGN),
identity-preserving (PRS),
or identity-breaking (BRK).

Lean represents this as `T → Option ClassificationValue`.
Inapplicability is represented by `none`, not by a fourth value.

Persistence uses `ClassificationValue.ign` for identity-ignoring behavior.
The companion paper *Referential Regimes* (Paper 200) uses `NEU`
for identity-neutral behavior.

In the invariant-based Identity Regimes models, `neu` has a more
specific meaning:
an applicable transformation whose effective instances
preserve the identity invariant without changing
any supported field.

These classifications should not be treated as interchangeable
without verifying their underlying semantics.

## Continuation Licences

A licence specifies which individual transformation steps count as
continuations.
The same operator can receive different continuation judgments
on different steps.

Operator-level classifications express licences only
where the required operator-level uniformity holds.

A preserving classification does not itself establish a continuation licence.
`Classification.WellFormed` requires every declared persistence transformation
to be classified as preserving, but does not require every preserving
transformation to be licensed.

## Identity Commitments

Same and distinct commitments constrain admissible equivalence relations.
The theory examines consistency, required and forbidden identifications,
and identifications left open under stated constraints.

The commitments and constraints require independent justification.

## Observations

Presentation soundness and completeness relate an observation map to the
specified induced identity relation.

Observational agreement alone does not establish identity of the intended
referent without the relevant adequacy conditions.
