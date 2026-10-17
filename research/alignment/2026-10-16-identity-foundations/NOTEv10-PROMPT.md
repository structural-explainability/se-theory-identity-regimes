# Structural Explainability — Independent Scientific Reconciliation and Evidence Feasibility

## Research Task

Continue the scientific development of Unified Referential Semantics for Structural Explainability (SE).

**Immediate research question:**

For the NIST Disk Chopper Spectrometer (DCS), can publicly inspectable, independently justified evidence establish that two presentations identify one particular physical acquisition episode, or does the available evidence leave multiple distinct acquisition histories compatible with the observations?

The objective is to critically reconcile two independently produced v0.9 investigations, correct scientifically unsupported claims, and determine whether the DCS case can support the required empirical test.

This is a scientific investigation, not a coding or repository-maintenance task.

**Do not assume that either v0.9 candidate is adequate or that combining them produces an adequate theory.**

A negative finding is acceptable. A scientifically justified decision to suspend the DCS case is preferable to repeatedly constructing unvalidated identity criteria.

## Supplied Research Documents

The following documents are attached:

1. `NOTEv08.md` — Consolidated current state of SE research.
2. `NOTEv09.md` — ChatGPT's DCS evidence and co-reference investigation.
3. `NOTEv09-c.md` — Claude's independent DCS investigation.
4. `NOTEv07.md` — Earlier DCS occurrence-individuation investigation.

Read these documents before beginning.

The v0.9 investigations are **independent provisional scientific reports**. Neither is authoritative over the other.

Use v0.8 for the established research context and v0.7 for earlier operational findings and qualifications.

Do not treat agreement between reports as independent empirical evidence.

All prior definitions, assumptions, classifications, and formalizations remain revisable where scientific adequacy requires it.

## Mandatory Research Protocols

Use the canonical protocols from:

https://github.com/structural-explainability/se-protocols-research

Read the actual instructions:

1. `protocols/source-audit/SKILL.md`
2. `protocols/independent-review/SKILL.md`
3. `protocols/theory-construction/SKILL.md`

Apply source-audit to external scientific claims, independent-review to the competing v0.9 proposals, and theory-construction only where the evidence justifies constructing or revising a candidate.

The subsequent theory-acceptance stage uses:

1. `protocols/theory-acceptance/SKILL.md`

**Do not perform theory acceptance in this investigation.**

The protocols govern research methodology; they do not dictate scientific semantics.

## Scientific Standard

Maintain the distinction among:

1. **Mathematical correctness:** Conclusions follow from stated definitions and assumptions.
2. **Scientific adequacy:** Those definitions and assumptions adequately represent the intended empirical phenomena, with independently justified interpretations and meaningful counterexamples.
3. **Original theoretical contribution:** The theory establishes substantive results not merely stipulated by its assumptions or already contained in the operational source.

In addition, distinguish:

- Actual numerical identity.
- Successful denotation.
- Evidence warranting a denotation.
- Evidence warranting co-reference.
- Independent corroboration of an identity claim.
- Uncertainty arising from incomplete or unreliable observations.

Do not make independent corroboration a necessary condition of numerical identity merely because it is valuable for scientific validation.

Do not treat a proposed predicate, evidential chain, hash, identifier, or discriminator as scientifically sufficient without establishing its interpretation and adequacy.

Unresolved foundational obligations remain OPEN.

---

# Phase I — Critical Comparison of the v0.9 Reports

## I.1 Recover the actual candidate proposals

Reconstruct each candidate faithfully.

The two reports both use the label `C-DCS-2`, but their scientific conditions differ.

Disambiguate them as:

- `C-DCS-2-ChatGPT`
- `C-DCS-2-Claude`

Do not merge them merely because their names and conclusions overlap.

For each candidate, identify:

- Intended referent.
- Existence conditions.
- Operational individuation.
- Run boundaries.
- Constituent activities.
- Denotation conditions.
- Evidential assumptions.
- Co-reference criterion.
- Treatment of competing explanations.
- Treatment of uncertainty.
- Conditions claimed necessary.
- Conditions claimed sufficient.

## I.2 Compare scientific claims

Classify each important claim as:

