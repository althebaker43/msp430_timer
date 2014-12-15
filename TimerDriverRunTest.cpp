#include "TimerDriverRunTest.hpp"

extern "C"
{
#include "TimerDriver.h"
#include <msp430f5529.h>
}


TEST(TimerDriverRunTest, ClockSource)
{
    CHECK_EQUAL(TIMER_CLOCKSOURCE_SMCLK, GetTimerClockSource(TIMER_TA0));
    CHECK_EQUAL(0x0200, (TA0CTL & (TASSEL1 | TASSEL0)));

    SetTimerClockSource(
            TIMER_TA0,
            TIMER_CLOCKSOURCE_ACLK
            );

    CHECK_EQUAL(TIMER_CLOCKSOURCE_ACLK, GetTimerClockSource(TIMER_TA0));
    CHECK_EQUAL(0x0100, (TA0CTL & (TASSEL1 | TASSEL0)));
}

TEST(TimerDriverRunTest, StartTimer)
{
    CHECK_FALSE(StartTimer(TIMER_TA0));
}
