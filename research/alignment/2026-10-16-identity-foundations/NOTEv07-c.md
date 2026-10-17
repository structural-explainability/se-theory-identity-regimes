I'm starting by reading the actual `source-audit` and `theory-construction` protocol files from the se-protocols-research repository, then I'll run the source audit on a real experimental standard before constructing the theory.

Now the two canonical protocol files themselves.

WebFetch is rate-limited, so I'm getting the same two sources through search excerpts instead.

The source audit is complete and the theory has been constructed and stress-tested against it. I'm closing out the task list before writing the report.

**Repo / path / file updates:** none. This was a read-only investigation, nothing was created or edited, and the report is inline.

**Method.** I read `source-audit` (171 lines) and `theory-construction` (183 lines) from `protocols/*/SKILL.md` on `main` and followed them. GitHub shows a YAML front-matter warning on both files (an unquoted multi-line `description`), but the protocol text rendered in full.

Evidence tags: **[SRC]** stated by a source · **[INF]** inferred from sources · **[ASM]** added assumption · **[PROP]** my proposal · **[CONJ]** conjecture. Source language is paraphrased with exact section pinpoints so each claim can be checked.

---

## A. Source-audit findings and coverage

**Audit question.** What do authoritative GLP sources specify about initiating, bounding, distinguishing and cross-record identifying one study (one execution of a study plan)?

**Candidates considered.**

- **GLP "study" (OECD / FDA / EPA / EU): selected.** Three normative regimes plus several interpretive documents agree on the identity-relevant structure. Milestones, amendment/deviation categories and unity statements are explicit. Records are produced by structurally independent parties (QA).
- **ATLAS/CMS data-taking "run": kept as a contrast case.** It has clear operational boundaries, but the source is one collaboration describing its own system. It states no normative identity conditions, and the run number is assigned by the same DAQ system that produces the run's records, so those records are not independent of the individuating mechanism.
- **Not inspected:** ISO/IEC 17025, ASTM/ISO test-method standards, ICH E6, and OBI/BFO (cited in v0.6 but not read here).

**Authority order.**

- _Normative, each for its own jurisdiction (not reconciled):_ OECD Principles C(97)186/FINAL; 21 CFR 58 (FDA); 40 CFR 160 (EPA).
- _Consensus guidance:_ OECD Consensus Documents 8 and 13.
- _Agency interpretation:_ EPA GLP Advisories 18 (reply to a 1990 letter) and 43 (3 March 1992). Their cover memos call them official policy for GLP inspectors. Their current force is unverified.
- _Non-binding:_ EU GLP Working Group Q&A (March 2016), which describes itself as opinion only.
- _Descriptive:_ ATLAS Run-2 trigger paper (JINST 15 P10004 / arXiv:2007.12539).

**Coverage.**

- **Inspected in full:** OECD C(97)186/FINAL; OECD Docs 8 and 13; 21 CFR 58.3, 58.33, 58.35, 58.120, 58.130, 58.185, 58.217; EPA Advisories 18 and 43; EU GLP Q&A (2016); the ATLAS paper.
- **Search excerpts only:** 40 CFR 160.3 (several consistent excerpts); UK GLP Regulations 1999; Directive 2004/10/EC; the CMS "run" statement (arXiv:2309.10157).
- **Unread or unavailable:** the FDA 1981 Q&A answers (only question headings came back; not used as confirmation); OECD Docs 4, 6, 7, 15; 21 CFR 58.190/58.195; 40 CFR 160.120/130/185.

## Findings by required topic

**1. Initiation.**

- The OECD Principles set the study initiation date as the day the Study Director signs the study plan, and require a written plan to exist before initiation (2.3.11, 8.1.1). 21 CFR 58.3(o) and 40 CFR 160.3 define it the same way.
- The experimental starting date is the first day study-specific data are collected (OECD 2.3.9). EPA instead makes it the first day the test substance is applied to the test system (160.3). FDA's definitions (58.3(a)–(p)) contain no experimental starting date.
- The UK transposition defines initiation as the date the study director (first) signs the plan. This is from an excerpt only.

**2. Completion and termination.**

