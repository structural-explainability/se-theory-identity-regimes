# SE Unified Referential Semantics: Evidence Protocol and Grounding Ledger (draft v0)

Oct 16, 2026 · @Denise

## Status and scope

This draft sets the working method and the source ledger that the Unified Referential Semantics specification must meet; it asserts no theory itself.

- **Repo / path / file updates:** none. No repository file was created or edited, and nothing was implemented.
- **Sources:** each source below was read in this work. Where a fetch was partial or secondary, the row says so.

Every statement in the later specification carries one of these tags.

| Tag | Meaning                                                                                                                                                                     |
| --- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| F   | Established by prior science, citing a source actually read                                                                                                                 |
| S   | An SE assumption or definition (SE-100, Neutral Substrate Lean, persistence); binding only as far as re-adopted                                                             |
| P   | A program decision by Denise. It can establish scope or methodology but cannot by itself establish a scientific proposition; any such proposition still needs justification |
| K   | A candidate contribution with no external grounding yet                                                                                                                     |
| L   | A lead not yet read; never used as grounding                                                                                                                                |

A definition with no F or S ancestor is K, even if a P decision motivates it. A K definition cannot support another K definition without that dependence being displayed.

## Part 1. Working method and evidence

The theory is built by repeating six steps, and it stands on its definitions, proofs, scientific grounding and explanatory power rather than on the path taken to find it.

1. Develop the scientific definitions from prior theory and the cases.
2. Formalize the relationships and derive their consequences.
3. Test against known cases, counterexamples and new cases.
4. Correct the definitions or assumptions when scientifically warranted.
5. Continue until one coherent, justified theory remains.
6. Preserve and verify the accepted implementation.

Exploratory work is not kept as a permanent research artifact. No finite set of tests shows a theory to be uniquely true; the aim is justified premises, formally verified consequences, independently tested predictions and explicit limits.

### Evidence classes

| Class                       | Meaning                                                        | May be used for                                                  |
| --------------------------- | -------------------------------------------------------------- | ---------------------------------------------------------------- |
| Foundational (F)            | Independently grounded principles and established results      | Deriving definitions                                             |
| Construction (C)            | Cases that informed or shaped the theory                       | Deriving and illustrating, never validating                      |
| Adversarial (A)             | Cases designed to defeat a named candidate definition          | Defeating; a survived attack is weak support                     |
| Independent application (I) | Cases not used to build or revise the definition under test    | The only adequacy evidence                                       |
| Historical (H)              | The nine-regime matrix and the SE-200 / SE-210 classifications | Reporting relations to earlier results; excluded from acceptance |

### What we already hold

All of the following are construction (C) and cannot be reused as independent:

- the SE-210 worked rule example (r0, r1, r2);
- the nine vulnerability-matching case files and their seven commitments;
- the pilot's PURL-preservation corpus and its release boundary;
- the split witnesses BF, AD and RF;
- the alternative bases from the SE-200 inventory and limits text;
- the earlier key-invariance exploration, kept only as a candidate (K1), not as a result.

The matrix and the SE-200 table are historical (H).

### Keeping tests meaningful

1. **Define first.** Definitions are written down before the new cases that test them are chosen.
2. **One use.** A case that fails, or contributes to a revision, becomes C for the revised definition. Testing the revision needs a fresh I case.
3. **Case notes.** Each case notes where it came from and which definitions it shaped or tested.
4. **Selector contamination.** The AI collaborator drafting this has read the matrix and all shaping cases, so any case proposed from memory is contaminated. I cases must come from sources named in advance and be chosen by a stated procedure, ideally by a selector blind to the definitions. The same holds for any other AI collaborator who has seen the theory's direction.
5. **Revision notes.** Each definition revision notes its trigger (a defeater, a new source or a drafting fix) in a line or two. A case-triggered revision moves that case to C.

### Case record schema

| Field                             | Content                                                                                                                                                            |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| ID, domain, referent kind         | Neutral Substrate carrier (entity, occurrence, institutional artifact) plus finer kind                                                                             |
| Source                            | A citable source; for disputed cases, the documented framework and its basis (SE-100 admissibility requires a named source, documented scope and citable basis)    |
| Presentations, references, stages | What was presented, referred to or tracked                                                                                                                         |
| Identity question                 | What question the source actually answers                                                                                                                          |
| In-source verdict                 | One of: same / different / criterion-dependent / insufficient information / inapplicable / operator-underdetermined, recorded from the source, not from our theory |
| Targets                           | The definitions the case attacks or applies to                                                                                                                     |
| Class                             | C, A or I                                                                                                                                                          |

### Coverage

The collection must be able to show failure to generalize. The grid is referent kind by domain by interpretation-dependence.

