import collections
import itertools

from ir_data import M, R, T

PRS = {r: frozenset(t for t in T if M[r][t] == "P") for r in R}
BRK = {r: frozenset(t for t in T if M[r][t] == "B") for r in R}
APP = {r: frozenset(t for t in T if M[r][t] != "A") for r in R}
# carrier kind of each position and basis index
KIND = {
    "OBL": "obl",
    "OCC": "occ",
    "REC": "rec",
    "ENR_L": "ref",
    "ENR_I": "ref",
    "CTX_E": "scp",
    "CTX_S": "scp",
    "NOR_C": "rul",
    "NOR_S": "rul",
}
BASIS = {
    "OBL": 0,
    "OCC": 0,
    "REC": 0,
    "ENR_L": 0,
    "ENR_I": 1,
    "CTX_E": 0,
    "CTX_S": 1,
    "NOR_C": 0,
    "NOR_S": 1,
}
KINDS = ["obl", "occ", "rec", "ref", "scp", "rul"]


def uf_classes(elems, pairs):
    par = {e: e for e in elems}

    def f(x):
        while par[x] != x:
            par[x] = par[par[x]]
            x = par[x]
        return x

    for a, b in pairs:
        par[f(a)] = f(b)
    g = collections.defaultdict(set)
    for e in elems:
        g[f(e)].add(e)
    return frozenset(frozenset(c) for c in g.values())


def carrier(kind):
    return [
        (kind, t, b) for t in T for b in (0, 1)
    ]  # free dynamics, one private pair per transformation


def rel(pos, kind, mode):
    gen = (
        PRS[pos]
        if mode == "prs"
        else frozenset(t for t in T if M[pos][t] in "PN" and M[pos][t] != "A")
    )
    X = carrier(kind)
    return uf_classes(X, [((kind, t, 0), (kind, t, 1)) for t in gen])


def glob(i, mode, X_all):
    pairs = []
    for k in KINDS:
        # position used for kind k under global relation i
        pos = next(
            p
            for p in R
            if KIND[p] == k
            and BASIS[p] == min(i, max(BASIS[q] for q in R if KIND[q] == k))
        )
        gen = (
            PRS[pos] if mode == "prs" else frozenset(t for t in T if M[pos][t] in "PN")
        )
        pairs += [((k, t, 0), (k, t, 1)) for t in gen]
    return uf_classes(X_all, pairs)


for mode in ("prs", "nb"):
    print(f"\n===== generation mode: {mode} =====")
    # shared-carrier collapse count (one carrier, nine profiles)
    shared = collections.Counter(rel(p, "shared", mode) for p in R)
    print("distinct generated relations on ONE shared carrier:", len(shared))
    # CE-5: six disjoint carriers, two global relations
    X_all = [x for k in KINDS for x in carrier(k)]
    G = [glob(0, mode, X_all), glob(1, mode, X_all)]

    def restrict(Gi, k):
        return frozenset(c for c in Gi if next(iter(c))[0] == k)

    ok = True
    for p in R:
        k = KIND[p]
        target = rel(p, k, mode)
        got = restrict(G[BASIS[p]], k)
        ok &= target == got
    print(
        "CE-5: all 9 carrier-basis position relations = restrictions of 2 global relations:",
        ok,
    )
    print(
        "CE-5: global relations G0 != G1:",
        G[0] != G[1],
        "| distinct global relations used:",
        len({G[0], G[1]}),
    )
    # Product-basis model: ONE relation on disjoint union of X_K x B_K
    Bk = {
        k: (2 if any(KIND[p] == k and BASIS[p] == 1 for p in R) else 1) for k in KINDS
    }
    Xp = [
        (k, t, b, bs) for k in KINDS for t in T for b in (0, 1) for bs in range(Bk[k])
    ]
    pp = []
    for p in R:
        k = KIND[p]
        gen = PRS[p] if mode == "prs" else frozenset(t for t in T if M[p][t] in "PN")
        pp += [((k, t, 0, BASIS[p]), (k, t, 1, BASIS[p])) for t in gen]
    H = uf_classes(Xp, pp)
    ok = True
    for p in R:
        k = KIND[p]
        bs = BASIS[p]
        res = frozenset(
            frozenset((kk, t, b) for (kk, t, b, s) in c)
            for c in H
            if next(iter(c))[0] == k and next(iter(c))[3] == bs
        )
        ok &= res == rel(p, k, mode)
    cross = any(len({(x[0], x[3]) for x in c}) > 1 for c in H)
    print(
        "Product basis: ONE global relation, nine projections recover positions:",
        ok,
        "| any class crosses carrier/basis tag:",
        cross,
    )
    print("Product basis: sub-carriers (kind,basis) =", sum(Bk.values()))

    # bare-isomorphism classes of the nine position relations (forget labels)
    def sig(p, mode=mode):
        k = KIND[p]
        r = rel(p, k, mode)
        return tuple(sorted(len(c) for c in r))

    print(
        "bare (unlabelled) isomorphism classes of the nine position relations:",
        len({sig(p) for p in R}),
    )
    # dynamics dependence: sub-dynamics using subset S of transformations
    best = 0
    worst = 99
    for n in range(1, len(T) + 1):
        for S in itertools.combinations(T, n):
            cls = len(
                {
                    (
                        frozenset(PRS[p] & set(S))
                        if mode == "prs"
                        else frozenset(
                            t for t in S if M[p][t] in "PN" and M[p][t] != "A"
                        )
                    )
                    for p in R
                }
            )
            best = max(best, cls)
            worst = min(worst, cls)
    print(
        "distinct relations over nine profiles across all sub-dynamics (shared carrier): min",
        worst,
        "max",
        best,
    )