- VERIFIED FROM PRIMARY SOURCE
- REPORTED OBSERVATION — NOT INDEPENDENTLY REPRODUCED
- SOURCE-SUPPORTED INFERENCE
- ADDITIONAL ASSUMPTION
- MATHEMATICAL CONSEQUENCE
- CONJECTURE
- COUNTEREXAMPLE
- UNSUPPORTED
- UNRESOLVED

Identify agreement, disagreement, and genuine new information.

Do not silently reconcile conflicting claims.

## I.3 Audit known concerns

At minimum, investigate the following.

**A. Causal independence**

Claude proposes that two attribution chains must share no link after the physical trace.

Determine whether this condition is scientifically justified, too restrictive, insufficient, or dependent on a particular threat or error model.

Distinguish independence of:

- Authors.
- Software processes.
- Records.
- Measurement channels.
- Identifier assignment.
- Attribution mechanisms.
- Error mechanisms.

Two records sharing a legitimate source do not automatically lose all evidential value.

Conversely, separately authored records can inherit one common attribution error.

**B. Content sensitivity**

Claude proposes that an identifying record should contain information that would differ if another run had been performed.

Examine whether this condition is necessary, sufficient, probabilistic, or unsupported.

Different physical executions can sometimes produce indistinguishable recorded outputs.

A scientifically useful discriminator must specify its error behavior and intended evidential force.

**C. Hash and file-state identity**

Critically assess the claimed implications among:

- Equal SHA-256 hashes.
- Equal file contents.
- Identical stored objects.
- Different temporal versions of one file.
- One physical acquisition episode.
- Two distinct episodes producing compatible data.

Do not confuse cryptographic collision-resistance assumptions with logical guarantees.

Do not infer occurrence identity merely from equal content.

**D. Histogram monotonicity**

Evaluate Claude's `CJ-A` conjecture.

Determine whether NIST's documented acquisition behavior supports binwise nondecreasing histogram values across successive file states of one run.

Consider:

- Rejected cycles.
- Memory clearing.
- Accumulation.
- Intermediate file writes.
- Replacement of file contents.
- Histogram processing.
- Detector behavior.
- Measurement and storage error.

Distinguish a necessary condition, a probabilistic indicator, and a sufficient discriminator.

Do not present an untested conjecture as a validated scientific law.

**E. Observed metadata**

Audit Claude's claim of 21 DCS rows from the live NIST metadata API.

Determine what was actually observed and whether it can be independently reproduced.

In particular, distinguish equal selected metadata attributes from completely identical records.

The reported records have different filenames or timestamps.

Repeated metadata fields do not independently establish repeated physical configurations, interruptions, restarts, or occurrence identity.

---

# Phase II — Focused Primary-Source and Evidence Audit

## II.1 Operational source

Begin with the NIST DCS Users' Guide:

https://www.nist.gov/ncnr/dcs-users-guide

Inspect the relevant primary sections concerning runs, acquisition cycles, sequences, stopping operations, datafiles, and logs.

Determine exactly what the guide establishes concerning:

1. Actual acquisition initiation.
2. Memory clearing.
3. Cycle continuation.
4. Datafile creation and replacement.
5. Cycle rejection.
6. Early termination.
7. Run restarts.
8. Run-buffer numbering.
9. File serial numbering.
10. Mapping between these identifiers.

Distinguish the documented operational rules from assumptions about their applicability to current instrument behavior.

## II.2 Live metadata audit

Investigate the publicly documented NIST metadata service:

https://www.ncnr.nist.gov/ncnrdata/metadata/search/api_docs.html

Attempt to reproduce the DCS records reported in `NOTEv09-c.md`.

Check:

- The actual endpoint and query parameters.
- Whether instrument filters function as documented.
- Whether pagination changes the sample.
- The complete returned filename values.
- The complete original `start_date` strings, including timezone offsets if present.
- The meaning of `experiment_id`.
- The meaning of `rxcycle_id`.
- The semantics of `start_date`.
- The role of `sha256`.
- The meaning of `metadata = null`.
- Whether records are directly generated from acquisition datafiles.
- The relationship between the metadata index and the physical acquisition process.

Do not treat a filtered or unfiltered sample as a complete population.

Record the exact source, observation date, inspected fields, and limitations.

If the live results cannot be reproduced, retain Claude's observations as unverified rather than rejecting or accepting them automatically.

