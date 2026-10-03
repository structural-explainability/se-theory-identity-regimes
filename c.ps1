# ============================================================
# Audit Lean module migration from repository root
# ============================================================
# Read-only: reports issues; changes nothing.

$ErrorActionPreference = "Stop"

$root = (Get-Location).Path
$lakefilePath = Join-Path $root "lakefile.toml"

Write-Host ""
Write-Host "============================================================"
Write-Host "Lean Module Audit"
Write-Host "============================================================"
Write-Host "Root: $root"
Write-Host ""

# ------------------------------------------------------------
# Helpers
# ------------------------------------------------------------

function Get-RelativePath {
    param(
        [Parameter(Mandatory)]
        [string] $Path
    )

    return [System.IO.Path]::GetRelativePath($root, $Path)
}

function Get-LeanContent {
    param(
        [Parameter(Mandatory)]
        [string] $Path
    )

    $content = Get-Content -LiteralPath $Path -Raw

    if ($null -eq $content) {
        return ""
    }

    return $content
}

function Test-HasModuleDeclaration {
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string] $Content
    )

    if ([string]::IsNullOrWhiteSpace($Content)) {
        return $false
    }

    # Accept:
    # module
    # module -- shake: keep-all
    return $Content -match '(?m)^\s*module(?:\s+--.*)?\s*$'
}

function Get-ImportedModules {
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string] $Content
    )

    if ([string]::IsNullOrWhiteSpace($Content)) {
        return @()
    }

    $matches = [regex]::Matches(
        $Content,
        '(?m)^\s*(?:public\s+)?import\s+([A-Za-z0-9_.]+)\s*(?:--.*)?$'
    )

    return @(
        foreach ($match in $matches) {
            $match.Groups[1].Value
        }
    )
}

function Convert-ModuleToPath {
    param(
        [Parameter(Mandatory)]
        [string] $Module
    )

    $relative =
        ($Module -replace '\.', [System.IO.Path]::DirectorySeparatorChar) +
        ".lean"

    return Join-Path $root $relative
}

function Test-HasDeclarations {
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string] $Content
    )

    if ([string]::IsNullOrWhiteSpace($Content)) {
        return $false
    }

    return $Content -match (
        '(?m)^\s*' +
        '(?:' +
            'abbrev|' +
            'axiom|' +
            'class|' +
            'def|' +
            'inductive|' +
            'instance|' +
            'opaque|' +
            'structure|' +
            'theorem|' +
            'lemma' +
        ')\s+'
    )
}

function Get-TomlStringArrayValues {
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string] $Content,

        [Parameter(Mandatory)]
        [string] $Key
    )

    $escapedKey = [regex]::Escape($Key)

    $arrayMatches = [regex]::Matches(
        $Content,
        "(?ms)^\s*$escapedKey\s*=\s*\[(.*?)\]"
    )

    return @(
        foreach ($arrayMatch in $arrayMatches) {
            $stringMatches = [regex]::Matches(
                $arrayMatch.Groups[1].Value,
                '"([^"]+)"'
            )

            foreach ($stringMatch in $stringMatches) {
                $stringMatch.Groups[1].Value
            }
        }
    )
}

function Get-LeanLibraryOwnershipRules {
    param(
        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string] $LakeContent
    )

    $rules = @()

    # Read each [[lean_lib]] declaration independently.
    $libraryBlocks = [regex]::Matches(
        $LakeContent,
        '(?ms)^\s*\[\[lean_lib\]\]\s*(.*?)(?=^\s*\[\[|\z)'
    )

    foreach ($libraryBlock in $libraryBlocks) {
        $block = $libraryBlock.Groups[1].Value

        # The library name itself denotes an owned module namespace.
        $nameMatch = [regex]::Match(
            $block,
            '(?m)^\s*name\s*=\s*"([^"]+)"\s*$'
        )

        if ($nameMatch.Success) {
            $name = $nameMatch.Groups[1].Value

            $rules += [pscustomobject]@{
                Mode  = "Exact"
                Value = $name
            }

            $rules += [pscustomobject]@{
                Mode  = "Prefix"
                Value = "$name."
            }
        }

        # roots identify explicit library roots.
        $roots = @(
            Get-TomlStringArrayValues `
                -Content $block `
                -Key "roots"
        )

        foreach ($moduleRoot in $roots) {
            $rules += [pscustomobject]@{
                Mode  = "Exact"
                Value = $moduleRoot
            }

            $rules += [pscustomobject]@{
                Mode  = "Prefix"
                Value = "$moduleRoot."
            }
        }

        # globs identify exact modules and owned submodule families.
        $globs = @(
            Get-TomlStringArrayValues `
                -Content $block `
                -Key "globs"
        )

        foreach ($glob in $globs) {
            if ($glob.EndsWith(".*")) {
                $base = $glob.Substring(0, $glob.Length - 2)

                $rules += [pscustomobject]@{
                    Mode  = "Exact"
                    Value = $base
                }

                $rules += [pscustomobject]@{
                    Mode  = "Prefix"
                    Value = "$base."
                }

                continue
            }

            if ($glob.EndsWith(".+")) {
                $base = $glob.Substring(0, $glob.Length - 2)

                $rules += [pscustomobject]@{
                    Mode  = "Prefix"
                    Value = "$base."
                }

                continue
            }

            $rules += [pscustomobject]@{
                Mode  = "Exact"
                Value = $glob
            }
        }
    }

    return @(
        $rules |
            Sort-Object Mode, Value -Unique
    )
}

