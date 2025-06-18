#include "ThreadAffinity.h"
#include <pthread.h>
#include <sched.h>
#include <iostream>

bool pin_thread_to_core(int core_id) {
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(core_id, &cpuset);

    pthread_t thread = pthread_self();
    int result = pthread_setaffinity_np(thread, sizeof(cpu_set_t), &cpuset);

    if (result != 0) {
        std::cerr << "Failed to pin thread to core " << core_id << std::endl;
        return false;
    }
    return true;
}
