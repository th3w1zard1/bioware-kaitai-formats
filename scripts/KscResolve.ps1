# Dot-source from other scripts: . "$PSScriptRoot/KscResolve.ps1"
# Resolves the Kaitai Struct compiler executable (same rules as generate_code.ps1 / compile_all_ksy.ps1).

function Get-ResolvedKscExecutable {
    if ($env:KAITAI_STRUCT_COMPILER -and (Test-Path -LiteralPath $env:KAITAI_STRUCT_COMPILER)) {
        return $env:KAITAI_STRUCT_COMPILER
    }
    foreach ($name in @('ksc', 'kaitai-struct-compiler', 'kaitai-struct-compiler.bat')) {
        $cmd = Get-Command $name -ErrorAction SilentlyContinue
        if ($cmd) {
            return $cmd.Source
        }
    }
    $commonWin = "${env:ProgramFiles(x86)}\kaitai-struct-compiler\bin\kaitai-struct-compiler.bat"
    if (Test-Path -LiteralPath $commonWin) {
        return $commonWin
    }
    return $null
}
