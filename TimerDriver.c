#include "TimerDriver.h"

#include <stdlib.h>
#include <msp430f5529.h>


typedef unsigned int Bool;
#define TRUE 1
#define FALSE 0

struct TimerInstance_struct
{
};


static Bool isDriverInitialized = FALSE;
static TimerInstance instance;


void
InitTimers()
{
    isDriverInitialized = TRUE;

    SetTimerClockSource(
            TIMER_TA0,
            TIMER_CLOCKSOURCE_SMCLK
            );
}

void
TerminateTimers()
{
    isDriverInitialized = FALSE;
}

TimerInstance*
CreateTimer()
{
    if (isDriverInitialized == TRUE)
    {
        return &instance;
    }
    else
    {
        return NULL;
    }
}

void
DestroyTimer(
        TimerInstance** timer
        )
{
    *timer = NULL;
}

TimerClockSource
GetTimerClockSource(
        TimerInstanceID timerID
        )
{
    switch (TA0CTL & (TASSEL1 | TASSEL0))
    {
        case 0x0100:
            return TIMER_CLOCKSOURCE_ACLK;

        case 0x0200:
            return TIMER_CLOCKSOURCE_SMCLK;

        default:
            return TIMER_CLOCKSOURCE_UNKNOWN;
    };
}

void
SetTimerClockSource(
        TimerInstanceID     timerID,
        TimerClockSource    clockSource
        )
{
    TA0CTL &= ~(TASSEL1 | TASSEL0);

    switch (clockSource)
    {
        case TIMER_CLOCKSOURCE_ACLK:
            TA0CTL |= ((~TASSEL1) | (TASSEL0));
            break;

        case TIMER_CLOCKSOURCE_SMCLK:
            TA0CTL |= ((TASSEL1) | (~TASSEL0));
            break;

        default:
            break;
    };
}

Bool
StartTimer(
        TimerInstanceID timerID
        )
{
    return FALSE;
}
