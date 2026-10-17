import collections
import itertools

from ir_data import M, R, T

# SE-200 Table (four-valued), transcribed from sections/06_nine_regimes.tex, rows = transformations
rows = {
    "RE": "N N N N N N N N N",
    "AN": "N N P N N N N N N",
    "RF": "P P P P P P B P B",
    "AD": "P B P P P P B P B",
    "RC": "N N N N N P B N N",
    "RA": "N A N A A N B N N",
    "SU": "B B B B B B B B B",
    "BF": "N A P P B P B B B",
    "PV": "N N P N N N N N N",
    "SE": "N P N P P A A A A",
}

# 1. cross-check against Lean three-valued (NEU,NA -> IGN)
lean = """OBL: IGN IGN PRS PRS IGN IGN BRK IGN IGN IGN
OCC: IGN IGN PRS BRK IGN IGN BRK IGN PRS IGN
REC: IGN PRS PRS PRS IGN IGN BRK PRS IGN PRS
ENR_L: IGN IGN PRS PRS IGN IGN BRK PRS PRS IGN
ENR_I: IGN IGN PRS PRS IGN IGN BRK BRK PRS IGN
CTX_E: IGN IGN PRS PRS PRS IGN BRK PRS IGN IGN
CTX_S: IGN IGN BRK BRK BRK BRK BRK BRK IGN IGN
NOR_C: IGN IGN PRS PRS IGN IGN BRK BRK IGN IGN
NOR_S: IGN IGN BRK BRK IGN IGN BRK BRK IGN IGN"""
order = ["RE", "AN", "RF", "AD", "RC", "RA", "SU", "BF", "SE", "PV"]
ok = True
for line in lean.splitlines():
    r, v = line.split(":")
    vs = v.split()
    for t, x in zip(order, vs):
        p = M[r][t]
        q = {"P": "PRS", "B": "BRK", "N": "IGN", "A": "IGN"}[p]
        if q != x:
            ok = False
            print("MISMATCH", r, t, p, x)
print("paper table agrees with Lean matrix after NEU,NA->IGN:", ok)
PRS = {r: frozenset(t for t in T if M[r][t] == "P") for r in R}
BRK = {r: frozenset(t for t in T if M[r][t] == "B") for r in R}
APP = {r: frozenset(t for t in T if M[r][t] != "A") for r in R}


def classes(key):
    d = collections.defaultdict(list)
    for r in R:
        d[key(r)].append(r)
    return list(d.values())


print(
    "\nrow classes (paper 4-valued):", len(classes(lambda r: tuple(M[r][t] for t in T)))
)
print(
    "row classes (Lean 3-valued):",
    len(classes(lambda r: tuple({"P": "P", "B": "B"}.get(M[r][t], "I") for t in T))),
)
print(
    "PRS-set classes (PRS-only generation, free dynamics):",
    len(classes(lambda r: PRS[r])),
    classes(lambda r: PRS[r]),
)
print(
    "BRK-set classes (non-breaking generation, all steps applicable):",
    len(classes(lambda r: BRK[r])),
    classes(lambda r: BRK[r]),
)
# non-breaking generation where NA steps do not exist: relation determined by (non-breaking AND applicable) set
NB = {r: frozenset(t for t in T if M[r][t] in "PN") for r in R}
print(
    "non-breaking-and-applicable-set classes:",
    len(classes(lambda r: NB[r])),
    classes(lambda r: NB[r]),
)


# separation kinds for 36 pairs
def sepkind(p, q):
    _both = [t for t in T if M[p][t] != "A" and M[q][t] != "A"]
    if any({M[p][t], M[q][t]} == {"P", "B"} for t in T):
        return "S1 PRS/BRK conflict"
    if any(
        (M[p][t] == "B") != (M[q][t] == "B") and M[p][t] != "A" and M[q][t] != "A"
        for t in T
    ):
        return "S2 BRK vs non-breaking (applicable both)"
    if PRS[p] != PRS[q]:
        return "S3 PRS-set only"
    if any(M[p][t] != M[q][t] for t in T):
        return "S4 neutral/inapplicable cells only"
    return "S5 carrier only"


cnt = collections.Counter()
S5 = []
pairs = list(itertools.combinations(R, 2))
for p, q in pairs:
    k = sepkind(p, q)
    cnt[k] += 1
    if k.startswith(("S5", "S4")):
        S5.append((p, q, k[:2]))
print("\npair separation kinds:", dict(cnt))
print("S4/S5 pairs:", S5)


# graph colouring / clique
def graph(pred):
    E = {(p, q) for p, q in pairs if pred(p, q)}
    return E


def chrom(E):
    adj = {r: set() for r in R}
    for p, q in E:
        adj[p].add(q)
        adj[q].add(p)

    def ok(k):
        col = {}

        def bt(i):
            if i == len(R):
                return True
            r = R[i]
            for c in range(k):
                if all(col.get(n) != c for n in adj[r]):
                    col[r] = c
                    if bt(i + 1):
                        return True
                    del col[r]
            return False

        return bt(0)

    for k in range(1, 10):
        if ok(k):
            return k


def clique(E):
    best = 0
    for n in range(1, 10):
        for c in itertools.combinations(R, n):
            if all((a, b) in E or (b, a) in E for a, b in itertools.combinations(c, 2)):
                best = n
                bc = c
    return best, bc


Es = {
    "strict PRS/BRK (S1)": graph(lambda p, q: sepkind(p, q).startswith("S1")),
    "S1+S2 (BRK vs non-breaking)": graph(
        lambda p, q: sepkind(p, q)[:2] in ("S1", "S2")
    ),
    "S1+S2+S3 (PRS-set)": graph(lambda p, q: sepkind(p, q)[:2] in ("S1", "S2", "S3")),
    "any row difference": graph(lambda p, q: sepkind(p, q)[:2] != "S5"),
}
for n, E in Es.items():
    print(f"{n}: edges={len(E)} chromatic={chrom(E)} maxclique={clique(E)}")

print("\n--- pair lists by separation kind ---")
for k in sorted({sepkind(p, q) for p, q in pairs}):
    print(
        k,
        [(p, q) for p, q in pairs if sepkind(p, q) == k]
        if not k.startswith("S1")
        else "(26 pairs)",
    )
