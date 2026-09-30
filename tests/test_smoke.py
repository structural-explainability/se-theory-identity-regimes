"""Smoke tests for the Python package."""

import se_theory_identity_regimes
import se_theory_identity_regimes.lean_surface
import se_theory_identity_regimes.paths


def test_package_imports() -> None:
    """Verify the package imports successfully."""
    assert se_theory_identity_regimes is not None
