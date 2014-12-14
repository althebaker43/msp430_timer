#include "TimerDriverObjectTest.hpp"

extern "C"
{
#include "TimerDriver.h"
}


TEST(TimerDriverObjectTest, CreateTimer)
{
    TimerInstance* timer = CreateTimer();

    CHECK(NULL != timer);
}

TEST(TimerDriverObjectTest, DestroyTimer)
{
    TimerInstance* timer = CreateTimer();
    DestroyTimer(&timer);

    POINTERS_EQUAL(NULL, timer);
}
