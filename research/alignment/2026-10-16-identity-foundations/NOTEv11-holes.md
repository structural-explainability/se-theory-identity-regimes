# NOTEv11: Known holes (working record, not accepted theory)

Updated: 2026-10-16

Status codes:

- OPEN: known missing.
- PARTIAL: a formal connection exists, but the stated closure condition is not fully discharged.
- LIMIT: documented limitation, kept visible.
- UNVERIFIED: suspected, proposed, or not checked against the authoritative source.

Source names refer to Lean files, research materials, and repository
artifacts examined in the research sessions.

This is a working research record, not an acceptance judgment.

## Current formalization state

Three theory repositories are relevant to this update:

- `se-theory-transformation`: transformation vocabulary, effect dimensions,
  footprints, required-change clauses, and state models.
- `se-theory-persistence` v0.4.0: generic classification, generated identity,
  invariance, presentations, soundness, completeness, and blindness.
  It no longer depends on Transformation.
- `se-theory-transformation-persistence`: classification lifting and
  dimension-based observation connecting the two foundational theories.

The TransformationPersistence public Lean source includes `Lift.lean`,
`Observer.lean`, and `Conformance.lean`. Its current main-branch Lean CI
completed successfully.

IdentityRegimes remains at published v0.3.1. Its proposed Persistence bridge,
including applicability restoration and identity-relation collapse theorems,
has been examined in the research sessions but was not present in the
public main branch at this check.

The principal scientific boundary remains:

Mathematical correctness of an observation or generated identity relation
does not independently establish that the model represents the identity
of an intended referent.

## A. Missing structure

H11-01 PARTIAL. Observability now has a formal Transformation–Persistence bridge.

Persistence/Relation/Invariance.lean defines `observationalEquivalence Φ`
over a family of predicates.

Persistence/Relation/Observability.lean defines `presentable π` and proves
`observationalEquivalence_presentable_iff`, relating observational
equivalence to equality of presentations.

Transformation/Effect/Model.lean supplies per-dimension `agree`
within `StateModel`.

TransformationPersistence/Observer.lean supplies:

- `dynamicsOf`
- `AgreesOn`
- `observerSetoid`
- `observe`
- `observe_eq_iff`
- `presentationSound_observe_iff`
- `presentationSound_of_disjoint`
- `maximalModel_agrees_iff_disjoint`
- `presentationSound_observe_maximal_iff`
- `detectsBreaks_maximal_iff`

Together, `observationalEquivalence_presentable_iff` and
`observe_eq_iff` give the formal connection between predicates
presentable through a dimension observer and agreement on those dimensions.

The connection can be expressed by composing the existing theorems.
A separately registered combined theorem was not identified.

The bridge establishes model-relative conditions for presentation
soundness and detection of required changes.

It does not establish that a selected observer, dimension interpretation,
or classification is scientifically adequate for an intended referent.

Remaining:

- State the combined observational-equivalence/dimension-agreement result
  explicitly if it is needed as a public research claim.
- Independently justify the interpretation of the observed dimensions.
- Establish the relevant referent-specific assumptions rather than
  treating the abstract construction as sufficient.

H11-02 OPEN. "Meaningful for the referent" remains underdetermined.

Persistence represents transformation applicability through
`Classification.Applicable` and `pattern t = none`.

Transformation supplies dimension-level agreement, footprints,
and required-change clauses.

The Observer module specifies which dimensions are observed.
It does not determine which dimensions are meaningful for
individuation or persistence of a particular referent kind.

H11-03 OPEN. "Known with justified confidence" has no formal home.

`Dimension.evidence` represents claims, verification, and attestation
metadata attached to participants.

It does not represent justified confidence that an observed dimension
accurately describes an intended referent.

No independently warranted belief or evidence-quality layer was established.

H11-04 OPEN. Invariance warrant.

Persistence characterizes soundness through invariance of
presentable predicates.

TransformationPersistence now establishes additional results:

- `presentationSound_observe_iff` characterizes soundness through
  agreement across all preserving steps.
- `presentationSound_of_disjoint` derives soundness from footprint
  disjointness under any `StateModel` satisfying its laws.
- `presentationSound_observe_maximal_iff` provides an exact
  characterization in `maximalModel`.

This resolves a formal question: specified transformation-effect
assumptions can imply presentation soundness.

It does not resolve the scientific question:

Why should a chosen footprint, classification, state model, or
dimension agreement relation be accepted as describing the
intended referent?

The independent justification remains relative to an appropriate
interpretation, threat model, error model, or evidence model.

H11-05 OPEN. Completeness warrant.

