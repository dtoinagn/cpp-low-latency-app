#pragma once
#include <vector>
#include <queue>
#include <mutex>

class MemoryPool {
public:
    explicit MemoryPool(size_t bufferSize, size_t poolSize)
        : bufferSize(bufferSize) {
        for (size_t i = 0; i < poolSize; ++i) {
            buffers.push(new char[bufferSize]);
        }
    }

    ~MemoryPool() {
        while (!buffers.empty()) {
            delete[] buffers.front();
            buffers.pop();
        }
    }

    char* allocate() {
        std::lock_guard<std::mutex> lock(mutex);
        if (buffers.empty()) return new char[bufferSize]; // fallback
        char* buf = buffers.front();
        buffers.pop();
        return buf;
    }

    void release(char* buf) {
        std::lock_guard<std::mutex> lock(mutex);
        buffers.push(buf);
    }

private:
    size_t bufferSize;
    std::queue<char*> buffers;
    std::mutex mutex;
};
