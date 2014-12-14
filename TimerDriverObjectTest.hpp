#include "CppUTest/TestHarness.h"

extern "C"
{
#include "TimerDriver.h"
}


TEST_GROUP(TimerDriverObjectTest)
{
    void setup()
    {
        InitTimers();
    };

    void teardown()
    {
        TerminateTimers();
    }
};
