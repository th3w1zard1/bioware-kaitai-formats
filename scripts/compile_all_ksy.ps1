<#
.SYNOPSIS
    Compiles all Kaitai Struct (.ksy) format definition files to target programming languages.

.DESCRIPTION
    This script recursively finds all .ksy files in the formats directory and compiles them
    to the specified target language using the Kaitai Struct compiler. It provides detailed
    progress reporting and error handling.

.PARAMETER TargetLanguage
    The target programming language to compile to. Supported languages include:
    python, javascript, java, go, rust, cpp_stl, csharp, ruby, php, lua, perl, nim, swift.

.PARAMETER OutputDirectory
    The directory where compiled files will be placed. Defaults to "src/<language>/kaitai_generated".

.PARAMETER FormatsDirectory
    The directory containing .ksy files to compile. Defaults to "formats".

.PARAMETER Force
    Overwrite existing output directory without prompting.

.EXAMPLE
    .\compile_all_ksy.ps1 -TargetLanguage python

    Compiles all .ksy files to Python in the default output directory.

.EXAMPLE
    .\compile_all_ksy.ps1 -TargetLanguage csharp -OutputDirectory "src/csharp" -Force

    Compiles all .ksy files to C# with a custom output directory, overwriting any existing files.

.EXAMPLE
    .\compile_all_ksy.ps1 -TargetLanguage java -FormatsDirectory "custom_formats" -Verbose

    Compiles .ksy files from a custom directory to Java with verbose output.
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('python', 'javascript', 'java', 'go', 'rust', 'cpp_stl', 'csharp', 'ruby', 'php', 'lua', 'perl', 'nim', 'swift')]
    [string]$TargetLanguage,

    [Parameter()]
    [ValidateScript({
        if ([string]::IsNullOrWhiteSpace($_)) {
            throw "OutputDirectory cannot be null or empty."
        }
        $true
    })]
    [string]$OutputDirectory,

    [Parameter()]
    [ValidateScript({
        if (-not (Test-Path $_ -PathType Container)) {
            throw "FormatsDirectory '$_' does not exist or is not a directory."
        }
        $true
    })]
    [string]$FormatsDirectory = "formats",

    [Parameter()]
    [switch]$Force
)

begin {
    . "$PSScriptRoot/KscResolve.ps1"

    # Set default output directory based on target language
    if (-not $OutputDirectory) {
        $OutputDirectory = "src/$TargetLanguage/kaitai_generated"
    }

    $script:kscExe = Get-ResolvedKscExecutable
    if (-not $script:kscExe) {
        throw "Could not find ksc or kaitai-struct-compiler. Add to PATH or set KAITAI_STRUCT_COMPILER."
    }
    Write-Verbose "Using Kaitai Struct compiler at: $script:kscExe"

    # Resolve paths to absolute paths
    $formatsDir = Resolve-Path $FormatsDirectory
    $outputDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputDirectory)

    Write-Verbose "Formats directory: $formatsDir"
    Write-Verbose "Output directory: $outputDir"
    Write-Verbose "Target language: $TargetLanguage"

    # Initialize counters
    $script:successCount = 0
    $script:failureCount = 0
    $script:failedFiles = @()
    $script:processedCount = 0
}