## II.3 Actual evidence availability

Investigate whether one identifiable DCS acquisition episode can be connected to:

- Its raw datafile.
- Acquisition start evidence.
- Acquisition termination evidence.
- A run-control or sequence log.
- A separately produced instrument-state record.
- A relevant experimental logbook.
- An independently authored observation or attestation.

For each record, determine whether it is:

- Publicly accessible.
- Actually inspected.
- Authenticated.
- Specific to the selected episode.
- Derived from another available record.
- Independent of the other evidence in a scientifically relevant sense.

Do not mistake a raw file and metadata extracted from that file for two independent observations.

Do not mistake an inaccessible source for an absent source.

Do not invent data or work around source-access restrictions.

## II.4 Explicit evidence-access decision

At the end of this phase, state whether the public evidence is sufficient to attempt a genuine positive cross-record identity test.

Use one of:

- **FEASIBLE:** The required records and attribution information were actually recovered.
- **PARTIALLY FEASIBLE:** Relevant evidence exists, but one or more essential relationships remain unverified.
- **BLOCKED:** The required evidence was not accessible or sufficient for the proposed test.

Explain the basis.

A BLOCKED verdict concerns the present evidential investigation. It does not prove that no adequate criterion exists.

---

# Phase III — Scientific Evaluation of Co-reference

## III.1 Separate three problems

**Constitution**

What makes the selected physical execution one operational occurrence rather than several?

**Denotation**

What establishes that a particular presentation identifies that occurrence?

**Warrant**

What evidence justifies accepting or rejecting the denotation or co-reference claim?

Do not substitute an answer to one question for an answer to another.

## III.2 Examine possible evidence criteria

Evaluate the following without presupposing their necessity or sufficiency:

- Authenticated acquisition-control history.
- Traceable record production.
- Content-sensitive measurements.
- Independent observation.
- Agreement between records.
- Common identifiers.
- Reliable shared provenance.
- Exclusion of plausible competing episodes.
- Absence or resolution of material defeaters.

Determine which conditions are supported by sources, which are additional assumptions, and which remain conjectural.

Avoid imposing universal causal disjointness if justified reliability and error modeling would permit scientific identification through shared infrastructure.

## III.3 Competing physical histories

Construct at least two distinct admissible acquisition histories that could produce the same accessible evidence, if the sources permit.

One should involve genuine co-reference.

The other should involve distinct acquisitions or an erroneous attribution.

Determine whether any actually recovered evidence discriminates them.

An identity criterion is not adequate merely because it succeeds in a mathematical model whose admissible histories were chosen to exclude the counterexample.

## III.4 Evidential certainty

Do not confuse:

- Logical entailment.
- Scientific identification under accepted operational assumptions.
- High-confidence probabilistic inference.
- Unvalidated heuristic matching.

If the evidence supports only a probabilistic conclusion, identify the relevant uncertainty and the assumptions needed to quantify it.

Do not demand logical certainty from empirical evidence without justifying that standard.

Conversely, do not call a probabilistic indication conclusive numerical identity.

---

# Phase IV — Adversarial Testing

Test the strongest defensible candidate against:

1. Two distinct runs with the same recorded configuration.
2. Two distinct runs producing identical or observationally indistinguishable content.
3. Two genuine records of the same run sharing a trustworthy acquisition source.
4. Two separately created records sharing an incorrect attribution.
5. One run associated with two different identifiers.
6. Two runs accidentally assigned the same identifier.
7. Changing file contents within one run.
8. A rejected acquisition cycle.
9. An interruption followed by resumption.
10. A completed or aborted run followed by another start.
11. A command that does not initiate acquisition.
12. A later correction to metadata.
13. Contradictory but individually authenticated records.
14. An experiment-level designation encompassing multiple runs.
15. Two distinct files containing exactly equal bytes.
16. One file and a database record derived entirely from that file.

For each case, state:

- Expected identity judgment, where justified.
- Candidate prediction.
- Primary-source basis.
- Additional assumptions.
- Evidential dependencies.
- Counterexample or unresolved ambiguity.
- Consequence for the candidate.

Distinguish observed empirical cases from constructed examples.

Do not describe constructed cases as independent validation.

---

