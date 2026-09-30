"""Repository validation for se-theory-identity-regimes."""

from typing import cast

from se_manifest_schema.load import (
    find_manifest_path,
    load_manifest,
    load_schema,
)
from se_manifest_schema.types.manifest_schema import ManifestSchemaData
from se_manifest_schema.validate_contract import validate_tag
from se_manifest_schema.validate_manifest import validate_manifest

from se_theory_identity_regimes.reference import run_ref_validate


def run_validate(*, require_tag: bool = False, strict: bool = False) -> int:
    """Validate this theory repository.

    Args:
        require_tag: Verify CITATION.cff version matches the current Git tag.
        strict: Treat reference-validation warnings as errors.

    Returns:
        0 on success, 1 on failure.
    """
    try:
        manifest_path = find_manifest_path()
        manifest = load_manifest(manifest_path)
        schema = cast(ManifestSchemaData, load_schema())
    except (FileNotFoundError, ValueError) as exc:
        print(f"ERROR: {exc}")
        return 1

    errors: list[str] = []

    if require_tag:
        errors.extend(validate_tag(manifest))

    errors.extend(
        validate_manifest(
            manifest,
            schema,
            manifest_filename=manifest_path.name,
        )
    )

    for error in errors:
        print(f"ERROR: {error}")

    if errors:
        return 1

    ref_result = run_ref_validate(strict=strict)
    if ref_result != 0:
        return ref_result

    print("Repository validation passed.")
    return 0
