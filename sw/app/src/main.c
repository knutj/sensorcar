#include "counter.h"
#include "platform.h"

int main() {
    init_platform();
    start();
    cleanup_platform();
    return 0;
}