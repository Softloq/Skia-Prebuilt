@setlocal
@for /F "delims== tokens=1,* eol=#" %%i in ('type .env') do @set %%i=%%~j
cmake -S %~dp0Prerequisite -B %~dp0build/Prerequisite
cmake --build %~dp0build/Prerequisite

cd %~dp0build/Prerequisite/Downloads/vcpkg-%VCPKG_VERSION%

@REM echo vcpkg_root = "%~dp0build/Prerequisite/Downloads/vcpkg-%VCPKG_VERSION%"> %~dp0build/Compile/skia/vcpkg.gn
@REM echo vcpkg_installed_root = "$vcpkg_root/installed/x64-windows">> %~dp0build/Compile/skia/vcpkg.gn
@REM echo vcpkg_include_dir = "$vcpkg_installed_root/include">> %~dp0build/Compile/skia/vcpkg.gn
@REM echo vcpkg_harfbuzz_include_dir = "$vcpkg_installed_root/include/harfbuzz">> %~dp0build/Compile/skia/vcpkg.gn
@REM echo vcpkg_lib_dir = [ "$vcpkg_installed_root/lib" ]>> %~dp0build/Compile/skia/vcpkg.gn
@REM echo vcpkg_lib = []>> %~dp0build/Compile/skia/vcpkg.gn

@REM echo vcpkg_root = "%~dp0build/Prerequisite/Downloads/vcpkg-%VCPKG_VERSION%"> %~dp0build/Prerequisite/Downloads/skia/vcpkg.gn
@REM echo vcpkg_installed_root = "$vcpkg_root/installed/x64-windows">> %~dp0build/Prerequisite/Downloads/skia/vcpkg.gn
@REM echo vcpkg_include_dir = "$vcpkg_installed_root/include">> %~dp0build/Prerequisite/Downloads/skia/vcpkg.gn
@REM echo vcpkg_harfbuzz_include_dir = "$vcpkg_installed_root/include/harfbuzz">> %~dp0build/Prerequisite/Downloads/skia/vcpkg.gn
@REM echo vcpkg_lib_dir = [ "$vcpkg_installed_root/lib" ]>> %~dp0build/Prerequisite/Downloads/skia/vcpkg.gn
@REM echo vcpkg_lib = []>> %~dp0build/Prerequisite/Downloads/skia/vcpkg.gn

cd %~dp0build/Prerequisite/Downloads/skia
git pull
git submodule update --init --recursive
git submodule update --recursive
python tools/git-sync-deps
.\bin\gn.exe gen "%~dp0build/Compile/skia"
%~dp0build\Prerequisite\Downloads\ninja-%NINJA_VERSION%\ninja.exe -C "%~dp0build/Compile/skia"

cmake -S %~dp0Package -B %~dp0build/Package
cmake --build %~dp0build/Package
@endlocal