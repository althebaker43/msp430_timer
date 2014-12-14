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

TEST(TimerDriverBasicTest, NoTimersAfterTerminate)
{
    InitTimers();
    TerminateTimers();

    POINTERS_EQUAL(NULL, CreateTimer());
}
