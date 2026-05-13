$content = @"
@echo off
setlocal enabledelayedexpansion

REM Android Release 构建脚本
REM 直接 gradlew assembleRelease（自动 dep -> buildRustRelease：cargo build --release）
REM 如果需要 clean 全量重编，先跑 clean_rebuild_android.bat 再跑这个

set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"
set "PATH=%JAVA_HOME%\bin;%PATH%"

REM 自动探测已安装的最新 NDK
if not exist "%ANDROID_NDK_ROOT%\source.properties" (
    if defined ANDROID_HOME (
        set "NDK_BASE=%ANDROID_HOME%\ndk"
    ) else (
        set "NDK_BASE=C:\Users\brain\AppData\Local\Android\Sdk\ndk"
    )
    for /f "delims=" %%d in ('dir /b /ad /o-n "!NDK_BASE!" 2^>nul') do (
        if exist "!NDK_BASE!\%%d\source.properties" (
            set "ANDROID_NDK_ROOT=!NDK_BASE!\%%d"
            set "ANDROID_NDK_HOME=!NDK_BASE!\%%d"
            set "NDK_HOME=!NDK_BASE!\%%d"
            goto ndk_ok
        )
    )
    echo ERROR: no valid NDK found
    exit /b 1
)
:ndk_ok

set "NDK_BIN=%ANDROID_NDK_ROOT%\toolchains\llvm\prebuilt\windows-x86_64\bin"
set "CC_aarch64-linux-android=%NDK_BIN%\aarch64-linux-android26-clang.cmd"
set "CXX_aarch64-linux-android=%NDK_BIN%\aarch64-linux-android26-clang++.cmd"
set "AR_aarch64-linux-android=%NDK_BIN%\llvm-ar.exe"
set "RANLIB_aarch64-linux-android=%NDK_BIN%\llvm-ranlib.exe"
set "CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=%NDK_BIN%\aarch64-linux-android26-clang.cmd"
set "LIBCLANG_PATH=%NDK_BIN%"
set "PATH=%NDK_BIN%;%PATH%"
set "NDK_SYSROOT=%ANDROID_NDK_ROOT:\=/%/toolchains/llvm/prebuilt/windows-x86_64/sysroot"
set "BINDGEN_EXTRA_CLANG_ARGS=--sysroot=%NDK_SYSROOT% --target=aarch64-linux-android26 -I%NDK_SYSROOT%/usr/include -I%NDK_SYSROOT%/usr/include/aarch64-linux-android"

echo ============================================
echo   Android RELEASE build (assembleRelease)
echo   Rust: cargo build --release (LTO + max opt, slow)
echo ============================================

java -version
call gradlew.bat --console=plain assembleRelease
if errorlevel 1 (
    echo gradlew assembleRelease failed
    exit /b 1
)

echo.
echo ============================================
echo   BUILD OK
echo ============================================
echo APK: app\build\outputs\apk\release\app-release.apk
"@

$content = $content -replace "`r?`n", "`r`n"
[System.IO.File]::WriteAllText(
    'E:\RustProject\PPEngineSuper\PPEngineX\release_android.bat',
    $content,
    [System.Text.Encoding]::ASCII
)

$b = [System.IO.File]::ReadAllBytes('E:\RustProject\PPEngineSuper\PPEngineX\release_android.bat')
Write-Host ("Wrote release_android.bat ({0} bytes, CRLF: {1})" -f $b.Length, (($b[9] -eq 0x0D) -and ($b[10] -eq 0x0A)))
