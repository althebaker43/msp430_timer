#include "TimerDriverBasicTest.hpp"

extern "C"
{
#include "TimerDriver.h"
}


TEST(TimerDriverBasicTest, NoTimersBeforeInit)
{
    POINTERS_EQUAL(NULL, CreateTimer());

    InitTimers();

    CHECK(NULL != CreateTimer());
}
