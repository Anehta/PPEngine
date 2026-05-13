Write-Host ('ANDROID_HOME=' + $env:ANDROID_HOME)
Write-Host ('  exists: ' + (Test-Path $env:ANDROID_HOME))
Write-Host ('ANDROID_NDK_ROOT=' + $env:ANDROID_NDK_ROOT)
Write-Host ('  exists: ' + (Test-Path $env:ANDROID_NDK_ROOT))
Write-Host ''
Write-Host 'Searching common locations for Android SDK...'
$candidates = @(
    'C:\Users\brain\AppData\Local\Android\Sdk',
    'C:\Android\Sdk',
    'D:\Android\Sdk',
    'E:\Android\Sdk',
    'C:\Program Files\Android\Sdk',
    'C:\Program Files (x86)\Android\android-sdk'
)
foreach ($p in $candidates) {
    if (Test-Path $p) {
        Write-Host ('  FOUND: ' + $p)
        Get-ChildItem $p -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name | ForEach-Object { Write-Host ('    ' + $_) }
    }
}
Write-Host ''
Write-Host 'Searching D: E: for build-tools...'
Get-ChildItem -Path 'D:\','E:\' -Directory -Filter 'Sdk' -Recurse -Depth 3 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName
