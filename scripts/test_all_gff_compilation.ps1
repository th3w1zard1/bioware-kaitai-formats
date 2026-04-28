# Test compilation of all GFF generic formats
# This script systematically tests each format and reports results

$ErrorActionPreference = "Continue"
. "$PSScriptRoot/KscResolve.ps1"
$kscExe = Get-ResolvedKscExecutable
if (-not $kscExe) {
    Write-Error "Could not find ksc or kaitai-struct-compiler. Add to PATH or set KAITAI_STRUCT_COMPILER."
    exit 1
}

$formats = @('ARE', 'CNV', 'DLG', 'FAC', 'GAM', 'GIT', 'GUI', 'GVT', 'IFO', 'JRL', 'NFO', 'PT', 'PTH', 'UTC', 'UTD', 'UTE', 'UTI', 'UTM', 'UTP', 'UTS', 'UTT', 'UTW')
$results = @{}

Write-Host "Testing GFF Generic Format Compilation..."
Write-Host ""

foreach ($fmt in $formats) {
    $path = "formats/GFF/Generics/$fmt/$fmt.ksy"
    
    if (-not (Test-Path $path)) {
        $results[$fmt] = "FILE NOT FOUND"
        Write-Host "${fmt}: FILE NOT FOUND"
        continue
    }
    
    Write-Host "Testing ${fmt}..."
    $output = & $kscExe -t csharp -d test_output $path 2>&1
    $exitCode = $LASTEXITCODE
    
    if ($exitCode -eq 0) {
        $results[$fmt] = "OK"
        Write-Host "  ✅ ${fmt}: OK"
    } else {
        $firstError = ($output | Select-Object -First 1).ToString()
        $results[$fmt] = "ERROR: $firstError"
        Write-Host "  ❌ ${fmt}: ERROR"
        Write-Host "     $firstError"
    }
    
    # Clean up test output
    if (Test-Path "test_output") {
        Remove-Item -Path test_output -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host ""
Write-Host "=== COMPILATION SUMMARY ==="
$okCount = ($results.Values | Where-Object { $_ -eq "OK" }).Count
$errorCount = ($results.Values | Where-Object { $_ -like "ERROR:*" }).Count
$notFoundCount = ($results.Values | Where-Object { $_ -eq "FILE NOT FOUND" }).Count

Write-Host "Total: $($results.Count)"
Write-Host "OK: $okCount"
Write-Host "Errors: $errorCount"
Write-Host "Not Found: $notFoundCount"

Write-Host ""
Write-Host "=== DETAILED RESULTS ==="
$results.GetEnumerator() | Sort-Object Name | ForEach-Object {
    Write-Host "$($_.Key): $($_.Value)"
}

