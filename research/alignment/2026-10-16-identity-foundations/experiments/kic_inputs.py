# Key-invariance criterion (KIC): FROZEN INPUTS, pass 1.
# Written before any prediction was computed.
# Sources: SE-200 inventory (section 4), transformation-basis definition (section 3.3),
# basis definitions (sections 5.1, 5.4-5.6, definitional sentences only).
# Disclosure: the author had already read the classification matrix before writing these inputs.
# Entries tagged J are judgment calls; each is listed in the ledger printed by kic_engine.py.

AXES = [
    "FMT",
    "ANN",
    "DSC",
    "STR",
    "SUB",
    "TXT",
    "CTX",
    "ASC",
    "HST",
    "ORG",
    "STA",
    "BRN",
    "CAR",
    "TMP",
    "LOC",
    "OBJ",
]

TRANSFORMATIONS = ["RE", "AN", "RF", "AD", "RC", "RA", "SU", "BF", "SE", "PV"]

REGIMES = ["OBL", "OCC", "REC", "ENR_L", "ENR_I", "CTX_E", "CTX_S", "NOR_C", "NOR_S"]

KIND_OF_REGIME = {
    "OBL": "obligation_bearer",
    "OCC": "occurrence",
    "REC": "record",
    "ENR_L": "plain_referent",
    "ENR_I": "plain_referent",
    "CTX_E": "scope",
    "CTX_S": "scope",
    "NOR_C": "rule",
    "NOR_S": "rule",
}

# Transformation effects, from the one-line definitions in the transformation basis (SE-200 section 3.3).
# pre = axes the kind must possess for the transformation to arise.
# alters = axes whose value the transformation changes.
TRANSFORMATION_EFFECT = {
    "RE": {
        "pre": ["FMT"],
        "alters": ["FMT"],
    },  # "change of representation format while preserving the represented content"
    "AN": {
        "pre": ["ANN"],
        "alters": ["ANN"],
    },  # "addition of non-identity-bearing information"
    "RF": {
        "pre": ["DSC"],
        "alters": ["DSC", "STR", "TXT"],
    },  # "increase in descriptive, structural, or normative detail"  (J: substance SUB is held fixed)
    "AD": {
        "pre": ["STR"],
        "alters": ["STR"],
    },  # "whole-preserving restructuring into coarser or finer components"
    "RC": {"pre": ["CTX"], "alters": ["CTX"]},  # "change in applicability context"
    "RA": {
        "pre": ["ASC"],
        "alters": ["ASC"],
    },  # "change in association, bearer, or assignment relation"
    "SU": {"pre": ["CAR"], "alters": ["CAR"]},  # "replacement of the identity carrier"
    "BF": {
        "pre": ["BRN"],
        "alters": ["BRN"],
    },  # "divergence into multiple continuations"  (plus per-kind fork divergence, below)
    "PV": {
        "pre": ["HST"],
        "alters": ["HST"],
    },  # "addition of historical, derivational, or evidentiary metadata"
    "SE": {
        "pre": ["STA"],
        "alters": ["STA"],
    },  # "change in state of an enduring referent over time"
}

