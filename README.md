# Overview

This example assumes a real-time, multi-threaded message processing system where minimizing memory allocation, contention, and latency is critical - such as in financial market data or trading platforms
Low-latency C++ Code Example that demonstrates:

1. **Lock-free queue** for producer/consumer communication
2. **Thread affinity** to pin worker threads to specific cores
3. **Zero-copy memory pool** to reuse buffers for network messages

# Summary of Low-Latency Features Used

| Feature         | Description                                                   |
| --------------- | ------------------------------------------------------------- |
| Lock-Free Queue | Minimal latency and no locks between producer/consumer        |
| Thread Affinity | Cache locality and CPU isolation                              |
| Memory Pool     | Reuses buffers to avoid heap fragmentation and malloc latency |
| Zero Copy       | Passes raw pointers around without copying                    |

# Profiling Tools for C++

Here are production-safe and widely-tools you can integrate:
| Tool | Purpose | Works in Docker? |
| ----------------------- | ---------------------------------------------- | ----------------------------- |
| `perf` | CPU sampling, cache misses, call stacks | Yes (with `--privileged`) |
| `valgrind` | Memory leaks, cache use, instruction count | Yes (slower) |
| `gperftools` | High-performance CPU profiler (Google) | Yes |
| `Callgrind/KCacheGrind` | Function-level call graph | Yes (offline visualization) |
| `clang sanitizer` | Detect UB, race, memory issues at compile-time | Yes |

As a prevention, we can use sanitizers at compile time to capture memory bugs or undefined behavior with readable diagnostics. Add the following to `CMakeLists.txt`:

# How to build

## For Unix/Linux/macOS

The build script (`build.sh`) accepts arguments for:

- Build type (`Debug` or `Release`)
- Compiler (`clang++` or `g++`)
- Optional flags (like enabling sanitizers)
- Usage Examples

* Build with Clang + Sanitizers:

```
./build.sh -t Debug -c clang++ -s ON
```

- Build with GCC for Production:

```
./build.sh -t Release -c g++ -s OFF
```
