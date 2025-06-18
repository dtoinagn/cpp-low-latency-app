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