Persistence/Relation/Observability.lean defines
`Classification.PresentationComplete`, characterizes completeness,
and proves that non-completeness corresponds to observational blindness.

Its results include:

- `presentationComplete_iff`
- `presentationComplete_iff_invariants_determined`
- `identityRel_of_complete_of_eq`
- `not_presentationComplete_iff_blind`
- `presentation_blind_example`

TransformationPersistence/Observer.lean does not establish
presentation completeness.

Nothing yet warrants completeness for an intended referent kind.

Positive co-reference based on equal presentations requires
a justified completeness condition.

Separation can use a sound presentation that distinguishes states;
equality of presentations alone does not establish identity.

H11-06 OPEN. Independent records.

Persistence relates states of one carrier under supplied dynamics.

TransformationPersistence obtains its dynamics directly from a
Transformation `StateModel`.

Neither construction establishes how separately produced records
denote the same or different referents.

Their causal independence, record-generation processes, and
evidential relationships remain unmodeled.

H11-07 OPEN. Denotation.

`ReferentCarriers` in Neutral Substrate provides abstract carrier types.

Persistence's dynamics carrier `C` is not formally connected to
those referent carriers by the examined bridge.

IdentityRegimes/Profile/Core.lean has now been examined.

It defines `IdentityBasis`, `ProfileAxes`, `Regime.axes`, and
`RegimeProfile`.

These distinguish canonical regime profiles and record their
structural axes, but do not supply a denotation map from observations
or records to a particular referent.

The missing relationship remains between:

- a world referent;
- a record or representation;
- the state-model configuration;
- the modeled identity relation;
- warranted claims about actual referent identity.

H11-08 OPEN. Two transformation vocabularies without a mapping.

Transformation theory has:

- 17 operator codes;
- 14 transformation families;
- 7 transformation kinds;
- 11 effect dimensions.

IdentityRegimes has:

- a ten-element transformation basis;
- nine canonical derived regimes;
- a 9 × 10 classification matrix.

IdentityRegimes/Vocab/TransformBasis.lean has now been examined.

Its transformation basis is:

RE, AN, RF, AD, RC, RA, SU, BF, PV, SE.

RE is defined as re-expression: change of representation format
while preserving content.

Thus the earlier uncertainty about what RE denotes is resolved
at the vocabulary-description level.

No formally justified mapping from these ten categories to
Transformation's operators, families, or kinds has been established.

TransformationPersistence/Lift.lean provides family-to-operator
and kind-to-operator classification lifting within Transformation's
own taxonomy.

It does not supply the missing IdentityRegimes vocabulary mapping.

H11-09 OPEN. Derived-versus-tabulated check not performed.

Transformation/Effect/Model.lean provides
`step_preserves` and `step_breaks`.

TransformationPersistence/Observer.lean now provides soundness and
visibility criteria over selected dimensions.

These results may constrain classifications when the following
are supplied:

- a mapping between the two transformation vocabularies;
- a state-model interpretation;
- independently justified regime-specific identity criteria;
- the relevant dimension sets.

They do not currently derive or certify cells of the
IdentityRegimes 9 × 10 matrix.

Footprints are upper bounds, and required clauses specify
necessary changes without always identifying a unique changed dimension.

H11-10 OPEN. Two missing interpretation maps.

- World operation → OperatorCode.
- Observed field → Dimension.

Without these maps and their justification, the abstract effect
laws do not establish facts about an observed system.

The Observer module assumes dimension agreement is already supplied.
It does not construct or validate these interpretation maps.

H11-11 OPEN. Disjunctive required clauses and referent identity.

Examples:

- CP requires change in referentPopulation or representationPopulation,
  and also requires lineage change.
- MG requires change in composition or referentPopulation.
- VS requires lineage change.

The state model does not always determine which alternative dimension
changes in a particular step.

TransformationPersistence/Observer.lean does establish when
an observer necessarily detects every step of an operator:
in `maximalModel`, the observed dimensions must contain a
complete required-change clause.

This resolves the formal visibility question for that model.

It does not decide whether an observed change constitutes a change
of referent identity.

H11-12 OPEN. Content sensitivity in likelihood form is not formalized.

The existing transformation content dimension supplies a qualitative
agreement criterion, not a likelihood model.

H11-13 OPEN. Directed versus symmetric evidence.

Persistence distinguishes:

- `Survives`: directed reachability through preserving steps.
- `identityRel`: the equivalence relation generated by preserving steps.

The Observer module evaluates presentations against the generated
identity relation.

Directed evidence, such as successive file states, has not been
connected to an independently justified interpretation of either relation.

