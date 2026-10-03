Current queue from ENR_I/ENR_L:

- spec-ae - definite update
  - Fix the explanatory notes in IDENTIFIERS.md.
  - Fix corresponding notes in data/spec/requirements.json.
  - Add se-theory-identity-regimes as the actual upstream semantic dependency in SE_MANIFEST.toml.
  - The normative SPEC.md mapping itself does not currently need changing; it correctly binds by ENR_I, ENR_L, etc.
- se-theory-identity-regimes - pending investigation
  - Verify/fix the apparently stale SE-300 citations.
  - Investigate CTX_E event-bound vs extension.
  - Investigate NOR_C context-bound vs content.
  - Investigate NOR_S scope-bound vs structure.
  - Decide whether NEU/N/A → IGN needs any clarification outside the non-collapse context.
  - Do not change these until those questions are resolved.
- paper-200-identity-regimes - no change currently
  - It is historical evidence and appears internally coherent for OBJ/LOC.
- AccountableEntities - check later
  - It declares a semantic dependency on se-theory-identity-regimes, but ENR_I gave us no demonstrated implementation error yet.
- spec-ep, EvolutionProtocol, spec-cee, CEE - no update established yet
  - Continue checking them as each regime/relationship reaches them.
    One unrelated defect also surfaced while checking spec-ae: data/spec/requirements.json says “exactly six accountable entity kinds” even though SPEC.md says nine and nine AE.KIND.PER.\* identifiers are present. That should go on the spec-ae fix list too, but separately from the identity-regime finding.
    So the rule I suggest is:
    diagnostic finding → add repo/file to queue → finish diagnostic → update authoritative repo first → downstream specs → implementations → papers/docs.
    I can keep that queue as we continue. Once the nine regimes are finished, we should put the final explicit queue into research/alignment/2026-09-30-ae-ep-cee-diagnostic.md before touching the affected repos.
