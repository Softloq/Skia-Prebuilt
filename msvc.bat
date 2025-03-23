@setlocal
@for /F "delims== tokens=1,* eol=#" %%i in ('type .env') do @set %%i=%%~j

cmake -S %~dp0Prerequisite -B %~dp0build/Prerequisite
cmake --build %~dp0build/Prerequisite

cd %~dp0build/Prerequisite/Downloads/skia
git pull
python3 tools/git-sync-deps
.\bin\gn.exe gen "%~dp0build/Compile/skia" --args="extra_cflags_cc=[\"/MD\"] is_official_build=true is_component_build=true is_debug=false skia_use_svg=true skia_enable_skshaper=true skia_use_system_libjpeg_turbo=false skia_use_system_zlib=false skia_use_system_expat=false skia_use_system_libwebp=false skia_use_system_libpng=false skia_use_system_harfbuzz=false skia_use_system_icu=false skia_use_icu=true"
%~dp0build\Prerequisite\Downloads\ninja-%NINJA_VERSION%\ninja.exe -C "%~dp0build/Compile/skia"

cmake -S %~dp0Package -B %~dp0build/Package
cmake --build %~dp0build/Package
@endlocal