## B. Limits kept visible

H11-20 LIMIT. BRK does not generally imply nonidentity.

Persistence/Relation/NonCollapse.lean includes
`stepBrk_not_separating`.

Only PRS-classified steps generate the modeled identity relation.

A BRK-classified step may connect states that are also related by
the generated identity relation.

Free-dynamics separation results remain model-specific.

TransformationPersistence adds a different route to separation:

A sound presentation that distinguishes two states establishes
nonidentity relative to the generated identity relation.

Detecting a breaking step is not, by itself, sufficient.
Soundness and the relevant model assumptions must also hold.

H11-21 LIMIT. N/A is folded into IGN in the IdentityRegimes matrix.

IdentityRegimes/Transform/Core.lean explicitly documents the
N/A → IGN convention for eight cells.

Persistence represents inapplicability separately from IGN through
an optional classification value.

Persistence also proves that forgetting applicability through
the coarse classification leaves the preserving set unchanged.

A proposed IdentityRegimes/PersistenceBridge.lean restores the
eight applicability distinctions and relates the result to the
existing total classification matrix.

That proposed IR bridge is not yet verified as part of the
published IdentityRegimes public surface.

Its draft also leaves the independently declared persistence set
empty; it should not be interpreted as establishing a substantive
referent-specific persistence set.

H11-22 LIMIT. Equal PRS sets in two regime pairs.

- OBL and NOR-C have equal preserving sets.
- CTX-S and NOR-S have equal preserving sets.

The original IR rows are distinct because some non-PRS cells differ.

Persistence establishes that classifications with the same
preserving sets generate identical identity relations on every
shared dynamics.

The proposed IR Persistence bridge applies that result to the
two named regime pairs.

The distinction between nine classification rows and
identity-relation non-collapse is substantive.

On a shared dynamics, those two pairs cannot be separated by
the generated identity relation as presently defined.

Thus nine distinct rows do not establish nine distinct
generated identity relations.

Carrier-based or other referent-specific separation is not
established by these matrix distinctions.

The proposed IR-specific bridge theorems still require verification
against the completed public IR implementation.

H11-23 LIMIT. Non-collapse results use one shared carrier.

Persistence's comparison of generated identity relations assumes
a common dynamics and carrier.

Carrier-sensitive regime separation is outside that comparison.

No general theorem was established that converts distinct identity
bases or carriers into distinct identity relations for the
intended referents.

H11-24 LIMIT. Footprints are upper bounds.

An omitted dimension asserts that the named operator leaves it unchanged.

Required clauses provide lower bounds on change.

Incidental changes are separate operator steps.

The maximal model permits every change compatible with its
footprints and required clauses.

Consequently, the exact Observer characterizations for
`maximalModel` are not automatically exact characterizations
of narrower state models or real systems.

The theory constrains its modeled operator, not arbitrary
tool behavior.

## C. Terminology collisions

H11-30 "dimension".

- Transformation/Effect/Dimension.lean: an axis of modeled change.
- Transformation operator semantics: characteristic or principal
  structural change.
- Observer.lean: a selected axis of agreement used in a presentation.
- Proposed referent-level structural dimensions: properties relevant
  to referent identity.

The mathematical connections are clearer, but these notions
must not be treated as interchangeable without interpretation.

H11-31 "evidence".

- `Dimension.evidence`: claims, verification, and attestation metadata.
- Epistemic evidence: grounds that warrant an identity conclusion.

These remain distinct.

H11-32 "observational".

- `TransformationKind.observational`: an operator kind in the
  Transformation taxonomy.
- `observationalEquivalence`: agreement on a family of predicates
  in Persistence.
- `observe`: a dimension-based presentation in TransformationPersistence.
- Scientific observability: justified ability to discriminate
  properties of an intended referent.

The Observer module connects the two formal notions but does not
establish the last one.

H11-33 "invariant".

- Persistence `Invariant`: unchanged across preserving steps.
- Paper 100 framework-invariance: a separate theoretical notion.

Do not identify them without a theorem establishing the relationship.

H11-34 "IGN" is written NEU in SE-200.

Persistence owns the canonical Lean constructors:

- `ign`
- `prs`
- `brk`

IdentityRegimes' duplicate uppercase classification type is scheduled
for replacement by the Persistence-owned type.

The distinction between IGN and N/A must remain explicit.

H11-35 UNVERIFIED. `Traceable` in StructuralExplainability.lean
versus provenance traceability.

The definition has not been retrieved and compared in this review.

## D. Paper 100

The following findings are carried forward unchanged.
They were not independently reverified in this update.

