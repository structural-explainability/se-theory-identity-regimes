# Research Doubts and Open Questions

This document records the current research assessment,
known limitations, unresolved questions, and safeguards
against overclaiming for this theory.

For the three research criteria, doubt classifications,
status definitions, and procedures, see the
[Structural Explainability Research Doubts Standard](https://github.com/structural-explainability/.github/blob/main/RESEARCH-DOUBTS-STANDARD.md).

## Repository Summary

This assessment is a summary of the present evidence.

| Criterion                | Current assessment                                                                                                                                                                                                                                                                           |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Mathematical Correctness | Formal results are established under stated hypotheses. Six of the 90 classification cells have proof-carrying derivations, and they agree with the stipulated matrix on breaking (`derived_agrees_on_breaking`). The other 84 cells are not derived.                                        |
| Scientific Adequacy      | Not established. Classifications are stipulated, or derived from declared identity bases and transformation effect models. Neither is independently derived from accepted identity criteria for real-world referent kinds.                                                                   |
| Theoretical Contribution | The proposed contribution is a conditional formal method for deriving and auditing identity-preservation classifications under transformation. The nine profiles are not claimed to be necessary criteria or a complete taxonomy. No related-work discussion is recorded in this repository. |

The doubts below identify specific issues affecting these assessments.

---

<!-- markdownlint-disable MD024 -->

## Register 1. Doubts About Assumptions (Undermining Doubts)

These questions concern the premises of an argument.
Even if a theorem is correctly proved, can we establish the assumptions necessary to apply it?

### UM-001. (OPEN) Intended Referents and Identity Bases

#### Research criterion

Scientific Adequacy

#### Concern

Do the regimes' identity bases match independently justified criteria for real-world referent kinds?

#### Current Knowledge

Scientific adequacy requires justification of the intended referent kinds and their individuation criteria, the basis assigned to each regime, the interpretation of transformations, the classifications, the connection to strict identity of referents, and the completeness and necessity of the taxonomy.

#### Remaining Work

Whether independently justified criteria support, revise, or replace the regime distinctions is open.

### UM-002. (OPEN) Stipulated and Derived Matrices

#### Research criterion

Mathematical Correctness

#### Concern

The stipulated matrix is a set of proposed assignments and only six cells are derived.

#### Current Knowledge

The three derived `neu` cells are `prs` in the stipulated matrix (`derived_neu_cells_are_stipulated_prs`).
The difference comes from field granularity, and both are non-breaking.

#### Remaining Work

Listed as planned: distinguish stipulated from derived entries, review claims that families necessarily force identity distinctions, and investigate coherence across derived cells.
Completing all 90 cells is not a goal in itself.

### UM-003. (OPEN) Fork Warrants

#### Research criterion

Scientific Adequacy

#### Concern

The branching verdicts depend on whether a continuation stays at the locus or is the same object.

#### Current Knowledge

Without a warrant, BF is `mix` for both the locus and object bases.
The `neu` and `brk` verdicts hold under the named warrants `Colocated`, `FreshObject`, and `SameObject`.

#### Remaining Work

A concrete application must justify the warrant it assumes.

### UM-004. (OPEN) Refining the RF Family

#### Research criterion

Mathematical Correctness

#### Concern

RF as defined in the transformation basis includes normative detail.

#### Current Knowledge

Read that way, RF is `mix` for the content basis.

#### Remaining Work

The family must be refined before it can be entered in a classification table.

### UM-005. (OPEN) Substrate Admissibility and Requirements

#### Research criterion

Scientific Adequacy

#### Concern

`RegimeApplicationAdmissible` and `RequirementSatisfied` might be read as checking more than they do.

#### Current Knowledge

`RegimeApplicationAdmissible` is defined by neutrality of the substrate element.
It does not validate a regime's identity criterion or its applicability to a referent kind.
`RequirementSatisfied` is defined as `True`; its docstring calls it intentionally minimal and says downstream implementations may refine it.

#### Remaining Work

Listed as planned: evaluate removing the direct Neutral Substrate dependency, and reassess both definitions.

### UM-006. (OPEN) Correspondence With Transformation Theory

#### Research criterion

Scientific Adequacy

#### Concern

The regime transformation families and the operator taxonomy are separate.

#### Current Knowledge

Declared correspondences do not transfer preservation classifications automatically.

#### Remaining Work

Listed as planned: a downstream bridge proving conditional results.

## Register 2. Doubts About Conclusions (Rebutting Doubts)

These questions concern whether a claimed conclusion is false.
For example, a counterexample satisfying all the premises
but violating the conclusion would challenge the claimed theorem or its formalization.
A model that violates a required assumption does not
necessarily refute a conditional theorem.
If a counterexample is found,
we must identify the exact claim it challenges and
whether its assumptions are satisfied.

**None currently identified.**

## Register 3. Doubts About What Our Results Mean (Undercutting Doubts)

These questions concern the connection
between a formal theorem and the scientific claim made about it.
A theorem may be correct while its informal interpretation is too strong.
Some of these doubts are addressed by permanent documentation
rules rather than additional proofs.

### UC-001. (STANDING RULES) Classifications and Identity Relations

#### Research criterion

Scientific Adequacy

#### Concern

A reader might read a difference between classifications as a difference between identity relations.

#### Current Knowledge

A difference between classifications does not by itself establish a difference between the identity relations they generate.
The converse needs its own justification.
Two profile pairs have identical preserving sets and generate the same relation on every shared dynamics.

#### Standing Rules

1. Do not infer identity-relation differences from classification differences alone.

### UC-002. (STANDING RULES) Inapplicable Cases

#### Research criterion

Scientific Adequacy

#### Concern

A reader might read an identity-ignoring value as a persistence criterion.

#### Current Knowledge

A representation that maps inapplicable cases to an identity-ignoring value does not establish a substantive persistence criterion.

#### Standing Rules

1. Keep inapplicable distinct from `ign` when describing a classification.

### UC-003. (STANDING RULES) Carrier Differences

#### Research criterion

Scientific Adequacy

#### Concern

A reader might read a classification comparison as a comparison across carriers.

#### Current Knowledge

Carrier differences are not represented by differences between classifications or by comparisons on one shared dynamics.

#### Standing Rules

1. Justify carrier-sensitive identity claims separately.

### UC-004. (STANDING RULES) Derived Verdicts Are Conditional

#### Research criterion

Scientific Adequacy

#### Concern

A reader might read a derived verdict as unconditional.

#### Current Knowledge

Each derived verdict is conditional on its presentation model, identity invariant, admissible steps, and any additional warrants.
The derivations establish mathematical consequences of the models, not that the selected criteria identify real-world referents.

#### Standing Rules

1. State the model, invariant, steps, and warrants with every derived verdict.

<!-- markdownlint-enable MD024 -->
