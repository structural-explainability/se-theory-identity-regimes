# Key-invariance criterion engine. Reads the frozen inputs, computes predictions, scores them
# against SE-200's four-valued table (transcribed from sections/06_nine_regimes.tex).
import copy
import itertools
import sys

import kic_inputs as inputs

# SE-200 Table (paper), P = preserves, B = breaks, N = neutral, A = not applicable.
PAPER_ROWS = {
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
MATRIX = {}
for regime in inputs.REGIMES:
    MATRIX[regime] = {}
for transformation in inputs.TRANSFORMATIONS:
    values = PAPER_ROWS[transformation].split()
    for regime, value in zip(inputs.REGIMES, values):
        MATRIX[regime][transformation] = value

VALUE_NAME = {"P": "PRS", "B": "BRK", "N": "NEU", "A": "N/A"}


def classify(regime, transformation, cfg):
    kind = cfg["KIND_OF_REGIME"][regime]
    effect = cfg["TRANSFORMATION_EFFECT"][transformation]
    for axis in effect["pre"]:
        if axis not in cfg["KIND_AXES"][kind]:
            return "A"
    altered = set(effect["alters"])
    if transformation == "BF":
        altered = altered | set(cfg["FORK_DIVERGES"][kind])
    if altered & set(cfg["KEY_AXES"][regime]):
        return "B"
    if altered & set(cfg["LIFECYCLE_AXES"][kind]):
        return "P"
    return "N"


def base_cfg():
    cfg = {}
    cfg["KIND_OF_REGIME"] = copy.deepcopy(inputs.KIND_OF_REGIME)
    cfg["TRANSFORMATION_EFFECT"] = copy.deepcopy(inputs.TRANSFORMATION_EFFECT)
    cfg["KIND_AXES"] = copy.deepcopy(inputs.KIND_AXES)
    cfg["KEY_AXES"] = copy.deepcopy(inputs.KEY_AXES)
    cfg["FORK_DIVERGES"] = copy.deepcopy(inputs.FORK_DIVERGES)
    cfg["LIFECYCLE_AXES"] = copy.deepcopy(inputs.LIFECYCLE_AXES)
    return cfg


def predict_all(cfg):
    prediction = {}
    for regime in inputs.REGIMES:
        prediction[regime] = {}
        for transformation in inputs.TRANSFORMATIONS:
            prediction[regime][transformation] = classify(regime, transformation, cfg)
    return prediction


def three_way(value):
    # Layer 1 and 2 view: BRK, applicable non-breaking, not applicable.
    if value == "B":
        return "BRK"
    if value == "A":
        return "N/A"
    return "NB"


def score(prediction, label):
    total = 0
    exact = 0
    layer12 = 0
    brk_true_positive = 0
    brk_predicted = 0
    brk_actual = 0
    na_true_positive = 0
    na_predicted = 0
    na_actual = 0
    relevance_total = 0
    relevance_correct = 0
    mismatches = []
    for regime in inputs.REGIMES:
        for transformation in inputs.TRANSFORMATIONS:
            predicted = prediction[regime][transformation]
            actual = MATRIX[regime][transformation]
            total += 1
            if predicted == actual:
                exact += 1
            else:
                mismatches.append(
                    (regime, transformation, VALUE_NAME[predicted], VALUE_NAME[actual])
                )
            if three_way(predicted) == three_way(actual):
                layer12 += 1
            if predicted == "B":
                brk_predicted += 1
            if actual == "B":
                brk_actual += 1
            if predicted == "B" and actual == "B":
                brk_true_positive += 1
            if predicted == "A":
                na_predicted += 1
            if actual == "A":
                na_actual += 1
            if predicted == "A" and actual == "A":
                na_true_positive += 1
            if predicted in "PN" and actual in "PN":
                relevance_total += 1
                if predicted == actual:
                    relevance_correct += 1
    print(f"[{label}] exact 4-way: {exact}/{total}")
    print(f"[{label}] layers 1+2 (BRK / non-breaking / N/A): {layer12}/{total}")
    print(
        f"[{label}] BRK: predicted {brk_predicted}, actual {brk_actual}, both {brk_true_positive}"
    )
    print(
        f"[{label}] N/A: predicted {na_predicted}, actual {na_actual}, both {na_true_positive}"
    )
    print(
        f"[{label}] layer 3 (PRS vs NEU, where both predicted and actual are applicable non-breaking): {relevance_correct}/{relevance_total}"
    )
    return mismatches, layer12


def baselines():
    print("\n== baselines ==")
    # Baseline 1: predict NEU everywhere.
    count_neu = 0
    count_su_only = 0
    total = 0
    for regime in inputs.REGIMES:
        for transformation in inputs.TRANSFORMATIONS:
            total += 1
            actual = MATRIX[regime][transformation]
            if actual == "N":
                count_neu += 1
            guess = "B" if transformation == "SU" else "N"
            if three_way(guess) == three_way(actual):
                count_su_only += 1
    print(f"all-NEU exact 4-way: {count_neu}/{total}")
    print(f"'BRK iff SU, else non-breaking' on layers 1+2: {count_su_only}/{total}")


def permutation_test(cfg):
    # Give each regime the key of a different regime (keeping its own kind and axes) and rescore layers 1+2.
    # Cell scores are precomputed per (regime, borrowed key), so each permutation is a sum of nine numbers.
    regimes = inputs.REGIMES
    cell_score = {}
    for regime in regimes:
        cell_score[regime] = {}
        for key_owner in regimes:
            trial = copy.deepcopy(cfg)
            trial["KEY_AXES"][regime] = cfg["KEY_AXES"][key_owner]
            correct = 0
            for transformation in inputs.TRANSFORMATIONS:
                predicted = classify(regime, transformation, trial)
                if three_way(predicted) == three_way(MATRIX[regime][transformation]):
                    correct += 1
            cell_score[regime][key_owner] = correct
    observed = sum(cell_score[regime][regime] for regime in regimes)
    scores = []
    for permutation in itertools.permutations(range(len(regimes))):
        total = 0
        for index, regime in enumerate(regimes):
            total += cell_score[regime][regimes[permutation[index]]]
        scores.append(total)
    at_least = sum(1 for s in scores if s >= observed)
    print("\n== permutation test on keys (9! assignments) ==")
    print(f"observed layers 1+2 correct: {observed}/90")
    print(
        f"assignments scoring >= observed: {at_least} of {len(scores)} (p = {at_least / len(scores):.6f})"
    )
    print(
        f"best possible by reassigning keys: {max(scores)}/90; median {sorted(scores)[len(scores) // 2]}/90"
    )


if __name__ == "__main__":
    cfg = base_cfg()
    prediction = predict_all(cfg)
    print("== PASS 1 (frozen inputs) ==")
    mismatches, _ = score(prediction, "pass1")
    print("\nmismatches (regime, transformation, predicted, matrix):")
    for item in mismatches:
        print("  ", item)
    baselines()
    if len(sys.argv) > 1 and sys.argv[1] == "perm":
        permutation_test(cfg)
