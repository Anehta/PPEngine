foreach ($path in @(
    'E:\RustProject\PPEngineSuper\PPEngineX\build_android.bat',
    'E:\RustProject\PPEngineSuper\PPEngineX\build_android_gradle.bat'
)) {
    $b = [System.IO.File]::ReadAllBytes($path)
    $hasBom = ($b[0] -eq 0xEF) -and ($b[1] -eq 0xBB) -and ($b[2] -eq 0xBF)
    $lfCount = 0; $crlfCount = 0
    for ($i = 0; $i -lt $b.Length; $i++) {
        if ($b[$i] -eq 0x0A) {
            if ($i -gt 0 -and $b[$i - 1] -eq 0x0D) { $crlfCount++ } else { $lfCount++ }
        }
    }
    Write-Host ('--- ' + [System.IO.Path]::GetFileName($path) + ' ---')
    Write-Host ('  BOM: ' + $hasBom)
    Write-Host ('  CRLF count: ' + $crlfCount)
    Write-Host ('  bare LF count: ' + $lfCount)
}
