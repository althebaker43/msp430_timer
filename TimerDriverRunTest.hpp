#include "CppUTest/TestHarness.h"

extern "C"
{
#include "TimerDriver.h"
}


TEST_GROUP(TimerDriverRunTest)
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