H11-40. Stable reference lists individuation, co-reference and persistence.

"unity", "denotation" and "observability" do not occur.
The only "denot" hits are the verb "denote".

H11-41. Co-reference is a condition only.

It has no warrant side.

H11-42. Referential Common Ground is likely to fail for
evidence-relative co-reference of occurrences.

The boundary section's attributed-claim treatment is not
worked out for it.

H11-43. The promised analysis of which regimes yield
common-ground commitments (Definitions section, after
Referential Regime) is not delivered.

H11-44. The boundary example involving two records of the
same or distinct institutional event is not tied to an
evidence criterion.

## E. Case-study holes

The following case-study findings are carried forward unchanged.
No new case-study verification was performed in this update.

H11-50 DCS: BLOCKED (evidence access).

Carry M1–M8 and R1–R5 from v0.10 unchanged.

H11-51 OPEN. No occurrence kind with causally separate records identified.

The vulnerability-matching repository was unread in the prior review.

H11-52 Pilot observations.

These are findings about what the pilot can show.
The pilot repository owns any corrective action.

a. `noncanonical_slots` is declared only for CycloneDX.
SPDX loaders never fill `other_purls`.
A relocation into an SPDX target is reported as VIOLATED_DROPPED.

b. design.md: 8 CycloneDX + 2 SPDX sources, 20 executable routes =
16 CycloneDX→SPDX + 4 SPDX→CycloneDX.
Relocation is observable in at most 4 of 20 routes.

c. NOT_APPLICABLE merges "no PURL" and "unparseable PURL".
An unparseable target canonical PURL yields DROPPED, not ALTERED.

d. UNSUPPORTED is unreachable under the current commitment
(`representable_in` lists all three formats).

e. test.md's outcome list omits UNDERDETERMINED.

f. `purl_canonical.py` uses `except TypeError, ValueError:`,
valid only on Python 3.14+.

g. UNVERIFIED. The SPDX 3.0 adapter reads `packageUrl`
and `spdxVersion`. Real JSON-LD field names were not confirmed.

h. The DROPPED detail string
("absent from the anchored target component")
overstates what the adapter observes
(canonical and declared noncanonical slots only).

i. Anchors are declared hashes, never computed.
Anchor preservation is untested
(schema.md assigns it to a separate commitment).

j. Source and target are dependent by construction.
The pilot does not test independent co-reference.

## F. Reading debt

### Examined since the original NOTEv11

- SE.Persistence.Relation.Observability
- SE.TransformationPersistence.Lift
- SE.TransformationPersistence.Observer
- SE.TransformationPersistence.Conformance
- SE.IdentityRegimes.Vocab.TransformBasis
- SE.IdentityRegimes.Profile.Core
- SE.IdentityRegimes.Transform.Core
- SE.IdentityRegimes.Transform.NonCollapse

### Still requiring examination or reconciliation

- SE.Substrate.ReferentialRegime / SubstrateSystem /
  Commitment / ReferentialCommitments.
- SE-300 §4–5 against the current formal distinctions between
  classification-row non-collapse and identity-relation non-collapse.
- Proposed SE.IdentityRegimes.Transform.PersistenceBridge,
  after integration into the public IR build.
- SE.NeutralSubstrate.Attribution.Permitted and CommonGround.
- se-verification-vulnerability-matching.
- Intended referent interpretations of state models,
  dimensions, and classification assumptions.
- Pilot files:
  - 03-corpus.toml
  - 05-transformations.toml
  - build_and_selftest.py
  - FREEZE_01_COMMITMENT_EVALUATOR.md
  - known_violations.toml
  - a real SPDX 3 sample

## G. Research assessment

The formal architecture has advanced.

Persistence now provides generic presentation soundness,
completeness, and blindness results without importing Transformation.

TransformationPersistence now relates selected dimensions,
state-model dynamics, footprints, required changes, and
presentation soundness.

These are mathematical achievements with explicit assumptions.

The main remaining scientific obligations concern:

- independently justified identity criteria for intended referent kinds;
- interpretation and warrant of observed dimensions;
- the relationship between presentations, records, and denoted referents;
- justified soundness and completeness assumptions;
- the connection between IdentityRegimes classifications and
  actual persistence relations;
- evidence that proposed interpretations discriminate genuine
  identity and nonidentity rather than merely formal classifications.

The nine-regime result requires particular care.

Pairwise distinct classification profiles are established.
Nine distinct generated identity relations are not established.
Two pairs with equal preserving sets provide concrete limits
on the stronger interpretation.

No unresolved scientific obligation is closed merely because
the relevant Lean definitions compile or their theorems are proved.
