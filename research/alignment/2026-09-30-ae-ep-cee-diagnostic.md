# AE / EP / CEE Alignment Diagnostic

Date: 2026-09-30

## Purpose

This note records diagnostic findings from comparison of the evolving
Structural Explainability identity-regime theory with related AE, EP, and CEE
specifications.

The objective is not to force the current theory to conform to earlier
specifications.

The objective is to determine whether differences represent:

- terminology only;
- theory evolution;
- downstream specification drift;
- unresolved differences due to insufficient evidence; or
- a theoretical conflation exposed by implementation or formalization.

The last category requires positive evidence. A naming difference alone is not
evidence of a theoretical conflation.

This work is diagnostic only. It does not prescribe changes to the theory or
specifications.

## Methodological Context

Later Structural Assurability work demonstrated why implementation and
formalization are useful adversarial tests of theory.

An initially simple Boolean-world construction made several assurability
dimensions appear interchangeable. A richer finite-history construction later
separated Observability, Coverage, Traceability, and Reconstructability with
dimension-specific witnesses.

That work also distinguished two mechanisms that had previously been easy to
conflate:

- richer observation or evidence; and
- restriction of admissible worlds through trust or provenance assumptions.

The resulting methodological rule for the present alignment work is:

> When two sources differ in naming or definition, determine whether the
> difference is merely terminological or whether one representation collapses
> distinctions that another keeps separate.

The Structural Assurability result is an analogy and a methodological warning.
It must not be projected onto AE, EP, CEE, or the identity regimes without
direct evidence.

## 1. ENR_I / OBJ Comparison

### Status

**Unresolved from currently available evidence.**

The available evidence is consistent with a terminology change, but it does
not establish that ENR_I and OBJ have the same identity basis.

### Current Identity-Regime Theory

Repository:

`se-theory-identity-regimes`

The repository README identifies ENR_I as one of nine profile kinds under the
ENR family.

It also identifies three split-witness theorems:

- ENR / BF
- CTX / AD
- NOR / RF

The top-level `IdentityRegimes.lean` only imports
`IdentityRegimes.Surface`.

The substantive definitions appear to live in modules under
`IdentityRegimes/` and in reference files including:

- `reference/regime-profiles.toml`
- `reference/regime-vocabulary.toml`

Those authoritative definitions were not successfully retrieved during this
diagnostic pass.

The non-authoritative documentation site lists the identity-basis axis as:

- single
- content
- structure
- extension
- locus
- instrument

It does not provide the authoritative definition of `instrument`.

### SE-200

Repository:

`paper-200-identity-regimes`

Paper:

SE-200, §5.7

SE-200 distinguishes two plain-referent regimes relevant here.

#### LOC

LOC is locus-fixed.

The referent is individuated by the place, site, slot, location, or
institutional position that remains fixed.

#### OBJ

OBJ is object-fixed.

The referent is individuated by the object occupying that locus.

The paper describes the relevant referent using examples including:

- object
- asset
- instrument
- sample
- device
- parcel
- thing

Proposition 5.7 states that branch/fork transformation is non-breaking for the
locus reading and breaking for the object reading.

### Apparent Correspondence

The locus side currently appears consistent:

`ENR_L` ↔ `LOC`

Both participate in the corresponding branch/fork distinction.

The unresolved question is:

`ENR_I` ↔ `OBJ`

The word `instrument` appears inside the broader OBJ description in SE-200.

That alone does not establish whether later `ENR_I`:

- renamed the same concept;
- generalized it;
- narrowed it to instruments;
- replaced object-fixed identity with a different abstraction such as a
  durable non-normative referent; or
- represents a neighboring but distinct regime.

### Chronology

SE-200 was first posted in January 2026.

Later work used the ENR_L / ENR_I terminology.

Earlier conversation records from April and May 2026 indicate that ENR_I was
already being described as `Instrument`, including the phrase
`durable non-normative referent`.

Those conversation records establish chronology but do not substitute for the
current authoritative Lean definition.

### Required Evidence

The question remains unresolved until the current authoritative definition of
ENR_I is read directly.

The comparison must be based on its actual identity criterion, not its label.

## 2. Structural Assurability Location

Structural Assurability work is publicly present.

It was not visible in the earlier organization-level index that was inspected,
but repository-level search located three relevant repositories.

### Formal Theory

Repository:

`se-theory-structural-assurability`

The README identifies public formal definitions including:

- `world`
- `indistinguishable`
- `claimDisagreement`
- `admissiblyIndistinguishable`
- `claimResolvedBy`
- `feasibleEvidence`
- `accessibleEvidence`
- `obtainableEvidence`
- `claimMaterialEvidence`

The repository identifies itself as the formal theory and has a public
v0.1.0 release.

The definitions themselves were not inspected during the reported search, so
this diagnostic does not independently verify their semantics.

### Experimental Pilot

Repository:

`se-pilot-structural-assurability`

The repository describes a NIST TEVV-Athlon study and links the formal Lean
theory as authoritative for formal definitions.

It contains experimental work under paths including:

`experiments/tevv-athlon/query_violation.py`

### Paper

Repository:

`paper-320-structural-assurability`

The pilot links this repository as the associated paper.

It was located but not inspected during this diagnostic pass.

### Relevance

The successful search establishes that Structural Assurability is not missing
from the public Structural Explainability work.

