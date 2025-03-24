@setlocal
@for /F "delims== tokens=1,* eol=#" %%i in ('type .env') do @set %%i=%%~j
cmake -S %~dp0Prerequisite -B %~dp0build/Prerequisite
cmake --build %~dp0build/Prerequisite

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