# Phase V — DCS Case Feasibility Decision

Determine whether continuing with DCS is scientifically productive.

This is a decision about the research case, not about the truth of the general SE research program.

**Continue the DCS investigation** if independently interpretable occurrence-specific evidence is accessible and permits a meaningful test.

**Suspend the DCS investigation** if the essential records are inaccessible or the available evidence cannot discriminate competing histories.

If suspension is justified:

- Preserve the source-grounded operational conclusions.
- Preserve the scientifically valid counterexamples.
- Keep cross-record identity unresolved.
- Identify exactly what evidence is missing.
- State what would permit reopening the case.
- Do not invent a replacement theory.
- Do not automatically claim that another domain solves the problem.

A more accessible occurrence kind may be investigated in subsequent research, but must satisfy the same scientific requirements.

---

# Phase VI — Implications for Existing SE Theory

Assess only consequences justified by this investigation for:

- Neutral Substrate.
- Unified Referential Semantics.
- Persistence.
- Transformation.
- Identity Regimes.
- Structural Explainability integration.

Where source-level assertions are necessary, inspect authoritative Lean files rather than relying on previous AI descriptions.

Distinguish:

- What remains mathematically valid.
- What is scientifically supported.
- What requires narrowing.
- What may need revision.
- What cannot yet be determined.

Do not change the repositories.

Do not treat existing Lean theorems as independent empirical validation.

Do not force the findings into existing classifications, dimensions, or transformation operators.

---

# Required Research Output

Produce one coherent report provisionally designated:

**Scientific Development Note v0.10 — Critical Reconciliation and Evidence Feasibility for Concrete Occurrence Identity**

Use these sections:

A. Research question, protocols, and source authority.

B. Comparative scientific findings from the two v0.9 reports.

C. Corrections, disagreements, and unresolved assumptions.

D. Primary-source audit and independently verified empirical observations.

E. Grounded DCS occurrence individuation.

F. Evaluation of competing co-reference criteria.

G. Adversarial cases and falsification results.

H. Scientific adequacy and potential original contribution.

I. Implications for existing SE theory.

J. Deferred-obligation ledger, including the disposition of obligations from both v0.9 reports.

K. Case-feasibility decision and theory-construction verdict.

L. Exactly one recommended next scientific question.

## Required verdict

Use exactly one theory-construction verdict:

- ACCEPT
- ACCEPT WITH NARROWING
- REJECT
- FUNDAMENTAL QUESTION REMAINS

Do not confuse a theory-construction verdict with formal scientific acceptance.

Report the separate DCS evidence-access decision as FEASIBLE, PARTIALLY FEASIBLE, or BLOCKED.

Neither verdict authorizes canonical adoption.

## Formatting

Provide the complete report as Markdown directly in the conversation, enclosed in **four backticks** for copying into a research note.

Include Mermaid diagrams where they materially clarify the scientific or evidential dependencies.

Use precise primary-source references, including relevant sections.

Clearly distinguish:

- Verified evidence.
- Reported but unreproduced observations.
- Inferences.
- Assumptions.
- Conjectures.
- Constructed counterexamples.
- Open obligations.

Do not state that a source was inspected unless its content was actually retrieved and examined.

## Research Boundaries

- Read-only investigation.
- Do not change repositories.
- Do not edit Lean.
- Do not create implementation code.
- Do not revise papers.
- Do not create research protocols.
- Do not perform theory acceptance.
- Do not silently combine competing candidate definitions.
- Do not treat agreement among AI reports as scientific verification.
- Do not substitute a mathematical predicate for independently justified scientific semantics.
- Do not assume that source independence requires completely disjoint causal histories.
- Do not assume that shared provenance establishes correctness.
- Do not generalize prematurely from one occurrence kind.
- Do not resolve foundational obligations by delegating them downstream.

## Final Scientific Requirement

The investigation must answer whether there is presently sufficient independently justified evidence to establish that two actual presentations identify one particular DCS acquisition episode.

If that claim cannot be established, say so explicitly.

Then determine whether the DCS case remains a viable empirical test case or whether its evidential limitations justify suspending further DCS-specific theory construction.

**The objective is not to produce another complete-looking identity theory. The objective is to discover what scientific evidence can actually establish, and to stop where the evidence stops.**
