# Case tests for the key-invariance criterion. Reads cases from the cloned pilot repositories (read-only).
import glob
import tomllib

import kic_engine as engine
import kic_inputs as inputs

VULN_REPO = (
    "/home/claude/structural-explainability/se-verification-vulnerability-matching"
)

# ---------------------------------------------------------------------------
# Case set A: SE-210 worked rule example (records r0, r1, r2).
# r0 original; r1 structural refinement (adds subsections, renumbers, same content);
# r2 editorial rewording (same content, same section structure).
# ---------------------------------------------------------------------------
print("== CASE SET A: SE-210 worked legal-alignment example ==")
records = {
    "r0": {"SUB": "content-1", "STR": "structure-0", "TXT": "wording-0"},
    "r1": {"SUB": "content-1", "STR": "structure-1", "TXT": "wording-1"},
    "r2": {"SUB": "content-1", "STR": "structure-0", "TXT": "wording-2"},
}
bases = {
    "RULEC (content-fixed)": ["SUB"],
    "RULES (structure-fixed)": ["STR"],
    "text-fixed (the version-field behaviour)": ["TXT"],
}


def partition(records, key_axes):
    groups = {}
    for name in sorted(records):
        key = tuple(records[name][axis] for axis in key_axes)
        groups.setdefault(key, []).append(name)
    return sorted(groups.values())


expected_partitions = {
    "RULEC (content-fixed)": [["r0", "r1", "r2"]],
    "RULES (structure-fixed)": [["r0", "r2"], ["r1"]],
    "text-fixed (the version-field behaviour)": [["r0"], ["r1"], ["r2"]],
}
for basis_name, key_axes in bases.items():
    computed = partition(records, key_axes)
    print(
        f"  {basis_name}: computed {computed}; SE-210 states {expected_partitions[basis_name]}; match={computed == expected_partitions[basis_name]}"
    )

# The editorial rewording is not in the ten-family basis. Its effect alone decides its classification.
rewording_alters = ["TXT"]
refinement_alters = inputs.TRANSFORMATION_EFFECT["RF"]["alters"]
print(
    "  classification of r0->r2 (editorial rewording; not in the transformation basis):"
)
for basis_name, key_axes in bases.items():
    print(
        f"    {basis_name}: {'BRK' if set(rewording_alters) & set(key_axes) else 'non-breaking'}"
    )
print("  classification of r0->r1 (structural refinement, family RF):")
for basis_name, key_axes in bases.items():
    print(
        f"    {basis_name}: {'BRK' if set(refinement_alters) & set(key_axes) else 'non-breaking'}"
    )

# ---------------------------------------------------------------------------
# Case set B: PURL and OCI cases from the vulnerability-matching study.
# ---------------------------------------------------------------------------
print("\n== CASE SET B: vulnerability-matching cases (cases/*/*.toml) ==")


def parse_purl(text):
    body = text.removeprefix("pkg:")
    subpath = ""
    if "#" in body:
        body, subpath = body.split("#", 1)
    qualifiers = []
    if "?" in body:
        body, query = body.split("?", 1)
        for pair in query.split("&"):
            if pair == "":
                continue
            if "=" in pair:
                key, value = pair.split("=", 1)
            else:
                key, value = pair, ""
            qualifiers.append((key.lower(), value))
    version = ""
    if "@" in body:
        body, version = body.rsplit("@", 1)
    parts = body.split("/")
    purl_type = parts[0].lower()
    name = parts[-1]
    namespace = "/".join(parts[1:-1])
    return purl_type, namespace, name, version, qualifiers, subpath


def canonical_key(text):
    # The PURL construction rules recorded in the study's commitments: sort qualifiers by key, drop empty-valued pairs.
    purl_type, namespace, name, version, qualifiers, subpath = parse_purl(text)
    kept = sorted((key, value) for key, value in qualifiers if value != "")
    return (purl_type, namespace, name, version, tuple(kept), subpath)


with open(VULN_REPO + "/contracts/commitments.toml", "rb") as commitments_file:
    commitments = tomllib.load(commitments_file)["commitment"]
commitment_by_id = {}
for entry in commitments:
    commitment_by_id[entry["id"]] = entry


def criterion_verdict(commitment, control, variant):
    kind = commitment["rule_kind"]
    if kind == "canonicalization":
        # A declared key function whose equality is an equivalence relation: verdict is key equality.
        return (
            "same" if canonical_key(control) == canonical_key(variant) else "different"
        )
    if kind == "content_identity":
        # The declared key is the verified digest. The case changes only a PURL qualifier, which the key does not read.
        return "same"
    if kind == "directional_match":
        # The relation is asymmetric, so it is not an identity criterion of the form f(x)=f(y) <-> R(x,y) with R an equivalence.
        return "not_asserted"
    if kind == "underspecification":
        # No key is declared for this relation.
        return "underdetermined"
    return "unclassified"


