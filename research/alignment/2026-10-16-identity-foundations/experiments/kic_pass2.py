# Pass 2: add explicit, named premises one at a time and show which cells each one fixes.
# Every number printed here is FITTED after seeing pass-1 mismatches; it is not a prediction score.
import kic_engine as engine
import kic_inputs as inputs


def cells_that_change(before, after):
    changed = []
    for regime in inputs.REGIMES:
        for transformation in inputs.TRANSFORMATIONS:
            if before[regime][transformation] != after[regime][transformation]:
                changed.append(
                    (
                        regime,
                        transformation,
                        engine.VALUE_NAME[before[regime][transformation]],
                        engine.VALUE_NAME[after[regime][transformation]],
                        "matrix="
                        + engine.VALUE_NAME[engine.MATRIX[regime][transformation]],
                    )
                )
    return changed


def add_parthood_axis(cfg):
    # P1: occurrences are closed under parthood; decomposing one yields parts with their own temporal individuation.
    cfg["TRANSFORMATION_EFFECT"]["AD"]["alters"] = ["STR", "PRT"]
    cfg["KEY_AXES"]["OCC"] = cfg["KEY_AXES"]["OCC"] + ["PRT"]


def rule_forks_diverge(cfg):
    # P2: forked continuations of a rule diverge in content and in structure.
    cfg["FORK_DIVERGES"]["rule"] = ["SUB", "STR"]


def scope_forks_diverge_structurally(cfg):
    # P3: forked continuations of a scope diverge in internal organization but not in extension. No text states this.
    cfg["FORK_DIVERGES"]["scope"] = ["STR", "CTX", "ASC"]


def description_and_structure_are_lifecycle_for_all_kinds(cfg):
    # P-L: description and internal structure are constitutive for every kind, so refinement and decomposition always act on the thing itself.
    for kind in cfg["LIFECYCLE_AXES"]:
        for axis in ["DSC", "STR"]:
            if axis not in cfg["LIFECYCLE_AXES"][kind]:
                cfg["LIFECYCLE_AXES"][kind] = cfg["LIFECYCLE_AXES"][kind] + [axis]


premises = [
    ("P1 occurrences closed under parthood", add_parthood_axis),
    ("P2 rule forks diverge in content and structure", rule_forks_diverge),
    ("P3 scope forks diverge in structure only", scope_forks_diverge_structurally),
    (
        "P-L description and structure are constitutive for every kind",
        description_and_structure_are_lifecycle_for_all_kinds,
    ),
]

cfg = engine.base_cfg()
previous = engine.predict_all(cfg)
print("== pass 1 baseline ==")
engine.score(previous, "pass1")
for name, apply_premise in premises:
    apply_premise(cfg)
    current = engine.predict_all(cfg)
    print("\n== after adding:", name, "==")
    for item in cells_that_change(previous, current):
        print("  ", item)
    engine.score(current, "cumulative")
    previous = current

print("\n== residual mismatches after P1, P2, P3, P-L ==")
mismatches, _ = engine.score(previous, "final")
for item in mismatches:
    print("  ", item)