function Test-IsOwnedModule {
    param(
        [Parameter(Mandatory)]
        [string] $Module,

        [Parameter(Mandatory)]
        [object[]] $Rules
    )

    foreach ($rule in $Rules) {
        if (
            $rule.Mode -eq "Exact" -and
            $Module -ceq $rule.Value
        ) {
            return $true
        }

        if (
            $rule.Mode -eq "Prefix" -and
            $Module.StartsWith($rule.Value)
        ) {
            return $true
        }
    }

    return $false
}

function Convert-PackageNameToLegacyNamespace {
    param(
        [Parameter(Mandatory)]
        [string] $PackageName
    )

    if ($PackageName -notmatch '^se-theory-(.+)$') {
        return $null
    }

    $suffix = $Matches[1]

    $pascalParts = @(
        foreach ($part in ($suffix -split '-')) {
            if ($part.Length -eq 0) {
                continue
            }

            $part.Substring(0, 1).ToUpperInvariant() +
                $part.Substring(1)
        }
    )

    if ($pascalParts.Count -eq 0) {
        return $null
    }

    return "SETheory$($pascalParts -join '')"
}

# ------------------------------------------------------------
# Read Lake configuration
# ------------------------------------------------------------

if (-not (Test-Path -LiteralPath $lakefilePath -PathType Leaf)) {
    throw "lakefile.toml was not found at repository root."
}

$lakeContent = Get-Content -LiteralPath $lakefilePath -Raw

if ($null -eq $lakeContent) {
    $lakeContent = ""
}

$ownedModuleRules = @(
    Get-LeanLibraryOwnershipRules -LakeContent $lakeContent
)

if ($ownedModuleRules.Count -eq 0) {
    throw "No local Lean library ownership rules could be read from lakefile.toml."
}

$packageNameMatch = [regex]::Match(
    $lakeContent,
    '(?m)^\s*name\s*=\s*"([^"]+)"\s*$'
)

$legacyNamespace = $null

if ($packageNameMatch.Success) {
    $packageName = $packageNameMatch.Groups[1].Value
    $legacyNamespace =
        Convert-PackageNameToLegacyNamespace -PackageName $packageName
}

# ------------------------------------------------------------
# Collect Lean files
# ------------------------------------------------------------

$leanFiles = @(
    Get-ChildItem `
        -Path $root `
        -Recurse `
        -File `
        -Filter "*.lean" |
    Where-Object {
        $_.FullName -notmatch '[\\/]\.lake[\\/]'
    } |
    Sort-Object FullName
)

Write-Host "Lean files found: $($leanFiles.Count)"
Write-Host ""

$errors = [System.Collections.Generic.List[object]]::new()
$warnings = [System.Collections.Generic.List[object]]::new()
$info = [System.Collections.Generic.List[object]]::new()

function Add-Issue {
    param(
        [Parameter(Mandatory)]
        [ValidateSet("ERROR", "WARNING", "INFO")]
        [string] $Severity,

        [Parameter(Mandatory)]
        [string] $File,

        [Parameter(Mandatory)]
        [string] $Message
    )

    $item = [pscustomobject]@{
        Severity = $Severity
        File     = $File
        Message  = $Message
    }

    switch ($Severity) {
        "ERROR"   { $errors.Add($item) }
        "WARNING" { $warnings.Add($item) }
        "INFO"    { $info.Add($item) }
    }
}

# ------------------------------------------------------------
# Audit every Lean file
# ------------------------------------------------------------

