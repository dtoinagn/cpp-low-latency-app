#pragma once
#include <atomic>
#include <cstddef>
#include <optional>

template<typename T, size_t Size>
class LockFreeQueue {
public:
    LockFreeQueue() : head(0), tail(0) {}

    bool push(const T& item) {
        size_t t = tail.load(std::memory_order_relaxed);
        size_t h = head.load(std::memory_order_acquire);

        if ((t + 1) % Size == h) return false;  // queue is full

        buffer[t] = item;
        tail.store((t + 1) % Size, std::memory_order_release);
        return true;
    }

    std::optional<T> pop() {
        size_t h = head.load(std::memory_order_relaxed);
        size_t t = tail.load(std::memory_order_acquire);

        if (h == t) return std::nullopt; // queue is empty

        T item = buffer[h];
        head.store((h + 1) % Size, std::memory_order_release);
        return item;
    }

private:
    T buffer[Size];
    std::atomic<size_t> head;
    std::atomic<size_t> tail;
};
