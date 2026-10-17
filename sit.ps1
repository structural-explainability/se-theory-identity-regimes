#Requires -Version 5.1

<#
============================================================
sit.ps1 (ALL-PY-REPOS) - Get Situated
============================================================
Updated: 2026-10-11

WHAT: A PowerShell script that sets up, updates, and checks the
      project's Python development environment.
      PowerShell scripts use the .ps1 file extension.

WHEN: Use when setting up a project or updating its development tools.
      Running the script is optional.

WHY: Professional projects use consistent tools and automated checks
     to help ensure they work reliably across different computers.
     This script provides a repeatable way to prepare the environment,
     update dependencies, run Git hooks, and build documentation.

POWERSHELL: PowerShell is a command shell and scripting language.
            Windows includes Windows PowerShell 5.1.
            The newer PowerShell (pwsh) is free and cross-platform.
            Windows, macOS, and Linux users can install pwsh.

HOW: Open a PowerShell terminal in the project root and run:

     .\sit.ps1

TOOLS: uv manages Python versions and project dependencies.
       prek runs automated Git hooks.
       Zensical builds the project documentation website.

SKILLS: PowerShell, scripting, Python environments, uv,
        dependency management, Git hooks, project automation,
        and documentation builds.

OBS: Some commands update project files or delete generated files.
     Review changes before committing them to Git.
============================================================
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ============================================================
# A) PYTHON ENVIRONMENT
# Clean, update, install, synchronize, and audit dependencies.
# ============================================================

uvx pup-clean --delete
uv self update
uv python install
uv lock --upgrade
uv sync
uv audit

# ============================================================
# B) GIT HOOKS
# Install, update, and run automated project checks.
# ============================================================

uvx prek install --force
uvx prek update
git add -A
uvx prek run --all-files
uvx prek run --all-files

# ============================================================
# C) DOCUMENTATION
# Build the professional project documentation website.
# ============================================================

uv run python -m zensical build

Write-Host "All commands executed successfully."