- **Domains:** institutional identity, physical objects, occurrences, scientific records, changes in organizational responsibility, plus the software and legal domains already held.
- **Dependence classes:** no dispute; documented disagreement between frameworks; insufficient information; transformation that underdetermines identity; question not applying to the kind.

Coverage claims must be supported by appropriate evidence and adversarial testing; untested areas remain explicit limitations. The cases held now cover only software supply chain and one legal example.

### Acceptance criteria

The theory is accepted at a given version only if all six hold:

1. **Coherent derivation.** Every definition and theorem has F or S ancestry or is flagged K, with no unrecorded stipulation; P decisions set scope and method but ground no scientific proposition.
2. **Grounded assumptions.** Each premise cites a source that was read, or is labeled S or K.
3. **Demonstrable adequacy.** I cases are evaluated against predeclared in-source verdict classes; failures are reported, not hidden.
4. **No known defeater.** The adversarial register has no open defeat; each resolved one is either repaired with a revision-log entry or recorded as a scoped limit.
5. **Compatibility with the Neutral Substrate boundary.** SE-100's Referential Common Ground requires the referential commitments to be consistent with every admissible framework. Any identity judgment committed at the substrate layer must meet that test, with invariance defined by consistency, not by agreement (SE-100 remark 14).
6. **Stated limits.** A written scope statement says what is not covered and why.

Finite testing supports a theory; it does not prove it, and the theory will say so.

### What counts as a defeat

A case defeats a definition D if any of these holds:

- D applied to a well-sourced case contradicts the source's documented warranted judgment within the stated interpretation.
- D's consequences contradict another accepted F or S premise.
- D needs a parameter the theory has not defined (the generic analogue of a hidden discriminator).

Agreement with the matrix is not a pass condition, and disagreement with it is not a defeat. Both are reported as relations to H.

## Part 2.1 Foundational sources read

Thirteen rows (F1 to F12, plus F5b) support the semantics; the weakest coverage is Q6, how transformation acts on identity. Q1 to Q6 refer to the six questions the specification must answer (successful whole, sameness across presentations, denotation and co-reference, persistence, interpretation and disagreement, transformation effects).

| ID  | Source and locator                                                                                    | What it establishes                                                                                                                                                                                                                                                                                                            | Bears on                        |
| --- | ----------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------- |
| F1  | Carrara & Gaio, pp. 75-77 (read earlier in this work; not re-read in this pass)                       | The identity-criterion schema, with R an equivalence; Frege's direction example                                                                                                                                                                                                                                                | Q2                              |
| F2  | Stanford Encyclopedia of Philosophy (SEP), "Identity", sections 2-4                                   | Criteria of identity take a two-level form (if x is G and y is G then d(x)=d(y) iff Rxy), which is an implicit definition of a function that merely constrains its referents; the one-level form is x=y iff Rxy; identity is second-order definable; Geach's sortal relativity is "not proven, but not refuted"                | Q2, Q5                          |
| F3  | SEP, "Relative Identity" (first \~100k characters read)                                               | The "same F" completing thesis can be held without relative identity; equivalence relations presuppose identity (Objection 5: identity is logically prior); the ship of Theseus shows ordinary criteria conflicting                                                                                                            | Q2, Q5                          |
| F4  | SEP, "Identity Over Time"                                                                             | The persistence puzzle; perdurantism, and stage theory (Sider, Hawley) where we refer to stages and sameness runs through counterpart relations; phase versus substance sortals, with a substance sortal going with a criterion of identity                                                                                    | Q4                              |
| F5  | Guarino & Welty, "Ontological Analysis of Taxonomic Relationships", ER-2000, Defs 4-9                 | An identity condition is a formula with necessary or sufficient form and an existence predicate over times (Def 4); supplying an identity criterion requires rigidity (Def 6); unity is distinct from identity; a whole under a relation w needs w to be an equivalence relation linking all parts and nothing else (Defs 8-9) | Q1, Q2, Q4                      |
| F5b | Guarino & Welty, OntoClean (CACM version and the v3 PDF, read earlier)                                | Identity criteria are described by a rigid property; the v3 PDF does not say that properties which can be lost cannot carry identity, so phased sortals are not ruled out                                                                                                                                                      | Q2                              |
| F6  | SEP, "Frege's Theorem and the Foundations of Arithmetic"                                              | Hume's Principle contextually defines number by an equivalence relation on concepts and, unlike Basic Law V, is consistent; the body text on the Julius Caesar problem was not in the portion read                                                                                                                             | Q2                              |
| F7  | SEP, "Vagueness", sections 5 and 9                                                                    | Supertruth is truth under all admissible precisifications; the entry does not define "admissible" (it says precisifications are judged by simplicity, conservativeness and fruitfulness); standard objections; Evans's argument that vagueness in identity is linguistic                                                       | Q5                              |
| F8  | SEP, "Reference" and "Gottlob Frege" sections 3.1.1 and 3.2                                           | Informative identity (a=b versus a=a) motivates sense and reference; descriptivists treat co-reference as accidental, while causal accounts treat anaphoric uses as links in reference chains; the "Reference" entry does not define co-reference                                                                              | Q3                              |
| F9  | SEP, "Social Ontology" (excerpt)                                                                      | Status functions ("X counts as Y in C") rest on collective acceptance; the excerpt gave no individuation or persistence criteria for corporations or offices                                                                                                                                                                   | Q1, Q4 (a gap)                  |
| F10 | Renear & Wickett, "Documents Cannot Be Edited" (Balisage 3) and "There Are No Documents" (Balisage 5) | If documents are strings and strings cannot change, document change is a puzzle; the "string-in-a-role" strategy uses rigidity; the authors treat the questions as open                                                                                                                                                        | Q1, Q2, Q4 (documents, records) |
| F11 | Halpin et al., "When owl:sameAs isn't the Same", ISWC 2010 (abstract only)                            | sameAs is one point on a scale of similarity; referentially opaque contexts exist; full text unread                                                                                                                                                                                                                            | Q3, Q5                          |
| F12 | W3C PROV-DM (partial; section 5.5 was not in what could be read)                                      | Entities have fixed aspects, and the same site on different days is a different entity; PROV does not specify conditions for derivation                                                                                                                                                                                        | Q6                              |