# Axes each kind possesses (decides applicability). Source tags in comments.
KIND_AXES = {
    # "a party that can bear responsibility ... across occurrences ... fulfilled, violated, transferred, contested, or discharged"
    "obligation_bearer": [
        "FMT",
        "ANN",
        "DSC",
        "STR",
        "CTX",
        "ASC",
        "HST",
        "STA",
        "BRN",
        "CAR",
    ],
    # "a happening individuated by temporal realization and provenance"; "may involve several bearers"; a happening is not an enduring referent (J), has one realization so no continuations (J)
    "occurrence": [
        "FMT",
        "ANN",
        "DSC",
        "STR",
        "CTX",
        "ASC",
        "HST",
        "ORG",
        "TMP",
        "CAR",
    ],
    # "a descriptive indicator or record ... cited, transferred, compared, annotated, or analyzed"
    "record": ["FMT", "ANN", "DSC", "STR", "CTX", "ASC", "HST", "STA", "BRN", "CAR"],
    # "a thing acted upon, regulated, located, transferred, observed"; "A sample may be transferred across institutions"
    "plain_referent": [
        "FMT",
        "ANN",
        "DSC",
        "STR",
        "CTX",
        "ASC",
        "HST",
        "STA",
        "BRN",
        "CAR",
        "LOC",
        "OBJ",
    ],
    # "the applicability domain for a rule": an abstract domain, not an enduring referent with states (J)
    "scope": ["FMT", "ANN", "DSC", "STR", "SUB", "CTX", "ASC", "HST", "BRN", "CAR"],
    # "a governing normative structure": abstract, not an enduring referent with states (J)
    "rule": [
        "FMT",
        "ANN",
        "DSC",
        "STR",
        "SUB",
        "TXT",
        "CTX",
        "ASC",
        "HST",
        "BRN",
        "CAR",
    ],
}

# Key axes (what the basis individuates on), from the definitional sentences of each basis.
KEY_AXES = {
    "OBL": ["CAR"],  # "persistence as the party that can bear responsibility"
    "OCC": [
        "CAR",
        "TMP",
        "ORG",
    ],  # "individuated by temporal realization and provenance" (origin provenance, not accumulated metadata)
    "REC": ["CAR"],  # "descriptive persistence": names no further key axis (J)
    "ENR_L": [
        "CAR",
        "LOC",
    ],  # "place, site, slot, location, or institutional position that remains fixed"
    "ENR_I": [
        "CAR",
        "OBJ",
    ],  # "object, asset, instrument, sample, device, parcel, or thing occupying that locus"
    "CTX_E": [
        "CAR",
        "SUB",
    ],  # "cases, persons, places, entities, or conditions it covers"
    "CTX_S": [
        "CAR",
        "STR",
        "CTX",
        "ASC",
    ],  # "internal organization through which coverage is represented"; inventory: "internal jurisdictional or applicability organization" (J: context and assignment count as organization)
    "NOR_C": [
        "CAR",
        "SUB",
    ],  # "requirements, permissions, prohibitions, authorizations, or definitions"
    "NOR_S": [
        "CAR",
        "STR",
    ],  # "organization of the text, sections, clauses, delegations, or internal rule structure" (J: wording TXT excluded; delegation counted inside STR)
}

# Fork divergence: axes along which forked continuations of a K-referent differ from one another.
# Only the plain-referent definition states this ("fork into non-identical object continuations").
# Default is empty: a fork of representations is a copy unless the kind's definition says the referents diverge.
FORK_DIVERGES = {
    "obligation_bearer": [],
    "occurrence": [],
    "record": [],
    "plain_referent": ["OBJ"],
    "scope": [],
    "rule": [],
}

# Lifecycle axes: axes along which instances of the kind ordinarily change while persisting.
# Used only for the PRS-versus-NEU interpretive layer. Source: verbs in the inventory entries.
LIFECYCLE_AXES = {
    "obligation_bearer": [
        "ASC",
        "STA",
    ],  # "fulfilled, violated, transferred, contested, or discharged"
    "occurrence": [
        "STA"
    ],  # "phases or stages" is not in the inventory; left minimal (J)
    "record": [
        "ANN",
        "ASC",
        "HST",
        "DSC",
    ],  # "cited, transferred, compared, annotated, or analyzed"; "produced ... received ... annotated ... reanalyzed"
    "plain_referent": [
        "ASC",
        "STA",
        "LOC",
    ],  # "acted upon, regulated, located, transferred, observed"
    "scope": [
        "STR",
        "CTX",
    ],  # "nested, overlapping, partially coincident, or contested"
    "rule": [
        "STR",
        "TXT",
        "SUB",
    ],  # "enacted, amended, delegated, interpreted, applied, violated, or repealed"
}
