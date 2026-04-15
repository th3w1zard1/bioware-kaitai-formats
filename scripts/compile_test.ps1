# Simple compilation test script
$ErrorActionPreference = "Continue"

. "$PSScriptRoot/KscResolve.ps1"
$kscExe = Get-ResolvedKscExecutable
if (-not $kscExe) {
    Write-Error "Could not find ksc or kaitai-struct-compiler. Add to PATH or set KAITAI_STRUCT_COMPILER."
    exit 1
}

$outputDir = "src/python/kaitai_generated"
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

$ksyFiles = Get-ChildItem -Path "formats" -Filter "*.ksy" -Recurse | Sort-Object FullName

$successes = 0
$failures = 0

Write-Host "Compiling $($ksyFiles.Count) .ksy files..."

foreach ($file in $ksyFiles) {
    $relPath = $file.FullName.Replace("$PWD\formats\", "")
    Write-Host -NoNewline "Compiling $relPath... "
    
    $output = & $kscExe -t python -d $outputDir $file.FullName 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "OK" -ForegroundColor Green
        $successes++
    } else {
        Write-Host "FAILED" -ForegroundColor Red
        $failures++
    }
}

Write-Host "`nSummary: $successes succeeded, $failures failed"
exit $(if ($failures -gt 0) { 1 } else { 0 })

