cmake_minimum_required(VERSION 3.15)
project(cpp_low_latency_flexible)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Optional: toggle sanitizers
option(USE_SANITIZERS "Enable Address + Undefined Behavior Sanitizers" OFF)

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND USE_SANITIZERS)
    message(STATUS "Sanitizers enabled for Clang build")
    add_compile_options(
        -fsanitize=address,undefined
        -fno-omit-frame-pointer
        -g
    )
    add_link_options(
        -fsanitize=address,undefined
        -fno-omit-frame-pointer
        -g
    )
endif()

# Optional: custom warning flags
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# Sources
add_executable(app
    src/main.cpp
    src/ThreadAffinity.cpp
)

target_include_directories(app PRIVATE ${CMAKE_SOURCE_DIR}/src)
