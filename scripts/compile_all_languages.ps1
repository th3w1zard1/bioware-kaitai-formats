#! /usr/bin/env pwsh
# Compile all .ksy files to ALL supported languages
#
# Windows + uv: `uv run .\scripts\compile_all_languages.ps1` fails with Win32 error 193 because `uv run`
# tries to execute the `.ps1` as a native binary. Use either:
#   uv run pwsh -NoProfile -File .\scripts\compile_all_languages.ps1
# or run this script directly from PowerShell (`.\scripts\compile_all_languages.ps1`).

$ErrorActionPreference = "Continue"

. "$PSScriptRoot/KscResolve.ps1"
$script:kscExe = Get-ResolvedKscExecutable
if (-not $script:kscExe) {
    Write-Error "Could not find ksc or kaitai-struct-compiler. Add to PATH or set KAITAI_STRUCT_COMPILER."
    exit 1
}

# All Kaitai Struct supported languages
$languages = @(
    "construct",   # Construct (Python) codegen
    "cpp_stl",     # Native tools
    "csharp",      # Andastra, KotOR.NET  
    "go",          # Performance tools
    "graphviz",    # Structure diagrams
    "html",        # HTML documentation
    "java",        # Android tools
    "javascript",  # Web tools, KotOR.js
    "lua",         # Game modding
    "nim",         # Performance + safety
    "perl",        # Legacy tools
    "php",         # Web backend
    "python",      # PyKotor compatibility
    "ruby",        # Scripting
    "rust"         # Safe parsing
)

Write-Host "Compiling all .ksy files to $($languages.Count) languages..."
Write-Host ("=" * 80)

$ksyFiles = Get-ChildItem -Path "formats" -Filter "*.ksy" -Recurse

Write-Host "Found $($ksyFiles.Count) .ksy files to compile"
Write-Host ""

$formatsBase = (Resolve-Path "formats").Path

foreach ($lang in $languages) {
    Write-Host "Compiling to $lang..." -ForegroundColor Cyan
    
    $outputDir = "src/$lang/kaitai_generated"
    New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
    
    $successes = 0
    $failures = 0
    
    foreach ($file in $ksyFiles) {
        $relativePath = $file.FullName.Substring($formatsBase.Length + 1)
        $relativeDir = Split-Path -Parent $relativePath
        if ($relativeDir) {
            $targetDir = Join-Path $outputDir $relativeDir
        } else {
            $targetDir = $outputDir
        }
        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
        }

        $output = & $script:kscExe -t $lang -d $targetDir $file.FullName 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            $successes++
        } else {
            $failures++
            Write-Host $output -ForegroundColor Red
        }
    }
    
    $color = if ($failures -eq 0) { "Green" } else { "Yellow" }
    Write-Host "  ${lang}: $successes succeeded, $failures failed" -ForegroundColor $color
}

Write-Host ""
Write-Host ("=" * 80)
Write-Host "Compilation complete for all languages!"
Write-Host "Generated code in: src/<language>/kaitai_generated/<relative path under formats/>"

