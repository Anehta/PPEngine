param(
    [string]$InputPath  = "capture/logo.ico",
    [string]$OutputPath = "capture/logo.png"
)

Add-Type -AssemblyName System.Drawing

if (-not (Test-Path $InputPath)) {
    Write-Error "Input not found: $InputPath"
    exit 1
}

$bytes = [System.IO.File]::ReadAllBytes($InputPath)

if ([BitConverter]::ToUInt16($bytes, 0) -ne 0 -or
    [BitConverter]::ToUInt16($bytes, 2) -ne 1) {
    Write-Error "Not a valid ICO file"
    exit 1
}

$count = [BitConverter]::ToUInt16($bytes, 4)
$bestW = 0; $bestOffset = 0; $bestSize = 0

for ($i = 0; $i -lt $count; $i++) {
    $entry  = 6 + $i * 16
    $w      = $bytes[$entry];     if ($w -eq 0) { $w = 256 }
    $size   = [BitConverter]::ToUInt32($bytes, $entry + 8)
    $offset = [BitConverter]::ToUInt32($bytes, $entry + 12)
    if ($w -gt $bestW) {
        $bestW = $w; $bestOffset = $offset; $bestSize = $size
    }
}

# PNG magic: 89 50 4E 47 -> frame already PNG-encoded, copy raw
if ($bytes[$bestOffset]     -eq 0x89 -and
    $bytes[$bestOffset + 1] -eq 0x50 -and
    $bytes[$bestOffset + 2] -eq 0x4E -and
    $bytes[$bestOffset + 3] -eq 0x47) {

    $png = New-Object byte[] $bestSize
    [Array]::Copy($bytes, $bestOffset, $png, 0, $bestSize)
    [System.IO.File]::WriteAllBytes($OutputPath, $png)
    Write-Host "Extracted PNG frame: $InputPath -> $OutputPath (${bestW}x${bestW})"
} else {
    # BMP/DIB frame — decode through System.Drawing.Icon
    $fs   = [System.IO.File]::OpenRead($InputPath)
    $icon = New-Object System.Drawing.Icon($fs, $bestW, $bestW)
    $bmp  = $icon.ToBitmap()
    $bmp.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose(); $icon.Dispose(); $fs.Close()
    Write-Host "Decoded BMP frame: $InputPath -> $OutputPath (${bestW}x${bestW})"
}
