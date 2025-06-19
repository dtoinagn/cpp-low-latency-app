#!/bin/bash

set -e

# Default values
BUILD_TYPE="Debug"
COMPILER="clang++"
USE_SANITIZERS="OFF"
BUILD_DIR="build"

# Usage help
usage() {
    echo "Usage: $0 [-t Debug|Release] [-c clang++|g++] [-s ON|OFF]"
    echo "  -t    CMake build type (default: Debug)"
    echo "  -c    Compiler to use (default: clang++)"
    echo "  -s    Enable sanitizers (ON/OFF, default: OFF)"
    exit 1
}

# Parse options
while getopts ":t:c:s:" opt; do
  case ${opt} in
    t ) BUILD_TYPE="$OPTARG"
      ;;
    c ) COMPILER="$OPTARG"
      ;;
    s ) USE_SANITIZERS="$OPTARG"
      ;;
    \? ) usage
      ;;
  esac
done

# Set compiler path if needed
if [[ "$COMPILER" == "clang++" ]]; then
    export CXX=clang++
    export CC=clang
elif [[ "$COMPILER" == "g++" ]]; then
    export CXX=g++
    export CC=gcc
else
    echo "❌ Unsupported compiler: $COMPILER"
    usage
fi

echo "🛠️  Building with:"
echo "  Build type:     $BUILD_TYPE"
echo "  Compiler:       $COMPILER"
echo "  Sanitizers:     $USE_SANITIZERS"
echo

# Create build directory
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Run cmake and build
cmake .. \
  -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
  -DCMAKE_CXX_COMPILER="$COMPILER" \
  -DUSE_SANITIZERS="$USE_SANITIZERS"

cmake --build .

echo "✅ Build complete."