## Part 2.2 SE assumptions and program decisions

Nine SE assumptions bind the specification only as far as they are re-adopted; the SE-200 notions (identity regime, basis plurality, hidden regime, induced identity relation) are historical, not assumptions.

| ID  | Statement                                                                                                                                                                                                                                                                                                           | Source                                                                |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| S1  | A substrate provides stable reference for entities, occurrences and institutional artifacts; stable reference consists of individuation, co-reference and persistence                                                                                                                                               | SE-100 `se100.def.Substrate`                                          |
| S2  | A referential regime is the triple of those three conditions. Individuation is when something counts as one thing rather than another; co-reference is when two references refer to the same thing; persistence is when something remains the same across time, transformation, revision or institutional change    | `def.ReferentialRegime`; paper-200 section 2                          |
| S3  | Referential commitments include identifiers, typing, timestamps, provenance and referential relations                                                                                                                                                                                                               | `def.ReferentialCommitments`                                          |
| S4  | A framework is admissible if it is consistent, evidentially grounded, and presented as a documented interpretive function with a named source and citable basis                                                                                                                                                     | `def.AdmissibleFramework`                                             |
| S5  | The framework class is open and not enumerable at design time                                                                                                                                                                                                                                                       | `note.FrameworkClass`                                                 |
| S6  | A proposition is framework-variant if two admissible frameworks entail it and its negation; framework-invariant if adding it stays consistent with every framework. Invariance is by consistency, not by non-refutation                                                                                             | `def.FrameworkVariant`, `def.FrameworkInvariant`, remark 14           |
| S7  | Referential Common Ground: the referential commitments, and any permitted attribution, are consistent with every admissible framework, including unknown ones                                                                                                                                                       | `assump.ReferentialCommonGround`                                      |
| S8  | Neutral Substrate leaves unspecified a denotation relation from references to referents, a stage-to-referent membership relation, existence-at-setting, and equivalence laws for `sameUnit`; it states that individuation, co-reference and persistence are not identified with each other or with carrier equality | Neutral Substrate Lean: `Individuation`, `CoReference`, `Persistence` |
| S9  | `presents` (presentation to referent) exists but carries no totality, functionality or identity consequence                                                                                                                                                                                                         | Neutral Substrate `Individuation`                                     |

## Part 2.3 Program decisions

Five decisions are Denise's direction for the program; they set scope and methodology, but cannot by themselves establish a scientific proposition, which still needs justification.

| ID  | Decision                                                                                                                                                                                                               |
| --- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| P-A | Keys come from justified criteria for individuating and identifying the intended referent. Practice is evidence, not authority. Keys represent criteria and do not found them                                          |
| P-B | Equivalence laws are established where a fixed interpretation and successful whole individuation justify them; they are not imposed globally on Neutral Substrate                                                      |
| P-C | Interpretations are explicit. Judgments warranted within an interpretation are distinguished from judgments supported by referential common ground; agreement among frameworks does not by itself establish neutrality |
| P-D | Semantic disagreement, insufficient information, inapplicability and operator-underdetermination are four distinct conditions                                                                                          |
| P-E | Reuse the eleven dimensions and 17 operators wherever scientifically adequate; they are not assumed exhaustive                                                                                                         |