process {
    try {
        # Find all .ksy files
        Write-Verbose "Searching for .ksy files in $formatsDir"
        $ksyFiles = Get-ChildItem -Path $formatsDir -Filter "*.ksy" -Recurse -File | Sort-Object FullName

        if ($ksyFiles.Count -eq 0) {
            Write-Warning "No .ksy files found in $formatsDir"
            return
        }

        Write-Host "Found $($ksyFiles.Count) .ksy files to compile" -ForegroundColor Cyan
        Write-Host ("=" * 80) -ForegroundColor Cyan

        # Create output directory
        if ($Force -or -not (Test-Path $outputDir)) {
            if ($PSCmdlet.ShouldProcess($outputDir, "Create output directory")) {
                New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
                Write-Verbose "Created output directory: $outputDir"
            }
        }
        elseif (-not $Force) {
            $existingFiles = Get-ChildItem -Path $outputDir -File -Recurse
            if ($existingFiles.Count -gt 0) {
                if (-not $PSCmdlet.ShouldContinue(
                    "Output directory '$outputDir' already exists and contains $($existingFiles.Count) files. Continue?",
                    "Output Directory Exists")) {
                    return
                }
            }
        }

        # Process each file
        foreach ($file in $ksyFiles) {
            $script:processedCount++
            $relativePath = $file.FullName.Replace("$formatsDir\", "").Replace("$formatsDir/", "")

            Write-Progress -Activity "Compiling Kaitai Struct files" `
                          -Status "Processing: $relativePath" `
                          -PercentComplete (($script:processedCount / $ksyFiles.Count) * 100)

            Write-Host "Compiling: $relativePath... " -NoNewline

            if ($PSCmdlet.ShouldProcess($relativePath, "Compile to $TargetLanguage")) {
                try {
                    # Call the compiler directly. Avoid Start-Process + empty redirected streams:
                    # ($null + $null).Trim() throws "You cannot call a method on a null-valued expression".
                    $prevEap = $ErrorActionPreference
                    $ErrorActionPreference = 'Continue'
                    try {
                        $allOutput = & $script:kscExe -t $TargetLanguage -d $outputDir $file.FullName 2>&1
                    }
                    finally {
                        $ErrorActionPreference = $prevEap
                    }

                    # Native process exit code (set after external `&` invocation)
                    $exitCode = $LASTEXITCODE

                    $output = if ($null -eq $allOutput) {
                        ''
                    }
                    elseif ($allOutput -is [System.Array]) {
                        (($allOutput | ForEach-Object { "$_" }) -join [Environment]::NewLine).Trim()
                    }
                    else {
                        "$allOutput".Trim()
                    }

                    if ($exitCode -eq 0) {
                        if ([string]::IsNullOrWhiteSpace($output)) {
                            Write-Host "OK" -ForegroundColor Green
                        }
                        else {
                            Write-Host "OK (with warnings)" -ForegroundColor Yellow
                            Write-Verbose "Compiler output for $relativePath`: $output"
                        }
                        $script:successCount++
                    }
                    else {
                        Write-Host "FAILED" -ForegroundColor Red
                        $script:failureCount++
                        $script:failedFiles += [PSCustomObject]@{
                            File = $relativePath
                            Output = $output
                            ExitCode = $exitCode
                        }
                        Write-Verbose "Compiler failed for $relativePath with exit code $exitCode"
                    }
                }
                catch {
                    Write-Host "ERROR" -ForegroundColor Red
                    $script:failureCount++
                    $script:failedFiles += [PSCustomObject]@{
                        File = $relativePath
                        Output = $_.Exception.Message
                        ExitCode = -1
                    }
                    Write-Verbose "Exception occurred compiling $relativePath`: $($_.Exception.Message)"
                }
            }
        }

        Write-Progress -Activity "Compiling Kaitai Struct files" -Completed
    }
    catch {
        Write-Error "An error occurred during compilation: $($_.Exception.Message)"
        throw
    }
}

end {
    # Print summary
    Write-Host ("=" * 80) -ForegroundColor Cyan
    Write-Host "Summary: $($script:successCount) succeeded, $($script:failureCount) failed" -ForegroundColor Cyan

    # Print failures if any
    if ($script:failureCount -gt 0) {
        Write-Host ("=" * 80) -ForegroundColor Red
        Write-Host "FAILURES:" -ForegroundColor Red
        Write-Host ("=" * 80) -ForegroundColor Red

        foreach ($failed in $script:failedFiles) {
            Write-Host "`n$($failed.File) (Exit Code: $($failed.ExitCode)):" -ForegroundColor Red
            Write-Host $failed.Output
        }

        # Set exit code for CI/CD
        $global:LASTEXITCODE = 1
        exit 1
    }

    Write-Host "`nCompilation completed successfully!" -ForegroundColor Green
    $global:LASTEXITCODE = 0
    exit 0
}