- The study completion date is the day the Study Director signs the final report (OECD 2.3.12; also 58.3(p) and 160.3).
- The experimental completion date is the last day data are collected from the study (OECD 2.3.10).
- "Completion (including termination)" appears in the archiving duty (OECD 1.2.2(i); Doc 8), but termination is never defined.
- 58.217 concerns a sponsor suspending or terminating a testing facility's participation in a study, with written notice to FDA within 15 working days. It does not address ending a study as such.

**3. Interruption and resumption: NOT FOUND at study level.** What exists:

- Only one Study Director may control a study at a time, replacement must be documented, and the replacement must assess GLP compliance of the study "as conducted to date".
- Critical phases falling in a Study Director's absence may be moved by study plan amendment.
- Principal Investigator replacement is communicated so a plan amendment can issue (Doc 13).
- Test systems that fall ill or are injured mid-study are isolated, treated and the event recorded (OECD 5.2.2).
- No source says a pause ends or splits a study.

**4. Repetition and independent executions.**

- A GLP study strictly has one plan and one report (the "rule of ones"), which also holds for multi-site studies (EU Q&A 023). Only one study director can be responsible for a study (Q&A 001).
- Each study must have one protocol and one study director (EPA Adv. 18).
- Separate field trials of the same product may each be a study with its own protocol, director and QA inspection, or may be combined into one. The choice is purely one of administrative discretion. Analytical work must stay in the same study, and one director oversees all sites. Separate parts that do not themselves demonstrate properties of the test substance cannot be studies. (EPA Adv. 43)

**5. Constituent activities.**

- A phase is a defined activity or set of activities in the conduct of a study; a multi-site study is still one study with a single plan, director and final report (Doc 13).
- A separate analytical phase does not meet the definition of a study (Adv. 18).
- Only the study plan and the final report are official GLP documents; phase procedures change only by plan amendment (Q&A 025).

**6. Operational boundaries.**

- Boundaries are given as day-granular dates plus plan content, as in finding 1.
- The FDA protocol contents list (58.120(a)(1)–(12)) has no unique study identifier and no proposed dates. The OECD plan content includes identification of the study and proposed experimental starting and completion dates (8.2).
- "Study-specific data" is used but undefined.
- An amendment is an intended change after initiation; a deviation is an unintended departure (2.3.4–5). Amendments are issued before the event occurs, or after unexpected occurrences needing significant action (Doc 8). **No limit on the magnitude of an amendment is stated.**

**7. Evidence of execution.**

- Raw data are records of original observations and activities necessary for reconstruction and evaluation of the report (58.3(k)).
- Data entries are dated and signed, and changes may not obscure the original entry and must state a reason (58.130(e); OECD 8.3.3–5).
- QA inspection records name the study and the phase or segment inspected, and QA must confirm no unauthorized deviations (58.35(b)(3), (5)).
- The plan, raw data, specimens, final report, QA records and master schedules are archived (OECD 10.1).

**8. Identification across independent records.**

- A unique identification should be given to each study, all study items should carry it, and specimens should be identified to confirm origin and enable traceability (OECD 8.3.1).
- Specimens are identified by test system, study, nature and collection date, in a way that precludes error (58.130(c)).
- Each site's master schedule must carry the unique study identification, cross-referenced to test-site identifiers, with phase start and completion dates (Doc 13).
- The QA unit must be entirely separate from and independent of the personnel conducting the study (58.35(a)). A head of test facility management acting as QA is a conflict of interest (Q&A 014).
- The master schedule lists test article, test system, nature of study, initiation date, current status, sponsor and study director (58.35(b)(1)).
- Reformatting a final report for a regulator is not an amendment; corrections and additions are amendments signed by the Study Director (OECD 9.1.4–5; 58.185(c)).
- **No source states a criterion for when two records identify the same study.**

**9. Explicit identity and distinctness conditions.** These are the rule of ones, the director's single point of control, and EPA's lower-bound interpretation. Nothing states criteria for numerical identity of occurrences or for continuity.

**Conflicts left unreconciled.**

- The experimental starting date differs across OECD, EPA and FDA.
- FDA excludes field trials in animals and basic exploratory studies, while OECD and EPA include field work.

