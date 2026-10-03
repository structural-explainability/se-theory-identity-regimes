"""Programmatic checks for repair-patch-1.diff.

Checks: Lean code unchanged outside comments; TOML parses; matrix cells/tags unchanged; only intended
reference fields changed; new text agrees with Lean glosses/headlines; facts asserted in new comments are
recomputed from the committed matrix; docs module paths exist; docs role table == regime-families.toml.
"""

import itertools
import pathlib
import re
import sys
import tomllib

OLD = pathlib.Path(sys.argv[1])
NEW = pathlib.Path(
    sys.argv[2]
)  # usage: validate-repair-patch-1.py <unpatched-checkout> <patched-checkout>
ok = True


def check(name, cond, detail=""):
    """Check a condition and print the result."""
    global ok
    ok &= bool(cond)
    print(("PASS " if cond else "FAIL ") + name + (f"  [{detail}]" if detail else ""))


def strip_lean(s):
    """Strip Lean comments and normalize whitespace."""
    out = []
    i = 0
    depth = 0
    while i < len(s):
        if s.startswith("/-", i):
            depth += 1
            i += 2
            continue
        if depth and s.startswith("-/", i):
            depth -= 1
            i += 2
            continue
        if depth:
            i += 1
            continue
        if s.startswith("--", i):
            while i < len(s) and s[i] != "\n":
                i += 1
            continue
        out.append(s[i])
        i += 1
    return re.sub(r"\s+", " ", "".join(out)).strip(), depth


for rel in [
    "SE/IdentityRegimes/Transform/Core.lean",
    "SE/IdentityRegimes/Transform/NonCollapse.lean",
]:
    a, da = strip_lean((OLD / rel).read_text(encoding="utf-8"))
    b, db = strip_lean((NEW / rel).read_text(encoding="utf-8"))
    check(
        f"{rel}: non-comment code identical",
        a == b and da == 0 and db == 0,
        f"balanced comments old={da == 0} new={db == 0}",
    )
    check(f"{rel}: no 'sorry'/'axiom' added", "sorry" not in b and "axiom" not in b)


def load(p):
    """Load and parse a TOML file from the given path."""
    return tomllib.load(open(p, "rb"))


files = [
    "regime-classification-matrix",
    "regime-transformations",
    "regime-profiles",
    "regime-profile-derivation",
]
for f in files:
    try:
        load(NEW / f"reference/{f}.toml")
        check(f"{f}.toml parses", True)
    except (OSError, tomllib.TOMLDecodeError) as e:
        check(f"{f}.toml parses", False, str(e))
