#include "LockFreeQueue.h"
#include "MemoryPool.h"
#include "ThreadAffinity.h"
#include <thread>
#include <cstring>
#include <iostream>
#include <chrono>

LockFreeQueue<char*, 1024> queue;
MemoryPool pool(1024, 512);

void producer(int core_id) {
    pin_thread_to_core(core_id);
    for (int i = 0; i < 1000; ++i) {
        char* buffer = pool.allocate();
        snprintf(buffer, 1024, "message_%d", i);

        while (!queue.push(buffer)) {
            std::this_thread::yield(); // spin-wait
        }
        std::this_thread::sleep_for(std::chrono::microseconds(100));
    }
}

void consumer(int core_id) {
    pin_thread_to_core(core_id);
    while (true) {
        auto opt = queue.pop();
        if (opt.has_value()) {
            char* msg = opt.value();
            std::cout << "[Consumed] " << msg << std::endl;
            pool.release(msg);
        } else {
            std::this_thread::yield(); // spin-wait
        }
    }
}

int main() {
    std::thread prod(producer, 2); // Pin producer to CPU 2
    std::thread cons(consumer, 3); // Pin consumer to CPU 3

    prod.join();
    cons.detach(); // in real system, you'd control shutdown

    return 0;
}