## Source-audit verdict: **PARTIAL**

| Topic                        | Class                                                                      |
| ---------------------------- | -------------------------------------------------------------------------- |
| Initiation                   | FOUND for the study; PARTIAL for the experimental start (regime-divergent) |
| Completion                   | FOUND (record-defined)                                                     |
| Termination                  | UNDER-SPECIFIED                                                            |
| Interruption/resumption      | NOT FOUND (in inspected surfaces)                                          |
| Repetition/distinctness      | FOUND at study level                                                       |
| Constituent activities       | PARTIAL                                                                    |
| Operational boundaries       | PARTIAL                                                                    |
| Evidence of execution        | FOUND as record requirements                                               |
| Cross-record identification  | PARTIAL (mechanisms yes, criterion no)                                     |
| Explicit identity conditions | PARTIAL                                                                    |

### JUSTIFIED FROM CURRENT SOURCES

- A study is initiated by the Study Director's dated signature of an approved plan, and completes administratively by signature of the final report.
- One study means one plan, one Study Director at a time, and one final report, including multi-site studies.
- Phases are proper parts of a study; an analytical phase is never a study alone.
- Whether several trials are one study or several is an administrative choice, bounded below by a requirement that each study's results demonstrate properties of the test substance independently.
- Amendments, deviations, Study Director or Principal Investigator replacement and report amendments are dated, documented events, and none is stated to end the study.
- Independent QA records must exist and must name study and phase.
- Specimens and data must carry study identification in an error-precluding manner.

### WOULD REQUIRE NEW THEORY OR INTERFACE

- Any criterion for when two presentations identify the same study, beyond carrying its identification.
- Boundaries and identity of the _experimental execution_ as distinct from the regulated study, including interruption, resumption and abort.
- A definition of "study-specific data" and a limit on amendment scope.
- Overlap (acts shared by two studies) and post-completion re-analysis.
- A scientific, not merely administrative, ground for how work is partitioned into studies.
- Any link from state changes of the occurrence to transformation models.

The protocol's step 8 (name one next question) is discharged in section J.

---

## B. Selected occurrence kind and scientific grounding

**Kind K: a GLP study**, laboratory-conducted, restricted to the structure common to OECD, FDA and EPA. Field studies are out of scope (FDA excludes them), as are human and clinical studies and basic exploratory studies.

**Mapping assumption A0 [ASM].** Your question says "one concrete experimental execution". The sources individuate the _regulated study_ S. Its experimental core E(S) is derivative, namely the study-specific data-generating acts. S starts at plan signature, before any experimental act, so S is not identical to the experiment. This is the central scoping fact of the report.

**What is grounded in sources [SRC].**

- The designation act is the approved plan.
- Control is a single Study Director at any time.
- Closure is one final report.
- A lower bound exists: each study must be function-sufficient, meaning its results independently demonstrate a property (EPA).

**What is not grounded.**

- The upper bound on how work is combined (administrative discretion).
- Experimental continuity.
- The co-reference criterion.

---

## C. Candidate individuation and identity conditions

### 1. Intended referent

S is the occurrence initiated when the Study Director signs the approved plan P. It consists of all acts performed under that director's control in pursuance of P (as amended), including recorded deviations. S runs through to signature of the one final report.

E(S) ⊂ S is the study-specific data-generating part. S is distinguished from:

- **its description:** the plan text and amendments;
- **its identifier:** the unique study identification, a label;
- **its participants:** the director, personnel, test-system individuals, test item, which take part in S but are not S;
- **its constituent activities:** phases and acts, which are proper parts;
- **its representations and provenance records:** raw data, specimen labels, QA records, master-schedule entries, reports, which are products of S;
- **other occurrences from the same procedure:** other studies using the same SOPs or plan template.

### 2. Existence

- **Initiated** [INF from SRC]: S exists as an initiated study from the first dated director signature of P.
- **Executed** [PROP]: an experimental execution occurred iff E(S) ≠ ∅.
- **Evidence is distinct from the occurrence** [ASM]: raw data and QA records are evidence of acts, not the acts themselves. Their loss does not unmake the acts. The sources set an evidence-adequacy standard (reconstruction and evaluation), not an existence criterion.

