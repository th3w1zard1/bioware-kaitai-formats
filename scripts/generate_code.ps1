# Helper script to generate Kaitai Struct code for a specific language
# Usage: .\scripts\generate_code.ps1 -Language python -OutputDir generated/python

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("python", "javascript", "java", "go", "rust", "cpp_stl", "csharp", "ruby", "php", "lua", "perl", "nim", "swift")]
    [string]$Language,

    [Parameter(Mandatory=$true)]
    [string]$OutputDir,

    [string]$KscVersion = "0.11",
    [string]$FormatsDir = "formats"
)

$ErrorActionPreference = "Stop"

Write-Host "Generating $Language code from Kaitai Struct definitions..." -ForegroundColor Cyan

. "$PSScriptRoot/KscResolve.ps1"

$kscExe = Get-ResolvedKscExecutable
if (-not $kscExe) {
    Write-Host "Installing Kaitai Struct compiler $KscVersion..." -ForegroundColor Yellow
    pip install "kaitai-struct-compiler==$KscVersion"
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to install kaitai-struct-compiler"
        exit 1
    }
    $kscExe = Get-ResolvedKscExecutable
}

if (-not $kscExe) {
    Write-Error "Could not locate ksc or kaitai-struct-compiler after install. Set KAITAI_STRUCT_COMPILER or add KSC to PATH."
    exit 1
}

$kscInstalled = $false
try {
    $verOut = & $kscExe --version 2>&1
    if ($LASTEXITCODE -eq 0 -and "$verOut" -match [regex]::Escape($KscVersion)) {
        $kscInstalled = $true
        Write-Host "Kaitai Struct compiler $KscVersion is already installed ($kscExe)" -ForegroundColor Green
    }
} catch {
    $kscInstalled = $false
}

if (-not $kscInstalled) {
    Write-Host "Installing Kaitai Struct compiler $KscVersion..." -ForegroundColor Yellow
    pip install "kaitai-struct-compiler==$KscVersion"
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to install kaitai-struct-compiler"
        exit 1
    }
    $kscExe = Get-ResolvedKscExecutable
    if (-not $kscExe) {
        Write-Error "Could not locate ksc or kaitai-struct-compiler after install."
        exit 1
    }
}

# Find all .ksy files
$ksyFiles = Get-ChildItem -Path $FormatsDir -Filter "*.ksy" -Recurse

if ($ksyFiles.Count -eq 0) {
    Write-Error "No .ksy files found in $FormatsDir"
    exit 1
}

Write-Host "Found $($ksyFiles.Count) .ksy files" -ForegroundColor Green

# Create output directory
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

$successCount = 0
$failCount = 0

foreach ($ksyFile in $ksyFiles) {
    $relativePath = $ksyFile.FullName.Substring((Resolve-Path $FormatsDir).Path.Length + 1)
    $relativeDir = Split-Path -Parent $relativePath

    # Calculate output path maintaining directory structure
    if ($relativeDir) {
        $targetDir = Join-Path $OutputDir $relativeDir
    } else {
        $targetDir = $OutputDir
    }

    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }

    Write-Host "  Processing: $relativePath" -ForegroundColor Gray

    try {
        & $kscExe -t $Language -d $targetDir $ksyFile.FullName
        if ($LASTEXITCODE -eq 0) {
            $successCount++
        } else {
            Write-Warning "  Failed to generate code for $relativePath"
            $failCount++
        }
    } catch {
        Write-Warning "  Error processing $relativePath : $_"
        $failCount++
    }
}

Write-Host ""
Write-Host "Generation complete:" -ForegroundColor Cyan
Write-Host "  Success: $successCount" -ForegroundColor Green
Write-Host "  Failed: $failCount" -ForegroundColor $(if ($failCount -gt 0) { "Red" } else { "Green" })

if ($failCount -gt 0) {
    exit 1
}

