$content = @'
@echo off
setlocal enabledelayedexpansion

set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"
set "PATH=%JAVA_HOME%\bin;%PATH%"
echo JAVA_HOME=%JAVA_HOME%

REM Auto-detect latest installed NDK if ANDROID_NDK_ROOT points nowhere
if not exist "%ANDROID_NDK_ROOT%\source.properties" (
    echo Current ANDROID_NDK_ROOT invalid: "%ANDROID_NDK_ROOT%"
    if defined ANDROID_HOME (
        set "NDK_BASE=%ANDROID_HOME%\ndk"
    ) else (
        set "NDK_BASE=C:\Users\brain\AppData\Local\Android\Sdk\ndk"
    )
    echo Scanning !NDK_BASE! for installed NDK versions...
    for /f "delims=" %%d in ('dir /b /ad /o-n "!NDK_BASE!" 2^>nul') do (
        if exist "!NDK_BASE!\%%d\source.properties" (
            set "ANDROID_NDK_ROOT=!NDK_BASE!\%%d"
            set "ANDROID_NDK_HOME=!NDK_BASE!\%%d"
            set "NDK_HOME=!NDK_BASE!\%%d"
            echo Using detected NDK: !ANDROID_NDK_ROOT!
            goto ndk_ok
        )
    )
    echo ERROR: no valid NDK found under !NDK_BASE!
    exit /b 1
)
:ndk_ok
echo ANDROID_NDK_ROOT=%ANDROID_NDK_ROOT%

java -version
gradlew.bat assembleDebug
'@

$bytes = [System.Text.UTF8Encoding]::new($false).GetBytes($content -replace "`r?`n", "`r`n")
[System.IO.File]::WriteAllBytes('E:\RustProject\PPEngineSuper\PPEngineX\build_android_gradle.bat', $bytes)

# verify no BOM
$head = [System.IO.File]::ReadAllBytes('E:\RustProject\PPEngineSuper\PPEngineX\build_android_gradle.bat')[0..3]
Write-Host ('First 4 bytes: ' + ($head | ForEach-Object { $_.ToString('X2') }) -join ' ')
Write-Host 'OK' -ForegroundColor Green