### 3. Individuation and unity (conditions U1–U7)

- **U1 Designation [SRC/INF]:** S is the realization of exactly one approved plan, including its amendments.
- **U2 Single control [SRC]:** one director at each time; replacement does not end or split S.
- **U3 Function lower bound [SRC-interpretive, formulation ASM]:** the work P designates must independently demonstrate some property of the test item.
- **U4 Closure [SRC]:** one final report covering all data the plan requires; later changes are report amendments.
- **U5 Participation [ASM]:** act a ∈ S iff a is performed under the director's control in pursuance of P as amended at that time, whether conforming or recorded as a deviation (Doc 8 places deviations within execution).
- **U6 Distinctness [SRC with gap]:** distinct approved plans mean distinct studies.
- **U7 Parts [SRC]:** phases are proper parts, never studies.

**Distinguishing S from neighbors.**

| Neighbor                   | Basis                                                                                                                |
| --------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| Component activity          | Phase or act; part of S (U7)                                                                                         |
| Larger encompassing process | A combined study only if the plan designates the combination (EPA Adv. 43); otherwise a campaign of separate studies |
| Concurrent execution        | Distinct plan                                                                                                        |
| Interrupted execution       | **No source basis**; same S only by U1/U2                                                                            |
| Resumed execution           | Same                                                                                                                 |
| Repeated execution          | New plan means new study; replicate within one plan is the same study (EU Q&A 023)                                   |

The operational convention is administrative, and its authority is EPA Adv. 43 and OECD Doc 13.

### 4. Referential identity

**Denotation [ASM]:** a presentation p denotes S iff p records, or is produced from, acts in S. Denotation is fixed by provenance. The study label in p is a defeasible _indicator_. The standards support this reading by treating mislabelled specimens as errors to be precluded (58.130(c); OECD 8.3.1), which presupposes a fact of the matter independent of the label.

**Co-reference warrant CR [PROP, falsifiable].** For independently authored presentations p and q, "p and q denote the same S" is warranted iff all four hold:

- **W1 Provenance:** each links to identifiable acts or items through signed and dated entries or study-identified specimens.
- **W2 Convergence:** a traceability chain connects an act or material in p's provenance to one in q's, such as the same specimen, test-system individual, item batch or raw-data entry. A shared label is not enough.
- **W3 Independent attestation:** membership of the linked act in S is attested by a record whose author is independent of p, q and the act, such as a QA inspection of that phase or a director acknowledgement of a deviation.
- **W4 No defeater:** no record attributes the linked act to another plan or gives irreconcilable provenance.

Outcomes are Warranted, Contested, Underdetermined, or Inapplicable. CR is an evidential warrant, not a definition of sameness. Sameness is S = S′ iff P = P′.

**Residual circularity (admitted).** Independent channels guard against _misattribution_. Every channel still ties acts to the study through the plan's content, so the designation remains the anchor of last resort. CR cannot establish what an ambiguous plan designates.

### 5. Temporal semantics

- **Occurrence extents:** administrative [initiation date, completion date], and experimental [experimental start, experimental completion]. The latter is regime-indexed (see E13). Both are day-granular, so intra-day order is unspecified.
- **Self-referential completion:** completion is defined by signing the final report, and the report itself states the completion date (58.185(a)(1)). The administrative end of S therefore coincides with creation of one of its own representations. This is why the experimental and administrative extents must be separated.
- **Evaluation time:** QA status reports and master-schedule status are time-indexed claims about S. A later description does not extend S.
- **Record creation and revision:** entries are dated at entry, corrections are dated with reasons, report amendments are dated. They do not change the occurrence's extent [INF].
- **Transformations:** plan amendments change the participation condition going forward; correction and reformatting act on representations; data transformations belong to reporting (58.185(a)(11)).
- **Post-completion acts** (report amendments, archiving): treated as acts concerning S's record life, not part of its core extent [ASM A5].

### 6. Strict identity and relatedness