mo, mn = (
    load(OLD / "reference/regime-classification-matrix.toml"),
    load(NEW / "reference/regime-classification-matrix.toml"),
)
check(
    "matrix: all 90 cells (value, basis, note) unchanged", mo["matrix"] == mn["matrix"]
)
check("matrix: meta unchanged", mo["meta"] == mn["meta"])
cnt = lambda m, v: sum(
    m["matrix"][p][t]["value"] == v for p in m["matrix"] for t in m["matrix"][p]
)
check(
    "matrix: PRS/BRK/IGN counts 22/20/48",
    (cnt(mn, "PRS"), cnt(mn, "BRK"), cnt(mn, "IGN")) == (22, 20, 48),
)
check(
    "matrix: eight na-to-ign tags preserved",
    sum(
        mn["matrix"][p][t]["basis"] == "na-to-ign"
        for p in mn["matrix"]
        for t in mn["matrix"][p]
    )
    == 8,
)
to, tn = (
    load(OLD / "reference/regime-transformations.toml"),
    load(NEW / "reference/regime-transformations.toml"),
)
chg = [
    k
    for k in to["transformations"]
    if to["transformations"][k] != tn["transformations"][k]
]
check(
    "transformations: exactly RE AN AD RC BF SE PV changed",
    sorted(chg) == sorted(["RE", "AN", "AD", "RC", "BF", "SE", "PV"]),
    str(chg),
)
check(
    "transformations: ids, order fields, labels unchanged",
    all(
        to["transformations"][k]["order"] == tn["transformations"][k]["order"]
        and to["transformations"][k]["label"] == tn["transformations"][k]["label"]
        for k in to["transformations"]
    )
    and list(to["transformations"]) == list(tn["transformations"]),
)
check("transformations: meta unchanged", to["meta"] == tn["meta"])
po, pn = (
    load(
        OLD / "reference/regime_profiles.toml"
        if False
        else OLD / "reference/regime-profiles.toml"
    ),
    load(NEW / "reference/regime-profiles.toml"),
)
chg = [
    k
    for k in po["regime_profiles"]
    if po["regime_profiles"][k] != pn["regime_profiles"][k]
]
check(
    "profiles: exactly CTX_E CTX_S NOR_C NOR_S changed",
    sorted(chg) == ["CTX_E", "CTX_S", "NOR_C", "NOR_S"],
    str(chg),
)
check(
    "profiles: only 'label' field differs; order/family unchanged",
    all(
        {
            k
            for k in po["regime_profiles"][p]
            if po["regime_profiles"][p][k] != pn["regime_profiles"][p][k]
        }
        <= {"label"}
        for p in po["regime_profiles"]
    ),
)
do_, dn = (
    load(OLD / "reference/regime-profile-derivation.toml"),
    load(NEW / "reference/regime-profile-derivation.toml"),
)
chg = [k for k in do_["derivation"] if do_["derivation"][k] != dn["derivation"][k]]
check(
    "derivation: exactly CTX and NOR changed", sorted(chg) == ["CTX", "NOR"], str(chg)
)
check(
    "derivation: split flags and profile lists unchanged",
    all(
        do_["derivation"][k]["split"] == dn["derivation"][k]["split"]
        and do_["derivation"][k]["profiles"] == dn["derivation"][k]["profiles"]
        for k in do_["derivation"]
    ),
)

# --- transformation descriptions == Lean TransformBasis glosses (text after the colon)
tb = (NEW / "SE/IdentityRegimes/Vocab/TransformBasis.lean").read_text(encoding="utf-8")
gl = {
    m.group(1): re.sub(r"\s*-/\s*$", "", m.group(3).strip())
    for m in re.finditer(r"^\s{6}([A-Z]{2})\s+([^:]+):\s+(.+)$", tb, re.MULTILINE)
}
for k in ["RE", "AN", "AD", "RC", "BF", "SE", "PV"]:
    d = tn["transformations"][k]["description"]
    parts = d.split(": ", 1)
    after = parts[1].rstrip(".") if len(parts) > 1 else d
    check(f"transformations.{k} matches Lean gloss", after == gl[k], gl[k])

# --- profile labels match Lean doc-comment headlines
core = (NEW / "SE/IdentityRegimes/Transform/Core.lean").read_text(encoding="utf-8")
for pk, hd in {
    "CTX_E": "CTX-E: ",
    "CTX_S": "CTX-S: ",
    "NOR_C": "NOR-C: ",
    "NOR_S": "NOR-S: ",
}.items():
    m = re.search(re.escape("/-- " + hd) + r"(.+?)\.", core)
    if m is None:
        check(
            f"label {pk} = Lean headline + ' profile'",
            False,
            f"missing Lean headline for {hd!r}",
        )
        continue
    line = m.group(1)  # e.g. "Applicability context, extension-sensitive"
    line = re.sub(r"\s*\(.*\)$", "", line)
    check(
        f"label {pk} = Lean headline + ' profile'",
        pn["regime_profiles"][pk]["label"] == line + " profile",
        pn["regime_profiles"][pk]["label"],
    )