Its absence from an organization README or index was an indexing/discovery
issue, not evidence that the work was unavailable.

## 3. CEE Evidence / Trust Diagnostic

### Source Limitation

The current `main` branch of `spec-cee` was not successfully retrieved during
the initial search.

The following findings are based on an older supplied CEE specification set:

- `SPEC.md`
- `IDENTIFIERS.md`
- `CONFORMANCE.md`
- `SE_MANIFEST.toml`
- `CHANGELOG.md`

The supplied changelog identifies version 0.9.0 dated 2025-12-31 as the
initial normative specification.

These findings therefore describe that CEE version and must not be assumed to
describe the current repository without verification.

### Finding

CEE 0.9.0 does not demonstrate a conflation between evidence/observation and
trust/admissibility.

Instead, it does not model either mechanism at the level later used by
Structural Assurability.

CEE operates at a different abstraction level.

### Evidence-Related Constructs

`CEE.DEFINITION.CORE` includes:

`evidentiary grouping and reference`

among the things CEE specifies.

However, the supplied specification does not define a corresponding evidence
model.

`IDENTIFIERS.md` contains no canonical identifier specifically defining an
evidence mechanism.

`CONFORMANCE.md` contains no evidence-specific conformance requirement.

The manifest scope includes:

- context tags
- explanation records
- attestations
- provenance
- multiplicity

but does not list evidence as a separate modeled construct.

### Provenance

`CEE.PROVENANCE` describes how an explanation, context assignment, or
attestation was produced.

It may record information such as:

- source materials;
- methods or processes;
- tools or models involved; and
- derivation history.

This does **not** establish that provenance is CEE's evidence model.

It establishes only that source materials may be recorded as part of the
provenance of a CEE artifact.

The supplied specification does not define:

- an evaluator observation channel;
- evidence visibility;
- obtainable evidence;
- evidentiary indistinguishability; or
- claim resolution from evidence.

### Attestation

`CEE.ATTESTATION` records that an accountable actor asserts responsibility for
an explanation under a context.

It identifies the actor and the scope of the assertion.

Importantly, the specification states that attestations do not certify
correctness or authority.

Therefore:

**attestation is not equivalent to trust or admissibility in the later
Structural Assurability sense.**

An attestation may itself constitute evidence about accountability or
provenance, but it does not by itself determine which possible worlds,
explanations, or claims are admissible.

### Context

`CEE.CONTEXT.TAG` scopes explanations by frameworks, assumptions, or
viewpoints.

Contexts may overlap or conflict.

This is contextualization, not an observation or admissibility mechanism.

### Explicit Scope Exclusions

`CEE.SCOPE.EXCLUSIONS` excludes:

- epistemic validation or truth criteria; and
- normative judgment or enforcement.

`CEE.MULTIPLICITY` also states that CEE must not require reconciliation,
prioritization, or resolution of conflicting interpretations.

These exclusions strongly limit any claim that CEE was intended to decide
which evidence or interpretation should be accepted as authoritative.

### Semantic Relationship to Structural Assurability

The supplied CEE specification and later Structural Assurability theory ask
different questions.

CEE asks approximately:

- Under what context is an explanation made?
- What explanation is asserted?
- Who attests to it?
- How was the artifact produced?
- How can multiple explanations coexist?

Structural Assurability asks approximately:

- What claim is being evaluated?
- What evidence can distinguish claim-material worlds?
- Which worlds are admissible?
- Which worlds remain observationally indistinguishable?
- Is the claim resolved?

These abstractions are related but not equivalent.

### Current Classification

For CEE 0.9.0:

**No demonstrated theoretical conflation.**

The available evidence instead supports:

- an earlier and narrower abstraction;
- no explicit Structural-Assurability-style observation model;
- no explicit admissible-world model;
- provenance and attestation modeled as accountability structures rather than
  substitutes for claim resolution; and
- explicit exclusion of truth criteria and mandatory reconciliation.

The later observation/admissibility distinction therefore appears to extend
the theoretical landscape rather than directly contradict CEE 0.9.0.

### Chronology

CEE 0.9.0 is dated 2025-12-31.

It predates:

- SE-200 identity-regime work from January 2026;
- later operational-identity work;
- and the Structural Assurability work from September 2026.

The absence of the later observation/admissibility distinction is therefore
chronologically unsurprising.

Chronology alone does not establish whether CEE should eventually incorporate
or reference the later distinction.

## 4. Current Diagnostic Categories

Future regime comparisons should classify discrepancies using the following
categories.

### Terminology only

Two sources express the same semantic distinction using different labels.

### Theory evolution

The later theory deliberately refines, generalizes, narrows, or replaces an
earlier concept.

### Downstream specification drift

The current theory is coherent, but a dependent specification,
implementation, or vocabulary still reflects an older formulation.

### Unresolved

Available evidence is insufficient to determine whether two formulations are
equivalent or different.

### Theoretical conflation exposed by implementation

Implementation, formalization, or experiment demonstrates that distinctions
previously treated as one behave differently under a richer or more faithful
model.

This classification should be used only when supported by evidence.

## 5. Current Open Question

The immediate unresolved identity-regime question is the relationship between:

`ENR_I`

and the earlier:

`OBJ`

The next required step is to read the authoritative current definition of
ENR_I and compare its identity basis directly with SE-200's object-fixed
regime.

Until that definition is available, the relationship should remain marked:

**unresolved**.