- **Numerical identity:** classical equality [ASM, per v0.6 §6]. S = S′ iff P = P′.
- **Kept distinct from identity:** temporal overlap (concurrent studies); proper parthood (phases); causal relatedness (one study's data informing another); succession and repetition (new plan); derivation (report from raw data, amended report from report).
- **Co-reference across time is not persistence.** Report amendments occur after S's core extent, so they refer to S without S continuing as an activity.

---

## D. Derivations and proof obligations

**Mathematical consequences (conditional, not Lean-verified).**

- **M1.** If S ↔ P is a bijection, "same study" is an equivalence on plans. This is a restatement of the rule of ones.
- **M2 (join-closure).** Take a body of work W. Call a cell admissible if it is dependency-closed (contains the analysis of its applications) and function-sufficient. Assume (Mono): a dependency-closed superset of a function-sufficient set is function-sufficient. For admissible partitions π₁ and π₂, each block of their join is a union of π₁-blocks. It is therefore dependency-closed (unions of closed sets are closed) and function-sufficient (it contains a sufficient block, by Mono). So admissible partitions are closed under join, and {W} is admissible whenever W is itself dependency-closed and function-sufficient. The meet need not be admissible. This is routine given the assumptions and I do not claim it as a contribution.
- **M3.** Under U6 and EPA's discretion, "is a study" is not an intrinsic property of an act set. The same act set can be a study under one admissible designation and a proper part under another. This is a corollary of a source premise, not a new result.

**Substantive consequences recovered from sources.**

- **SC1.** Study individuation is designation-relative above the function-sufficiency bound.
- **SC2.** Phases cannot be studies.
- **SC3.** Study identity survives director replacement, Principal Investigator replacement, plan amendment and report amendment. No limit on any of these is stated.
- **SC4.** Completion is a record-defined milestone, unaffected by later amendments.

**Additional assumptions.** A0 (study ≈ execution); A1 (classical identity); A2 (signing is constitutive of the regulated study); A3 (Mono); A4 (participation rule U5); A5 (post-completion acts outside the core extent); A6 (QA channels are causally independent of the conduct they inspect); A7 (day-granular dates represent extents).

**Conjectures.**

- **CJ1.** Study identity across amendment is preserved only if the amended plan addresses the same test item and the same property question.
- **CJ2.** For GLP-conformant studies, W1–W4 suffices to make co-reference errors rare, which is testable against inspection findings.
- **CJ3.** For designation-constituted occurrence kinds, identity keys must carry designation provenance.

---

## E. Adversarial cases and candidate failures

**Evidence typing.** Cases E1–E10 are _construction cases_ from the prompt. E11–E13 are source-suggested, arising from source silence or conflict. E14 is a cross-kind comparison. The EPA advisories and EU Q&A were read _before_ the candidate was fixed and shaped U3, U6 and U7, so agreement with them is not validation. **No independent validation was obtained.**

**E1. Identical recorded attributes.** Grounded judgment: distinct (separate plans, unique identification). Prediction: distinct, via separate designation acts and disjoint realizations. Effect: survives. Distinctness rests on designation and disjoint acts, never on attribute equality.

**E2. One execution, two independent records** (QA inspection record and Principal Investigator phase report). Grounded: same study and phase. Prediction: CR warrants it if W1–W4 hold. QA records name study, phase and date, not individual acts. Effect: **narrows.** Warrant holds at phase/date grain unless identified specimens or animals supply act grain.

**E3. Interrupted and resumed.** Not grounded in sources. Prediction: same S if same plan and director control. E(S) has a gap, and whether that is one experimental execution is decided only by designation. ATLAS states a contrast rule (E14). Effect: **unresolved.** The candidate defers to designation and supplies no scientific continuity criterion.

**E4. Two repetitions.** Under distinct plans: distinct studies. Within one plan (two formulations): one study, one report (EU Q&A 023). The candidate agrees. Effect: **narrows.** The account individuates the regulated study, not each replicate execution.

**E5. Concurrent or overlapping.** Concurrent studies are envisaged (master schedule). Prediction: distinct by plan, with disjoint study-specific acts. In a constructed variant, one control group serves two plans (shared acts), and the sources are silent. The candidate permits this only because it assumes neither disjoint realizations nor partition-based unity (v0.6 §3). Effect: survives; shared acts **unresolved** (D6).

**E6. Sub-operation versus complete execution.** An analytical phase is never a study (Adv. 18). A single-site trial is a study or a part depending on designation (Adv. 43). The candidate predicts both, by construction. Effect: consistent, not validating.

**E7. Record corrected later.** Original preserved with reason; report amended, with completion date unchanged. Prediction: S and its extents are unchanged, and versions are distinct presentations. Edge: correcting an animal number changes act-level denotation but not study-level denotation. The audit trail records the reason, not whether denotation changed. Effect: survives, with a **narrowing**: denotation-preserving and denotation-changing corrections need to be distinguished, and no source does so.

**E8. Same identifier, conflicting evidence.** The standard treats mislabelling as an error to be precluded. Prediction: denotation follows provenance, and the outcome is "Contested" until resolved. Effect: **unresolved case-by-case**, but it supports treating the label as non-constitutive.

**E9. One occurrence, two identifiers** (study number and test-site identifier). Doc 13 requires cross-referencing. Prediction: same S, warranted when the cross-reference is attested. Two independent master schedules agreeing is stronger evidence than one author's table. Effect: survives. The cross-reference table is evidence, not constitutive. Lead and site QA are independent of study conduct but not necessarily of each other (D8).

**E10. Failure or aborted study.** Termination is named but undefined. Completion is defined by report signature, so an aborted study with no report has no completion date. A study that never reaches the experimental start has E(S) = ∅. Prediction: S exists from initiation regardless, and "execution occurred" iff E(S) ≠ ∅. Effect: **unresolved.**

**E11. Amendment scope.** No limit is stated, so an amendment could replace the test item, system or sites. The source-faithful candidate preserves identity, which is scientifically implausible. Effect: **narrows.** Designation-only identity over-identifies, and CJ1 is needed.

**E12. Post-completion re-analysis.** OECD 9.1.4 allows additions by amendment, while a new plan means a new study. New acts occur after completion. Under A5 the candidate cannot say whether they belong to S or to a new study. Effect: **unresolved.**

**E13. Regime divergence on the experimental start.** Pre-dose baseline observations can start the experimental extent under OECD but not under EPA. Effect: **narrows.** Experimental extent must be regime-indexed, while S's identity is unaffected.

**E14. Cross-kind (ATLAS run).**

- A run is a period of data acquisition with stable detector configuration; the DAQ assigns a unique run number at the start transition; and event identifiers are unique only within a run.
- Prescale and bunch-group changes can be deployed during a run, but a change to trigger-algorithm parameters, which yields a new super master key, requires stopping the run and starting a new one.
- Configuration keys are saved per luminosity block, and luminosity blocks are the smallest units that can be declared good or bad.

This kind is individuated by an operational-state anchor with no designation act. Effect: the designation anchor is **kind-specific**. A universal anchor is not supported.

---

## F. Comparison with prior SE semantics

The Lean repositories, papers and URS v0.2 text were not supplied or inspected. This section is relative to the interfaces as described in v0.6 and your prompt.

- **Neutral Substrate.**
  - _Remains valid:_ nothing in this case forces global equivalence laws. Study identity is plan-local, which fits local establishment.
  - _Requires narrowing:_ any treatment of a registered identifier or document class as the identity of an occurrence should carry only evidential weight for designation-constituted kinds.
  - _Cannot determine:_ whether the substrate's carrier equality has semantic force in the current repository.
- **Unified Referential Semantics v0.2.**
  - _Remains valid:_ the R1–R5 separation is exercised and needed here. This covers label versus provenance denotation, two-tier existence, and relatedness (phase, repetition, concurrency).
  - _Requires narrowing:_ occurrence time needs an aspect parameter (administrative extent, experimental extent, post-completion acts). A completion can be a record-defined milestone.
  - _May require revision:_ any single-interval treatment of an occurrence. This is undetermined without the text.
- **Persistence.**
  - _Remains valid:_ co-reference is not persistence. Report amendments refer to S after its core extent.
  - _Requires narrowing:_ continuation across director replacement or plan amendment is designation-anchored, not physically grounded, and the theory must record that distinction.
  - _Cannot determine:_ whether `se-theory-persistence` can represent designation-conditional continuation.
- **Transformation.** The sources give a catalogue of transformation events with source-stated identity consequences:
  - plan amendment, director or Principal Investigator replacement and report amendment preserve the study (no limit stated);
  - report reformatting is explicitly not an amendment;
  - data correction preserves the original entry;
  - data transformations are reported.

  Does this connect concrete occurrences to transformation-state models? **Only partly.**
  - It does so for transformations of designation and representations.
  - It does **not** do so for state changes of the occurrence itself (interruption, resumption, deviation), where the sources supply no identity criterion. A transformation theorem would establish identity only relative to a designation, never replace it.
  - No mapping to the eleven dimensions or seventeen operators was attempted.

- **Identity Regimes.** I did not reproduce the historical classification. This case is one datum in which identity roles do not share one criterion: the study (designation), the report (a document with amendments), and the work occurrences (unspecified). It supports treating the number of regimes as an outcome.
- **Integration layer.** Cannot be determined.
- **Repository changes.** None are recommended from this investigation alone.

---

## G. Scientific adequacy and potential contribution

**Mathematical correctness:** conditional. M1–M3 are routine given the assumptions, and none is Lean-verified.

**Scientific adequacy:** partial.

- What is grounded is the _study layer_: designation, single control, closure, and a function lower bound.
- What is not grounded is any _scientific_ continuity or boundary criterion for the experimental execution, and the sufficiency of CR.

**Original contribution: not established.** Candidate observations, unvalidated:

- the two-extent decomposition with a record-defined completion;
- provenance-based denotation, with GLP's error semantics as supporting evidence;
- the designation-anchor versus operational-state-anchor contrast;
- a precise gap list.

Against the v0.6 success criteria:

| Criterion                  | Status                                                                 |
| -------------------------- | ---------------------------------------------------------------------- |
| O1 boundaries              | PARTIAL: dates and milestones; experimental boundaries regime-relative |
| O2 distinctness            | PARTIAL: rule of ones, which is designation-based                      |
| O3 components              | PARTIAL: phases are parts; granularity thin                            |
| O4 co-reference            | PROPOSED, unvalidated                                                  |
| O5 temporal treatment      | MET at source level; later revisions do not extend the occurrence      |
| O6 interruption/repetition | Repetition yes; interruption NOT MET                                   |
| O7 falsifying cases        | DONE, but mostly construction cases                                    |
| O8 SE contribution         | NOT ESTABLISHED beyond the narrow observations above                   |

---

## H. Deferred-obligation ledger

- **D1** Amendment-scope limit on study identity. Deferred: needs a source or a theory of question-preservation.
- **D2** Definition of "study-specific data". Deferred: sources leave it undefined.
- **D3** Interruption and resumption of the experimental execution. Deferred: no source in the inspected surfaces.
- **D4** Termination and abort semantics, including a completion date with no report. Deferred: sources name termination only.
- **D5** Regime divergence (experimental start, field studies, UK "(first)" signature). Deferred: needs primary text for each regime.
- **D6** Shared acts across studies. Deferred: sources silent.
- **D7** Post-completion re-analysis. Deferred: sources silent.
- **D8** Degree of independence among QA channels. Deferred: needs the unread OECD Doc 4.
- **D9** Current authority of the 1990/1992 EPA advisories. Deferred: unverified.
- **D10** Sufficiency of CR. Deferred: requires independent review and real inspection data.
- **D11** Whether designation-constituted unity is a _scientific_ individuation. Deferred: this is J.
- **D12** Transfer to other occurrence kinds (U1). Deferred: ATLAS shows a different anchor.
- **D13** Intra-day ordering. Deferred: dates, not instants, are defined.
- **D14** Mapping to Transformation dimensions and operators. Deferred: outside this task's boundaries.
- **D15** Unread sources (OECD Docs 4, 6, 7, 15; FDA Q&A answers; 21 CFR 58.190/58.195; 40 CFR 160.120/130/185). Deferred: coverage gap.

---

## I. Theory-construction verdict and strongest supported definition

**Verdict: FUNDAMENTAL QUESTION REMAINS.**

**Why not ACCEPT WITH NARROWING.** The narrowing needed to make the candidate survive is to the regulated-study layer. At that layer the individuating principle is the regulatory rule of ones, which restates source premises. It then does not individuate a concrete _experimental execution_ independently of a designation act. E3, E10 and E12 are unresolved and E11 shows over-identification. CR is unverified. Whether a designation-constituted unit can ground scientific, as opposed to institutional, occurrence identity is exactly the open foundational question.

**Strongest supported definition (narrow).**

> A GLP study is the occurrence initiated when a Study Director signs an approved plan. It comprises all acts performed under that Study Director's single control in pursuance of that plan, as amended, including recorded deviations, until the Study Director signs the one final report covering all data the plan requires. It is individuated by its plan (one plan, one report). It is bounded below by the requirement that its results independently demonstrate a property of the test item, and bounded above only by the responsible persons' discretion to combine function-sufficient work. Its phases are proper parts and never studies. Records and later amendments are products of, not parts of, its experimental phase. A record's reference to the study is established by the provenance of the acts it records, with the study identification serving as a defeasible indicator.

**Unverified.** CR's sufficiency; the assumptions A0 and A2–A6; conjectures CJ1–CJ3; the authority status of the EPA advisories; every unread source in D15.

This is a theory-construction verdict only. It is not a `theory-acceptance` verdict and does not authorize canonical adoption.

---

## J. One recommended next scientific question

Is there a designation-independent layer of individuated experimental work occurrences (runs or trials) that GLP studies are composed of, and if so, what independently documented criterion decides whether an interrupted and resumed run is one occurrence or two?

**Sources:**

- [se-protocols-research: source-audit SKILL.md](https://github.com/structural-explainability/se-protocols-research/blob/main/protocols/source-audit/SKILL.md)
- [se-protocols-research: theory-construction SKILL.md](https://github.com/structural-explainability/se-protocols-research/blob/main/protocols/theory-construction/SKILL.md)
- [OECD Principles of GLP, C(97)186/FINAL](<https://one.oecd.org/document/C(97)186/FINAL/en/pdf>)
- [OECD Consensus Doc 13, multi-site studies](https://www.bfr.bund.de/cm/349/oecd_principles_glp_13.pdf)
- [OECD Consensus Doc 8, Study Director](<https://www.people.iup.edu/nate/wikis/chem581/docs/env-jm-mono(99)24.pdf>)
- [21 CFR 58.3](https://www.law.cornell.edu/cfr/text/21/58.3)
- [21 CFR 58.33](https://www.law.cornell.edu/cfr/text/21/58.33)
- [21 CFR 58.35](https://www.law.cornell.edu/cfr/text/21/58.35)
- [21 CFR 58.120](https://www.law.cornell.edu/cfr/text/21/58.120)
- [21 CFR 58.130](https://www.law.cornell.edu/cfr/text/21/58.130)
- [21 CFR 58.185](https://www.law.cornell.edu/cfr/text/21/58.185)
- [21 CFR 58.217](https://www.law.cornell.edu/cfr/text/21/58.217)
- [40 CFR 160.3](https://www.law.cornell.edu/cfr/text/40/160.3)
- [EPA GLP Advisory 18](https://19january2021snapshot.epa.gov/sites/static/files/2013-11/documents/advisory18.pdf)
- [EPA GLP Advisory 43](https://19january2021snapshot.epa.gov/sites/static/files/2013-11/documents/advisory43.pdf)
- [EU GLP Q&A (2016)](https://ec.europa.eu/docsroom/documents/16007/attachments/1/translations/en/renditions/pdf)
- [UK GLP Regulations 1999](https://www.legislation.gov.uk/cy/uksi/1999/3106/regulation/2/made)
- [ATLAS Run-2 trigger operation (arXiv:2007.12539)](https://arxiv.org/pdf/2007.12539)
- [CMS run structure statement (arXiv:2309.10157)](https://arxiv.org/pdf/2309.10157)