foreach ($file in $leanFiles) {
    $relative = Get-RelativePath -Path $file.FullName
    $content = Get-LeanContent -Path $file.FullName

    if ([string]::IsNullOrWhiteSpace($content)) {
        Add-Issue `
            -Severity "ERROR" `
            -File $relative `
            -Message "Lean file is empty."

        continue
    }

    $hasModule = Test-HasModuleDeclaration -Content $content
    $imports = @(Get-ImportedModules -Content $content)

    # --------------------------------------------------------
    # 1. Every migrated Lean file should use the module system.
    # --------------------------------------------------------

    if (-not $hasModule) {
        Add-Issue `
            -Severity "ERROR" `
            -File $relative `
            -Message "Missing module declaration."
    }

    # --------------------------------------------------------
    # 2. Catch stale pre-migration namespace/import references.
    # --------------------------------------------------------

    if ($null -ne $legacyNamespace) {
        $legacyPattern =
            '\b' + [regex]::Escape($legacyNamespace) + '\b'

        if ($content -match $legacyPattern) {
            Add-Issue `
                -Severity "ERROR" `
                -File $relative `
                -Message "Contains stale $legacyNamespace reference."
        }
    }

    # --------------------------------------------------------
    # 3. Module files defining declarations should normally
    #    expose them explicitly through a public section.
    # --------------------------------------------------------

    if (
        $hasModule -and
        (Test-HasDeclarations -Content $content) -and
        $content -notmatch '(?m)^\s*(?:@\[[^\]]+\]\s*)?public\s+section\b'
    ) {
        Add-Issue `
            -Severity "WARNING" `
            -File $relative `
            -Message "Defines declarations but has no public section; review public visibility."
    }

    # --------------------------------------------------------
    # 4. Check locally owned import targets.
    #
    #    Dependencies may expose modules under the same top-level
    #    namespace, such as:
    #
    #    SE.NeutralSubstrate
    #    SE.Transformation
    #
    #    Only modules owned by this repository's [[lean_lib]]
    #    declarations are required to have local source files.
    # --------------------------------------------------------

    foreach ($import in $imports) {
        if (
            -not (
                Test-IsOwnedModule `
                    -Module $import `
                    -Rules $ownedModuleRules
            )
        ) {
            continue
        }

        $targetPath = Convert-ModuleToPath -Module $import

        if (-not (Test-Path -LiteralPath $targetPath -PathType Leaf)) {
            Add-Issue `
                -Severity "ERROR" `
                -File $relative `
                -Message "Local import '$import' has no file: $([System.IO.Path]::GetRelativePath($root, $targetPath))"

            continue
        }

        # ----------------------------------------------------
        # 5. A new-style module cannot import an old-style
        #    non-module local dependency.
        # ----------------------------------------------------

        if ($hasModule) {
            $targetContent = Get-LeanContent -Path $targetPath

            if (-not (Test-HasModuleDeclaration -Content $targetContent)) {
                Add-Issue `
                    -Severity "ERROR" `
                    -File $relative `
                    -Message "Module imports legacy non-module '$import'."
            }
        }
    }

    # --------------------------------------------------------
    # 6. Report ordinary imports inside production modules.
    #    Not automatically wrong: useful migration review.
    # --------------------------------------------------------

    if ($hasModule -and $relative -match '^SE[\\/]') {
        $ordinaryImports = [regex]::Matches(
            $content,
            '(?m)^\s*import\s+([A-Za-z0-9_.]+)\s*(?:--.*)?$'
        )

        foreach ($match in $ordinaryImports) {
            Add-Issue `
                -Severity "INFO" `
                -File $relative `
                -Message "Ordinary import '$($match.Groups[1].Value)'; confirm it should not be public import."
        }
    }
}

# ------------------------------------------------------------
# Display results
# ------------------------------------------------------------

function Show-Issues {
    param(
        [Parameter(Mandatory)]
        [string] $Title,

        [Parameter(Mandatory)]
        [System.Collections.IEnumerable] $Items
    )

    $array = @($Items)

    Write-Host ""
    Write-Host "============================================================"
    Write-Host "$Title ($($array.Count))"
    Write-Host "============================================================"

    if ($array.Count -eq 0) {
        Write-Host "None."
        return
    }

    foreach ($item in $array) {
        Write-Host ""
        Write-Host "$($item.File)"
        Write-Host "  $($item.Message)"
    }
}

Show-Issues -Title "ERRORS" -Items $errors
Show-Issues -Title "WARNINGS" -Items $warnings
Show-Issues -Title "REVIEW ONLY" -Items $info

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------

Write-Host ""
Write-Host "============================================================"
Write-Host "Summary"
Write-Host "============================================================"
Write-Host "Lean files : $($leanFiles.Count)"
Write-Host "Errors     : $($errors.Count)"
Write-Host "Warnings   : $($warnings.Count)"
Write-Host "Review     : $($info.Count)"
Write-Host ""

if ($errors.Count -gt 0) {
    Write-Host "FAIL: module migration issues found."
    exit 1
}

Write-Host "PASS: no structural module errors found."

if ($warnings.Count -gt 0) {
    Write-Host "Review warnings before considering the migration complete."
}

exit 0
