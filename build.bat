@echo off
setlocal EnableDelayedExpansion

:: Default values
set BUILD_TYPE=Debug
set COMPILER=clang++
set USE_SANITIZERS=OFF
set BUILD_DIR=build

:: Help message
:usage
echo Usage: build.bat [-t Debug^|Release] [-c clang++^|g++] [-s ON^|OFF]
echo   -t   CMake build type (default: Debug)
echo   -c   Compiler to use (default: clang++)
echo   -s   Enable sanitizers (Clang only; default: OFF)
exit /b 1

:: Parse arguments
:parse_args
if "%~1"=="" goto done

if "%~1"=="-t" (
    set BUILD_TYPE=%~2
    shift
) else if "%~1"=="-c" (
    set COMPILER=%~2
    shift
) else if "%~1"=="-s" (
    set USE_SANITIZERS=%~2
    shift
) else (
    goto usage
)
shift
goto parse_args

:done

echo.
echo 🛠️  Building with:
echo   Build type:     %BUILD_TYPE%
echo   Compiler:       %COMPILER%
echo   Sanitizers:     %USE_SANITIZERS%
echo.

:: Set compilers
if "%COMPILER%"=="clang++" (
    set CC=clang
    set CXX=clang++
) else if "%COMPILER%"=="g++" (
    set CC=gcc
    set CXX=g++
) else (
    echo ❌ Unsupported compiler: %COMPILER%
    goto usage
)

:: Create build dir
if not exist %BUILD_DIR% mkdir %BUILD_DIR%
cd %BUILD_DIR%

:: Run CMake
cmake .. ^
  -G "NMake Makefiles" ^
  -DCMAKE_BUILD_TYPE=%BUILD_TYPE% ^
  -DCMAKE_C_COMPILER=%CC% ^
  -DCMAKE_CXX_COMPILER=%CXX% ^
  -DUSE_SANITIZERS=%USE_SANITIZERS%

:: Build
cmake --build .

echo.
echo ✅ Build complete.
endlocal