# --- facts asserted in the new NonCollapse/Core comments, recomputed from the committed matrix
o = ["RE", "AN", "RF", "AD", "RC", "RA", "SU", "BF", "PV", "SE"]
P = ["OBL", "OCC", "REC", "ENR_L", "ENR_I", "CTX_E", "CTX_S", "NOR_C", "NOR_S"]
v = lambda p, t: mn["matrix"][p][t]["value"]
prs = {p: frozenset(t for t in o if v(p, t) == "PRS") for p in P}
pairs = list(itertools.combinations(P, 2))
eq = [(a, b) for a, b in pairs if prs[a] == prs[b]]
check(
    "36 unordered pairs; 34 differ in PRS set; 2 equal",
    len(pairs) == 36 and 36 - len(eq) == 34 and len(eq) == 2,
    str(eq),
)
check(
    "equal-PRS pairs are exactly OBL/NOR_C and CTX_S/NOR_S",
    set(eq) == {("OBL", "NOR_C"), ("CTX_S", "NOR_S")},
)
check(
    "OBL/NOR_C PRS sets both {RF,AD}",
    prs["OBL"] == prs["NOR_C"] == frozenset({"RF", "AD"}),
)
check("CTX_S/NOR_S PRS sets both empty", prs["CTX_S"] == prs["NOR_S"] == frozenset())
d1 = [(t, v("OBL", t), v("NOR_C", t)) for t in o if v("OBL", t) != v("NOR_C", t)]
d2 = [(t, v("CTX_S", t), v("NOR_S", t)) for t in o if v("CTX_S", t) != v("NOR_S", t)]
check(
    "OBL vs NOR_C differ only at BF (IGN vs BRK)", d1 == [("BF", "IGN", "BRK")], str(d1)
)
check(
    "CTX_S vs NOR_S differ only at RC,RA (BRK vs IGN)",
    d2 == [("RC", "BRK", "IGN"), ("RA", "BRK", "IGN")],
    str(d2),
)
rows = [tuple(v(p, t) for t in o) for p in P]
check(
    "all nine rows pairwise distinct (classification_pattern_unique)",
    len(set(rows)) == 9,
)
split = {("ENR_L", "ENR_I"), ("CTX_E", "CTX_S"), ("NOR_C", "NOR_S")}
check("66 cross-family ordered pairs", 2 * (36 - 3) == 66)
lb = (NEW / "SE/IdentityRegimes/Transform/LowerBound.lean").read_text(encoding="utf-8")
nc = (NEW / "SE/IdentityRegimes/Transform/NonCollapse.lean").read_text(encoding="utf-8")
check(
    "named theorems exist: classification_pattern_unique / noncollapse_of_distinct_regime / noncollapse_all_pairs / noncollapse_of_prs_difference",
    all(
        x in (lb + nc)
        for x in [
            "theorem classification_pattern_unique",
            "theorem noncollapse_of_distinct_regime",
            "theorem noncollapse_all_pairs",
            "theorem noncollapse_of_prs_difference",
        ]
    ),
)

# --- docs: every dotted SE.IdentityRegimes.* module cited exists as a file
docs = (NEW / "docs/en/index.md").read_text(encoding="utf-8")
mods = sorted(set(re.findall(r"`(SE\.IdentityRegimes\.[A-Za-z.]+)`", docs)))
missing = [m for m in mods if not (NEW / (m.replace(".", "/") + ".lean")).exists()]
check(f"docs: {len(mods)} cited modules all exist as files", not missing, str(missing))
check(
    "docs: no remaining un-prefixed IdentityRegimes.* module references",
    not re.findall(r"`IdentityRegimes\.[A-Za-z.]+`", docs),
)
fam = {
    k: v_["label"]
    for k, v_ in load(NEW / "reference/regime-families.toml")["regime_families"].items()
}
match = re.search(r"\| Regime \| Role[^\n]*\n(?:\|[^\n]*\n)+", docs)
check("docs role table exists", match is not None, str(docs[:400]))
blk = match.group(0) if match else ""
rows = dict(
    re.findall(r"^\| (OBL|NOR|OCC|CTX|REC|ENR)\s+\| (.+?)\s+\|$", blk, re.MULTILINE)
)
check(
    "docs role table == reference/regime-families.toml labels", rows == fam, str(rows)
)
print("\nOVERALL:", "ALL PASS" if ok else "FAILURES")
