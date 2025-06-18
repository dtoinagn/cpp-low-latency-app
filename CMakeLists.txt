cmake_minimum_required(VERSION 3.10)
project(cpp_low_latency_app)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=address,undefined -fno-omit-frame-pointer")

add_executable(app
    src/main.cpp
    src/ThreadAffinity.cpp
)

target_include_directories(app PRIVATE ${CMAKE_SOURCE_DIR}/src)