agree = 0
total = 0
for path in sorted(glob.glob(VULN_REPO + "/cases/*/*.toml")):
    with open(path, "rb") as case_file:
        case = tomllib.load(case_file)
    commitment = commitment_by_id[case["case"]["primary_commitment_id"]]
    control = case["pair"]["control"]["identifier"]
    variant = case["pair"]["variant"]["identifier"]
    expected = case["expected"]["identity_relation"]
    verdict = criterion_verdict(commitment, control, variant)
    canonical_says = (
        "same" if canonical_key(control) == canonical_key(variant) else "different"
    )
    total += 1
    if verdict == expected:
        agree += 1
    print(
        f"  {case['case']['id']}: criterion={verdict}; expected={expected}; canonical-PURL equality of this pair={canonical_says}; rule_kind={commitment['rule_kind']}; agree={verdict == expected}"
    )
print(f"  agreement: {agree}/{total}")

print(
    "  note: the rule_kind column is read from the commitment, so the directional and underspecification verdicts test the criterion's logic, not its discovery of the rule type."
)
print(
    "  determinate cases whose verdict depends on computing a key: order, OCI digest. Probes below add the empty-qualifier commitment and value changes."
)

probes = [
    (
        "empty qualifier value vs absent (IC-PURL-EMPTY-QUALIFIER-001, expected same)",
        "pkg:maven/com.google.guava/guava@24.1.1?classifier=",
        "pkg:maven/com.google.guava/guava@24.1.1",
        "same",
    ),
    (
        "qualifier order (expected same)",
        "pkg:maven/com.google.guava/guava@24.1.1?classifier=x86&type=dll",
        "pkg:maven/com.google.guava/guava@24.1.1?type=dll&classifier=x86",
        "same",
    ),
    (
        "qualifier value change (a different canonical PURL)",
        "pkg:maven/com.google.guava/guava@24.1.1?classifier=x86",
        "pkg:maven/com.google.guava/guava@24.1.1?classifier=sources",
        "different",
    ),
    (
        "version removed (a different canonical PURL)",
        "pkg:maven/com.google.guava/guava@24.1.1",
        "pkg:maven/com.google.guava/guava",
        "different",
    ),
]
for label, left, right, expected in probes:
    computed = "same" if canonical_key(left) == canonical_key(right) else "different"
    print(
        f"  probe: {label}: computed={computed}; expected={expected}; agree={computed == expected}"
    )

# ---------------------------------------------------------------------------
# Case set C: split test applied to the "unsplit" kinds, using alternative bases that the papers themselves mention.
# ---------------------------------------------------------------------------
print("\n== CASE SET C: split test on kinds the matrix leaves unsplit ==")
cfg = engine.base_cfg()
cfg["TRANSFORMATION_EFFECT"]["AD"]["alters"] = ["STR", "PRT"]  # premise P1
cfg["KEY_AXES"]["OCC"] = cfg["KEY_AXES"]["OCC"] + [
    "PRT"
]  # premise P1: fine-grained occurrence
extra = {
    # SE-200 inventory: "One jurisdiction may individuate responsibility at the parent-entity level.
    # Another may individuate it at the subsidiary, facility, role, or delegated-agent level."
    "OBL_UNIT": ("obligation_bearer", ["CAR", "STR"]),
    # SE-200 limits section: "a record may be tracked by ... a particular carrier, file, signature, or chain-of-custody token."
    "REC_FILE": ("record", ["CAR", "FMT", "ANN", "DSC", "STR", "TXT", "HST"]),
    # SE-200 limits section: "An occurrence may be tracked as a fine-grained realization or as a coarser event complex."
    "OCC_COARSE": ("occurrence", ["CAR", "TMP", "ORG"]),
}
for name, (kind_name, key_axes) in extra.items():
    cfg["KIND_OF_REGIME"][name] = kind_name
    cfg["KEY_AXES"][name] = key_axes
candidate_groups = {
    "obligation_bearer": ["OBL", "OBL_UNIT"],
    "record": ["REC", "REC_FILE"],
    "occurrence": ["OCC", "OCC_COARSE"],
}
for kind_name, names in candidate_groups.items():
    first, second = names[0], names[1]
    witnesses = []
    for transformation in inputs.TRANSFORMATIONS:
        value_first = engine.classify(first, transformation, cfg)
        value_second = engine.classify(second, transformation, cfg)
        if value_first in "PN" and value_second == "B":
            witnesses.append((transformation, first + " non-breaking", second + " BRK"))
        if value_second in "PN" and value_first == "B":
            witnesses.append((transformation, second + " non-breaking", first + " BRK"))
    print(f"  {kind_name}: {first} vs {second}: separating transformations {witnesses}")

# Baseline for set C: do the nine matrix kinds that ARE split show the same witnesses under the same test?
print(
    "  control: the three split kinds under the same test (should reproduce BF, AD, RF witnesses)"
)
for first, second in [("ENR_L", "ENR_I"), ("CTX_E", "CTX_S"), ("NOR_C", "NOR_S")]:
    witnesses = []
    cfg_split = engine.base_cfg()
    cfg_split["FORK_DIVERGES"]["rule"] = ["SUB", "STR"]
    cfg_split["FORK_DIVERGES"]["scope"] = ["STR", "CTX", "ASC"]
    for transformation in inputs.TRANSFORMATIONS:
        value_first = engine.classify(first, transformation, cfg_split)
        value_second = engine.classify(second, transformation, cfg_split)
        if (
            (value_first == "B") != (value_second == "B")
            and value_first != "A"
            and value_second != "A"
        ):
            witnesses.append(transformation)
    print(f"    {first} vs {second}: {witnesses}")