## Part 2.4 Candidate contributions

Five candidates are open and none is accepted; each depends on the whole-individuation definition that does not yet exist.

| ID  | Candidate                                                                                                                    | Status                                                                             |
| --- | ---------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| K1  | Key-invariance as a representation of a justified criterion                                                                  | Not accepted; its justification depends on P-A and on a derivation not yet written |
| K2  | A relation tying `presents`, `one` and `sameUnit` through whole-individuation conditions                                     | Open; needs the definition of a whole first                                        |
| K3  | A reference-to-referent denotation and a stage-to-referent membership, with co-reference and persistence constrained by them | Open                                                                               |
| K4  | A notion of warrant separating judgments within an interpretation from judgments grounded in common ground                   | Open; must be consistent with S6 and S7                                            |
| K5  | Transformation consequences derived from the criterion plus the Transformation repository's footprint and requirements       | Open; depends on K1 to K4                                                          |

## Part 2.5 Tensions the specification must resolve

T1 is the central one: the substrate must not silently commit to one identity criterion, yet it must still provide stable reference.

| ID  | Tension                                                                                                                                                                                                                                                                                          |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| T1  | **S7 versus basis plurality.** Referential Common Ground requires the substrate's referential commitments to be consistent with every admissible framework, but frameworks can disagree about identity criteria. The theory must say what the substrate commits to when criteria conflict        |
| T2  | **`sameUnit` has no equivalence laws in Neutral Substrate, but F5 defines a whole through an equivalence relation.** P-B says laws are justified locally; the specification must give the local justification conditions                                                                         |
| T3  | **F3 (Objection 5) says equivalence or similarity presupposes identity, while F1, F2 and F6 build identity from an equivalence.** The key-as-criterion move (K1) needs the relation R to be intelligible independently                                                                           |
| T4  | **S3 lists identifiers, timestamps and provenance as referential commitments, while the Neutral Substrate Lean docstring says their presence alone does not constitute referential fixing.** The specification must say what makes such material referential                                     |
| T5  | **Neutral Substrate persistence speaks of "stages of the same continuing unit" with no stage-to-referent membership, while F4 distinguishes perdurantism (stages are parts) from stage theory (stages are the objects).** The persistence specification must stay neutral between them or choose |
| T6  | **F5's identity conditions carry an existence predicate over times; Neutral Substrate persistence has no existence-at-setting.** The relation between `eligibleStage` and existence is undefined                                                                                                 |
| T7  | **Neutral Substrate says persistence is not identified with transformation; the persistence repository defines survival under transformation.** Q6 must connect them without identifying them                                                                                                    |
| T8  | **F7 leaves "admissible" undefined, while SE-100 defines it (S4).** A possible K contribution to supervaluation-style treatment of disagreement; not yet developed                                                                                                                               |

## Part 2.6 Coverage of the six questions

Grounding is thinnest for Q6, transformation effects on identity, and for institutional wholes and persistence.

| Question                            | Grounding present                             | Grounding missing                                                                 |
| ----------------------------------- | --------------------------------------------- | --------------------------------------------------------------------------------- |
| Q1 successful whole                 | F5 (unity as an equivalence-based whole), F10 | Institutional wholes (F9 gave nothing); occurrence wholes                         |
| Q2 same whole across presentations  | F1, F2, F3, F5, F6                            | The Julius Caesar problem (the sortal boundary of abstraction)                    |
| Q3 denotation and co-reference      | F8                                            | A formal account linking references to referents; F8 does not define co-reference |
| Q4 persistence                      | F4, F5                                        | Institutional and obligation-bearer persistence                                   |
| Q5 interpretations and disagreement | F7, F3, S4 to S7                              | Anything on warrant relative to an interpretation; F11 full text unread           |
| Q6 transformation effects           | F12, F10 (partial)                            | Almost nothing; how changes act on identity is the weakest of the six             |

## Part 2.7 Leads not read

These are not grounding until read: Frege's _Grundlagen_ (sections 62 to 69), Wiggins, Geach (primary), Quine, Evans (primary), Lewis on counterparts and "Survival and Identity", Parfit, Sider, Hawley, Kripke, Searle (primary), Hart, Raz, BFO and DOLCE treatments of identity and persistence (the DOLCE deliverable D18 is already in `paper-200-identity-regimes/references/`), PROV-DM section 5.5, the Halpin full text, Bowker and Star, Longino, Haslanger, and Alchourron and Bulygin (existence verified earlier, content not read).
